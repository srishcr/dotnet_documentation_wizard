# .NET Codebase Documentation Wizard - Copilot Instructions

## Overview

This workflow provides comprehensive documentation generation for .NET codebases. The system creates a complete analysis including business overview, technical architecture details, API inventory, and individual API documentation files.

## Workflow Purpose

This copilot workflow is designed to:
1. Analyze any .NET codebase comprehensively
2. Extract business and technical insights
3. Create structured documentation assets
4. Generate detailed API inventories and specifications
5. Provide actionable insights for development teams

## Key Components

### Documentation Assets Generated
- **01_overview.md**: High-level business and product overview with domain diagrams
- **02_technical_details.md**: Technical architecture, coding standards, and system design
- **03_api_inventory.csv**: Complete API inventory with sensitivity and business journey analysis
- **04_sensitive_data_apis.md**: Catalog of APIs handling potentially sensitive data
- **05_business_critical_journeys.md**: Analysis of potential business-critical API workflows
- **apis/**: Individual API documentation files with detailed specifications and security analysis
- **workflow_execution_summary.md**: Comprehensive validation results and execution summary

### Supporting Tools
- **Static Endpoint Extractor**: Pre-analyzes codebase using ripgrep for efficiency
- **Template System**: Consistent documentation structure
- **Automated Code Analysis**: Intelligent parsing of .NET patterns

## Workflow Execution Approach

### Phase 1: Preparation and Analysis
1. **Repository Path Validation**: Ensure valid .NET project structure
2. **Endpoint Extraction**: Run static analyzer to extract API patterns
3. **Codebase Structure Analysis**: Understand project organization and architecture

### Phase 2: Business Documentation
1. **Domain Analysis**: Identify business domains and capabilities
2. **Product Overview**: Create high-level business context
3. **Domain Diagrams**: Generate visual representations of business logic

### Phase 3: Technical Documentation
1. **Architecture Analysis**: Document system architecture and patterns
2. **Technology Stack**: Identify frameworks, libraries, and dependencies
3. **Security and Standards**: Document coding patterns and security approaches

### Phase 4: API Documentation
1. **API Inventory Creation**: Generate comprehensive CSV inventory with security and business analysis
2. **API Categorization**: Classify APIs by purpose, access patterns, data sensitivity, and business journey
3. **Individual API Documentation**: Create detailed specifications for each endpoint including security analysis

### Phase 5: Security and Business Analysis
1. **Sensitive Data Analysis**: Identify and catalog APIs handling sensitive information
2. **Business Critical Journey Mapping**: Analyze potential business-critical API workflows
### Phase 6: Validation and Finalization
1. **API Documentation Validation**: Ensure all APIs from inventory have documentation files
2. **Cross-Reference Validation**: Verify consistency across all documentation
3. **Workflow Execution Summary**: Generate comprehensive completion report

## Key Principles

### Efficiency First
- Use static analysis to reduce context overhead
- Process large codebases without overwhelming token limits
- Leverage pre-extracted endpoint data for focused analysis

### Comprehensive Coverage
- Analyze both modern minimal APIs and traditional MVC patterns
- Document authentication, authorization, and security patterns
- Include business context alongside technical details

### Actionable Insights
- Provide clear categorization (internal vs external APIs)
- Identify user roles and access patterns
- Include code citations for traceability

### Consistent Structure
- Use standardized templates for all documentation
- Maintain consistent API codification (e.g., eshop-api-00001)
- Follow established documentation patterns

## Execution Instructions

### When User Triggers Workflow

1. **Validate Input**
   - Confirm repository path exists
   - Verify .NET project structure
   - Check for endpoint extractor availability

2. **Run Endpoint Extraction**
   - Execute static_dotnet_endpoint_extractor script
   - Parse extracted endpoint data
   - Validate extraction results

3. **Create Analysis Folder**
   - Create `analysis/` subfolder in repository
   - Create `analysis/apis/` subfolder for individual API docs

4. **Generate Documentation Assets**
   - Execute in sequence: overview → technical → inventory → individual APIs
   - Use templates for consistent structure
   - Apply intelligent analysis for each component

5. **Validate Documentation Completeness**
   - Parse API inventory to extract all expected API codes
   - Compare existing API documentation files against inventory
   - Identify and create missing API documentation files
   - Generate validation report with coverage statistics

6. **Finalize and Summarize**
   - Perform cross-reference validation across all documents
   - Create comprehensive workflow execution summary including security and business analysis
   - Ensure all files are created successfully
   - Provide completion summary with security and business insights to user

## Template Usage Guidelines

### For 01_overview.md
- Focus on business value and product capabilities
- Use domain-driven design principles
- Include stakeholder perspectives
- Generate simple domain diagrams using Mermaid

### For 02_technical_details.md
- Document architecture patterns (layered, clean, etc.)
- Identify frameworks and key technologies
- Document security approaches and patterns
- Include technical diagrams for system flow

### For 03_api_inventory.csv
- Assign unique codes to each API (project-api-XXXXX format)
- Categorize by business domain
- Include access level classification
- Add discovery metadata (file paths, line numbers)

### For Individual API Files
- Use endpoint-specific code as filename
- Include comprehensive contract documentation
- Add request/response examples
- Cite exact code locations
- Document authentication requirements
- Conduct OWASP API Security Top 10 assessment with red/amber/green risk ratings
- Provide technical implementation context and business impact analysis for security risks

### For workflow_execution_summary.md
- Document all validation results and coverage statistics
- Provide comprehensive asset inventory with file details
- Include performance metrics and execution timeline
- Offer maintenance recommendations and next steps
- Generate actionable insights for development teams
- Include security and business analysis summaries

## Sensitive Data and Business Analysis

### Sensitive Data Detection
The workflow automatically identifies APIs handling potentially sensitive data through:

- **Pattern-based Analysis**: Scanning for field names indicating PII, financial, authentication, or confidential data
- **Model Inspection**: Analyzing request/response models for sensitive data types
- **Security Classification**: Categorizing APIs by data sensitivity for security review
- **Compliance Mapping**: Identifying potential GDPR, PCI-DSS, and regulatory considerations

#### Detection Patterns
- **PII Indicators**: `email`, `phone`, `address`, `name`, `ssn`, `birth`, `id`
- **Financial Indicators**: `card`, `payment`, `billing`, `amount`, `account`, `transaction`
- **Authentication Indicators**: `password`, `token`, `secret`, `credential`, `auth`
- **Confidential Indicators**: `internal`, `admin`, `private`, `confidential`, `config`

### Business Journey Analysis
The workflow identifies potential business-critical workflows through:

- **API Relationship Mapping**: Analyzing controller dependencies and service interactions
- **Usage Pattern Recognition**: Identifying high-complexity and high-frequency operations
- **Core Entity Analysis**: Mapping APIs to fundamental business entities (users, orders, products)
- **Workflow Sequencing**: Documenting potential multi-step business processes

#### Journey Identification Criteria
- Complex business logic patterns
- Financial transaction involvement
- User authentication dependencies
- External system integrations
- Core CRUD operations on business entities

### OWASP API Security Assessment
Each individual API documentation includes a comprehensive security assessment against the OWASP API Security Top 10 (2023):

- **Risk Rating System**: Red (high risk), Amber (medium risk), Green (low risk)
- **Technical Analysis**: Code-based evaluation of security implementations
- **Business Impact Assessment**: Description of how each risk could affect business operations
- **Remediation Guidance**: Specific recommendations for identified security gaps

#### OWASP Top 10 Categories Assessed:
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

## Validation Process

### API Documentation Validation
1. **Inventory Parsing**: Extract all API codes from `03_api_inventory.csv`
2. **File Verification**: Check existence of corresponding `.md` files in `apis/` directory
3. **Gap Analysis**: Identify missing API documentation files
4. **Documentation Generation**: Create missing API documentation using templates
5. **Coverage Reporting**: Generate validation statistics and completion status

### Cross-Reference Validation
1. **Domain Consistency**: Ensure business domains align across all documents
2. **API Classification**: Verify access levels and user roles are consistent
3. **Technical Accuracy**: Validate code citations and implementation details
4. **Link Verification**: Check internal references and cross-document links

### Quality Assurance Checks
- Markdown syntax validation for all generated files
- Template compliance verification for consistent structure
- File naming convention adherence (project-api-XXXXX format)
- Completeness verification for all required documentation sections

## Error Handling

### Missing Dependencies
- If endpoint extractor fails, provide manual analysis guidance
- Fall back to basic file scanning if ripgrep unavailable
- Provide clear error messages with resolution steps

### Large Codebases
- Use chunked analysis for massive repositories
- Prioritize high-value endpoints and controllers
- Provide progress indicators for long-running operations

### Incomplete Analysis
- Document areas requiring manual review
- Flag potential security concerns
- Identify missing documentation opportunities

## Quality Assurance

### Documentation Standards
- Ensure all generated files are valid Markdown
- Validate CSV format and structure
- Check for broken links and references

### Content Quality
- Verify business context accuracy
- Ensure technical details are current
- Validate API classifications and access levels

### Completeness Checks
- Confirm all discovered endpoints are documented
- Verify cross-reference consistency
- Ensure template compliance
- Validate API documentation coverage reaches 100%
- Check that workflow execution summary is comprehensive and actionable

## Success Criteria

A successful workflow execution should:
1. Create all required documentation files
2. Provide comprehensive API coverage (100% of discovered APIs documented)
3. Generate actionable business and technical insights
4. Maintain consistency across all documents
5. Enable easy maintenance and updates
6. Include validation summary with complete coverage statistics
7. Provide workflow execution summary for transparency and auditability

## Workflow Extensibility

This workflow is designed to be:
- **Framework Agnostic**: Adaptable to different .NET patterns
- **Template Driven**: Easy to customize documentation structure
- **Tool Independent**: Can work with or without static analyzer
- **Scalable**: Handles projects from small APIs to large enterprise systems

## Usage Context

This workflow is ideal for:
- Legacy system documentation
- API inventory and governance
- Security audit preparation
- Migration planning
- Developer onboarding
- Architecture review processes