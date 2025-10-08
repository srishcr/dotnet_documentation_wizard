# Individual API Documentation Template

## Template Instructions

This template generates detailed documentation for individual API endpoints. Each API gets its own markdown file named with its unique code identifier (e.g., `eshop-api-00001.md`).

### File Naming Convention

- **Format**: `{api-code}.md`
- **Examples**: `eshop-api-00001.md`, `crm-api-00042.md`, `blog-api-00156.md`
- **Location**: `analysis/apis/` directory

### Document Structure

Each individual API document should follow this comprehensive structure:

```markdown
# {API_CODE} - {Endpoint_Name}

## API Overview

**Code**: {API_CODE}
**Method**: {HTTP_METHOD}
**Endpoint**: `{FULL_ENDPOINT_PATH}`
**Purpose**: {Brief description of what this API does}

## Classification

| Attribute | Value |
|-----------|-------|
| **Access Level** | {External/Internal/Public/Private} |
| **Domain** | {Business_Domain} |
| **Authentication** | {Required/Optional/None} |
| **User Roles** | {Comma-separated list of allowed roles} |
| **Status** | {Active/Deprecated/Beta/Planned} |

## Functional Overview

### Business Purpose
{Detailed explanation of the business value and use case}

### User Scenarios
- **{User Type 1}**: {When and why they use this API}
- **{User Type 2}**: {When and why they use this API}

### Business Rules
- {Rule 1}: {Description}
- {Rule 2}: {Description}

## Technical Specification

### Endpoint Details
- **HTTP Method**: {METHOD}
- **Route Template**: `{route-with-parameters}`
- **Controller**: {ControllerName}
- **Action**: {ActionMethodName}

### Parameters

#### Path Parameters
| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| {param1} | {type} | {Yes/No} | {description} | {example} |

#### Query Parameters
| Parameter | Type | Required | Default | Description | Example |
|-----------|------|----------|---------|-------------|---------|
| {param1} | {type} | {Yes/No} | {default} | {description} | {example} |

#### Request Body
```json
{
  "property1": "string",
  "property2": 123,
  "property3": {
    "nestedProperty": "value"
  }
}
```

### Response Format

#### Success Response (200)
```json
{
  "data": {
    "property1": "string",
    "property2": 123
  },
  "metadata": {
    "totalCount": 100,
    "pageSize": 20
  }
}
```

#### Error Responses
| Status Code | Description | Response Format |
|-------------|-------------|-----------------|
| 400 | Bad Request | `{"error": "Invalid input", "details": [...]}` |
| 401 | Unauthorized | `{"error": "Authentication required"}` |
| 403 | Forbidden | `{"error": "Insufficient permissions"}` |
| 404 | Not Found | `{"error": "Resource not found"}` |
| 500 | Server Error | `{"error": "Internal server error"}` |

## Authentication & Authorization

### Authentication Method
{Description of how authentication works for this endpoint}

### Required Permissions
- {Permission 1}: {Description}
- {Permission 2}: {Description}

### Authorization Logic
{Explanation of any complex authorization rules}

## Security Analysis

### Sensitive Data Assessment
**Sensitive Data Classification**: {PII/Financial/Auth/Confidential/None}

#### Data Sensitivity Details
- **Input Data**: {List any sensitive fields in request}
- **Output Data**: {List any sensitive fields in response}
- **Processing**: {Describe any sensitive data processing}

#### Identified Sensitive Fields
| Field Name | Data Type | Sensitivity Level | Notes |
|------------|-----------|-------------------|-------|
| {field1} | {type} | {PII/Financial/Auth/Confidential} | {context} |
| {field2} | {type} | {PII/Financial/Auth/Confidential} | {context} |

### Security Patterns Observed
- **Input Validation**: {Describe validation patterns found}
- **Output Sanitization**: {Describe sanitization if present}
- **Encryption**: {Note any encryption usage}
- **Access Controls**: {Document access control mechanisms}

### Potential Security Considerations
- **Data Exposure Risk**: {Assess risk of sensitive data exposure}
- **Authentication Adequacy**: {Evaluate if auth requirements are appropriate}
- **Authorization Scope**: {Assess if authorization is sufficient}
- **Compliance Relevance**: {Note potential GDPR, PCI-DSS, or other compliance considerations}

### Business Journey Context
**Primary Journey**: {Journey name this API supports}
**Journey Role**: {Role this API plays in the business workflow}
**Criticality Assessment**: {Potential business impact if this API fails}

## Business Behavior Specification (BDD)

### API Behavior in Gherkin Format

This section describes the API's behavior using Behavior-Driven Development (BDD) Gherkin syntax to clearly communicate the expected functionality from a business perspective.

#### Feature: {Feature Name}
```gherkin
Feature: {High-level feature description}
  As a {type of user}
  I want to {perform some action}
  So that {achieve some business value}

  Background:
    Given the system is available
    And the user is authenticated with valid credentials
    And {any other common preconditions}

  Scenario: {Primary success scenario name}
    Given {initial context or preconditions}
    And {additional context if needed}
    When {the action that triggers the behavior}
    And {additional actions if needed}
    Then {expected outcome}
    And {additional expected outcomes}
    But {what should not happen}

  Scenario: {Alternative success scenario}
    Given {different initial context}
    When {the same or different action}
    Then {different but valid outcome}

  Scenario: {Error scenario 1}
    Given {context that leads to error}
    When {action that triggers error}
    Then {expected error response}
    And {error handling behavior}

  Scenario: {Error scenario 2}
    Given {different error context}
    When {action that triggers different error}
    Then {different error response}
    And {appropriate error handling}

  Scenario Outline: {Data-driven scenarios}
    Given I have <input_data>
    When I perform the API operation
    Then I should get <expected_result>

    Examples:
      | input_data | expected_result |
      | value1     | result1         |
      | value2     | result2         |
      | value3     | result3         |
```

### Business Rules as Scenarios
```gherkin
Rule: {Business rule description}

  Scenario: {Scenario that validates the rule}
    Given {conditions}
    When {action}
    Then {outcome that demonstrates rule compliance}

Rule: {Another business rule}

  Scenario: {Another validation scenario}
    Given {different conditions}
    When {action}
    Then {outcome}
```

### Edge Cases and Boundary Conditions
```gherkin
Scenario: {Boundary condition 1}
  Given {boundary condition setup}
  When {action at boundary}
  Then {expected boundary behavior}

Scenario: {Edge case handling}
  Given {edge case setup}
  When {action that triggers edge case}
  Then {how system handles edge case}
```

### Security Behavior Scenarios
```gherkin
Scenario: Unauthorized access attempt
  Given a user without valid credentials
  When they attempt to access the API
  Then they should receive a 401 Unauthorized response
  And no sensitive data should be exposed

Scenario: Insufficient permissions
  Given a user with valid credentials but insufficient permissions
  When they attempt to perform the operation
  Then they should receive a 403 Forbidden response
  And the operation should not be executed

Scenario: Rate limiting behavior
  Given a user has exceeded the rate limit
  When they make additional requests
  Then they should receive a 429 Too Many Requests response
  And they should be informed about the retry window
```

### Performance and Reliability Scenarios
```gherkin
Scenario: Normal response time
  Given typical system load
  When a request is made to the API
  Then the response should be returned within {X} milliseconds
  And the response should be complete and accurate

Scenario: High load conditions
  Given the system is under high load
  When multiple concurrent requests are made
  Then each request should still be processed correctly
  And response times should remain within acceptable limits

Scenario: Timeout handling
  Given a request that takes longer than the timeout threshold
  When the timeout is reached
  Then the request should be terminated gracefully
  And an appropriate timeout response should be returned
```

### Integration Behavior
```gherkin
Scenario: External service dependency success
  Given external services are available and responding
  When the API processes a request requiring external services
  Then the request should be completed successfully
  And data from external services should be properly integrated

Scenario: External service failure handling
  Given an external service is unavailable or failing
  When the API processes a request requiring that service
  Then the API should handle the failure gracefully
  And provide an appropriate fallback response or error message
```

### Instructions for Generating BDD Content

When documenting API behavior using BDD Gherkin format:

1. **Focus on Business Value**: Each scenario should clearly articulate the business value and user perspective
2. **Use Natural Language**: Write scenarios in plain English that business stakeholders can understand
3. **Be Specific**: Include concrete examples and data where possible
4. **Cover Happy Path**: Start with the primary success scenarios
5. **Include Error Cases**: Document expected error conditions and how they should be handled
6. **Address Security**: Include scenarios for authentication, authorization, and security concerns
7. **Consider Performance**: Add scenarios for performance expectations and boundary conditions
8. **Think User-Centric**: Write from the perspective of different user types and their goals
9. **Validate Business Rules**: Ensure each business rule is covered by at least one scenario
10. **Use Examples**: Leverage scenario outlines with examples for data-driven testing

### BDD Analysis Guidelines

When analyzing the API code to create BDD scenarios:

1. **Identify User Types**: Determine who uses this API and their roles
2. **Extract Business Logic**: Find validation rules, business constraints, and processing logic
3. **Map Error Conditions**: Identify all possible error states and their causes
4. **Understand Dependencies**: Note external services or data dependencies
5. **Document State Changes**: Describe how the API changes system state
6. **Consider Security Context**: Include authentication and authorization requirements
7. **Performance Requirements**: Note any performance expectations or constraints
8. **Integration Points**: Document how the API interacts with other system components

## OWASP API Security Top 10 Assessment

### Security Risk Analysis
This section evaluates the API against the OWASP API Security Top 10 (2023) framework.

**Risk Rating Legend**:
- 🔴 **RED**: High risk - immediate attention required
- 🟡 **AMBER**: Medium risk - review and remediation recommended
- 🟢 **GREEN**: Low risk - secure implementation observed

#### API1:2023 - Broken Object Level Authorization
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Object Access Control**: {Description of how object-level access is controlled}
- **Authorization Implementation**: {Details of authorization checks found in code}
- **User Context Validation**: {How user permissions are validated for specific objects}

**Code Evidence**:
```csharp
{Code snippet showing authorization implementation or lack thereof}
```

**Business Impact**:
{Description of how this risk could affect the business - e.g., "Unauthorized access to user profiles could lead to privacy breaches and GDPR violations, potentially resulting in regulatory fines and loss of customer trust"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API2:2023 - Broken Authentication
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Authentication Mechanism**: {JWT, OAuth, API keys, etc.}
- **Token Validation**: {How tokens are validated}
- **Session Management**: {Session handling approach}

**Code Evidence**:
```csharp
{Code snippet showing authentication implementation}
```

**Business Impact**:
{e.g., "Broken authentication could allow attackers to impersonate legitimate users, leading to unauthorized transactions and potential financial losses"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API3:2023 - Broken Object Property Level Authorization
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Property-Level Controls**: {How sensitive properties are protected}
- **Data Exposure Patterns**: {What data is exposed in responses}
- **Input Validation**: {Validation of incoming property modifications}

**Code Evidence**:
```csharp
{Code snippet showing property-level security or data exposure}
```

**Business Impact**:
{e.g., "Exposing sensitive user properties could reveal PII, leading to privacy violations and potential identity theft"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API4:2023 - Unrestricted Resource Consumption
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Rate Limiting**: {Rate limiting implementation if any}
- **Resource Constraints**: {Pagination, query limits, timeouts}
- **Resource Validation**: {Input size and complexity validation}

**Code Evidence**:
```csharp
{Code snippet showing rate limiting or resource controls}
```

**Business Impact**:
{e.g., "Unrestricted resource consumption could lead to DoS attacks, causing service outages and revenue loss during peak business hours"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API5:2023 - Broken Function Level Authorization
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Function Access Controls**: {Role-based or permission-based access}
- **Administrative Functions**: {Protection of admin-only endpoints}
- **Privilege Escalation**: {Prevention of unauthorized function access}

**Code Evidence**:
```csharp
{Code snippet showing function-level authorization}
```

**Business Impact**:
{e.g., "Broken function-level authorization could allow regular users to access administrative functions, potentially compromising system integrity and business operations"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API6:2023 - Unrestricted Access to Sensitive Business Flows
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Business Flow Protection**: {How critical business processes are protected}
- **Sequence Validation**: {Validation of proper workflow sequence}
- **Abuse Prevention**: {Mechanisms to prevent business logic abuse}

**Code Evidence**:
```csharp
{Code snippet showing business flow controls}
```

**Business Impact**:
{e.g., "Unrestricted access to payment flows could allow attackers to manipulate transactions, leading to financial fraud and business losses"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API7:2023 - Server Side Request Forgery (SSRF)
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **External Requests**: {How external URLs/resources are handled}
- **Input Validation**: {Validation of user-provided URLs or external references}
- **Network Controls**: {Network-level protections against SSRF}

**Code Evidence**:
```csharp
{Code snippet showing external request handling}
```

**Business Impact**:
{e.g., "SSRF vulnerabilities could allow attackers to access internal systems and sensitive data, potentially compromising internal infrastructure and business secrets"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API8:2023 - Security Misconfiguration
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Security Headers**: {HTTP security headers implementation}
- **Error Handling**: {How errors are handled and what information is exposed}
- **Configuration Management**: {Security configuration patterns observed}

**Code Evidence**:
```csharp
{Code snippet showing security configuration}
```

**Business Impact**:
{e.g., "Security misconfigurations could expose sensitive system information, making the organization vulnerable to targeted attacks and data breaches"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API9:2023 - Improper Inventory Management
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **API Documentation**: {Whether API is properly documented and tracked}
- **Version Management**: {API versioning and deprecation strategy}
- **Access Monitoring**: {Monitoring and logging of API access}

**Code Evidence**:
```csharp
{Code snippet showing versioning or documentation attributes}
```

**Business Impact**:
{e.g., "Poor API inventory management could lead to untracked APIs being exploited, creating unknown security vulnerabilities and compliance risks"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

#### API10:2023 - Unsafe Consumption of APIs
**Status**: {🔴/🟡/🟢}

**Technical Assessment**:
- **Third-party API Usage**: {How external APIs are consumed}
- **Data Validation**: {Validation of data from external sources}
- **Trust Boundaries**: {How trust is established with external APIs}

**Code Evidence**:
```csharp
{Code snippet showing external API consumption}
```

**Business Impact**:
{e.g., "Unsafe consumption of third-party APIs could lead to data poisoning attacks, potentially compromising business logic and customer data integrity"}

**Remediation Notes**: {Specific recommendations if risks are identified}

---

### OWASP Assessment Summary

| Risk Category | Status | Priority | Business Impact Level |
|---------------|---------|----------|----------------------|
| API1: Broken Object Level Authorization | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API2: Broken Authentication | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API3: Broken Object Property Level Authorization | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API4: Unrestricted Resource Consumption | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API5: Broken Function Level Authorization | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API6: Unrestricted Access to Sensitive Business Flows | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API7: Server Side Request Forgery | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API8: Security Misconfiguration | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API9: Improper Inventory Management | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |
| API10: Unsafe Consumption of APIs | {🔴/🟡/🟢} | {High/Medium/Low} | {High/Medium/Low} |

### Critical Security Recommendations

**Immediate Actions Required** (🔴 Red Status):
{List all red status items that need immediate attention}

**Review and Remediation Recommended** (🟡 Amber Status):
{List all amber status items for review}

**Strengths Identified** (🟢 Green Status):
{List secure implementations that were identified}

### Business Risk Summary
**Overall Security Posture**: {High Risk/Medium Risk/Low Risk}
**Primary Business Concerns**: {List top 3 business impact concerns}
**Regulatory Compliance Impact**: {Potential compliance implications}

## Request/Response Examples

### Example 1: {Scenario Name}

#### Request
```http
{METHOD} {full-endpoint-url}
Content-Type: application/json
Authorization: Bearer {token}

{request-body-if-applicable}
```

#### Response
```http
HTTP/1.1 200 OK
Content-Type: application/json

{response-body}
```

### Example 2: {Error Scenario}

#### Request
```http
{METHOD} {full-endpoint-url}
Content-Type: application/json

{invalid-request-body}
```

#### Response
```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{error-response}
```

## Implementation Details

### Source Code Location
- **File**: `{relative-file-path}`
- **Line**: {line-number}
- **Last Updated**: {when-possible}

### Dependencies
- {Dependency 1}: {Purpose}
- {Dependency 2}: {Purpose}

### Database Operations
- {Operation 1}: {Tables/Collections affected}
- {Operation 2}: {Tables/Collections affected}

### External Service Calls
- {Service 1}: {Purpose and integration details}
- {Service 2}: {Purpose and integration details}

## Performance Characteristics

### Expected Response Time
- **Target**: {time} ms
- **Timeout**: {time} ms

### Rate Limiting
- **Limit**: {requests per time period}
- **Scope**: {per user/IP/API key}

### Caching
- **Strategy**: {None/In-Memory/Redis/CDN}
- **Duration**: {cache-lifetime}
- **Cache Keys**: {key-pattern}

## Testing Information

### Unit Tests
- **Test File**: `{test-file-path}`
- **Coverage**: {percentage if known}

### Integration Tests
- **Test Scenarios**: {list of test scenarios}
- **Test Data**: {requirements for test data}

## Error Handling

### Common Error Scenarios
1. **{Error Type}**: {Description and resolution}
2. **{Error Type}**: {Description and resolution}

### Error Response Format
```json
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "details": [
    {
      "field": "fieldName",
      "message": "Validation error message"
    }
  ],
  "traceId": "correlation-id"
}
```

## Business Impact

### Success Metrics
- {Metric 1}: {How to measure success}
- {Metric 2}: {How to measure success}

### Failure Impact
- **User Impact**: {What happens when this API fails}
- **Business Impact**: {Business consequences of failure}
- **Mitigation**: {Fallback strategies}

## Related APIs

### Dependencies
- **{API_CODE}**: {How this API depends on another}
- **{API_CODE}**: {How this API depends on another}

### Related Endpoints
- **{API_CODE}**: {Relationship description}
- **{API_CODE}**: {Relationship description}

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| {date} | {version} | {change description} | {author} |

## Notes and Considerations

### Known Issues
- {Issue 1}: {Description and workaround}
- {Issue 2}: {Description and workaround}

### Future Enhancements
- {Enhancement 1}: {Description}
- {Enhancement 2}: {Description}

### Security Considerations
- {Consideration 1}: {Security implication}
- {Consideration 2}: {Security implication}
```

### Template Analysis Guidelines

#### Code Analysis Focus

When analyzing code to populate this template:

1. **Extract HTTP Method and Route**
```csharp
[HttpGet("api/products/{id}")]
[Route("api/[controller]/[action]")]
app.MapGet("/api/products", GetProducts);
```

2. **Identify Parameters**
```csharp
public async Task<IActionResult> GetProduct(int id, [FromQuery] string? category)
{
    // id is path parameter
    // category is query parameter
}
```

3. **Analyze Request/Response Types**
```csharp
public async Task<ActionResult<ProductDto>> GetProduct(int id)
{
    // Response type: ProductDto
}

[HttpPost]
public async Task<IActionResult> CreateProduct([FromBody] CreateProductRequest request)
{
    // Request type: CreateProductRequest
}
```

4. **Check Authorization**
```csharp
[Authorize(Roles = "Admin,Manager")]
[AllowAnonymous]
[Authorize(Policy = "ProductManagement")]
```

5. **Identify Business Logic**
```csharp
public async Task<IActionResult> CreateOrder(CreateOrderRequest request)
{
    // Look for business rules in the implementation
    if (request.Items.Count > 100)
        return BadRequest("Too many items");

    await _orderService.ProcessOrder(request);
    // Business logic patterns
}
```

#### Response Schema Generation

For complex response types, analyze DTOs:

```csharp
public class ProductDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public CategoryDto Category { get; set; } = null!;
}

public class CategoryDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}
```

Convert to JSON schema:
```json
{
  "id": 123,
  "name": "Product Name",
  "price": 29.99,
  "category": {
    "id": 1,
    "name": "Category Name"
  }
}
```

#### Error Handling Analysis

Look for error handling patterns:

```csharp
try
{
    var result = await _service.ProcessRequest(request);
    return Ok(result);
}
catch (ValidationException ex)
{
    return BadRequest(new { error = ex.Message });
}
catch (NotFoundException ex)
{
    return NotFound(new { error = ex.Message });
}
```

#### Performance Considerations

Identify performance patterns:

```csharp
[ResponseCache(Duration = 300)] // Caching
public async Task<IActionResult> GetProducts()

[HttpGet]
[RateLimit(100, TimeSpan.FromMinutes(1))] // Rate limiting
public async Task<IActionResult> SearchProducts()
```

### Quality Assurance Checklist

For each individual API document:

- [ ] API code matches inventory entry
- [ ] All parameters are documented with types and examples
- [ ] Request/response examples are valid and realistic
- [ ] Authentication requirements are clearly stated
- [ ] Error responses cover common scenarios
- [ ] Business context explains the "why" not just the "how"
- [ ] Performance characteristics are realistic
- [ ] Code citations are accurate (file path and line number)
- [ ] Related APIs are properly cross-referenced
- [ ] Security considerations are addressed

### Common .NET API Patterns

#### Minimal API Pattern
```csharp
app.MapGet("/api/products", async (IProductService service) =>
{
    var products = await service.GetProductsAsync();
    return Results.Ok(products);
})
.WithName("GetProducts")
.WithTags("Products")
.WithOpenApi();
```

#### Controller Action Pattern
```csharp
[HttpGet]
[Route("api/products")]
[ProducesResponseType(typeof(List<ProductDto>), 200)]
[ProducesResponseType(404)]
public async Task<ActionResult<List<ProductDto>>> GetProducts()
{
    var products = await _productService.GetAllAsync();
    return Ok(products);
}
```

#### Authentication Patterns
```csharp
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
[Authorize(Policy = "RequireAdminRole")]
[AllowAnonymous]
```

### Integration with Workflow

Each individual API document should:
- Reference the correct entry in the API inventory CSV
- Link back to relevant sections in the technical details document
- Connect to business domains identified in the overview document
- Enable easy maintenance and updates as APIs evolve
- Support automated validation and testing workflows