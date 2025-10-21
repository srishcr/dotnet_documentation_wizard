# .NET Codebase Documentation Wizard

This project is created to create comprehensive documentation of any .net code repository. It needs to create assets in a subfolder within the code repository folder called "analysis":
1. Create a high level business and product focused overview of the repository along with a domain diagram (analysis/01_overview.md)
2. Create a high level technical overview of the repository containing details about the architecture, coding standards, security approach, domain model, flow diagram, high level API information (analysis/02_technical_details.md)
3. Create an inventory list of all APIs in the code repository as a CSV (analysis/03_api_inventory.csv). Each API can be codified (Ex: eshop-api-00001). The inventory should include sensitive data classification and business journey mapping.
4. Create a document for each API detailing the functional overview of the API, contract and request/response examples, citation to lines of code & files where the API is defined, authentication details of the API, classification of whether the API is for internal or external use, intended user roles, sensitive data analysis, OWASP API Security Top 10 assessment, and other important information. Each API should have its own file (Ex: analysis/apis/eshop-api-00001.md)
5. Create a comprehensive catalog of APIs handling potentially sensitive data (analysis/04_sensitive_data_apis.md)
6. Create an analysis of potential business-critical API workflows and journeys (analysis/05_business_critical_journeys.md)
7. Include validation to ensure 100% API documentation coverage and generate a comprehensive workflow execution summary (analysis/workflow_execution_summary.md)
8. Generate a navigable documentation website using MkDocs or Docsify with professional theming and deployment guidance


## Key Features and Capabilities

### Core Documentation Assets
- **Business Overview**: High-level product and domain analysis with visual diagrams
- **Technical Architecture**: Comprehensive technical documentation with security patterns
- **API Inventory**: Complete CSV catalog with unique identifiers, sensitivity classification, and business journey mapping
- **Individual API Documentation**: Detailed specifications for each endpoint with security analysis
- **Sensitive Data Analysis**: Catalog of APIs handling PII, financial, authentication, and confidential data
- **Business Journey Mapping**: Analysis of potential business-critical API workflows
- **Validation and Quality Assurance**: 100% API coverage validation with comprehensive reporting

### Security and Risk Assessment
- **OWASP API Security Top 10 Assessment**: Each API evaluated against industry-standard security framework
- **Risk Rating System**: Red/Amber/Green status indicators for security risks
- **Business Impact Analysis**: Technical security risks translated into business impact scenarios
- **Sensitive Data Detection**: Automated pattern recognition for PII, financial, authentication, and confidential data
- **Compliance Mapping**: GDPR, PCI-DSS, and regulatory consideration identification

### Business Analysis Features
- **Business Journey Identification**: Mapping of potential revenue-generating and customer-critical workflows
- **API Dependency Analysis**: Understanding of API relationships and workflow dependencies
- **Technical Complexity Assessment**: Identification of high-complexity operations requiring business attention
- **Usage Pattern Recognition**: Analysis of authentication patterns and access control structures

### Quality Assurance and Validation
- **Comprehensive Validation**: Automated checking to ensure all discovered APIs have documentation
- **Cross-Reference Validation**: Consistency verification across all documentation assets
- **Coverage Reporting**: Detailed statistics on documentation completeness
- **Workflow Execution Summary**: Transparent reporting of all analysis results and recommendations

### Documentation Website Generation
- **Static Website Creation**: Automated generation of navigable documentation website using MkDocs or Docsify
- **Responsive Design**: Mobile-friendly documentation with search functionality and organized navigation
- **Multi-Platform Deployment**: Support for GitHub Pages, Netlify, Azure Static Web Apps, and internal servers
- **Local Development Server**: Built-in capability for local documentation preview and testing
- **Auto-Generated Navigation**: Dynamic menu creation based on API inventory and documentation structure
- **Professional Theming**: Material Design theme with customizable branding and color schemes

## Approach

I want to have a copilot workflow for executing this documentation workflow, with a high level overview file (copilot instructions) and detailed instructions and templates for each part of the workflow. There should be a user_runbook.md file also which explains to the user how to trigger the workflow.

### Workflow Components Required
1. **Main Coordination Script** (workflow_orchestration.md) - Detailed step-by-step workflow execution guide
2. **Copilot Instructions** (.github/copilot-instructions.md) - High-level workflow overview and execution principles
3. **User Runbook** (user_runbook.md) - User-facing documentation for triggering and understanding the workflow
4. **Documentation Templates**:
   - 01_overview_template.md - Business and domain overview template
   - 02_technical_details_template.md - Technical architecture template
   - 03_api_inventory_template.md - API inventory CSV template with sensitivity and journey columns
   - individual_api_template.md - Individual API documentation template with OWASP security assessment
   - 04_sensitive_data_template.md - Sensitive data analysis template
   - 05_business_critical_journeys_template.md - Business journey analysis template
   - workflow_execution_summary_template.md - Execution summary template

### Workflow Execution Phases
The workflow should be structured in distinct phases:

**Phase 1: Preparation and Validation**
- Repository path validation and .NET project structure verification
- Static endpoint extraction using ripgrep-based analyzer
- Analysis folder structure setup

**Phase 2: Documentation Generation**
- Business overview creation with domain analysis
- Technical details documentation with architecture patterns
- API inventory generation with security and business analysis
- Individual API documentation with comprehensive security assessment

**Phase 3: Security and Business Analysis**
- Sensitive data pattern detection and cataloging
- Business-critical journey identification and mapping
- OWASP API Security Top 10 assessment for each endpoint

**Phase 4: Validation and Finalization**
- API documentation coverage validation (100% target)
- Cross-reference consistency verification
- Documentation website generation with MkDocs/Docsify
- Comprehensive workflow execution summary generation

### Static Endpoint Extraction Integration

### Static Endpoint Extraction Integration

I have built a static_dotnet_endpoint_extractor script using ripgrep in the static_dotnet_endpoint_extractor folder. The workflow should first run the script to extract the endpoints from the repository path specified by the user. Then, using the output of the extractor, it needs to create the API documentation. The reason for this is to make this workflow efficient even for large codebases and save copilot context by pre-extracting the endpoint patterns from files. It is designed to improve efficiency and help preserve context for copilot.

### Analysis Requirements

#### Sensitive Data Detection
The workflow must automatically identify APIs handling sensitive data through:
- **Pattern-based Analysis**: Scanning field names for PII, financial, authentication, and confidential data indicators
- **Model Inspection**: Analyzing request/response models for sensitive data types
- **Security Classification**: Categorizing APIs by data sensitivity for security review
- **Compliance Mapping**: Identifying potential GDPR, PCI-DSS, and regulatory considerations

Detection patterns should include:
- **PII Indicators**: email, phone, address, name, ssn, birth, id
- **Financial Indicators**: card, payment, billing, amount, account, transaction, balance
- **Authentication Indicators**: password, token, secret, credential, auth
- **Confidential Indicators**: internal, admin, private, confidential, config

#### Business Journey Analysis
The workflow must identify potential business-critical workflows through:
- **API Relationship Mapping**: Analyzing controller dependencies and service interactions
- **Usage Pattern Recognition**: Identifying high-complexity and high-frequency operations
- **Core Entity Analysis**: Mapping APIs to fundamental business entities (users, orders, products)
- **Workflow Sequencing**: Documenting potential multi-step business processes

Journey identification criteria:
- Complex business logic patterns
- Financial transaction involvement
- User authentication dependencies
- External system integrations
- Core CRUD operations on business entities

#### OWASP API Security Assessment
Each individual API documentation must include comprehensive security assessment against OWASP API Security Top 10 (2023):
- **Risk Rating System**: Red (high risk), Amber (medium risk), Green (low risk)
- **Technical Analysis**: Code-based evaluation of security implementations
- **Business Impact Assessment**: Description of how each risk could affect business operations
- **Remediation Guidance**: Specific recommendations for identified security gaps

Assessment must cover all 10 categories:
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

### Implementation Guidelines

#### Analysis Approach (Not Prescriptive)
The workflow should focus on **identification and analysis** rather than making business decisions:
- ✅ Detect sensitive data patterns in code
- ✅ Map potential business journeys
- ✅ Document security patterns found
- ✅ Present findings for business review
- ❌ Do NOT make monitoring recommendations
- ❌ Do NOT define SLAs or business requirements
- ❌ Do NOT make architectural decisions

#### Quality Assurance Requirements
- Markdown syntax validation for all generated files
- Template compliance verification for consistent structure
- File naming convention adherence (project-api-XXXXX format)
- 100% API documentation coverage validation
- Cross-reference consistency verification
- Comprehensive execution reporting

#### Error Handling Strategy
- Fallback to manual analysis if endpoint extractor fails
- Graceful handling of large codebases with context management
- Clear error reporting with resolution guidance
- Progressive workflow execution with validation checkpoints

### Expected Deliverables

I want you to create all the copilot workflow files based on this requirement. I have included a sample repository in the repositories/eShopOnWeb-main folder and the output of the endpoint extractor script in this file eShopOnWeb-main_rigrep_endpoints.txt for your reference.

### Expected Deliverables

When the workflow is complete, it should generate:

```
repository/
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

### Success Criteria

A successful workflow implementation should:
1. **Complete Documentation Coverage**: 100% of discovered APIs documented with validation confirmation
2. **Security Analysis Integration**: OWASP assessment and sensitive data analysis for all APIs
3. **Business Intelligence**: Business journey mapping and criticality analysis
4. **Quality Assurance**: Comprehensive validation and cross-reference verification
5. **Transparency**: Complete workflow execution summary with actionable insights
6. **Maintainability**: Documentation structure that supports ongoing updates and governance
7. **Compliance Readiness**: Security and compliance considerations documented for business review

### Reference Implementation

I have included a sample repository in the repositories/eShopOnWeb-main folder and the output of the endpoint extractor script in this file eShopOnWeb-main_rigrep_endpoints.txt for your reference.

### Generation Instructions

Generate all the required files based on this comprehensive requirement specification. The workflow should be production-ready and suitable for enterprise-grade API documentation and governance. Ask me any clarifications if required before you proceed.
