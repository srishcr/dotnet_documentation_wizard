# .NET Documentation Wizard - Comprehensive Copilot Instructions

## Overview

The .NET Documentation Wizard provides five specialized workflows for enterprise-scale API discovery, mapping, documentation, and analysis. Each workflow serves a specific purpose in the comprehensive API analysis pipeline, supporting universal endpoint types and optimized for large codebases (20-30M LOC across 60-70 repositories).

## Five-Workflow Architecture

### 🔍 Workflow 1: Repository Discovery and API Identification
**Purpose**: Enterprise-scale repository scanning to identify which repositories contain API definitions
**Trigger Patterns**: "Find all repositories with APIs", "Scan repositories for API definitions", "Run repository API discovery", "Identify which repositories contain APIs"
**Output**: `reports/repositories_with_apis.csv`
**Efficiency**: Optimized for 20-30M LOC using Windows PowerShell commands

### 🗺️ Workflow 2: Intelligent API-to-Repository Mapping
**Purpose**: Map known API lists to specific repositories using intelligent matching algorithms
**Trigger Patterns**: "Map known APIs to repositories using my API list: [file]", "Run API mapping workflow", "Execute Workflow 2", "Match APIs to repositories"
**Output**: `reports/api_to_repository_mapping.csv`
**Dependencies**: Requires Workflow 1 output

### 📋 Workflow 3: Comprehensive Endpoint Inventory Creation
**Purpose**: Create complete endpoint inventory for ANY repository (ALL endpoint types)
**Trigger Patterns**: "Create endpoint inventory for repository: [repo]", "Generate comprehensive endpoint inventory", "Execute endpoint discovery workflow", "Extract all endpoints"
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoint_inventory.csv`
**Coverage**: REST APIs, ASP.NET WebForms, WCF Services, ASMX, Handlers, SignalR

### 📚 Workflow 4: Universal Endpoint Documentation
**Purpose**: Document every endpoint from inventory CSV with validation and gap detection
**Trigger Patterns**: "Document all endpoints from inventory", "Execute endpoint documentation workflow 4", "Generate comprehensive endpoint docs", "Create detailed documentation for all endpoints"
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoints/*.md` + `missed_endpoints.csv`
**Dependencies**: Requires Workflow 3 output (endpoint_inventory.csv)

### 🔍 Workflow 5: Granular Repository Analysis
**Purpose**: Business and technical analysis with granular execution options
**Trigger Patterns**: "Run overview only analysis", "Execute technical details only", "Generate sensitive data analysis only", "Create business journey analysis only", "Perform all analysis"
**Output**: Selected analysis files: `01_overview.md`, `02_technical_details.md`, `03_sensitive_data_analysis.md`, `04_business_critical_journeys.md`
**Flexibility**: Individual or combined analysis options

## Workflow Selection Logic

When user requests include:
- **"find", "scan", "discover" + "repositories"** → Execute Workflow 1
- **"map", "match", "align" + "API" + "repositories"** → Execute Workflow 2
- **"endpoint inventory", "create endpoint inventory", "extract endpoints"** → Execute Workflow 3
- **"document endpoints", "endpoint documentation", "workflow 4"** → Execute Workflow 4
- **"overview only", "technical details only", "sensitive data only", "business journey only", "all analysis"** → Execute Workflow 5

## Workflow Dependencies

- **Workflow 1**: Standalone (no dependencies)
- **Workflow 2**: Requires Workflow 1 output (`repositories_with_apis.csv`)
- **Workflow 3**: Standalone (optional enhancement from Workflows 1 & 2)
- **Workflow 4**: Requires Workflow 3 output (`endpoint_inventory.csv`)
- **Workflow 5**: Standalone (optional enhancement from endpoint inventory)

## Core Principles

### Efficiency and Scalability
- Use static analysis to minimize context overhead
- Handle large codebases without overwhelming token limits
- Leverage pre-extracted data for focused analysis
- Implement progressive analysis with validation checkpoints

### Comprehensive Coverage
- Support modern minimal APIs and traditional MVC patterns
- Document authentication, authorization, and security patterns
- Include business context alongside technical details
- Ensure 100% API documentation coverage for Workflow 3

### Actionable Intelligence
- Provide clear categorization and confidence levels
- Generate security assessments and business impact analysis
- Include precise code citations for traceability
- Create structured reports for enterprise governance

---

# 🔍 WORKFLOW 1: FIND REPOSITORIES WITH APIs

## Execution Trigger Recognition

### Primary Triggers
- "Find all repositories with APIs in the repositories folder"
- "Scan repositories for API definitions using Workflow 1"
- "Run repository API discovery workflow"
- "Identify which repositories contain APIs"

### Contextual Indicators
- User mentions analyzing multiple repositories
- Request for repository inventory or overview
- Need to understand API landscape across projects

## Execution Steps

### Phase 1: Repository Discovery
1. **Validate Environment**: Ensure `repositories/` folder exists
2. **Scan Structure**: List all subdirectories in repositories folder
3. **Initial Assessment**: Quick validation of folder contents

### Phase 2: .NET Project Identification
1. **Project File Detection**: Search for `*.csproj`, `*.sln` files
2. **Framework Identification**: Analyze project files for .NET versions
3. **Structure Analysis**: Determine mono-repo vs single-app architecture

### Phase 3: API Pattern Detection
1. **Controller Detection**: Search for files ending with `Controller.cs`
2. **Minimal API Detection**: Look for `MapGet`, `MapPost`, `MapPut`, `MapDelete` patterns
3. **Attribute Analysis**: Search for `[ApiController]`, `[Route]`, `[Http*]` attributes
4. **Configuration Analysis**: Look for Swagger/OpenAPI configurations

### Phase 4: Technology Stack Analysis
1. **Framework Analysis**: Extract .NET version and web frameworks
2. **Package Dependencies**: Analyze NuGet packages for technology identification
3. **Architecture Patterns**: Identify Clean Architecture, DDD, MVC patterns

### Phase 5: Report Generation
1. **CSV Creation**: Generate `reports/repositories_with_apis.csv`
2. **Data Validation**: Verify completeness and accuracy
3. **Summary Generation**: Provide execution summary to user

## CSV Report Format

```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
```

### Column Specifications
- **Repository Path**: Relative path from repositories folder
- **Contains APIs**: Yes/No based on API pattern detection
- **Repository Type**: Single App, Mono Repo, Library, Unknown
- **Summary**: 1-2 sentence description of repository purpose
- **Potential API Files**: Comma-separated list of files with API patterns
- **Technology Stack**: Key technologies (.NET version, frameworks, etc.)
- **Mono Repo Structure**: Semicolon-separated list of services/applications
- **Notes**: Additional observations or recommendations

## Analysis Approach

### Ultra-Efficient Analysis Only (CRITICAL for 20-30M LOC)
- ✅ **File system structure scanning** (ls, find commands)
- ✅ **Pattern matching without file reading** (grep for existence, not content)
- ✅ **Project file analysis** (.csproj/.sln only, first match)
- ✅ **README first 20 lines only** for business context
- ✅ **Bash command efficiency** (head, wc -l, existence checks)
- ❌ **NEVER read controller file contents**
- ❌ **NEVER examine business logic or service layers**
- ❌ **NEVER read full configuration files**
- ❌ **NEVER analyze test projects or documentation**
- ❌ **NEVER traverse bin/, obj/, node_modules/, .git/ folders**

### Efficiency Rules for Large Codebases (Cross-Platform)
- **Max 5 file reads per repository** (only .csproj, .sln, first 20 lines of README)
- **Use PowerShell/CMD on Windows** for counting and pattern detection
- **Skip repositories without .NET indicators** immediately
- **Batch operations** using Get-ChildItem, Select-String, Test-Path (Windows) or find/grep (Unix)
- **Pattern detection over content analysis** (existence checks vs file reading)

### Windows-Specific Efficiency Commands
```powershell
# Repository scanning
Get-ChildItem repositories\ -Directory | Select-Object -First 100

# .NET project detection
Test-Path "repositories\REPO\*.sln"
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj" | Select-Object -First 1

# API pattern detection
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]" -Recurse
(Get-ChildItem "repositories\REPO" -Recurse -Filter "*Controller.cs").Count

# Windows PowerShell pattern detection (recommended)
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]|MapGet" -Recurse
```

### Detection Patterns

#### .NET Project Indicators
```
*.csproj, *.sln, Program.cs, Startup.cs, appsettings.json
```

#### API Implementation Patterns
```
*Controller.cs files
[ApiController] attributes
[Route] attributes
[HttpGet/Post/Put/Delete] attributes
app.Map* method calls (minimal APIs)
Swagger/OpenAPI configurations
```

#### Technology Stack Indicators
```
<TargetFramework> in project files
Package references (Microsoft.AspNetCore.*)
Using statements analysis
Configuration patterns
```

---

# 🗺️ WORKFLOW 2: MAP KNOWN APIs TO REPOSITORIES

## Execution Trigger Recognition

### Primary Triggers
- "Map known APIs to repositories using my API list: [file]"
- "Run API mapping workflow with the provided API inventory"
- "Execute Workflow 2 to map APIs to repositories"
- "Match APIs to repositories using the discovery results"

### Prerequisites Validation
1. **Workflow 1 Dependency**: Verify `reports/repositories_with_apis.csv` exists
2. **API List Validation**: Confirm user-provided API list is accessible
3. **Format Support**: Validate CSV, Excel, or Markdown format

## Execution Steps

### Phase 1: Input Processing
1. **API List Parsing**: Read and standardize user-provided API list
2. **Repository Data Loading**: Load results from Workflow 1
3. **Data Normalization**: Standardize formats for matching algorithms
4. **Validation**: Verify data completeness and format integrity

### Phase 2: Matching Analysis
1. **Name-Based Matching**: Direct API name matches with repository names
2. **Domain Alignment**: Match business domains and functional areas
3. **Pattern Recognition**: Endpoint pattern matching with repository structure
4. **Technology Compatibility**: Align technology requirements with capabilities

### Phase 3: Confidence Scoring
1. **Multi-Factor Analysis**: Combine name, domain, pattern, and technology scores
2. **Confidence Assignment**: Calculate High (80-100%), Medium (50-79%), Low (20-49%)
3. **Alternative Identification**: Find secondary repository candidates
4. **Gap Analysis**: Identify APIs with no probable matches

### Phase 4: Report Generation
1. **Mapping Report**: Create `reports/api_to_repository_mapping.csv`
2. **Summary Statistics**: Generate matching success rates and distributions
3. **Recommendations**: Provide actionable next steps for each API

## Matching Algorithm

### Scoring Components
```
Final Score = (Name Similarity * 0.3) +
              (Domain Alignment * 0.25) +
              (Technology Match * 0.25) +
              (Pattern Match * 0.2)
```

### Confidence Levels
- **High (80-100%)**: Multiple strong indicators align
- **Medium (50-79%)**: Some indicators align, requires validation
- **Low (20-49%)**: Weak indicators, manual review needed
- **No Match (0-19%)**: No meaningful alignment found

## CSV Report Format

```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
```

---

# 📋 WORKFLOW 3: COMPREHENSIVE ENDPOINT INVENTORY CREATION

## Execution Trigger Recognition

### Primary Triggers
- "Create endpoint inventory for repository: [repo-name]"
- "Generate comprehensive endpoint inventory using Workflow 3"
- "Execute endpoint discovery workflow for [repo-name]/[sub-project]"
- "Extract all endpoints from [repository-name]"

### Universal Endpoint Support
- **REST APIs**: MVC Controllers, Web API Controllers, Minimal APIs
- **ASP.NET WebForms**: ASPX pages, code-behind methods, user controls, master pages
- **WCF Services**: Service contracts, operation contracts, SVC files
- **Legacy Services**: ASMX web services, WebMethods
- **HTTP Handlers**: ASHX generic handlers, custom HTTP handlers
- **Modern Patterns**: SignalR Hubs, OData Controllers, GraphQL endpoints

## Execution Phases

### Phase 1: Repository Analysis Setup
1. **Repository Path Validation**: Ensure target is valid .NET project
2. **Analysis Folder Creation**: Create centralized `{wizard_root}/analysis/{repo}/{sub_repo}/` structure
3. **Static Endpoint Extraction**: Execute optimized pattern detection
4. **Multi-Type Detection**: Scan for all endpoint types simultaneously

### Phase 2: Universal Endpoint Discovery
1. **Advanced Pattern Detection**: Use Windows PowerShell commands for efficiency
2. **Endpoint Classification**: Accurately classify all endpoint types
3. **Location Tracking**: Precise file paths and line numbers
4. **Metadata Extraction**: Gather endpoint parameters, methods, authentication

### Phase 3: Inventory Generation
1. **CSV Creation**: Generate comprehensive `endpoint_inventory.csv`
2. **Data Validation**: Verify completeness and accuracy
3. **Quality Assurance**: Ensure all endpoints are captured
4. **Summary Reporting**: Provide endpoint discovery statistics

### Advanced Pattern Detection (Windows Optimized)
```powershell
# Multi-type endpoint discovery
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*Controller.cs"  # REST APIs
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.aspx"          # WebForms
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.svc"           # WCF Services
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[WebMethod\]" -Recurse  # ASMX

# Windows PowerShell universal endpoint detection (recommended)
Select-String -Path "repositories\{repo}\*" -Pattern "class.*Controller|\.aspx|\.svc|\[WebMethod\]" -Recurse
```

# 📚 WORKFLOW 4: UNIVERSAL ENDPOINT DOCUMENTATION

## Execution Trigger Recognition

### Primary Triggers
- "Document all endpoints from inventory for [repo-name]"
- "Execute endpoint documentation workflow 4 for [repo-name]/[sub-project]"
- "Generate comprehensive endpoint docs using Workflow 4"
- "Create detailed documentation for all endpoints in CSV"

### Prerequisites
- Requires `endpoint_inventory.csv` from Workflow 3
- Access to source repository for code analysis

## Execution Phases

### Phase 1: Inventory Processing
1. **CSV Validation**: Verify endpoint inventory completeness
2. **Template Selection**: Choose appropriate templates for each endpoint type
3. **Documentation Planning**: Organize documentation generation approach
4. **Quality Setup**: Prepare validation and gap detection mechanisms

### Phase 2: Universal Endpoint Documentation
1. **Multi-Type Documentation**: Support ALL endpoint types with specific templates
2. **Individual Documentation**: Create detailed `.md` files for each endpoint
3. **Code Analysis**: Extract implementation details and security patterns
4. **Business Context**: Map endpoints to business domains and journeys

### Phase 3: Validation and Gap Detection
1. **Coverage Validation**: Ensure 100% endpoint documentation
2. **Gap Detection**: Identify missed endpoints during validation
3. **Missed Endpoints CSV**: Create `missed_endpoints.csv` if gaps found
4. **Quality Assurance**: Verify documentation completeness and accuracy

### Multi-Type Template Support
- **rest_api_endpoint_template.md**: HTTP methods, status codes, request/response examples
- **webform_endpoint_template.md**: Page lifecycle, controls, postback behavior, ViewState
- **wcf_service_endpoint_template.md**: Service contracts, SOAP operations, bindings
- **asmx_service_endpoint_template.md**: WebMethods, XML schema, SOAP messages
- **handler_endpoint_template.md**: HTTP processing, context handling
- **virtual_endpoint_template.md**: Configuration-based routing, virtual-to-physical mapping
- **generic_endpoint_template.md**: Fallback for unrecognized endpoint types

# 🔍 WORKFLOW 5: GRANULAR REPOSITORY ANALYSIS

## Execution Trigger Recognition

### Granular Trigger Patterns
- "Run overview only analysis for [repo-name]"
- "Execute technical details only for [repo-name]/[sub-project]"
- "Generate sensitive data analysis only for [repo-name]"
- "Create business journey analysis only for [repo-name]"
- "Perform all analysis for [repo-name]"

### Individual Analysis Options
1. **Business Overview** (`01_overview.md`) - Domain analysis and business context
2. **Technical Details** (`02_technical_details.md`) - Architecture and technical patterns
3. **Sensitive Data Analysis** (`03_sensitive_data_analysis.md`) - Security and compliance
4. **Business Journey Mapping** (`04_business_critical_journeys.md`) - Workflow analysis

## Execution Phases

### Phase 1: Analysis Selection
1. **Request Parsing**: Determine which analyses to perform
2. **Dependency Check**: Verify repository access and optional enhancements
3. **Template Selection**: Choose appropriate analysis templates
4. **Context Integration**: Leverage endpoint inventory if available

### Phase 2: Targeted Analysis Execution
1. **Selected Analysis**: Execute only requested analysis types
2. **Enhanced Context**: Use endpoint inventory for deeper insights
3. **Quality Documentation**: Generate high-quality business and technical insights
4. **Cross-Analysis Integration**: Ensure consistency and reference accuracy

### Phase 3: Summary and Validation
1. **Analysis Summary**: Create execution summary for completed analyses
2. **Quality Validation**: Verify analysis completeness and accuracy
3. **Integration Check**: Ensure cross-references are accurate
4. **Completion Report**: Provide summary of what was analyzed

---

# SECURITY AND BUSINESS ANALYSIS FRAMEWORK

## Sensitive Data Detection (Workflows 2 & 3)

### Detection Patterns
- **PII Indicators**: `email`, `phone`, `address`, `name`, `ssn`, `birth`, `id`
- **Financial Indicators**: `card`, `payment`, `billing`, `amount`, `account`, `transaction`, `balance`
- **Authentication Indicators**: `password`, `token`, `secret`, `credential`, `auth`
- **Confidential Indicators**: `internal`, `admin`, `private`, `confidential`, `config`

### Analysis Approach
1. **Pattern-based Analysis**: Field name scanning for sensitive data indicators
2. **Model Inspection**: Request/response model analysis for data types
3. **Security Classification**: API categorization by data sensitivity
4. **Compliance Mapping**: GDPR, PCI-DSS, and regulatory identification

## OWASP API Security Assessment (Workflow 3 Only)

### Risk Rating System
- **Red (High Risk)**: Immediate attention required, significant business impact
- **Amber (Medium Risk)**: Review recommended, moderate business impact
- **Green (Low Risk)**: Best practices followed, minimal business impact

### Assessment Categories
1. **API1:2023** - Broken Object Level Authorization
2. **API2:2023** - Broken Authentication
3. **API3:2023** - Broken Object Property Level Authorization
4. **API4:2023** - Unrestricted Resource Consumption
5. **API5:2023** - Broken Function Level Authorization
6. **API6:2023** - Unrestricted Access to Sensitive Business Flows
7. **API7:2023** - Server Side Request Forgery (SSRF)
8. **API8:2023** - Security Misconfiguration
9. **API9:2023** - Improper Inventory Management
10. **API10:2023** - Unsafe Consumption of APIs

## Business Journey Analysis (Workflows 2 & 3)

### Journey Identification Criteria
- Complex business logic patterns
- Financial transaction involvement
- User authentication dependencies
- External system integrations
- Core CRUD operations on business entities

### Analysis Components
1. **API Relationship Mapping**: Controller dependencies and service interactions
2. **Usage Pattern Recognition**: High-complexity and high-frequency operations
3. **Core Entity Analysis**: Mapping to business entities (users, orders, products)
4. **Workflow Sequencing**: Multi-step business process documentation

---

# ERROR HANDLING AND QUALITY ASSURANCE

## Error Handling Strategy

### Missing Dependencies (All Workflows)
- Graceful handling when required files are missing
- Clear error messages with resolution guidance
- Fallback mechanisms for tool unavailability
- Progressive execution with validation checkpoints

### Large Codebase Handling (Workflow 3)
- Chunked analysis for massive repositories
- Context management to avoid token limits
- Progress indicators for long-running operations
- Prioritization of high-value endpoints

### Validation Requirements (All Workflows)
- Report completeness verification
- Format validation for CSV outputs
- Cross-reference consistency checking
- Template compliance verification

## Quality Assurance Checks

### Documentation Standards (Workflow 3)
- Markdown syntax validation
- Template structure compliance
- Consistent formatting and terminology
- Code citation accuracy

### Coverage Requirements (Workflow 3)
- 100% API documentation coverage validation
- Cross-reference consistency verification
- Quality assurance reporting
- Comprehensive execution summaries

---

# EXECUTION INSTRUCTIONS

## User Interaction Protocol

### Workflow Identification
1. **Parse User Request**: Identify workflow through trigger patterns
2. **Validate Prerequisites**: Check for required dependencies
3. **Confirm Execution**: Clarify scope and parameters with user
4. **Execute Workflow**: Follow phase-by-phase execution plan

### Progress Communication
1. **Phase Announcements**: Clearly indicate current execution phase
2. **Progress Updates**: Provide status updates for long-running operations
3. **Completion Summaries**: Summarize results and next steps
4. **Error Reporting**: Clear error messages with resolution guidance

### Result Presentation
1. **Structured Output**: Present results in organized, actionable format
2. **File Locations**: Clearly indicate where outputs are created
3. **Success Metrics**: Report coverage, quality, and completion statistics
4. **Recommendations**: Provide next steps and improvement suggestions

## Success Criteria

### Workflow 1 Success
- Complete repository inventory generated
- Accurate API detection across all repositories
- Comprehensive technology stack analysis
- Actionable CSV report with business insights

### Workflow 2 Success
- Complete API-to-repository mapping
- Meaningful confidence level assignments
- Clear next steps for each mapped API
- Integration insights from Workflow 1 results

### Workflow 3 Success
- Universal endpoint detection (REST, WebForms, WCF, ASMX, Handlers, etc.)
- Accurate endpoint classification with precise location tracking
- Comprehensive CSV inventory with all required metadata
- Advanced pattern recognition for legacy and modern .NET applications

### Workflow 4 Success
- 100% endpoint documentation coverage from inventory CSV
- Universal template system supporting all endpoint types
- Validation process with gap detection and missed_endpoints.csv generation
- Quality documentation with meaningful content and code citations

### Workflow 5 Success
- Granular analysis execution based on user selection
- High-quality business and technical insights
- Security and compliance analysis with OWASP assessment integration
- Consistent cross-analysis integration and reference accuracy

## Extensibility and Customization

### Framework Adaptability
- Support for different .NET patterns and versions
- Extensible analysis patterns for new frameworks
- Configurable detection rules and criteria
- Scalable architecture for enterprise requirements

### Template Customization
- Organization-specific documentation templates
- Custom security assessment criteria
- Business-specific analysis patterns
- Branded documentation themes

### Integration Capabilities
- CI/CD pipeline integration potential
- Enterprise governance tool compatibility
- API management platform integration
- Security scanning tool coordination