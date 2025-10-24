# Security Patterns and Detection Guide

## Overview
This guide documents the security patterns and detection methods used in Workflow 6 for comprehensive authentication, authorization, and security analysis.

## Authentication Patterns

### JWT Authentication Detection
```powershell
# JWT Bearer token configuration
Select-String -Pattern "AddJwtBearer|JwtBearerDefaults|ValidateIssuer|ValidateAudience" -Recurse

# JWT token generation and validation
Select-String -Pattern "JwtSecurityToken|WriteToken|ValidateToken|SecurityTokenHandler" -Recurse
```

**Common Implementations:**
- `services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)`
- `services.AddJwtBearer(options => { ... })`
- `new JwtSecurityToken(...)`

### Identity Framework Detection
```powershell
# ASP.NET Core Identity
Select-String -Pattern "AddIdentity|AddDefaultIdentity|IdentityUser|UserManager|SignInManager" -Recurse

# Identity configuration
Select-String -Pattern "PasswordOptions|LockoutOptions|SignInOptions|UserOptions" -Recurse
```

**Common Implementations:**
- `services.AddIdentity<IdentityUser, IdentityRole>()`
- `services.AddDefaultIdentity<IdentityUser>()`
- `UserManager<IdentityUser>`

### Cookie Authentication Detection
```powershell
# Cookie authentication scheme
Select-String -Pattern "AddCookie|CookieAuthenticationDefaults|UseCookieAuthentication" -Recurse

# Cookie configuration
Select-String -Pattern "ExpireTimeSpan|SlidingExpiration|HttpOnly|Secure" -Recurse
```

### OAuth and External Providers
```powershell
# OAuth providers
Select-String -Pattern "AddGoogle|AddMicrosoft|AddFacebook|AddTwitter|AddGitHub" -Recurse

# OpenID Connect
Select-String -Pattern "AddOpenIdConnect|OpenIdConnectDefaults|Authority|ClientId" -Recurse
```

## Authorization Patterns

### Attribute-Based Authorization
```powershell
# Authorization attributes
Select-String -Pattern "\[Authorize\]|\[AllowAnonymous\]|Roles.*=|Policy.*=" -Recurse

# Custom authorization attributes
Select-String -Pattern "AuthorizeAttribute|IAuthorizationFilter|OnAuthorization" -Recurse
```

**Common Implementations:**
- `[Authorize]`
- `[Authorize(Roles = "Admin")]`
- `[Authorize(Policy = "RequireManagerRole")]`

### Policy-Based Authorization
```powershell
# Authorization policies
Select-String -Pattern "AddAuthorization|AddPolicy|RequireRole|RequireClaim" -Recurse

# Custom authorization handlers
Select-String -Pattern "AuthorizationHandler|IAuthorizationRequirement|HandleRequirementAsync" -Recurse
```

**Common Implementations:**
- `services.AddAuthorization(options => { ... })`
- `options.AddPolicy("PolicyName", policy => policy.RequireRole("Admin"))`
- `public class CustomAuthorizationHandler : AuthorizationHandler<CustomRequirement>`

### Claims-Based Authorization
```powershell
# Claims handling
Select-String -Pattern "ClaimsPrincipal|ClaimsIdentity|Claim|HasClaim|FindFirst" -Recurse

# Claims transformation
Select-String -Pattern "IClaimsTransformation|TransformAsync|ClaimsAuthenticationOptions" -Recurse
```

## Data Protection Patterns

### Sensitive Data Detection

#### Personal Identifiable Information (PII)
```powershell
# Email patterns
Select-String -Pattern "email|e-mail|@.*\.|EmailAddress|MailAddress" -Recurse -CaseSensitive:$false

# Phone number patterns
Select-String -Pattern "phone|telephone|mobile|cell|PhoneNumber" -Recurse -CaseSensitive:$false

# Address patterns
Select-String -Pattern "address|street|city|state|zip|postal|country" -Recurse -CaseSensitive:$false

# Government IDs
Select-String -Pattern "ssn|social.*security|passport|driver.*license|tax.*id" -Recurse -CaseSensitive:$false
```

#### Financial Data
```powershell
# Payment information
Select-String -Pattern "credit.*card|debit.*card|card.*number|cvv|expiry" -Recurse -CaseSensitive:$false

# Banking information
Select-String -Pattern "account.*number|routing.*number|iban|swift|bank" -Recurse -CaseSensitive:$false

# Financial amounts
Select-String -Pattern "payment|billing|amount|price|cost|fee" -Recurse -CaseSensitive:$false
```

#### Medical Data (HIPAA)
```powershell
# Healthcare information
Select-String -Pattern "medical|health|patient|diagnosis|treatment|prescription" -Recurse -CaseSensitive:$false

# Healthcare identifiers
Select-String -Pattern "patient.*id|medical.*record|insurance.*number" -Recurse -CaseSensitive:$false
```

### Encryption Detection
```powershell
# Data encryption
Select-String -Pattern "Encrypt|Decrypt|AES|RSA|DataProtection|ProtectedData" -Recurse

# Hashing and salting
Select-String -Pattern "Hash|Salt|BCrypt|PBKDF2|SHA256|SHA512" -Recurse

# SSL/TLS configuration
Select-String -Pattern "UseHttps|RequireHttps|SslProtocols|TlsProtocols" -Recurse
```

## Configuration Security Patterns

### Connection Strings and Secrets
```powershell
# Connection strings
Select-String -Pattern "connectionstring|server=|database=|user.*id=|password=" -Recurse -CaseSensitive:$false

# API keys and secrets
Select-String -Pattern "api.*key|secret|token|password|credential" -Recurse -CaseSensitive:$false

# Configuration files
Get-ChildItem -Recurse -Include "*.config","*.json","*.xml" | Select-String -Pattern "password|secret|key" -CaseSensitive:$false
```

### Environment Variables and Settings
```powershell
# Environment variable usage
Select-String -Pattern "Environment\.GetEnvironmentVariable|GetEnvironmentVariable|env:" -Recurse

# Configuration providers
Select-String -Pattern "AddConfiguration|IConfiguration|IOptions|Configure<" -Recurse
```

## External Integration Security

### HTTP Client Security
```powershell
# HTTP client usage
Select-String -Pattern "HttpClient|RestSharp|WebClient|HttpWebRequest" -Recurse

# SSL/TLS validation
Select-String -Pattern "ServerCertificateValidationCallback|ServicePointManager|SecurityProtocol" -Recurse
```

### Package Dependencies
```powershell
# Package references
Get-ChildItem -Recurse -Filter "*.csproj" | ForEach-Object {
    Select-String -Path $_.FullName -Pattern "PackageReference.*Include"
}

# NuGet packages.config
Get-ChildItem -Recurse -Filter "packages.config" | ForEach-Object {
    Select-String -Path $_.FullName -Pattern "package.*id"
}
```

## Vulnerability Patterns

### SQL Injection Detection
```powershell
# Dynamic SQL construction
Select-String -Pattern "SqlCommand.*CommandText|ExecuteReader.*\+|ExecuteNonQuery.*\+" -Recurse

# String concatenation in SQL
Select-String -Pattern "\"SELECT.*\+|\"INSERT.*\+|\"UPDATE.*\+|\"DELETE.*\+" -Recurse
```

### Cross-Site Scripting (XSS)
```powershell
# Unencoded output
Select-String -Pattern "Html\.Raw|@Html\.Raw|HttpUtility\.HtmlDecode" -Recurse

# JavaScript injection points
Select-String -Pattern "document\.write|innerHTML|eval\(" -Recurse
```

### Cross-Site Request Forgery (CSRF)
```powershell
# CSRF protection
Select-String -Pattern "ValidateAntiForgeryToken|AntiForgeryToken|__RequestVerificationToken" -Recurse

# CSRF configuration
Select-String -Pattern "AddAntiforgery|AntiforgeryOptions|SameSiteMode" -Recurse
```

## Security Configuration Patterns

### HTTPS Enforcement
```powershell
# HTTPS redirection
Select-String -Pattern "UseHttpsRedirection|RequireHttps|UseHsts" -Recurse

# Security headers
Select-String -Pattern "UseSecurityHeaders|X-Frame-Options|Content-Security-Policy" -Recurse
```

### Session Security
```powershell
# Session configuration
Select-String -Pattern "AddSession|SessionOptions|IdleTimeout|HttpOnly" -Recurse

# Session state
Select-String -Pattern "HttpContext\.Session|ISession|SessionExtensions" -Recurse
```

### Logging Security
```powershell
# Logging configuration
Select-String -Pattern "AddLogging|ILogger|LogLevel|LogInformation" -Recurse

# Sensitive data in logs
Select-String -Pattern "Log.*password|Log.*secret|Log.*token" -Recurse -CaseSensitive:$false
```

## Risk Assessment Criteria

### Critical Risk Indicators
- Unencrypted sensitive data storage
- Missing authentication on admin endpoints
- SQL injection vulnerabilities
- Hardcoded secrets in source code
- Disabled HTTPS enforcement

### High Risk Indicators
- Weak password policies
- Missing authorization checks
- Excessive logging of sensitive data
- Outdated dependencies with known vulnerabilities
- Insecure external API communications

### Medium Risk Indicators
- Missing CSRF protection
- Weak session configuration
- Insufficient input validation
- Poor error handling exposing system details
- Missing security headers

### Low Risk Indicators
- Missing rate limiting
- Suboptimal logging configuration
- Minor configuration improvements
- Documentation gaps
- Non-critical dependency updates

## Compliance Mapping

### GDPR Requirements
- **Data Minimization**: Collect only necessary data
- **Purpose Limitation**: Use data only for stated purposes
- **Storage Limitation**: Retain data only as long as necessary
- **Data Protection by Design**: Implement privacy controls
- **Data Subject Rights**: Enable data access, portability, erasure

### HIPAA Requirements
- **Administrative Safeguards**: Access controls and training
- **Physical Safeguards**: Facility access and workstation security
- **Technical Safeguards**: Access controls, audit logs, encryption
- **Breach Notification**: Incident response procedures

### PCI DSS Requirements
- **Build and Maintain Secure Networks**: Firewalls and default passwords
- **Protect Cardholder Data**: Encryption and data retention policies
- **Maintain Vulnerability Management**: Security updates and testing
- **Implement Strong Access Control**: Role-based access and monitoring
- **Regularly Monitor and Test Networks**: Logging and penetration testing
- **Maintain Information Security Policy**: Documentation and training

## Best Practices

### Authentication Best Practices
1. Use strong password policies (minimum 12 characters, complexity)
2. Implement multi-factor authentication for privileged accounts
3. Use secure token storage and transmission
4. Implement proper session timeout and management
5. Use HTTPS for all authentication endpoints

### Authorization Best Practices
1. Implement principle of least privilege
2. Use role-based access control with clear role definitions
3. Implement defense in depth with multiple authorization layers
4. Regularly review and audit access permissions
5. Use policy-based authorization for complex scenarios

### Data Protection Best Practices
1. Encrypt sensitive data at rest and in transit
2. Implement proper key management and rotation
3. Use data classification and handling procedures
4. Implement data minimization and retention policies
5. Regular security assessments and penetration testing