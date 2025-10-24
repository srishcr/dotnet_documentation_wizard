# Workflow 6: Authentication & Authorization Analysis

## Overview
A focused security workflow that analyzes .NET repository authentication and authorization mechanisms. Provides concise, actionable findings about authentication risks and authorization gaps without verbose reporting.

## Purpose
- Analyze authentication mechanisms and strength
- Assess authorization coverage and gaps
- Identify critical auth/authz vulnerabilities
- Provide clear, actionable security recommendations

## Quick Start

### Trigger Commands
```
Analyze security setup for [repo-name]
```
```
Run auth/authz analysis for [repository]
```
```

### Prerequisites
**Required:**
- **Target repository path** with .NET projects
- **Repository access** with read permissions

**Optional (Enhanced Analysis):**
- **Endpoint inventory CSV** from Workflow 3 (provides endpoint-specific context)
- **Analysis folder path** containing previous workflow outputs

### Expected Output
```
analysis/{repo_name}/{sub_repo}/
├── security_summary.md           # 📋 Concise auth/authz summary
├── security_detailed_report.md   # 📊 Technical auth/authz analysis
└── security_findings.csv         # 📈 Auth/authz issues and fixes
```

## Features

### 🔐 **Authentication Analysis**
- **Authentication Methods**: JWT, Cookie, Identity Framework, OAuth
- **Password Policies**: Strength requirements and validation
- **Token Security**: Validation, expiration, secure handling
- **Session Management**: Security configuration and timeouts

### 🛡️ **Authorization Analysis**
- **Access Control**: RBAC, policy-based, custom models
- **Endpoint Protection**: Authorization coverage assessment
- **Privilege Issues**: Escalation and over-privileged access
- **Authorization Gaps**: Missing or weak access controls

### 📊 **Output Reports**

#### Security Summary (`security_summary.md`)
- **Auth/Authz Status**: Clear pass/fail assessment
- **Critical Issues**: Top security risks requiring immediate attention
- **Risk Scores**: Simple high/medium/low risk categorization
- **Action Plan**: Prioritized remediation steps

#### Detailed Report (`security_detailed_report.md`)
- **Authentication Analysis**: Methods, strength, and issues
- **Authorization Analysis**: Coverage, gaps, and risks
- **Technical Recommendations**: Specific implementation guidance
- **Code Examples**: Sample fixes and improvements

#### Findings (`security_findings.csv`)
```csv
Finding_ID,Category,Severity,Title,Location,Risk_Score,Remediation
AUTH-001,Authentication,High,Weak Password Policy,src/Identity/PasswordValidator.cs,8.5,Implement 12+ char passwords
AUTHZ-001,Authorization,Medium,Missing Authorization,src/Controllers/AdminController.cs,6.2,Add [Authorize] attribute
```

## Security Framework Integration

### 🛡️ **OWASP Assessment**

#### API Security Top 10 (2023)
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

#### Web Application Security Top 10 (2021)
- **A01:2021** - Broken Access Control
- **A02:2021** - Cryptographic Failures
- **A03:2021** - Injection
- **A07:2021** - Identification and Authentication Failures
- Complete assessment across all OWASP categories

### 📋 **Compliance Framework Support**

#### Regulatory Compliance
- **GDPR**: Data protection and privacy compliance assessment
- **HIPAA**: Healthcare data protection analysis (when applicable)
- **PCI DSS**: Payment card data security evaluation (when applicable)
- **SOX**: Financial reporting controls assessment (when applicable)
- **ISO 27001**: Information security management alignment

## Detection Capabilities

### 🔍 **Deep Code Analysis**

#### Authentication Patterns
```powershell
# Comprehensive authentication detection
Select-String -Pattern "AddAuthentication|UseAuthentication|JwtBearer|AddIdentity|OAuth" -Recurse
```

#### Authorization Patterns
```powershell
# Authorization scheme detection
Select-String -Pattern "\[Authorize\]|AddAuthorization|RequireRole|Claims|Policy" -Recurse
```

#### Sensitive Data Detection
```powershell
# Enhanced sensitive data patterns
Select-String -Pattern "email|phone|ssn|password|credit.*card|medical|patient" -Recurse -CaseSensitive:$false
```

#### External Integration Analysis
```powershell
# Third-party integration detection
Select-String -Pattern "HttpClient|RestSharp|PackageReference|connectionstring" -Recurse
```

### 📈 **Risk Assessment Matrix**

| Security Area | Analysis Depth | Risk Factors | Output |
|---------------|----------------|--------------|---------|
| Authentication | Deep code analysis | Weak implementations, missing MFA | High/Medium/Low risk findings |
| Authorization | Endpoint-level review | Missing controls, over-privilege | Per-endpoint authorization matrix |
| Data Protection | Sensitive data mapping | Encryption gaps, exposure risks | Data classification and protection status |
| External Integrations | Dependency analysis | Vulnerable packages, insecure APIs | Third-party security assessment |

## Integration Patterns

### 🔗 **Standalone Usage**
```
"Perform security analysis for CustomerPortal"
→ Complete security assessment using code analysis only
```

### 🔗 **Enhanced with Workflow 3**
```
"Security audit for CustomerPortal using endpoint inventory from analysis folder"
→ Enhanced analysis with endpoint-specific security context
```

### 🔗 **Targeted Security Analysis**
```
"Analyze authentication setup for PaymentService with focus on PCI compliance"
→ Focused analysis with compliance-specific assessment
```

## Advanced Features

### 🎯 **Context-Aware Analysis**
- **Business Context Integration**: Maps security findings to business impact
- **Technology Stack Awareness**: Framework-specific security analysis
- **Architecture Pattern Recognition**: Microservices, monolith, serverless security
- **Legacy System Handling**: Special considerations for older .NET Framework applications

### 🔧 **Customizable Security Focus**
- **Authentication-Only Analysis**: Focus solely on auth mechanisms
- **Data Protection Deep Dive**: Comprehensive data security assessment
- **Compliance-Focused Review**: Specific regulatory compliance analysis
- **External Integration Audit**: Third-party security risk assessment

## Error Handling
- **False Positive Management**: Intelligent filtering of security findings
- **Context Validation**: Business context consideration in risk assessment
- **Large Repository Handling**: Efficient analysis for enterprise-scale codebases
- **Expert Review Flagging**: Complex findings marked for manual security review

## Success Criteria
✅ **Comprehensive Coverage**: All major security aspects analyzed and documented
✅ **Accurate Risk Assessment**: Realistic risk scoring with business context
✅ **Actionable Insights**: Clear, implementable security recommendations
✅ **Compliance Alignment**: Regulatory requirements clearly mapped and addressed
✅ **Integration Value**: Enhanced analysis quality when combined with endpoint inventory

## Support
- Check `docs/security-patterns.md` for detailed security pattern documentation
- Review `templates/` folder for all security analysis templates
- Consult `examples/` for sample security analysis outputs and findings