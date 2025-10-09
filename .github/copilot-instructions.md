# .NET Documentation Wizard - Comprehensive Copilot Instructions

## Overview

The .NET Documentation Wizard provides three specialized workflows for enterprise-scale API discovery, mapping, and documentation. Each workflow serves a specific purpose in the comprehensive API analysis pipeline.

## Available Workflows

### 🔍 Workflow 1: Find Repositories with APIs
**Purpose**: Scan all repositories to identify which ones contain API definitions
**Trigger Patterns**: "Find all repositories with APIs", "Scan repositories for API definitions", "Run repository API discovery"
**Output**: `reports/repositories_with_apis.csv`

### 🗺️ Workflow 2: Map Known APIs to Repositories
**Purpose**: Map provided API lists to specific repositories and locations
**Trigger Patterns**: "Map known APIs to repositories", "Run API mapping workflow", "Execute Workflow 2"
**Output**: `reports/api_to_repository_mapping.csv`

### 📚 Workflow 3: Detailed Repository Analysis
**Purpose**: Generate comprehensive documentation for a specific repository
**Trigger Patterns**: "Generate comprehensive documentation", "Run detailed analysis", "Execute Workflow 3"
**Output**: Complete `analysis/` folder with comprehensive documentation

## Workflow Selection Logic

When user requests include:
- **"find", "scan", "discover" + "repositories"** → Execute Workflow 1
- **"map", "match", "align" + "API" + "repositories"** → Execute Workflow 2
- **"documentation", "analyze", "detailed" + specific repository** → Execute Workflow 3

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

### High-Level Analysis Only
- ✅ File structure scanning and pattern matching
- ✅ Project file analysis for technology identification
- ✅ README and documentation review for context
- ✅ Configuration file analysis for framework detection
- ❌ Detailed code examination or business logic analysis
- ❌ Individual endpoint extraction or security analysis
- ❌ Performance or architectural deep-dive

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

# 📚 WORKFLOW 3: DETAILED REPOSITORY ANALYSIS

## Execution Trigger Recognition

### Primary Triggers
- "Generate comprehensive documentation for this repository using Workflow 3"
- "Run detailed analysis workflow on repository: [path]"
- "Create complete API documentation for this .NET codebase"
- "Execute Workflow 3 detailed analysis on [repository-name]"

### Context Enhancement
- Use results from Workflows 1 & 2 if available for enhanced context
- Accept specific repository paths or work with current directory
- Leverage previous analysis for focused documentation

## Execution Phases

### Phase 1: Preparation and Validation
1. **Repository Path Validation**: Ensure target is valid .NET project
2. **Static Endpoint Extraction**: Execute `static_dotnet_endpoint_extractor`
3. **Analysis Folder Setup**: Create `analysis/` and `analysis/apis/` folders
4. **Context Integration**: Incorporate insights from previous workflows

### Phase 2: Documentation Generation
1. **Business Overview**: Generate `01_overview.md` with domain analysis
2. **Technical Details**: Create `02_technical_details.md` with architecture documentation
3. **API Inventory**: Generate `03_api_inventory.csv` with comprehensive API catalog
4. **Individual APIs**: Create detailed documentation for each endpoint

### Phase 3: Security and Business Analysis
1. **Sensitive Data Analysis**: Generate `04_sensitive_data_apis.md`
2. **Business Journeys**: Create `05_business_critical_journeys.md`
3. **OWASP Assessment**: Conduct security analysis for each API
4. **Compliance Mapping**: Identify regulatory considerations

### Phase 4: Validation and Finalization
1. **Coverage Validation**: Ensure 100% API documentation coverage
2. **Cross-Reference Verification**: Validate consistency across documents
3. **Quality Assurance**: Verify template compliance and markdown syntax
4. **Execution Summary**: Generate `workflow_execution_summary.md`

## Documentation Templates Integration

### Template Usage Guidelines
- **01_overview_template.md**: Business and domain overview structure
- **02_technical_details_template.md**: Technical architecture template
- **individual_api_template.md**: Individual API documentation format
- **workflow_execution_summary_template.md**: Execution summary structure

### Template Compliance Requirements
- Follow exact section structures from templates
- Maintain consistent formatting and terminology
- Include all required sections and subsections
- Use standardized code citation formats

## Static Endpoint Extraction Integration

### Extractor Workflow (Workflow 3 Only)
1. **Pre-Analysis**: Execute `static_dotnet_endpoint_extractor` script
2. **Pattern Extraction**: Use optimized ripgrep queries for API pattern identification
3. **Context Optimization**: Use pre-extracted data to preserve context for analysis
4. **Fallback Handling**: Graceful degradation if extractor unavailable

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
- 100% API documentation coverage
- Comprehensive security and business analysis
- Consistent cross-reference documentation
- Production-ready documentation assets
- Validated execution summary with actionable insights

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