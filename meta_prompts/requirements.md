# .NET Documentation Wizard - Comprehensive Enterprise API Analysis Platform

## System Overview

The .NET Documentation Wizard is a comprehensive enterprise platform for analyzing, mapping, and documenting APIs across multiple .NET repositories. It provides five specialized workflows that work independently or in sequence to deliver complete API landscape analysis, endpoint discovery, documentation, and governance capabilities.

## Five-Workflow Architecture

### 🔍 **Workflow 1: Repository Discovery and API Identification**
**Purpose**: Enterprise-scale repository scanning to identify which repositories contain API definitions
**Scope**: Analyze multiple repositories simultaneously with technology stack identification
**Output**: `reports/repositories_with_apis.csv`
**Efficiency**: Optimized for 20-30M LOC across 60-70 repositories using Windows PowerShell commands

### 🗺️ **Workflow 2: Intelligent API-to-Repository Mapping**
**Purpose**: Map known API lists to specific repositories using intelligent matching algorithms
**Scope**: Confidence-based mapping with multi-factor scoring and business intelligence
**Output**: `reports/api_to_repository_mapping.csv`
**Input**: User-provided API list (CSV/Excel/Markdown) + Workflow 1 results

### 📋 **Workflow 3: Comprehensive Endpoint Inventory Creation**
**Purpose**: Create complete endpoint inventory for ANY repository (ALL endpoint types)
**Scope**: REST APIs, ASP.NET WebForms, WCF Services, ASMX, Handlers, SignalR, etc.
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoint_inventory.csv`
**Coverage**: Universal endpoint detection with advanced pattern recognition

### 📚 **Workflow 4: Universal Endpoint Documentation**
**Purpose**: Document every endpoint from inventory CSV with validation and gap detection
**Scope**: Universal endpoint documentation supporting all endpoint types
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoints/*.md` + `missed_endpoints.csv`
**Validation**: 100% coverage validation with gap detection and missed endpoint identification

### 🔍 **Workflow 5: Granular Repository Analysis**
**Purpose**: Business and technical analysis with granular execution options
**Scope**: Individual or combined analysis (overview, technical, security, business journey)
**Output**: Selected analysis files: `01_overview.md`, `02_technical_details.md`, `03_sensitive_data_analysis.md`, `04_business_critical_journeys.md`
**Flexibility**: Run individual analyses or complete repository analysis

## Comprehensive Trigger Commands

### Workflow 1 Triggers (Repository Discovery)
```
"Find all repositories with APIs in the repositories folder"
"Scan repositories for API definitions using Workflow 1"
"Run repository API discovery workflow"
"Identify which repositories contain APIs"
```

### Workflow 2 Triggers (API Mapping)
```
"Map known APIs to repositories using my API list: [file_path]"
"Run API mapping workflow with the provided API inventory"
"Execute Workflow 2 to map APIs to repositories"
"Match APIs to repositories using the discovery results"
```

### Workflow 3 Triggers (Endpoint Inventory)
```
"Create endpoint inventory for repository: [repo-name]"
"Generate comprehensive endpoint inventory using Workflow 3"
"Execute endpoint discovery workflow for [repo-name]/[sub-project]"
"Extract all endpoints from [repository-name]"
```

### Workflow 4 Triggers (Endpoint Documentation)
```
"Document all endpoints from inventory for [repo-name]"
"Execute endpoint documentation workflow 4 for [repo-name]/[sub-project]"
"Generate comprehensive endpoint docs using Workflow 4"
"Create detailed documentation for all endpoints in CSV"
```

### Workflow 5 Triggers (Granular Analysis)
```
"Run overview only analysis for [repo-name]"
"Execute technical details only for [repo-name]/[sub-project]"
"Generate sensitive data analysis only for [repo-name]"
"Create business journey analysis only for [repo-name]"
"Perform all analysis for [repo-name]"
```

## Advanced Endpoint Detection Capabilities

### Universal Endpoint Support
- **REST APIs**: MVC Controllers, Web API Controllers, Minimal APIs
- **ASP.NET WebForms**: ASPX pages, code-behind methods, user controls, master pages
- **WCF Services**: Service contracts, operation contracts, SVC files
- **Legacy Services**: ASMX web services, WebMethods
- **HTTP Handlers**: ASHX generic handlers, custom HTTP handlers
- **Modern Patterns**: SignalR Hubs, OData Controllers, GraphQL endpoints

### Advanced Pattern Detection
```powershell
# Multi-type endpoint discovery (Windows optimized)
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*Controller.cs"  # REST APIs
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.aspx"          # WebForms
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.svc"           # WCF Services
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[WebMethod\]" -Recurse  # ASMX

# Cross-platform using ripgrep (recommended for large codebases)
rg "class.*Controller|\.aspx|\.svc|\[WebMethod\]" "repositories\{repo}"
```

## Centralized Analysis Structure

### Output Organization
```
dotnet_documentation_wizard/
├── analysis/                           # Centralized analysis folder
│   ├── eShopOnWeb-main/               # Repository-specific analysis
│   │   ├── PublicApi/                 # Sub-project analysis
│   │   │   ├── endpoint_inventory.csv
│   │   │   ├── endpoints/
│   │   │   │   ├── {repo}-endpoint-00001.md
│   │   │   │   └── ...
│   │   │   ├── missed_endpoints.csv   # If gaps found
│   │   │   ├── 01_overview.md
│   │   │   ├── 02_technical_details.md
│   │   │   ├── 03_sensitive_data_analysis.md
│   │   │   └── 04_business_critical_journeys.md
│   │   ├── Web/                       # Another sub-project
│   │   └── BlazorAdmin/
│   └── AnotherRepository/
├── reports/                           # Workflow 1 & 2 outputs
│   ├── repositories_with_apis.csv
│   └── api_to_repository_mapping.csv
└── repositories/                      # Source repositories
```

### Path Structure Benefits
- **Multi-repository analysis** without conflicts
- **Mono-repo sub-project separation**
- **Organized documentation management**
- **Easy comparison across repositories**
- **Scalable structure for enterprise environments**

## Cross-Platform Compatibility

### Windows Support (Primary)
```powershell
# Repository scanning
Get-ChildItem repositories\ -Directory | Select-Object -First 100

# Endpoint detection
(Get-ChildItem "repositories\REPO" -Recurse -Filter "*Controller.cs").Count
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]" -Recurse

# Framework detection
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj" |
    ForEach-Object { Select-String -Path $_.FullName -Pattern "<TargetFramework>" }
```

### Cross-Platform Alternative (Recommended for Large Codebases)
```bash
# Using ripgrep for optimal performance
rg "\[ApiController\]|MapGet|app\.Map" repositories/REPO --type cs
rg "<TargetFramework>" repositories/REPO --type xml
rg "\.aspx|\.svc|\[WebMethod\]" repositories/REPO
```

## Advanced Security and Compliance Framework

### Sensitive Data Detection Patterns
- **PII Indicators**: email, phone, address, name, ssn, birth, id, passport
- **Financial Indicators**: card, payment, billing, amount, account, transaction, balance, credit
- **Authentication Indicators**: password, token, secret, credential, auth, key, certificate
- **Confidential Indicators**: internal, admin, private, confidential, config, classified

### OWASP API Security Top 10 (2023) Assessment
Complete evaluation framework for each endpoint:
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

### Risk Rating System
- **Red (High Risk)**: Immediate attention required, significant business impact
- **Amber (Medium Risk)**: Review recommended, moderate business impact
- **Green (Low Risk)**: Best practices followed, minimal business impact

## Workflow Dependencies and Integration

### Dependency Matrix
- **Workflow 1**: Standalone (no dependencies)
- **Workflow 2**: Requires Workflow 1 output (`repositories_with_apis.csv`)
- **Workflow 3**: Standalone (optional enhancement from Workflows 1 & 2)
- **Workflow 4**: Requires Workflow 3 output (`endpoint_inventory.csv`)
- **Workflow 5**: Standalone (optional enhancement from endpoint inventory)

### Integration Patterns
```
Complete Analysis Pattern:
Workflow 1 → Workflow 3 → Workflow 4 → Workflow 5

API Mapping Pattern:
Workflow 1 → Workflow 2 → Workflow 3 → Workflow 4

Targeted Documentation:
Workflow 3 → Workflow 4 → Workflow 5 (granular)

Focused Analysis:
Workflow 5 (individual analysis options)
```

## Performance Optimizations for Enterprise Scale

### Large Codebase Efficiency (20-30M LOC, 60-70 repositories)
- **Max 5 file reads per repository** (Workflow 1)
- **PowerShell/CMD optimization** for Windows environments
- **Pattern detection over content analysis**
- **Batch operations** using Get-ChildItem, Select-String, Test-Path
- **Early termination** for non-.NET repositories
- **Parallel processing** for multiple analyses

### Memory Management
- **Streaming processing** for large CSV files
- **Chunked analysis** for massive repositories
- **Resource cleanup** between workflow executions
- **Context preservation** through static analysis tools

## Endpoint Documentation Templates

### Multi-Type Template Support
- **rest_api_endpoint_template.md**: HTTP methods, status codes, request/response examples
- **webform_endpoint_template.md**: Page lifecycle, controls, postback behavior, ViewState
- **wcf_service_endpoint_template.md**: Service contracts, SOAP operations, bindings
- **asmx_service_endpoint_template.md**: WebMethods, XML schema, SOAP messages
- **handler_endpoint_template.md**: HTTP processing, context handling
- **generic_endpoint_template.md**: Fallback for unrecognized endpoint types

### Universal Template Elements
- **Code Citation**: Exact file paths and line numbers
- **Security Analysis**: Authentication, authorization, input validation
- **Business Context**: Domain mapping, user journey integration
- **Dependencies**: Internal and external service dependencies
- **Performance**: Caching, async patterns, optimization opportunities

## Quality Assurance and Validation

### Validation Standards
- **Template Compliance**: All outputs follow standardized templates
- **Cross-Reference Validation**: Consistency across all documents
- **Markdown Syntax**: Valid formatting for all generated files
- **Coverage Requirements**: 100% endpoint documentation (Workflow 4)
- **Gap Detection**: Missed endpoints identified and documented

### Error Handling Strategy
- **Missing Dependencies**: Graceful fallback with clear error messages
- **Large Repositories**: Progressive analysis with context management
- **Permission Issues**: Clear guidance for resolution
- **Validation Failures**: Detailed reporting with remediation steps

## Success Criteria by Workflow

### Workflow 1 Success
- ✅ Complete repository inventory generated with technology stack identification
- ✅ Accurate API detection across all repositories using efficient PowerShell commands
- ✅ Valid CSV format with all required columns and mono-repo breakdown
- ✅ Performance optimized for large codebase analysis

### Workflow 2 Success
- ✅ All provided APIs have mapping entries with confidence levels
- ✅ Intelligent multi-factor scoring algorithm applied successfully
- ✅ Clear recommendations for each API with business context
- ✅ Integration with Workflow 1 results for enhanced accuracy

### Workflow 3 Success
- ✅ Universal endpoint detection (REST, WebForms, WCF, ASMX, Handlers, etc.)
- ✅ Accurate endpoint classification with precise location tracking
- ✅ Comprehensive CSV inventory with all required metadata
- ✅ Advanced pattern recognition for legacy and modern .NET applications

### Workflow 4 Success
- ✅ 100% endpoint documentation coverage from inventory CSV
- ✅ Universal template system supporting all endpoint types
- ✅ Validation process with gap detection and missed_endpoints.csv generation
- ✅ Quality documentation with meaningful content and code citations

### Workflow 5 Success
- ✅ Granular analysis execution based on user selection
- ✅ High-quality business and technical insights
- ✅ Security and compliance analysis with OWASP assessment integration
- ✅ Consistent cross-analysis integration and reference accuracy

## Enterprise Integration Features

### Static Endpoint Extraction (Workflow 3 Enhancement)
- **Efficiency Tool**: `static_dotnet_endpoint_extractor` using ripgrep
- **Context Preservation**: Pre-extract API patterns to save AI context
- **Fallback Strategy**: Graceful degradation if extractor unavailable
- **Large Codebase Support**: Handle enterprise-scale repositories efficiently

### Documentation Website Generation (Optional Extension)
- **MkDocs Integration**: Professional Material Design theme
- **Responsive Design**: Mobile-friendly with search functionality
- **Auto-Navigation**: Dynamic menu generation from endpoint inventory
- **Multi-Platform Deployment**: GitHub Pages, Netlify, Azure Static Web Apps

## File Structure Requirements

### Project Organization
```
dotnet_documentation_wizard/
├── 📋 Master Coordination Files
│   ├── workflow_orchestration.md           # Master workflow coordination
│   ├── user_runbook.md                     # User guide with clear triggers
│   └── .github/copilot-instructions.md     # Comprehensive AI instructions
├── 🔍 Individual Workflow Documentation
│   ├── workflow_1_find_apis.md             # Repository discovery workflow
│   ├── workflow_2_map_apis.md              # API mapping workflow
│   ├── workflow_3_endpoint_inventory.md    # Endpoint inventory creation
│   ├── workflow_4_endpoint_documentation.md # Universal endpoint documentation
│   └── workflow_5_repository_analysis.md   # Granular repository analysis
├── 📁 Supporting Infrastructure
│   ├── analysis/                           # Centralized analysis outputs
│   ├── reports/                            # Workflow 1 & 2 outputs
│   ├── templates/                          # Documentation templates
│   │   ├── endpoint_inventory_template.csv
│   │   ├── rest_api_endpoint_template.md
│   │   ├── webform_endpoint_template.md
│   │   ├── wcf_service_endpoint_template.md
│   │   ├── 01_overview_template.md
│   │   ├── 02_technical_details_template.md
│   │   ├── 03_sensitive_data_template.md
│   │   └── 04_business_critical_journeys_template.md
│   ├── static_dotnet_endpoint_extractor/   # Efficiency tool
│   ├── repositories/                       # Target repositories for analysis
│   └── meta_prompts/                       # Meta-requirements and prompts
```

## Implementation Instructions for AI Assistants

### Required Deliverables
When implementing this system, create:

1. **Master Coordination Files**
   - `workflow_orchestration.md` - Master workflow coordination with 5-workflow structure
   - `user_runbook.md` - Comprehensive user guide with all trigger commands
   - `.github/copilot-instructions.md` - Complete AI instructions for all workflows

2. **Individual Workflow Documentation**
   - `workflow_1_find_apis.md` - Repository discovery with Windows PowerShell optimization
   - `workflow_2_map_apis.md` - Intelligent API mapping with confidence scoring
   - `workflow_3_endpoint_inventory.md` - Universal endpoint discovery specification
   - `workflow_4_endpoint_documentation.md` - Multi-type endpoint documentation
   - `workflow_5_repository_analysis.md` - Granular analysis with individual options

3. **Template System**
   - `endpoint_inventory_template.csv` - Comprehensive endpoint catalog structure
   - Multi-type endpoint documentation templates (REST, WebForm, WCF, etc.)
   - Repository analysis templates (overview, technical, security, business journey)

4. **Supporting Infrastructure**
   - Centralized analysis folder structure
   - Cross-platform compatibility (Windows PowerShell + ripgrep)
   - Error handling and validation frameworks
   - Performance optimization for enterprise scale

### Implementation Validation
- **Trigger Pattern Consistency**: All files use identical trigger patterns
- **Dependency Clarity**: Prerequisites explicitly documented
- **Output Format Standardization**: Consistent CSV and markdown structures
- **Template Integration**: All workflows properly reference templates
- **Cross-Platform Support**: Windows commands with ripgrep alternatives

### Enterprise Readiness Requirements
- **Scalability**: Handle 60-70 repositories with 20-30M lines of code
- **Security**: Comprehensive OWASP assessment and sensitive data analysis
- **Governance**: Support enterprise API governance and compliance requirements
- **Maintainability**: Documentation structure supports ongoing updates and evolution
- **Performance**: Optimized for Windows environments with large codebase efficiency

## Meta-Prompt Validation

This specification provides complete requirements for building an enterprise-grade API analysis and documentation platform suitable for large-scale .NET environments. A successful implementation should enable:

1. **Clear Workflow Differentiation**: Unambiguous trigger patterns for each of 5 workflows
2. **Universal Endpoint Support**: Comprehensive detection of all .NET endpoint types
3. **Enterprise Scalability**: Efficient handling of massive codebases
4. **Quality Documentation**: Template-driven, consistent output across all workflows
5. **Granular Control**: Individual analysis options with combined workflow capabilities
6. **Cross-Platform Compatibility**: Windows optimization with universal alternatives
7. **Centralized Organization**: Structured analysis output supporting multiple repositories
8. **Validation and Quality Assurance**: Built-in gap detection and coverage validation

This comprehensive specification enables any AI coding assistant to recreate the entire .NET Documentation Wizard platform from scratch, maintaining enterprise-grade quality and performance standards.