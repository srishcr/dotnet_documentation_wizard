# Workflow 3: Detailed Repository Analysis and Documentation

## Overview

This workflow performs comprehensive documentation generation for a specific .NET repository. It creates detailed business overviews, technical specifications, API inventories, individual API documentation, and security assessments. This is the evolution of the original documentation wizard workflow.

## Purpose

- Generate comprehensive documentation for a specific .NET codebase
- Extract business and technical insights with detailed analysis
- Create structured documentation assets for enterprise use
- Provide detailed API inventories and specifications with security analysis
- Generate actionable insights for development teams and stakeholders

## Prerequisites

### Optional Inputs
- Output from Workflow 1 (`reports/repositories_with_apis.csv`) for context
- Output from Workflow 2 (`reports/api_to_repository_mapping.csv`) for focused analysis
- Specific repository path for analysis

### Required Tools
- **ripgrep** for efficient endpoint extraction
- Access to the static_dotnet_endpoint_extractor script
- Write permissions to create analysis folder

## Output Structure

Creates a comprehensive `analysis/` folder within the target repository:

```
target-repository/
├── analysis/
│   ├── 01_overview.md                    # Business and domain overview
│   ├── 02_technical_details.md           # Technical architecture details
│   ├── 03_api_inventory.csv              # Complete API inventory with security/business analysis
│   ├── 04_sensitive_data_apis.md         # Sensitive data handling APIs catalog
│   ├── 05_business_critical_journeys.md  # Business-critical workflow analysis
│   ├── workflow_execution_summary.md     # Comprehensive execution report
│   └── apis/                             # Individual API documentation
│       ├── {project}-api-00001.md        # Detailed API specs with OWASP assessment
│       ├── {project}-api-00002.md
│       └── ... (all discovered APIs)
```

## Execution Phases

### Phase 1: Preparation and Validation
1. **Repository Path Validation**: Ensure valid .NET project structure
2. **Static Endpoint Extraction**: Run endpoint extractor using ripgrep-based analyzer
3. **Analysis Folder Setup**: Create analysis folder structure
4. **Context Integration**: Incorporate insights from Workflows 1 & 2 if available

### Phase 2: Documentation Generation
1. **Business Overview Creation**: Analyze business domains and generate overview with domain diagrams
2. **Technical Details Documentation**: Document architecture patterns, technology stack, and security approaches
3. **API Inventory Generation**: Create comprehensive CSV inventory with security and business analysis
4. **Individual API Documentation**: Generate detailed specifications for each endpoint

### Phase 3: Security and Business Analysis
1. **Sensitive Data Pattern Detection**: Identify and catalog APIs handling sensitive information
2. **Business-Critical Journey Identification**: Map potential business-critical API workflows
3. **OWASP API Security Assessment**: Conduct comprehensive security assessment for each endpoint
4. **Compliance Mapping**: Identify potential GDPR, PCI-DSS, and regulatory considerations

### Phase 4: Validation and Finalization
1. **API Documentation Coverage Validation**: Ensure 100% coverage of discovered APIs
2. **Cross-Reference Consistency Verification**: Validate consistency across all documents
3. **Documentation Website Generation**: Create navigable documentation using MkDocs/Docsify
4. **Comprehensive Workflow Execution Summary**: Generate detailed completion report

## Documentation Assets Generated

### 01_overview.md - Business Overview
**Purpose**: High-level business and product-focused overview

**Content Includes**:
- Product purpose and value proposition analysis
- Business domain identification and classification
- Stakeholder analysis and user personas
- Domain diagrams using Mermaid notation
- Key business capabilities and features
- Business impact assessment

**Template Source**: `templates/01_overview_template.md`

### 02_technical_details.md - Technical Architecture
**Purpose**: Comprehensive technical documentation

**Content Includes**:
- Architecture patterns (Clean Architecture, MVC, layered, etc.)
- Technology stack and framework analysis
- Security approaches and implementation patterns
- Database design and data flow documentation
- System integration points and dependencies
- Performance and scalability considerations
- Development standards and coding conventions

**Template Source**: `templates/02_technical_details_template.md`

### 03_api_inventory.csv - API Inventory
**Purpose**: Complete API catalog with business and security analysis

**Content Includes**:
- Unique API identification codes (project-api-XXXXX format)
- HTTP methods and endpoint patterns
- Controller and action mappings
- Business domain classifications
- Access level categorization (internal/external)
- Sensitive data classification
- Business journey mapping
- File path citations with line numbers

**Template Source**: `templates/03_api_inventory_template.md`

### Individual API Documentation (apis/)
**Purpose**: Detailed specifications for each endpoint

**Content Includes**:
- Comprehensive endpoint specifications
- Request/response contract documentation
- Authentication and authorization requirements
- Error handling scenarios and status codes
- Code citations with exact file paths and line numbers
- OWASP API Security Top 10 assessment with risk ratings
- Business impact analysis for security risks
- Usage examples and integration guidance

**Template Source**: `templates/individual_api_template.md`

### 04_sensitive_data_apis.md - Sensitive Data Analysis
**Purpose**: Catalog APIs handling potentially sensitive data

**Content Includes**:
- Sensitive data pattern detection results
- PII, financial, authentication, and confidential data analysis
- Compliance considerations (GDPR, PCI-DSS)
- Risk assessment and classification
- Data flow analysis for sensitive information
- Recommendations for data protection

**Template Source**: `templates/04_sensitive_data_template.md`

### 05_business_critical_journeys.md - Business Journey Analysis
**Purpose**: Analysis of potential business-critical API workflows

**Content Includes**:
- API relationship mapping and dependencies
- Multi-step business process identification
- Core entity analysis (users, orders, products)
- Usage pattern recognition
- Critical workflow sequencing
- Business impact assessment for API failures

**Template Source**: `templates/05_business_critical_journeys_template.md`

### workflow_execution_summary.md - Execution Report
**Purpose**: Comprehensive validation results and execution summary

**Content Includes**:
- Complete asset inventory and validation results
- API documentation coverage statistics (target: 100%)
- Cross-reference consistency verification results
- Performance metrics and execution timeline
- Security and business analysis summaries
- Recommendations for maintenance and updates
- Quality assurance results and findings

**Template Source**: `templates/workflow_execution_summary_template.md`

## Static Endpoint Extraction Integration

### Extractor Workflow
1. **Pre-Analysis**: Run `static_dotnet_endpoint_extractor` script on target repository
2. **Pattern Extraction**: Extract API patterns using optimized ripgrep queries
3. **Efficiency Optimization**: Use pre-extracted data to reduce context usage
4. **Fallback Handling**: Graceful degradation if extractor fails

### Extractor Benefits
- **Performance**: Handles large codebases efficiently
- **Context Preservation**: Saves copilot context for analysis rather than extraction
- **Accuracy**: Purpose-built for .NET API pattern recognition
- **Scalability**: Works with enterprise-scale repositories

## Security Analysis Framework

### Sensitive Data Detection
**Automated pattern recognition for**:
- **PII Indicators**: email, phone, address, name, ssn, birth, id
- **Financial Indicators**: card, payment, billing, amount, account, transaction, balance
- **Authentication Indicators**: password, token, secret, credential, auth
- **Confidential Indicators**: internal, admin, private, confidential, config

### OWASP API Security Top 10 Assessment
**Comprehensive evaluation against**:
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

**Risk Rating System**: Red (high risk), Amber (medium risk), Green (low risk)

## Business Analysis Framework

### Business Journey Identification
**Analysis criteria**:
- Complex business logic patterns
- Financial transaction involvement
- User authentication dependencies
- External system integrations
- Core CRUD operations on business entities

### Business Impact Assessment
**Evaluation factors**:
- Revenue generation potential
- Customer experience impact
- Operational efficiency implications
- Compliance and regulatory considerations
- Data protection and privacy implications

## Quality Assurance Requirements

### Validation Process
1. **API Documentation Validation**: Ensure all discovered APIs have documentation files
2. **Cross-Reference Validation**: Verify consistency across all documentation assets
3. **Coverage Reporting**: Generate detailed statistics on documentation completeness
4. **Template Compliance**: Verify all files follow template structure
5. **Markdown Syntax Validation**: Ensure all generated files are valid Markdown

### Success Criteria
1. **Complete Documentation Coverage**: 100% of discovered APIs documented
2. **Security Analysis Integration**: OWASP assessment and sensitive data analysis for all APIs
3. **Business Intelligence**: Business journey mapping and criticality analysis
4. **Quality Assurance**: Comprehensive validation and cross-reference verification
5. **Transparency**: Complete workflow execution summary with actionable insights
6. **Maintainability**: Documentation structure supports ongoing updates and governance
7. **Compliance Readiness**: Security and compliance considerations documented for business review

## Error Handling Strategy

### Missing Dependencies
- Fallback to manual analysis if endpoint extractor fails
- Graceful handling of large codebases with context management
- Clear error reporting with resolution guidance
- Progressive workflow execution with validation checkpoints

### Large Codebase Handling
- Use chunked analysis for massive repositories
- Prioritize high-value endpoints and controllers
- Provide progress indicators for long-running operations
- Implement context management to avoid token limits

### Incomplete Analysis
- Document areas requiring manual review
- Flag potential security concerns for investigation
- Identify missing documentation opportunities
- Provide recommendations for addressing gaps

## Documentation Website Generation

### Static Website Creation
- Automated generation using MkDocs or Docsify
- Responsive design with mobile-friendly navigation
- Search functionality and organized menu structure
- Professional theming with customizable branding

### Deployment Options
- Support for GitHub Pages, Netlify, Azure Static Web Apps
- Local development server for preview and testing
- Auto-generated navigation based on API inventory
- Multi-platform deployment guidance

## Integration with Other Workflows

### Workflow 1 Integration
- Use repository analysis results for enhanced context
- Leverage technology stack insights for targeted analysis
- Apply mono-repo structure understanding for focused documentation

### Workflow 2 Integration
- Use API mapping results to prioritize analysis efforts
- Apply confidence levels to guide documentation depth
- Leverage location hints for efficient endpoint extraction

## Usage Context

### Primary Use Cases
- **Legacy System Documentation**: Comprehensive analysis of existing systems
- **API Inventory and Governance**: Enterprise-scale API management
- **Security Audit Preparation**: Security-focused analysis and documentation
- **Migration Planning**: Understanding current state for modernization efforts
- **Developer Onboarding**: Complete system documentation for new team members
- **Architecture Review**: Detailed analysis for technical reviews and assessments

### Enterprise Applications
- **Compliance Documentation**: Support for regulatory requirements
- **API Governance Programs**: Standardized documentation across organizations
- **Security Assessments**: Comprehensive security analysis and reporting
- **Business Impact Analysis**: Understanding business implications of technical decisions

## Customization and Extensibility

### Template Customization
- Organization-specific documentation templates
- Custom security assessment criteria
- Business-specific analysis patterns
- Branded documentation themes

### Framework Adaptability
- Support for different .NET patterns and versions
- Extensible analysis patterns for new frameworks
- Configurable detection rules and criteria
- Scalable architecture for enterprise requirements