# Workflow 4: Universal Endpoint Documentation

## Purpose
This workflow documents every endpoint from an endpoint inventory CSV with validation and gap detection. It supports ALL endpoint types through a universal template system with 100% coverage validation.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Document all endpoints from inventory"
- "Execute endpoint documentation workflow"
- "Generate comprehensive endpoint docs"
- "Create detailed documentation for all endpoints"
- "Run Workflow 4"
- "Document endpoints using inventory CSV"

## Input Requirements
- **Endpoint inventory CSV** from Workflow 3 (or provided as context)
- **Repository access** for code analysis and citation
- **Target repository path** for documentation generation

## Output
Creates:
- `analysis/{repo_name}/{sub_repo}/endpoints/*.md` - Individual endpoint documentation
- `missed_endpoints.csv` - Gap detection report (if gaps found)

## Universal Template System

### Multi-Type Template Support
- **rest_api_endpoint_template.md**: REST API endpoints with HTTP methods
- **webform_endpoint_template.md**: ASP.NET WebForm pages and controls
- **wcf_service_endpoint_template.md**: WCF service operations and contracts
- **asmx_service_endpoint_template.md**: ASMX web methods and SOAP
- **handler_endpoint_template.md**: HTTP handlers and request processing
- **virtual_endpoint_template.md**: Configuration-based virtual endpoints
- **generic_endpoint_template.md**: Fallback for unrecognized types

### Universal Documentation Elements
- **Code Citation**: Exact file paths and line numbers
- **Security Analysis**: Authentication, authorization, input validation
- **Business Context**: Domain mapping, user journey integration
- **Dependencies**: Internal and external service dependencies
- **Performance**: Caching, async patterns, optimization opportunities

## Execution Strategy

### Phase 1: Inventory Processing
1. **CSV Validation**: Verify endpoint inventory format and completeness
2. **Endpoint Classification**: Group endpoints by type for template selection
3. **Repository Validation**: Confirm access to source repository
4. **Template Mapping**: Assign appropriate templates to each endpoint type

### Phase 2: Universal Documentation
1. **Template-Driven Generation**: Use endpoint-specific templates
2. **Code Analysis**: Extract implementation details and context
3. **Security Assessment**: Apply OWASP evaluation framework
4. **Business Integration**: Connect endpoints to business workflows

### Phase 3: Validation and Gap Detection
1. **Coverage Validation**: Ensure 100% endpoint documentation
2. **Cross-Reference Checking**: Verify consistency across documents
3. **Gap Identification**: Find endpoints missed during documentation
4. **Quality Assurance**: Validate markdown syntax and template compliance

### Phase 4: Quality Assurance
1. **Template Compliance**: Verify all outputs follow templates
2. **Cross-Reference Validation**: Check consistency across documents
3. **Gap Detection**: Generate `missed_endpoints.csv` if needed
4. **Final Validation**: Confirm 100% coverage achievement

## OWASP API Security Top 10 (2023) Assessment
Complete evaluation for each endpoint:
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

## Risk Rating System
- **Red (High Risk)**: Immediate attention required, significant business impact
- **Amber (Medium Risk)**: Review recommended, moderate business impact
- **Green (Low Risk)**: Best practices followed, minimal business impact

## Error Handling
- **Missing Inventory**: Request Workflow 3 execution or provide CSV
- **Invalid CSV Format**: Provide format guidance and validation
- **Repository Access Issues**: Handle permission problems gracefully
- **Template Missing**: Use generic template with warnings

## Success Criteria
- **100% Coverage**: Every endpoint from inventory CSV documented
- **Template Compliance**: All outputs follow appropriate templates
- **Gap Detection**: Missed endpoints identified and reported
- **Quality Documentation**: Meaningful content with code citations
- **Validation Success**: Cross-reference consistency verified

## Integration Notes
- **Requires Workflow 3**: Uses endpoint inventory as foundation
- **Standalone with CSV**: Can work with provided inventory data
- **Feeds Analysis**: Enhanced documentation for business review
- **Quality Assurance**: Built-in validation and gap detection