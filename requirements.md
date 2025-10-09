# .NET Documentation Wizard - Enterprise API Analysis Platform

## Overview

The .NET Documentation Wizard is a comprehensive enterprise-scale platform for analyzing, mapping, and documenting APIs across multiple .NET repositories. It provides three specialized workflows that work independently or in sequence to deliver complete API landscape analysis and governance capabilities.

## System Architecture

### Three-Workflow Architecture

#### 🔍 **Workflow 1: Repository Discovery and API Identification**
**Purpose**: Enterprise-scale repository scanning to identify which repositories contain API definitions
**Scope**: Analyze multiple repositories simultaneously with technology stack identification
**Output**: `reports/repositories_with_apis.csv` - Comprehensive repository inventory

#### 🗺️ **Workflow 2: Intelligent API-to-Repository Mapping**
**Purpose**: Map known API lists to specific repositories using intelligent matching algorithms
**Scope**: Confidence-based mapping with multi-factor scoring and business intelligence
**Output**: `reports/api_to_repository_mapping.csv` - API mapping with confidence levels

#### 📚 **Workflow 3: Comprehensive Repository Documentation**
**Purpose**: Deep technical and business analysis with enterprise-grade security assessment
**Scope**: Complete documentation generation with OWASP security analysis and business journey mapping
**Output**: Complete `analysis/` folder structure with all documentation assets

### Workflow Integration Patterns

#### Sequential Enterprise Pattern
```
Workflow 1 → Workflow 2 → Workflow 3 (on priority repositories)
```
For comprehensive enterprise API landscape understanding

#### Focused Documentation Pattern
```
Workflow 3 (standalone)
```
For specific repository documentation when target is known

#### API Governance Pattern
```
Workflow 1 → Workflow 3 (on multiple repositories)
```
For API inventory and compliance documentation

## Core Capabilities

### 🔍 **Workflow 1: Repository Discovery**

#### Repository Analysis Features
- **Multi-Repository Scanning**: Analyze all repositories in `repositories/` folder
- **Technology Stack Identification**: Detect .NET versions, frameworks, and architecture patterns
- **Mono-Repo Support**: Break down mono-repositories into individual services/applications
- **API Pattern Detection**: Identify controllers, minimal APIs, and web API patterns
- **Business Context Analysis**: High-level repository purpose identification

#### Detection Patterns
- **Project Indicators**: `*.csproj`, `*.sln`, `Program.cs`, `Startup.cs`
- **API Patterns**: `*Controller.cs`, `[ApiController]`, `MapGet/Post/Put/Delete`
- **Framework Detection**: ASP.NET Core, Web API, MVC patterns
- **Architecture Recognition**: Clean Architecture, DDD, microservices

#### Output Format: repositories_with_apis.csv
```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
```

### 🗺️ **Workflow 2: API Mapping Intelligence**

#### Intelligent Matching System
- **Multi-Factor Scoring**: Name similarity, domain alignment, technology compatibility, pattern matching
- **Confidence Levels**: High (80-100%), Medium (50-79%), Low (20-49%), No Match (0-19%)
- **Alternative Suggestions**: Multiple repository candidates per API
- **Gap Analysis**: Identify APIs not found in any repository

#### Input Format Support
- **CSV Files**: Standard comma-separated format
- **Excel Files**: .xlsx format support
- **Markdown Files**: Structured list format

#### Scoring Algorithm
```
Final Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
              (Technology Match × 0.25) + (Pattern Match × 0.2)
```

#### Output Format: api_to_repository_mapping.csv
```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
```

### 📚 **Workflow 3: Enterprise Documentation**

#### Documentation Assets Generated
1. **01_overview.md**: Business and domain overview with visual diagrams
2. **02_technical_details.md**: Technical architecture and security patterns
3. **03_api_inventory.csv**: Complete API catalog with unique identifiers
4. **04_sensitive_data_apis.md**: Sensitive data handling analysis
5. **05_business_critical_journeys.md**: Business-critical workflow mapping
6. **workflow_execution_summary.md**: Comprehensive execution report
7. **apis/**: Individual API documentation with OWASP security assessment

#### Advanced Security Analysis
- **OWASP API Security Top 10 (2023)**: Complete assessment for each API
- **Risk Rating System**: Red/Amber/Green classification with business impact analysis
- **Sensitive Data Detection**: Automated pattern recognition for PII, financial, authentication data
- **Compliance Mapping**: GDPR, PCI-DSS, and regulatory consideration identification

#### Business Intelligence Features
- **Domain Analysis**: Business domain identification and mapping
- **Journey Mapping**: Business-critical workflow identification
- **Stakeholder Analysis**: User role and access pattern documentation
- **Impact Assessment**: Business implications of technical security findings

## Implementation Requirements

### Trigger Pattern Specification

#### Workflow 1 Triggers
```
"Find all repositories with APIs in the repositories folder"
"Scan repositories for API definitions using Workflow 1"
"Run repository API discovery workflow"
"Identify which repositories contain APIs"
```

#### Workflow 2 Triggers
```
"Map known APIs to repositories using my API list: [file_path]"
"Run API mapping workflow with the provided API inventory"
"Execute Workflow 2 to map APIs to repositories"
"Match APIs to repositories using the discovery results"
```

#### Workflow 3 Triggers
```
"Generate comprehensive documentation for this repository using Workflow 3"
"Run detailed analysis workflow on repository: [path]"
"Create complete API documentation for this .NET codebase"
"Execute Workflow 3 detailed analysis on [repository-name]"
```

### Workflow Selection Logic
```
IF request contains ("find" OR "scan" OR "discover") AND "repositories"
   THEN execute Workflow 1

IF request contains ("map" OR "match" OR "align") AND "API" AND "repositories"
   THEN execute Workflow 2

IF request contains ("documentation" OR "analyze" OR "detailed") AND specific_repository
   THEN execute Workflow 3
```

### Dependency Management

#### Workflow 1 Dependencies
- ✅ Access to `repositories/` folder
- ✅ Read permissions for repository scanning
- ❌ No external dependencies

#### Workflow 2 Dependencies
- ✅ Completed Workflow 1 (`reports/repositories_with_apis.csv`)
- ✅ User-provided API list (CSV, Excel, or Markdown)
- ✅ File access permissions

#### Workflow 3 Dependencies
- 🔧 Optional: Results from Workflows 1 & 2 for enhanced context
- ✅ Target repository path
- ✅ Write permissions for analysis folder creation
- 🔧 Optional: `static_dotnet_endpoint_extractor` for efficiency

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
│   └── workflow_3_detailed_analysis.md     # Detailed documentation workflow
├── 📁 Supporting Infrastructure
│   ├── reports/                            # Workflow 1 & 2 outputs
│   ├── templates/                          # Documentation templates
│   ├── static_dotnet_endpoint_extractor/   # Efficiency tool for Workflow 3
│   ├── repositories/                       # Target repositories for analysis
│   └── meta_prompts/                       # Meta-requirements and prompts
```

### Template System
All workflows use standardized templates for consistent output:
- `01_overview_template.md` - Business and domain overview
- `02_technical_details_template.md` - Technical architecture
- `03_api_inventory_template.md` - API inventory format
- `individual_api_template.md` - Individual API documentation
- `04_sensitive_data_template.md` - Sensitive data analysis
- `05_business_critical_journeys_template.md` - Business journey analysis
- `workflow_execution_summary_template.md` - Execution summary

## Security and Compliance Framework

### Sensitive Data Detection Patterns
- **PII Indicators**: email, phone, address, name, ssn, birth, id
- **Financial Indicators**: card, payment, billing, amount, account, transaction, balance
- **Authentication Indicators**: password, token, secret, credential, auth
- **Confidential Indicators**: internal, admin, private, confidential, config

### OWASP API Security Top 10 (2023) Assessment
Each API (Workflow 3) must be evaluated against:
1. API1:2023 - Broken Object Level Authorization
2. API2:2023 - Broken Authentication
3. API3:2023 - Broken Object Property Level Authorization
4. API4:2023 - Unrestricted Resource Consumption
5. API5:2023 - Broken Function Level Authorization
6. API6:2023 - Unrestricted Access to Sensitive Business Flows
7. API7:2023 - Server Side Request Forgery (SSRF)
8. API8:2023 - Security Misconfiguration
9. API9:2023 - Improper Inventory Management
10. API10:2023 - Unsafe Consumption of APIs

### Risk Rating System
- **Red (High Risk)**: Immediate attention required, significant business impact
- **Amber (Medium Risk)**: Review recommended, moderate business impact
- **Green (Low Risk)**: Best practices followed, minimal business impact

## Quality Assurance Requirements

### Validation Standards
- **Template Compliance**: All outputs follow standardized templates
- **Cross-Reference Validation**: Consistency across all documents (Workflow 3)
- **Markdown Syntax**: Valid formatting for all generated files
- **Coverage Requirements**: 100% API documentation (Workflow 3 only)
- **File Naming**: Consistent conventions (project-api-XXXXX format)

### Error Handling Strategy
- **Missing Dependencies**: Graceful fallback with clear error messages
- **Large Repositories**: Progressive analysis with context management
- **Permission Issues**: Clear guidance for resolution
- **Validation Failures**: Detailed reporting with remediation steps

### Success Criteria

#### Workflow 1 Success
- ✅ Complete repository inventory generated
- ✅ Accurate API detection across all repositories
- ✅ Valid CSV format with all required columns
- ✅ Technology stack properly identified

#### Workflow 2 Success
- ✅ All provided APIs have mapping entries
- ✅ Confidence levels properly assigned
- ✅ Clear recommendations for each API
- ✅ Valid CSV format with comprehensive data

#### Workflow 3 Success
- ✅ 100% API documentation coverage achieved
- ✅ All templates properly populated
- ✅ Security analysis completed for all APIs
- ✅ Cross-reference validation successful
- ✅ Execution summary comprehensive and actionable

## Enterprise Integration Features

### Static Endpoint Extraction (Workflow 3)
- **Efficiency Tool**: `static_dotnet_endpoint_extractor` using ripgrep
- **Context Preservation**: Pre-extract API patterns to save AI context
- **Fallback Strategy**: Graceful degradation if extractor unavailable
- **Large Codebase Support**: Handle enterprise-scale repositories

### Documentation Website Generation (Workflow 3)
- **MkDocs Integration**: Professional Material Design theme
- **Docsify Alternative**: Lightweight documentation framework
- **Responsive Design**: Mobile-friendly with search functionality
- **Deployment Options**: GitHub Pages, Netlify, Azure Static Web Apps
- **Auto-Navigation**: Dynamic menu generation from API inventory

### CI/CD Integration Potential
- **Automated Execution**: Workflow triggers for CI/CD pipelines
- **Quality Gates**: Documentation coverage and security assessment integration
- **Governance**: API compliance checking and reporting

## Analysis Approach Guidelines

### Identification vs. Prescription
The workflows focus on **identification and analysis** rather than making business decisions:
- ✅ Detect sensitive data patterns in code
- ✅ Map potential business journeys
- ✅ Document security patterns found
- ✅ Present findings for business review
- ❌ Do NOT make monitoring recommendations
- ❌ Do NOT define SLAs or business requirements
- ❌ Do NOT make architectural decisions

### Business Context Integration
- **Domain-Driven Analysis**: Identify business domains from code structure
- **Stakeholder Mapping**: Analyze user roles from authentication patterns
- **Journey Identification**: Map potential business workflows from API relationships
- **Impact Assessment**: Translate technical findings to business implications

## Implementation Instructions

### Required Deliverables
When implementing this system, create:

1. **Master Coordination Files**
   - `workflow_orchestration.md` - Master workflow coordination with clear selection logic
   - `user_runbook.md` - User guide with unambiguous trigger patterns
   - `.github/copilot-instructions.md` - Comprehensive AI instructions for all workflows

2. **Individual Workflow Documentation**
   - `workflow_1_find_apis.md` - Complete repository discovery specification
   - `workflow_2_map_apis.md` - Intelligent API mapping specification
   - `workflow_3_detailed_analysis.md` - Comprehensive documentation specification

3. **Supporting Infrastructure**
   - `reports/` folder creation
   - Template validation and consistency
   - Clear dependency documentation
   - Error handling specifications

### Validation Requirements
- **Trigger Pattern Consistency**: Ensure all files use identical trigger patterns
- **Dependency Clarity**: Clear prerequisite requirements for each workflow
- **Output Format Standardization**: Consistent CSV and markdown formats
- **Template Compliance**: All outputs follow established templates

### Enterprise Readiness
- **Scalability**: Handle multiple repositories and large codebases
- **Security**: Comprehensive security analysis and risk assessment
- **Governance**: Support enterprise API governance requirements
- **Maintainability**: Documentation structure supports ongoing updates

## Success Validation

A successful implementation should enable:
1. **Clear Workflow Selection**: Unambiguous trigger patterns for each workflow
2. **Independent Execution**: Each workflow operates standalone when needed
3. **Sequential Integration**: Workflows enhance each other when used in sequence
4. **Enterprise Scale**: Handle multiple repositories and complex architectures
5. **Security Focus**: Comprehensive security analysis and risk assessment
6. **Business Intelligence**: Meaningful business context and impact analysis
7. **Quality Assurance**: Validation and consistency across all outputs

This specification provides complete requirements for building an enterprise-grade API analysis and documentation platform suitable for large-scale .NET environments with comprehensive security and governance capabilities.