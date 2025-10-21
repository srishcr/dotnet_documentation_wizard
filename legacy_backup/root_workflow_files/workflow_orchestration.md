# .NET Documentation Wizard - Master Workflow Orchestration

## Overview

This is the master coordination guide for the .NET Documentation Wizard's three specialized workflows. Each workflow serves a distinct purpose in the comprehensive API analysis and documentation pipeline.

## Workflow Architecture

### 🔍 **Workflow 1: Find Repositories with APIs**
**Purpose**: Repository discovery and API identification across multiple repositories
**Scope**: Enterprise-scale repository analysis
**Output**: `reports/repositories_with_apis.csv`

### 🗺️ **Workflow 2: Map Known APIs to Repositories**
**Purpose**: Intelligent mapping of known APIs to discovered repositories
**Scope**: API-to-repository alignment with confidence scoring
**Output**: `reports/api_to_repository_mapping.csv`

### 📋 **Workflow 3: API/Endpoint Inventory Creation**
**Purpose**: Comprehensive endpoint discovery for any repository (ALL endpoint types)
**Scope**: REST APIs, WebForms, WCF Services, ASMX, Handlers, SignalR, etc.
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoint_inventory.csv`

### 📚 **Workflow 4: Detailed Endpoint Documentation**
**Purpose**: Document every endpoint from inventory CSV with validation
**Scope**: Universal endpoint documentation with gap detection
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoints/*.md` + `missed_endpoints.csv`

### 🔍 **Workflow 5: Repository Analysis**
**Purpose**: Business and technical analysis with granular options
**Scope**: Individual or combined analysis (overview, technical, security, business journey)
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/*.md` (based on selected analyses)

## Workflow Selection Matrix

| User Request Pattern | Workflow | Key Indicators |
|---------------------|----------|----------------|
| "Find repositories with APIs" | Workflow 1 | "find", "scan", "discover", "repositories" |
| "Map APIs to repositories" | Workflow 2 | "map", "match", "API list", "align" |
| "Create endpoint inventory" | Workflow 3 | "endpoint inventory", "inventory", "extract endpoints" |
| "Document endpoints" | Workflow 4 | "document endpoints", "endpoint documentation", "document APIs" |
| "Repository analysis" | Workflow 5 | "analysis", "overview only", "technical details only", "sensitive data only", "business journey only", "all analysis" |
| "Run repository discovery" | Workflow 1 | Focus on multiple repositories |
| "Execute API mapping" | Workflow 2 | Mentions provided API list |
| "Generate comprehensive docs" | Workflow 4 | Focus on endpoint documentation |

## Execution Decision Logic

### Workflow Identification Process

1. **Parse User Request**: Analyze user input for workflow indicators
2. **Validate Prerequisites**: Check for required dependencies
3. **Confirm Workflow Selection**: Clarify with user if ambiguous
4. **Execute Selected Workflow**: Follow specific workflow instructions

### Prerequisite Dependencies

#### Workflow 1 Prerequisites
- ✅ Access to `repositories/` folder
- ✅ Read permissions for repository scanning
- ❌ No other dependencies

#### Workflow 2 Prerequisites
- ✅ Completed Workflow 1 (`reports/repositories_with_apis.csv`)
- ✅ User-provided API list (CSV, Excel, or Markdown)
- ✅ File access permissions

#### Workflow 3 Prerequisites
- 🔧 Optional: Results from Workflows 1 & 2 for enhanced context
- ✅ Target repository path
- ✅ Write permissions for analysis folder creation
- 🔧 Optional: `static_dotnet_endpoint_extractor` for efficiency

---

# 🔍 WORKFLOW 1: FIND REPOSITORIES WITH APIs

## Quick Reference
**File**: `workflow_1_find_apis.md`
**Triggers**: "Find repositories with APIs", "Scan repositories", "Repository discovery"
**Output**: `reports/repositories_with_apis.csv`

## Execution Summary (EFFICIENCY CRITICAL - 20-30M LOC)
1. **Ultra-Fast Repository Discovery**: Quick scan with immediate .NET filtering
2. **Minimal API Detection**: File system pattern matching (no content reading)
3. **Lightweight Technology Analysis**: Project files and README headers only
4. **Efficient Report Generation**: CSV creation with minimal data processing

⚠️ **LARGE CODEBASE WARNING**: For 60-70 repositories with millions of lines, use ONLY file system commands, pattern matching, and existence checks. Avoid reading file contents except for .csproj/.sln and first 20 lines of README.

🖥️ **WINDOWS COMPATIBILITY**: All workflows use PowerShell commands (Get-ChildItem, Select-String, Test-Path) with CMD fallbacks for optimal Windows performance.

## Key Detection Patterns
- Controller files (`*Controller.cs`)
- Minimal API patterns (`MapGet`, `MapPost`, etc.)
- API attributes (`[ApiController]`, `[Route]`)
- Project files (`.csproj`, `.sln`)

---

# 🗺️ WORKFLOW 2: MAP KNOWN APIs TO REPOSITORIES

## Quick Reference
**File**: `workflow_2_map_apis.md`
**Triggers**: "Map APIs to repositories", "API mapping workflow", "Execute Workflow 2"
**Input**: User API list + Workflow 1 results
**Output**: `reports/api_to_repository_mapping.csv`

## Execution Summary
1. **Input Processing**: Parse user API list and repository analysis
2. **Matching Analysis**: Apply multi-factor scoring algorithm
3. **Confidence Assessment**: Assign High/Medium/Low confidence levels
4. **Report Generation**: Create mapping with recommendations

## Confidence Scoring Formula
```
Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
        (Technology Match × 0.25) + (Pattern Match × 0.2)
```

---

# 📋 WORKFLOW 3: COMPREHENSIVE ENDPOINT INVENTORY CREATION

## Quick Reference
**File**: `workflow_3_endpoint_inventory.md`
**Triggers**: "Create endpoint inventory", "Generate endpoint inventory", "Extract endpoints", "Execute Workflow 3"
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoint_inventory.csv`

## Execution Summary
1. **Repository Analysis**: Validate target repository and setup analysis structure
2. **Universal Detection**: Scan for ALL endpoint types (REST, WebForms, WCF, ASMX, Handlers, SignalR)
3. **Inventory Creation**: Generate comprehensive endpoint catalog with metadata
4. **Quality Assurance**: Verify completeness and endpoint classification accuracy

## Endpoint Types Supported
- **REST APIs**: MVC Controllers, Web API Controllers, Minimal APIs
- **ASP.NET WebForms**: ASPX pages, code-behind methods, user controls
- **WCF Services**: Service contracts, operation contracts, SVC files
- **Legacy Services**: ASMX web services, WebMethods
- **HTTP Handlers**: ASHX generic handlers, custom HTTP handlers
- **Modern Patterns**: SignalR Hubs, OData Controllers, GraphQL endpoints

---

# 📚 WORKFLOW 4: UNIVERSAL ENDPOINT DOCUMENTATION

## Quick Reference
**File**: `workflow_4_endpoint_documentation.md`
**Triggers**: "Document endpoints", "Generate endpoint docs", "Create endpoint documentation", "Execute Workflow 4"
**Dependencies**: Requires Workflow 3 output (`endpoint_inventory.csv`)
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoints/*.md` + `missed_endpoints.csv`

## Execution Summary
1. **Inventory Processing**: Validate endpoint inventory from Workflow 3
2. **Universal Documentation**: Document ALL endpoint types using specific templates
3. **Validation**: Ensure 100% coverage with gap detection
4. **Quality Assurance**: Generate `missed_endpoints.csv` if gaps found

## Multi-Type Template System
- `rest_api_endpoint_template.md` - REST API endpoints
- `webform_endpoint_template.md` - ASP.NET WebForm pages
- `wcf_service_endpoint_template.md` - WCF service operations
- `asmx_service_endpoint_template.md` - ASMX web methods
- `handler_endpoint_template.md` - HTTP handlers
- `virtual_endpoint_template.md` - Configuration-based virtual endpoints
- `generic_endpoint_template.md` - Fallback for unrecognized types

---

# 🔍 WORKFLOW 5: GRANULAR REPOSITORY ANALYSIS

## Quick Reference
**File**: `workflow_5_repository_analysis.md`
**Triggers**: "overview only", "technical details only", "sensitive data only", "business journey only", "all analysis"
**Output**: Selected analysis files in `{wizard_root}/analysis/{repo}/{sub_repo}/`

## Execution Summary
1. **Analysis Selection**: Determine which analyses to perform based on user request
2. **Targeted Execution**: Execute only requested analysis types
3. **Enhanced Context**: Leverage endpoint inventory if available for deeper insights
4. **Quality Output**: Generate high-quality business and technical documentation

## Individual Analysis Options
- **Overview Only** (`01_overview.md`) - Business domain and context analysis
- **Technical Details Only** (`02_technical_details.md`) - Architecture and technical patterns
- **Sensitive Data Only** (`03_sensitive_data_analysis.md`) - Security and compliance analysis
- **Business Journey Only** (`04_business_critical_journeys.md`) - Business workflow mapping
- **All Analysis** - Generate all four analysis files

---

## Common Workflow Patterns

### Complete Analysis Pattern
For comprehensive enterprise analysis:
1. **Execute Workflow 1** → Get complete repository landscape
2. **Execute Workflow 3** → Create endpoint inventory for priority repositories
3. **Execute Workflow 4** → Document all endpoints with validation
4. **Execute Workflow 5** → Generate business and technical analysis

### API Mapping Pattern
For mapping known APIs to repositories:
1. **Execute Workflow 1** → Discover repositories with APIs
2. **Execute Workflow 2** → Map known API list to repositories
3. **Execute Workflow 3** → Create inventory for mapped repositories
4. **Execute Workflow 4** → Document endpoints

### Targeted Documentation Pattern
For specific repository endpoint documentation:
1. **Execute Workflow 3** → Create endpoint inventory for target repository
2. **Execute Workflow 4** → Document all endpoints with validation
3. **Execute Workflow 5** → Add business analysis (optional)

### Granular Analysis Pattern
For specific analysis needs:
- **Execute Workflow 5** → Run only needed analysis ("overview only", "technical only", etc.)

---

## Error Handling and Quality Assurance

### Universal Error Handling
- **Missing Dependencies**: Graceful fallback with clear error messages
- **Large Repositories**: Progressive analysis with context management
- **Permission Issues**: Clear guidance for resolution
- **Validation Failures**: Detailed reporting with remediation steps

### Quality Standards
- **Template Compliance**: All outputs follow standardized templates
- **Cross-Reference Validation**: Consistency across all documents
- **Markdown Syntax**: Valid formatting for all generated files
- **Coverage Requirements**: 100% endpoint documentation (Workflow 4)

---

## Integration Points

### File Dependencies
- **Workflow 2** requires output from **Workflow 1** (`repositories_with_apis.csv`)
- **Workflow 3** standalone (optional enhancement from Workflows 1 & 2)
- **Workflow 4** requires output from **Workflow 3** (`endpoint_inventory.csv`)
- **Workflow 5** standalone (optional enhancement from endpoint inventory)
- All workflows use shared **templates/** folder

### Tool Dependencies
- **PowerShell/CMD**: Windows optimization for all workflows
- **static_dotnet_endpoint_extractor**: Optional for Workflow 3 efficiency
- **File system access**: All workflows require appropriate permissions

---

## Success Validation

### Workflow 1 Success Criteria
- ✅ Complete repository inventory generated
- ✅ Accurate API detection across all repositories
- ✅ Valid CSV format with all required columns
- ✅ Technology stack properly identified

### Workflow 2 Success Criteria
- ✅ All provided APIs have mapping entries
- ✅ Confidence levels properly assigned
- ✅ Clear recommendations for each API
- ✅ Valid CSV format with comprehensive data

### Workflow 3 Success Criteria
- ✅ Universal endpoint detection (REST, WebForms, WCF, ASMX, Handlers, etc.)
- ✅ Accurate endpoint classification with precise location tracking
- ✅ Comprehensive CSV inventory with all required metadata
- ✅ Advanced pattern recognition for legacy and modern .NET applications

### Workflow 4 Success Criteria
- ✅ 100% endpoint documentation coverage from inventory CSV
- ✅ Universal template system supporting all endpoint types
- ✅ Validation process with gap detection and missed_endpoints.csv generation
- ✅ Quality documentation with meaningful content and code citations

### Workflow 5 Success Criteria
- ✅ Granular analysis execution based on user selection
- ✅ High-quality business and technical insights
- ✅ Security and compliance analysis with OWASP assessment integration
- ✅ Consistent cross-analysis integration and reference accuracy

---

## Maintenance and Updates

### Template Management
- **Location**: All templates stored in `templates/` folder
- **Customization**: Templates can be modified for organization-specific needs
- **Versioning**: Consider version control for template changes

### Workflow Updates
- **Individual Workflows**: Each workflow documented in separate `.md` files
- **Coordination**: This file serves as master orchestration guide
- **Dependencies**: Update all related files when making structural changes

### Tool Dependencies
- **PowerShell**: Windows-native pattern matching and file operations
- **static_dotnet_endpoint_extractor**: Maintain and enhance for better coverage
- **MkDocs/Docsify**: Update for latest documentation features

---

## Quick Start Guide

### For New Users
1. **Read**: `user_runbook.md` for comprehensive usage guide
2. **Review**: Individual workflow files for detailed execution steps
3. **Start**: With simple trigger commands from the user runbook

### For Administrators
1. **Templates**: Review and customize templates in `templates/` folder
2. **Configuration**: Ensure tool dependencies are properly installed
3. **Permissions**: Verify file system access for all workflow outputs

### For Developers
1. **Copilot Instructions**: Review `.github/copilot-instructions.md` for implementation details
2. **Extension**: Use individual workflow files as basis for enhancements
3. **Integration**: Consider CI/CD integration patterns for automated documentation

---

*This orchestration file serves as the master coordination guide. For detailed execution instructions, refer to the individual workflow files: `workflow_1_find_apis.md`, `workflow_2_map_apis.md`, `workflow_3_endpoint_inventory.md`, `workflow_4_endpoint_documentation.md`, and `workflow_5_repository_analysis.md`.*