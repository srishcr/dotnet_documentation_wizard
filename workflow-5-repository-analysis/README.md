# Workflow 5: Granular Repository Analysis

## Overview
A flexible workflow that provides business and technical analysis with granular execution options. Supports individual or combined analysis including overview, technical details, security analysis, and business journey mapping.

## Purpose
- Provide granular analysis execution based on user needs
- Generate high-quality business and technical insights
- Integrate security and compliance analysis with OWASP assessment
- Enable focused analysis without running complete workflow suite

## Quick Start

### Trigger Commands

#### Individual Analysis
```
Run overview only analysis for [repo-name]
```
```
Execute technical details only for [repo-name]/[sub-project]
```
```
Generate sensitive data analysis only for [repo-name]
```
```
Create business journey analysis only for [repo-name]
```

#### Complete Analysis
```
Perform all analysis for [repo-name]
```

### Prerequisites
- **Target repository path** (e.g., "eShopOnWeb-main", "ProductService")
- **Repository access** with read permissions
- Optional: **Endpoint inventory CSV** for enhanced analysis

### Expected Output
Based on requested analysis type:
```
analysis/{repo_name}/{sub_repo}/
├── 01_overview.md                      # If "overview only" or "all analysis"
├── 02_technical_details.md             # If "technical only" or "all analysis"
├── 03_sensitive_data_analysis.md       # If "sensitive data only" or "all analysis"
├── 04_business_critical_journeys.md    # If "business journey only" or "all analysis"
└── analysis_execution_summary.md       # Summary of completed analyses
```

## Features

### Granular Analysis Options

#### 🏢 Overview Analysis (`01_overview.md`)
**Focus**: Business domain and application context
**Content**:
- Business domain identification and context
- Application purpose and key stakeholders
- High-level architecture overview
- Technology stack summary
- User base and target audience

#### 🔧 Technical Details Analysis (`02_technical_details.md`)
**Focus**: Architecture and technical implementation
**Content**:
- Detailed architecture patterns and design
- Technology stack deep dive
- Database and data access patterns
- Integration patterns and dependencies
- Performance and scalability considerations

#### 🔒 Sensitive Data Analysis (`03_sensitive_data_analysis.md`)
**Focus**: Security, compliance, and data protection
**Content**:
- PII and sensitive data identification
- Security patterns and implementations
- OWASP API Security assessment
- Compliance framework analysis
- Risk assessment with recommendations

#### 🚀 Business Journey Analysis (`04_business_critical_journeys.md`)
**Focus**: Business workflows and user journeys
**Content**:
- User journey mapping and workflows
- Critical business scenarios
- Cross-system integrations
- Business value analysis
- Workflow optimization opportunities

### Enhanced Analysis with Endpoint Context

#### When Endpoint Inventory Available
Leverages endpoint data from Workflow 3 for:
- **API-Driven Analysis**: Focus on endpoint-centric patterns
- **Security Deep Dive**: Endpoint-specific security assessment
- **Business Mapping**: Connect endpoints to business workflows
- **Integration Analysis**: API dependency mapping

#### Standalone Repository Analysis
Without endpoint inventory, provides:
- **Code Pattern Analysis**: General architecture patterns
- **Technology Assessment**: Framework and library usage
- **Security Review**: General security practices
- **Business Context**: Inferred from structure and naming

## Analysis Framework

### Sensitive Data Detection
Comprehensive pattern recognition for:
- **PII Indicators**: email, phone, address, name, ssn, birth, id, passport
- **Financial Data**: card, payment, billing, amount, account, transaction, balance
- **Authentication Data**: password, token, secret, credential, auth, key, certificate
- **Confidential Data**: internal, admin, private, confidential, config, classified

### Security Assessment Framework
- **OWASP API Security Top 10 (2023)**: Complete evaluation when endpoints available
- **Risk Rating System**: Red/Amber/Green classification
- **Remediation Guidance**: Specific security improvement recommendations
- **Compliance Mapping**: GDPR, HIPAA, PCI-DSS considerations

### Business Analysis Framework
- **Domain-Driven Design**: Business domain identification
- **User Journey Mapping**: Critical business workflows
- **Value Stream Analysis**: Business value and impact assessment
- **Integration Patterns**: Cross-system business interactions

## Flexible Execution Patterns

### Individual Analysis Workflow
1. **Single Focus**: Execute only requested analysis type
2. **Optimized Performance**: Faster execution with targeted scope
3. **Specific Insights**: Deep dive into particular aspect
4. **Resource Efficient**: Minimal AI context usage

### Combined Analysis Workflow
1. **Comprehensive Coverage**: All analysis types executed
2. **Cross-Reference Integration**: Consistent narrative across documents
3. **Complete Picture**: Full repository understanding
4. **Business Ready**: Complete documentation package

### Progressive Analysis
1. **Start Simple**: Begin with overview analysis
2. **Add Detail**: Progressively add technical details
3. **Security Focus**: Include security analysis for sensitive systems
4. **Business Context**: Add business journey analysis for stakeholder review

## Quality Standards

### Template Compliance
- **Standardized Format**: All outputs follow template structure
- **Consistent Sections**: Uniform section organization
- **Required Elements**: All mandatory content included
- **Professional Quality**: Business-ready documentation

### Cross-Reference Validation
- **Consistency Checking**: Aligned information across documents
- **Dependency Mapping**: Proper cross-document references
- **Business Alignment**: Coherent business narrative
- **Technical Accuracy**: Verified technical details

## Integration

### Standalone Operation
- **No Dependencies**: Works independently of other workflows
- **Self-Contained**: Complete analysis from repository code
- **Flexible Input**: Adapts to available information
- **Rapid Execution**: Quick turnaround for focused analysis

### Enhanced with Context
- **Endpoint Integration**: Leverages Workflow 3 endpoint inventory
- **API-Centric Analysis**: Focus on endpoint-driven insights
- **Security Deep Dive**: Endpoint-specific security assessment
- **Business Mapping**: Connect APIs to business workflows

### Output Usage
- **Business Planning**: Strategic decision making
- **Architecture Review**: Technical assessment and modernization
- **Security Audit**: Compliance and risk assessment
- **Development Guide**: Implementation guidance for teams

## Success Criteria
✅ Granular analysis execution based on user selection
✅ High-quality business and technical insights
✅ Security and compliance analysis with OWASP integration
✅ Consistent cross-analysis integration and accuracy
✅ Template compliance with professional quality output

## Use Cases

### Business Stakeholder Review
```
Run overview only analysis for CustomerPortal
Create business journey analysis only for CustomerPortal
```
**Result**: Business-focused documentation for stakeholder review

### Technical Architecture Assessment
```
Execute technical details only for PaymentService
Generate sensitive data analysis only for PaymentService
```
**Result**: Technical and security assessment for architecture review

### Complete Documentation Package
```
Perform all analysis for eShopOnWeb-main/PublicApi
```
**Result**: Comprehensive documentation across all dimensions

### Security Compliance Review
```
Generate sensitive data analysis only for UserManagementAPI
```
**Result**: Focused security and compliance assessment

## Support
- Check `templates/` folder for all analysis templates
- Review `examples/` for sample outputs across different analysis types
- Consult `docs/analysis-framework.md` for detailed methodology