# Workflow 5: Granular Repository Analysis

## Purpose
This workflow provides business and technical analysis with granular execution options. It allows individual or combined analysis including overview, technical details, security analysis, and business journey mapping.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Run overview only analysis for [repo-name]"
- "Execute technical details only for [repo-name]"
- "Generate sensitive data analysis only for [repo-name]"
- "Create business journey analysis only for [repo-name]"
- "Perform all analysis for [repo-name]"
- "Repository analysis workflow"
- "Execute Workflow 5"

## Input Requirements
- **Target repository path** (e.g., "eShopOnWeb-main", "ProductService")
- **Analysis type selection** (overview, technical, security, business, or all)
- Optional: **Endpoint inventory CSV** for enhanced analysis

## Output
Creates selected analysis files in `analysis/{repo_name}/{sub_repo}/`:
- `01_overview.md` - Business domain and context analysis
- `02_technical_details.md` - Architecture and technical patterns
- `03_sensitive_data_analysis.md` - Security and compliance analysis
- `04_business_critical_journeys.md` - Business workflow mapping

## Granular Analysis Options

### Overview Only Analysis
**Triggers**: "overview only", "business overview", "domain analysis"
**Output**: `01_overview.md`
**Content**:
- Business domain identification
- Application purpose and context
- Key stakeholders and users
- High-level architecture overview
- Technology stack summary

### Technical Details Only Analysis
**Triggers**: "technical details only", "architecture analysis", "technical patterns"
**Output**: `02_technical_details.md`
**Content**:
- Detailed architecture patterns
- Design patterns and implementations
- Technology stack deep dive
- Database and data access patterns
- Integration patterns and dependencies

### Sensitive Data Analysis Only
**Triggers**: "sensitive data only", "security analysis", "compliance analysis"
**Output**: `03_sensitive_data_analysis.md`
**Content**:
- PII and sensitive data identification
- Security patterns and implementations
- OWASP assessment integration
- Compliance framework analysis
- Risk assessment and recommendations

### Business Journey Analysis Only
**Triggers**: "business journey only", "workflow analysis", "business process"
**Output**: `04_business_critical_journeys.md`
**Content**:
- User journey mapping
- Business process workflows
- Critical business scenarios
- Cross-system integrations
- Business value analysis

### All Analysis
**Triggers**: "all analysis", "complete analysis", "full repository analysis"
**Output**: All four analysis files
**Content**: Complete comprehensive analysis across all dimensions

## Enhanced Analysis with Endpoint Context

### When Endpoint Inventory Available
If endpoint inventory from Workflow 3 is available:
- **API-Driven Analysis**: Focus on endpoint-centric patterns
- **Security Deep Dive**: Endpoint-specific security assessment
- **Business Mapping**: Connect endpoints to business workflows
- **Integration Analysis**: API dependency and integration patterns

### Without Endpoint Inventory
**General Repository Analysis**:
- **Code Pattern Analysis**: General architecture and design patterns
- **Technology Assessment**: Framework and library usage
- **Security Review**: General security patterns and practices
- **Business Context**: Inferred from repository structure and naming

## Analysis Templates and Standards

### Template Integration
Uses templates from `templates/` folder:
- `01_overview_template.md`
- `02_technical_details_template.md`
- `03_sensitive_data_template.md`
- `04_business_critical_journeys_template.md`

### Quality Standards
- **Template Compliance**: All outputs follow standardized templates
- **Cross-Reference Validation**: Consistency across analysis documents
- **Markdown Syntax**: Valid formatting for all generated files
- **Business Value**: Actionable insights and recommendations

## Security and Compliance Framework

### Sensitive Data Detection Patterns
- **PII Indicators**: email, phone, address, name, ssn, birth, id, passport
- **Financial Indicators**: card, payment, billing, amount, account, transaction
- **Authentication Indicators**: password, token, secret, credential, auth, key
- **Confidential Indicators**: internal, admin, private, confidential, config

### OWASP Integration
When endpoint inventory available:
- **Complete OWASP Assessment**: API Security Top 10 evaluation
- **Risk Rating**: Red/Amber/Green classification
- **Remediation Guidance**: Specific security improvement recommendations

## Execution Strategy

### Phase 1: Analysis Selection
1. **Parse User Request**: Determine which analyses to perform
2. **Template Selection**: Choose appropriate templates
3. **Context Assessment**: Determine available enhancement data
4. **Scope Definition**: Set analysis boundaries and depth

### Phase 2: Repository Analysis
1. **Code Analysis**: Examine repository structure and patterns
2. **Configuration Review**: Analyze configuration files and settings
3. **Documentation Review**: Process existing documentation
4. **Pattern Recognition**: Identify architectural and business patterns

### Phase 3: Enhanced Analysis (if endpoint data available)
1. **Endpoint Integration**: Connect analysis to specific endpoints
2. **Security Deep Dive**: Endpoint-specific security assessment
3. **Business Mapping**: Link endpoints to business workflows
4. **Dependency Analysis**: API and service dependency mapping

### Phase 4: Report Generation
1. **Template Population**: Fill selected templates with analysis
2. **Cross-Reference Integration**: Ensure consistency across documents
3. **Quality Validation**: Verify completeness and accuracy
4. **Summary Generation**: Create analysis execution summary

## Error Handling
- **Repository Access Issues**: Handle permission problems gracefully
- **Missing Templates**: Use generic fallbacks with warnings
- **Incomplete Analysis**: Flag areas requiring manual review
- **Large Repositories**: Implement progressive analysis techniques

## Success Criteria
- **Granular Execution**: Only requested analyses performed
- **High-Quality Insights**: Actionable business and technical analysis
- **Security Integration**: OWASP assessment when applicable
- **Cross-Analysis Consistency**: Coherent narrative across documents
- **Template Compliance**: Standardized format adherence

## Integration Notes
- **Standalone Operation**: Works independently without dependencies
- **Enhanced with Context**: Leverages endpoint inventory for deeper analysis
- **Flexible Execution**: Supports individual or combined analysis types
- **Business Value**: Provides actionable insights for stakeholders