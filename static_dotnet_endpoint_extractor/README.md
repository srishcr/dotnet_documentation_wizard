# 🔍 .NET API Endpoint Extractor

A comprehensive script that uses **ripgrep** to analyze .NET codebases and extract all API endpoints, including modern minimal APIs, traditional MVC controllers, and attribute-based routing patterns.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Search Types Explained](#search-types-explained)
- [Output Format](#output-format)
- [Creating an API Inventory](#creating-an-api-inventory)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This script analyzes .NET projects to discover and catalog all HTTP API endpoints using advanced pattern matching with ripgrep. It supports both modern .NET 6+ minimal APIs and traditional ASP.NET Core MVC patterns, making it perfect for:

- **API Documentation** - Generate comprehensive endpoint inventories
- **Security Audits** - Identify all exposed endpoints
- **Migration Planning** - Understand existing API surface area
- **Code Reviews** - Validate endpoint consistency
- **Legacy Analysis** - Map complex enterprise applications

## ✨ Features

- 🚀 **Multi-Pattern Detection** - Finds 7 different types of API patterns
- 📊 **Statistical Summary** - Provides endpoint counts and categorization
- 🎨 **Color-Coded Output** - Easy-to-read console display
- 📄 **File Export** - Generates clean text reports for documentation
- 🔍 **Context Extraction** - Shows file names, line numbers, and method signatures
- 🏷️ **OpenAPI Integration** - Identifies Swagger/OpenAPI configurations
- ⚡ **Fast Scanning** - Leverages ripgrep's speed for large codebases

## 📦 Prerequisites

### Required Tools

1. **ripgrep** - High-performance text search tool
   ```bash
   # macOS (Homebrew)
   brew install ripgrep

   # Ubuntu/Debian
   sudo apt install ripgrep

   # Windows (Chocolatey)
   choco install ripgrep
   ```

2. **Bash** - Compatible with bash 4.0+ or zsh

### Supported .NET Patterns

- ✅ .NET 6+ Minimal APIs (`app.MapGet`, `app.MapPost`, etc.)
- ✅ ASP.NET Core MVC Controllers
- ✅ Web API Controllers with `[ApiController]`
- ✅ Attribute-based routing (`[HttpGet]`, `[Route]`, etc.)
- ✅ Traditional action methods
- ✅ OpenAPI/Swagger configurations

## 🚀 Installation

1. **Clone or download the script:**
   ```bash
   wget https://your-repo/extract_dotnet_api_endpoints.sh
   # or copy the script file to your project directory
   ```

2. **Make it executable:**
   ```bash
   chmod +x extract_dotnet_api_endpoints.sh
   ```

3. **Verify ripgrep installation:**
   ```bash
   rg --version
   ```

## 💻 Usage

### Basic Usage

```bash
# Analyze current directory
./extract_dotnet_api_endpoints.sh

# Analyze specific project
./extract_dotnet_api_endpoints.sh /path/to/your/dotnet/project

# Analyze subdirectory
./extract_dotnet_api_endpoints.sh ./src
```

### Output Files

The script generates a file named `{project_name}_rigrep_endpoints.txt` containing:
- Project metadata (name, path, timestamp)
- Categorized endpoint listings
- File locations and line numbers
- Method signatures and HTTP attributes
- Statistical summary

### Command Line Examples

```bash
# Analyze the main project
./extract_dotnet_api_endpoints.sh ./MyWebApp
# Creates: MyWebApp_rigrep_endpoints.txt

# Analyze just the API layer
./extract_dotnet_api_endpoints.sh ./MyWebApp/src/Api
# Creates: Api_rigrep_endpoints.txt

# Default behavior (looks for ./eShopOnWeb-main)
./extract_dotnet_api_endpoints.sh
# Creates: eShopOnWeb-main_rigrep_endpoints.txt
```

## 🔍 Search Types Explained

The script performs **7 distinct search patterns** to comprehensively identify all API endpoints:

### 1. 🚀 **Minimal API Endpoints**
**Pattern:** `app\.Map(Get|Post|Put|Delete|Patch)\s*\(`

**What it finds:**
- Modern .NET 6+ style endpoints
- Functional programming approach to API definition

**Example matches:**
```csharp
app.MapGet("/api/products", GetProducts);
app.MapPost("/api/products", CreateProduct);
app.MapPut("/api/products/{id}", UpdateProduct);
app.MapDelete("/api/products/{id}", DeleteProduct);
```

### 2. 📋 **Attribute-Based HTTP Endpoints**
**Pattern:** `\[Http(Get|Post|Put|Delete|Patch)(\(.*\))?\]`

**What it finds:**
- HTTP method attributes on controller actions
- Both parameterized and non-parameterized attributes

**Example matches:**
```csharp
[HttpGet]
[HttpPost("/api/authenticate")]
[HttpPut("/api/users/{id}")]
[HttpDelete("/api/orders/{orderId}")]
```

### 3. 🛣️ **Route Attributes**
**Pattern:** `\[Route\s*\(`

**What it finds:**
- Explicit route definitions
- Controller-level and action-level routing

**Example matches:**
```csharp
[Route("api/[controller]")]
[Route("/api/v1/products")]
[Route("[controller]/[action]")]
```

### 4. 🎮 **Controller Action Methods**
**Pattern:** `public\s+(async\s+)?(Task<)?IActionResult`

**What it finds:**
- Traditional MVC action methods
- Both synchronous and asynchronous actions
- Methods returning `IActionResult` or `Task<IActionResult>`

**Example matches:**
```csharp
public IActionResult Index()
public async Task<IActionResult> GetUsers()
public Task<IActionResult> CreateOrder(OrderModel model)
```

### 5. 🏗️ **API Controllers**
**Pattern:** `\[ApiController\]`

**What it finds:**
- Controllers marked with the `[ApiController]` attribute
- Automatic model validation and binding behaviors

**Example matches:**
```csharp
[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
```

### 6. 📍 **Endpoint Registrations**
**Pattern:** `app\.Map.*\(` (excluding HTTP method maps)

**What it finds:**
- General endpoint registrations
- Health checks, fallback routes, and other mappings

**Example matches:**
```csharp
app.MapControllers();
app.MapHealthChecks("/health");
app.MapFallbackToFile("index.html");
```

### 7. 📚 **Swagger/OpenAPI Configurations**
**Pattern:** `WithOpenApi\(\)|WithTags\(|WithSummary\(`

**What it finds:**
- OpenAPI documentation configurations
- Swagger tags and summaries
- API documentation metadata

**Example matches:**
```csharp
.WithTags("Products")
.WithSummary("Get all products")
.WithOpenApi()
```

## 📊 Output Format

### Console Output
- **Color-coded sections** for easy reading
- **Real-time progress** as patterns are found
- **Summary statistics** at the end

### File Output (`{project_name}_rigrep_endpoints.txt`)
```
🔍 API Endpoints Extraction Report
Project: MyWebApp
Source Directory: ./MyWebApp
Generated: Thu Sep 18 14:07:09 IST 2025
=========================================================================================

🚀 MINIMAL API ENDPOINTS
-----------------------------------------------------------------------------------------
HTTP Method & Route: Get("/api/products",
   File: ProductEndpoints.cs
   Line: 15

🛣️ ROUTE ATTRIBUTES
-----------------------------------------------------------------------------------------
Route: [Route("api/[controller]")]
   File: ProductsController.cs
   Line: 8

📊 ENDPOINT SUMMARY
-----------------------------------------------------------------------------------------
📋 Minimal API Endpoints: 12
🏷️  HTTP Attribute Endpoints: 45
🛣️  Route Attributes: 8
🎮 Controller Actions: 38
🏗️  API Controllers: 6

🎯 Total HTTP Endpoints Found: 57
```

## 📈 Creating an API Inventory

The script output provides the foundation for creating a comprehensive API inventory. Here's how to transform the raw output into a structured inventory:

### Step 1: Parse the Output File

Use the generated `{project_name}_rigrep_endpoints.txt` file as your data source. The file contains structured sections that can be parsed programmatically.

### Step 2: Create Inventory Schema

Design a structured format for your API inventory:

```json
{
  "project": "ProjectName",
  "generated": "2025-09-18T14:07:09Z",
  "summary": {
    "totalEndpoints": 57,
    "minimalApiEndpoints": 12,
    "attributeEndpoints": 45,
    "controllers": 6
  },
  "endpoints": [
    {
      "id": "endpoint-001",
      "method": "GET",
      "route": "/api/products",
      "controller": "ProductsController",
      "action": "GetProducts",
      "file": "ProductsController.cs",
      "line": 25,
      "type": "attribute-based",
      "authentication": "required",
      "description": "Retrieves all products",
      "parameters": [],
      "responses": ["200", "401", "500"]
    }
  ]
}
```

### Step 3: Enhancement Scripts

Create additional scripts to enrich the basic endpoint data:

#### A. **Parameter Extraction Script**
```bash
#!/bin/bash
# Extract method parameters from endpoint definitions
rg -A 10 "public.*IActionResult.*\(" "$PROJECT_DIR" --type cs | \
grep -E "\w+\s+\w+[,\)]" > parameters.txt
```

#### B. **Authentication Detection Script**
```bash
#!/bin/bash
# Find authentication requirements
rg -B 5 -A 1 "\[Authorize\]|\[AllowAnonymous\]" "$PROJECT_DIR" --type cs > auth.txt
```

#### C. **Response Type Analysis Script**
```bash
#!/bin/bash
# Identify return types and status codes
rg "return.*Ok\(|return.*BadRequest\(|return.*NotFound\(" "$PROJECT_DIR" --type cs > responses.txt
```

### Step 4: Automated Inventory Generation

Create a master script that combines all analyses:

```bash
#!/bin/bash
# master_inventory.sh

PROJECT_DIR="$1"
OUTPUT_DIR="./inventory"

mkdir -p "$OUTPUT_DIR"

# Step 1: Extract endpoints
./extract_dotnet_api_endpoints.sh "$PROJECT_DIR"

# Step 2: Extract additional metadata
./extract_parameters.sh "$PROJECT_DIR" > "$OUTPUT_DIR/parameters.txt"
./extract_authentication.sh "$PROJECT_DIR" > "$OUTPUT_DIR/auth.txt"
./extract_responses.sh "$PROJECT_DIR" > "$OUTPUT_DIR/responses.txt"

# Step 3: Generate consolidated inventory
python3 ./scripts/generate_inventory.py \
  --endpoints "${PROJECT_DIR##*/}_rigrep_endpoints.txt" \
  --parameters "$OUTPUT_DIR/parameters.txt" \
  --auth "$OUTPUT_DIR/auth.txt" \
  --responses "$OUTPUT_DIR/responses.txt" \
  --output "$OUTPUT_DIR/api_inventory.json"

echo "✅ API inventory generated: $OUTPUT_DIR/api_inventory.json"
```

### Step 5: Inventory Enrichment

Add business context to your technical inventory:

1. **Business Domain Mapping**
   - Group endpoints by business capability
   - Add business owner information
   - Document business rules and constraints

2. **Security Classification**
   - Identify sensitive data endpoints
   - Document authentication requirements
   - Add authorization levels

3. **Performance Characteristics**
   - Add SLA requirements
   - Document expected load patterns
   - Identify caching strategies

4. **Integration Dependencies**
   - Map external service dependencies
   - Document database interactions
   - Identify message queue usage

### Step 6: Documentation Generation

Transform your inventory into various documentation formats:

```bash
# Generate OpenAPI specification
python3 ./scripts/generate_openapi.py \
  --inventory "$OUTPUT_DIR/api_inventory.json" \
  --output "$OUTPUT_DIR/openapi.yaml"

# Generate markdown documentation
python3 ./scripts/generate_docs.py \
  --inventory "$OUTPUT_DIR/api_inventory.json" \
  --template "./templates/api_docs.md" \
  --output "$OUTPUT_DIR/API_Documentation.md"

# Generate security analysis report
python3 ./scripts/security_analysis.py \
  --inventory "$OUTPUT_DIR/api_inventory.json" \
  --output "$OUTPUT_DIR/security_report.html"
```

## 🎯 Examples

### Example 1: E-commerce Application Analysis

```bash
./extract_dotnet_api_endpoints.sh ./eShopOnWeb-main
```

**Output highlights:**
- **33 total endpoints** discovered
- **7 minimal API endpoints** for catalog operations
- **26 attribute-based endpoints** for user management
- **2 API controllers** identified

### Example 2: Microservice Analysis

```bash
./extract_dotnet_api_endpoints.sh ./microservices/order-service
```

**Typical findings:**
- RESTful CRUD operations
- Health check endpoints
- Authentication endpoints
- Message handling endpoints

### Example 3: Legacy Application Assessment

```bash
./extract_dotnet_api_endpoints.sh ./legacy-monolith/src
```

**Value for migration:**
- Complete API surface mapping
- Dependency identification
- Refactoring candidates
- Breaking change analysis

## 🛠️ Troubleshooting

### Common Issues

#### 1. **ripgrep not found**
```bash
Error: rg: command not found
```
**Solution:** Install ripgrep using your package manager
```bash
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt install ripgrep
```

#### 2. **No endpoints found**
```bash
🎯 Total HTTP Endpoints Found: 0
```
**Possible causes:**
- Wrong directory specified
- No .NET project in the directory
- Non-standard naming conventions

**Solutions:**
- Verify the project structure: `ls -la src/`
- Check for .cs files: `find . -name "*.cs" | head -10`
- Run with verbose output: add `set -x` to script

#### 3. **Permission denied**
```bash
Permission denied: ./extract_dotnet_api_endpoints.sh
```
**Solution:** Make the script executable
```bash
chmod +x extract_dotnet_api_endpoints.sh
```

#### 4. **Output file not created**
- Check write permissions in the current directory
- Ensure disk space is available
- Verify the script completed successfully

### Performance Considerations

- **Large codebases**: The script should handle repositories with 100K+ files efficiently
- **Network drives**: May be slower on network-mounted filesystems
- **Memory usage**: ripgrep is memory-efficient, but very large matches might use significant RAM

### Customization

#### Adding New Patterns

To add support for additional endpoint patterns, modify the script:

```bash
# Add new search pattern
print_section "🔧 CUSTOM ENDPOINTS"
rg -n --type cs 'YourCustomPattern' "$SEARCH_DIR" | while IFS=: read -r file line content; do
    # Process matches
done
```

#### Filtering Results

Filter by specific patterns:

```bash
# Only find GET endpoints
rg -n --type cs '\[HttpGet\]|app\.MapGet' "$SEARCH_DIR"

# Only find controllers
rg -n --type cs '\[ApiController\]' "$SEARCH_DIR"
```

## 📚 Additional Resources

- [Ripgrep Documentation](https://github.com/BurntSushi/ripgrep)
- [ASP.NET Core Routing](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/routing)
- [Minimal APIs in .NET](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis)
- [OpenAPI Specification](https://swagger.io/specification/)

## 🤝 Contributing

To improve this script:

1. **Add new endpoint patterns** for frameworks not currently supported
2. **Enhance output formatting** for better readability
3. **Add export formats** (JSON, CSV, XML)
4. **Improve error handling** for edge cases
5. **Add configuration options** for customizable behavior

## 📄 License

This script is provided as-is for educational and professional use. Feel free to modify and distribute according to your organization's policies.

---

**Happy API hunting! 🔍✨**