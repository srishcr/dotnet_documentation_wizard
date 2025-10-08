#!/bin/bash

# Script to extract all API endpoints from .NET codebase using ripgrep
# Supports: Traditional Controllers, API Controllers, Minimal APIs, and Attribute Routing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default directory
SEARCH_DIR="${1:-./eShopOnWeb-main}"

if [ ! -d "$SEARCH_DIR" ]; then
    echo -e "${RED}Error: Directory '$SEARCH_DIR' not found${NC}"
    echo "Usage: $0 [directory_path]"
    exit 1
fi

# Extract project name from directory path
PROJECT_NAME=$(basename "$SEARCH_DIR")
OUTPUT_FILE="${PROJECT_NAME}_rigrep_endpoints.txt"

# Function to write both to console and file
write_output() {
    echo -e "$1" | tee -a "$OUTPUT_FILE"
}

# Clear the output file
> "$OUTPUT_FILE"

echo -e "${GREEN}🔍 Extracting API endpoints from .NET codebase in: $SEARCH_DIR${NC}"
echo -e "${GREEN}📄 Output will be saved to: $OUTPUT_FILE${NC}"
echo "========================================================================================="

# Write header to file (without colors)
echo "🔍 API Endpoints Extraction Report" >> "$OUTPUT_FILE"
echo "Project: $PROJECT_NAME" >> "$OUTPUT_FILE"
echo "Source Directory: $SEARCH_DIR" >> "$OUTPUT_FILE"
echo "Generated: $(date)" >> "$OUTPUT_FILE"
echo "=========================================================================================" >> "$OUTPUT_FILE"

# Function to print section headers
print_section() {
    echo -e "\n${BLUE}$1${NC}"
    echo "-----------------------------------------------------------------------------------------"
    # Also write to file without colors
    echo "" >> "$OUTPUT_FILE"
    echo "$1" >> "$OUTPUT_FILE"
    echo "-----------------------------------------------------------------------------------------" >> "$OUTPUT_FILE"
}

# Function to extract and format endpoint info
extract_endpoint_context() {
    local file="$1"
    local line_num="$2"
    local pattern="$3"

    # Get the class name and namespace context
    local class_info=$(rg -n "^namespace|^public class|^public partial class" "$file" | head -10)
    local method_context=$(rg -A 5 -B 2 "$pattern" "$file" | grep -E "(public|private|protected).*\{")

    # Get relative path from search directory
    local relative_path="${file#$SEARCH_DIR/}"
    file_info="   File: $relative_path"
    line_info="   Line: $line_num"

    echo -e "   ${PURPLE}File:${NC} $relative_path"
    echo -e "   ${PURPLE}Line:${NC} $line_num"
    echo "$file_info" >> "$OUTPUT_FILE"
    echo "$line_info" >> "$OUTPUT_FILE"

    if [ ! -z "$method_context" ]; then
        method_info="   Method: $(echo "$method_context" | head -1 | sed 's/^[[:space:]]*//')"
        echo -e "   ${PURPLE}Method:${NC} $(echo "$method_context" | head -1 | sed 's/^[[:space:]]*//')"
        echo "$method_info" >> "$OUTPUT_FILE"
    fi
}

# 1. MINIMAL API ENDPOINTS (app.Map*)
print_section "🚀 MINIMAL API ENDPOINTS"
rg -n --type cs 'app\.Map(Get|Post|Put|Delete|Patch)\s*\(' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    route_info="HTTP Method & Route: $(echo "$content" | sed 's/^[[:space:]]*//' | sed 's/app\.Map//')"
    echo -e "${YELLOW}$route_info${NC}"
    echo "$route_info" >> "$OUTPUT_FILE"
    extract_endpoint_context "$file" "$line" 'app\.Map'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 2. ATTRIBUTE-BASED ROUTING ([HttpGet], [HttpPost], etc.)
print_section "📋 ATTRIBUTE-BASED HTTP ENDPOINTS"
rg -n --type cs '\[Http(Get|Post|Put|Delete|Patch)(\(.*\))?\]' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    # Get the method that follows this attribute
    method_line=$((line + 1))
    method_info=$(sed -n "${method_line}p" "$file" 2>/dev/null)

    attr_info="HTTP Attribute: $(echo "$content" | sed 's/^[[:space:]]*//')"
    echo -e "${YELLOW}$attr_info${NC}"
    echo "$attr_info" >> "$OUTPUT_FILE"

    if [ ! -z "$method_info" ]; then
        method_text="Method: $(echo "$method_info" | sed 's/^[[:space:]]*//')"
        echo -e "${YELLOW}$method_text${NC}"
        echo "$method_text" >> "$OUTPUT_FILE"
    fi
    extract_endpoint_context "$file" "$line" '\[Http'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 3. ROUTE ATTRIBUTES ON CONTROLLERS AND METHODS
print_section "🛣️  ROUTE ATTRIBUTES"
rg -n --type cs '\[Route\s*\(' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    route_text="Route: $(echo "$content" | sed 's/^[[:space:]]*//')"
    echo -e "${YELLOW}$route_text${NC}"
    echo "$route_text" >> "$OUTPUT_FILE"
    extract_endpoint_context "$file" "$line" '\[Route'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 4. API CONTROLLER ACTIONS (public IActionResult methods)
print_section "🎮 CONTROLLER ACTION METHODS"
rg -n --type cs 'public\s+(async\s+)?(Task<)?IActionResult' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    # Only process files that are controllers
    if [[ "$file" == *"Controller.cs" ]]; then
        # Get the HTTP method attribute above this method (if any)
        http_attr=$(rg -B 10 -A 0 "public\s+(async\s+)?(Task<)?IActionResult" "$file" | grep -E '\[Http(Get|Post|Put|Delete|Patch)' | tail -1)

        action_text="Action Method: $(echo "$content" | sed 's/^[[:space:]]*//')"
        echo -e "${YELLOW}$action_text${NC}"
        echo "$action_text" >> "$OUTPUT_FILE"

        if [ ! -z "$http_attr" ]; then
            attr_text="HTTP Attribute: $(echo "$http_attr" | sed 's/^[[:space:]]*//')"
            echo -e "${YELLOW}$attr_text${NC}"
            echo "$attr_text" >> "$OUTPUT_FILE"
        fi
        extract_endpoint_context "$file" "$line" 'IActionResult'
        echo
        echo "" >> "$OUTPUT_FILE"
    fi
done

# 5. API CONTROLLER DETECTION
print_section "🏗️  API CONTROLLERS"
rg -n --type cs '\[ApiController\]' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    # Get the class declaration that follows
    class_line=$((line + 1))
    class_info=$(rg -A 5 "public.*class.*Controller" "$file" | head -1)

    controller_text="API Controller: $(echo "$content" | sed 's/^[[:space:]]*//')"
    echo -e "${YELLOW}$controller_text${NC}"
    echo "$controller_text" >> "$OUTPUT_FILE"

    if [ ! -z "$class_info" ]; then
        class_text="Class: $(echo "$class_info" | sed 's/^[[:space:]]*//')"
        echo -e "${YELLOW}$class_text${NC}"
        echo "$class_text" >> "$OUTPUT_FILE"
    fi
    extract_endpoint_context "$file" "$line" '\[ApiController\]'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 6. APP.MAP REGISTRATIONS (for endpoint discovery)
print_section "📍 ENDPOINT REGISTRATIONS"
rg -n --type cs 'app\.Map.*\(' "$SEARCH_DIR" | grep -v 'MapGet\|MapPost\|MapPut\|MapDelete\|MapPatch' | while IFS=: read -r file line content; do
    reg_text="Registration: $(echo "$content" | sed 's/^[[:space:]]*//')"
    echo -e "${YELLOW}$reg_text${NC}"
    echo "$reg_text" >> "$OUTPUT_FILE"
    extract_endpoint_context "$file" "$line" 'app\.Map'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 7. SWAGGER/OPENAPI ENDPOINT DEFINITIONS
print_section "📚 SWAGGER/OPENAPI ENDPOINTS"
rg -n --type cs 'WithOpenApi\(\)|WithTags\(|WithSummary\(' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    openapi_text="OpenAPI Config: $(echo "$content" | sed 's/^[[:space:]]*//')"
    echo -e "${YELLOW}$openapi_text${NC}"
    echo "$openapi_text" >> "$OUTPUT_FILE"
    extract_endpoint_context "$file" "$line" 'With(OpenApi|Tags|Summary)'
    echo
    echo "" >> "$OUTPUT_FILE"
done

# 8. SUMMARY STATISTICS
print_section "📊 ENDPOINT SUMMARY"

total_minimal=$(rg -c --type cs 'app\.Map(Get|Post|Put|Delete|Patch)\s*\(' "$SEARCH_DIR" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
total_attributes=$(rg -c --type cs '\[Http(Get|Post|Put|Delete|Patch)(\(.*\))?\]' "$SEARCH_DIR" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
total_routes=$(rg -c --type cs '\[Route\s*\(' "$SEARCH_DIR" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
total_actions=$(rg -c --type cs 'public\s+(async\s+)?(Task<)?IActionResult' "$SEARCH_DIR" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
total_controllers=$(rg -c --type cs '\[ApiController\]' "$SEARCH_DIR" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')

echo -e "${CYAN}📋 Minimal API Endpoints:${NC} $total_minimal"
echo -e "${CYAN}🏷️  HTTP Attribute Endpoints:${NC} $total_attributes"
echo -e "${CYAN}🛣️  Route Attributes:${NC} $total_routes"
echo -e "${CYAN}🎮 Controller Actions:${NC} $total_actions"
echo -e "${CYAN}🏗️  API Controllers:${NC} $total_controllers"

total_endpoints=$((total_minimal + total_attributes))
echo -e "\n${GREEN}🎯 Total HTTP Endpoints Found: $total_endpoints${NC}"

# Write summary to file (without colors)
echo "📋 Minimal API Endpoints: $total_minimal" >> "$OUTPUT_FILE"
echo "🏷️  HTTP Attribute Endpoints: $total_attributes" >> "$OUTPUT_FILE"
echo "🛣️  Route Attributes: $total_routes" >> "$OUTPUT_FILE"
echo "🎮 Controller Actions: $total_actions" >> "$OUTPUT_FILE"
echo "🏗️  API Controllers: $total_controllers" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "🎯 Total HTTP Endpoints Found: $total_endpoints" >> "$OUTPUT_FILE"

# 9. DETAILED ENDPOINT LISTING (Optional - uncomment if needed)
# print_section "📝 DETAILED ENDPOINT LISTING"
# echo "Generating detailed endpoint listing..."
#
# {
#     echo "=== MINIMAL API ENDPOINTS ==="
#     rg --type cs 'app\.Map(Get|Post|Put|Delete|Patch)\s*\(' "$SEARCH_DIR" -A 2 -B 1
#     echo -e "\n=== ATTRIBUTE ENDPOINTS ==="
#     rg --type cs '\[Http(Get|Post|Put|Delete|Patch)(\(.*\))?\]' "$SEARCH_DIR" -A 3 -B 1
#     echo -e "\n=== ROUTE ATTRIBUTES ==="
#     rg --type cs '\[Route\s*\(' "$SEARCH_DIR" -A 2 -B 1
# } > "${SEARCH_DIR}_detailed_endpoints.txt"
#
# echo -e "${GREEN}📄 Detailed listing saved to: ${SEARCH_DIR}_detailed_endpoints.txt${NC}"

echo -e "\n${GREEN}✅ Endpoint extraction completed!${NC}"
echo -e "${GREEN}📄 Full report saved to: $OUTPUT_FILE${NC}"