# Workflow 6: Authentication & Authorization Analysis

## Purpose
This workflow performs focused security analysis of .NET repositories, primarily examining authentication mechanisms and authorization patterns. It provides clear, concise findings about authentication risks and authorization gaps with minimal verbosity.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Analyze security setup for [repo-name]"
- "Perform security analysis for [repository]"
- "Execute security deep-dive for [repo-name]"
- "Run Workflow 6 security analysis"
- "Analyze authentication and authorization for [repo]"
- "Security audit for [repository-name]"
- "Deep security analysis with endpoint context"

## Input Requirements
**Required:**
- **Target repository path** (e.g., "eShopOnWeb-main", "ProductService")

**Optional (Enhanced Analysis):**
- **Endpoint inventory CSV** from Workflow 3 (can be provided as context)
- **Analysis folder path** containing Workflow 3 outputs
- **Specific security focus areas** (authentication, authorization, data protection, etc.)

## Output
Creates focused auth/authz analysis in `analysis/{repo_name}/{sub_repo}/`:
- `security_summary.md` - Concise auth/authz findings summary
- `security_detailed_report.md` - Technical auth/authz analysis
- `security_findings.csv` - Auth/authz issues with risk scores

## Security Analysis Framework

### Phase 1: Authentication Analysis
**Deep-dive code patterns:**
```powershell
# Authentication scheme detection
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AddAuthentication|UseAuthentication|AuthenticationScheme" -Recurse

# Identity framework detection
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AddIdentity|IdentityUser|UserManager|SignInManager" -Recurse

# JWT and token patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "JwtBearer|AddJwtBearer|ValidateToken|SecurityToken" -Recurse

# OAuth and external providers
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AddGoogle|AddMicrosoft|AddFacebook|OAuth|OpenIdConnect" -Recurse

# Cookie authentication
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AddCookie|CookieAuthentication|SignIn|SignOut" -Recurse
```

### Phase 2: Authorization Analysis
**Authorization pattern detection:**
```powershell
# Authorization policies
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AddAuthorization|AuthorizeAttribute|Policy|RequireRole" -Recurse

# Role-based authorization
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[Authorize\]|Roles.*=|RequireRole|IsInRole" -Recurse

# Claims-based authorization
Select-String -Path "repositories\{repo}\*.cs" -Pattern "Claims|ClaimsPrincipal|RequireClaim|ClaimsIdentity" -Recurse

# Custom authorization handlers
Select-String -Path "repositories\{repo}\*.cs" -Pattern "AuthorizationHandler|IAuthorizationRequirement|HandleRequirementAsync" -Recurse
```

### Phase 3: Authentication Secrets Detection
**Focus on auth-related secrets only:**
```powershell
# API keys and tokens
Select-String -Path "repositories\{repo}\*.cs" -Pattern "api.*key|secret|token|password|credential" -Recurse -CaseSensitive:$false

# Connection strings
Select-String -Path "repositories\{repo}\*.config,*.json" -Pattern "connectionstring|server=|password=" -Recurse -CaseSensitive:$false
```

## Analysis Focus

### 1. Authentication Assessment
- **Methods**: JWT, Identity, Cookie, OAuth detection
- **Strength**: Password policies, token expiration
- **Issues**: Missing validation, weak implementation

### 2. Authorization Assessment
- **Model**: RBAC, policy-based, or custom
- **Coverage**: Endpoint protection percentage
- **Issues**: Missing [Authorize], privilege escalation

## Output Requirements

### Keep It Concise
- **Focus**: Authentication and Authorization only
- **Style**: Clear, actionable findings
- **Length**: Summary under 2 pages, detailed report under 5 pages
- **Verbosity**: Minimal - highlight risks and fixes only

### Risk Scoring (1-10)
- **Critical (9-10)**: Missing auth/authz on admin endpoints
- **High (7-8)**: Weak password policies, privilege escalation
- **Medium (4-6)**: Missing session timeouts, weak validation
- **Low (1-3)**: Best practice improvements
## Templates Usage

### Use the provided templates:
- `security_summary_template.md` - Concise auth/authz summary
- `security_detailed_report_template.md` - Technical findings
- `security_findings_template.csv` - Structured findings list

### Focus Areas (Priority Order):
1. **Authentication mechanisms** and strength
2. **Authorization coverage** and gaps
3. **Critical auth/authz vulnerabilities**
4. **High-level security risks** only

## Execution Guidelines
- **Stay Focused**: Auth/authz only - avoid deep diving into data protection
- **Be Concise**: Clear findings, minimal explanations
- **Actionable Results**: Specific fixes with code locations
- **Risk-Based**: Prioritize by actual security impact