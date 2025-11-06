# Workflow 7: Endpoint Catalog Conversion

## Purpose
This workflow converts consolidated endpoint inventory CSV (from Workflow 3) into standardized API catalog format for enterprise API management and governance. It transforms technical endpoint data into business-friendly catalog entries with proper categorization.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Convert endpoint inventory to catalog format"
- "Create API catalog from endpoint CSV"
- "Transform endpoints to catalog format for [service-name]"
- "Generate catalog CSV from consolidated endpoint inventory"
- "Run Workflow 7 catalog conversion"
- "Convert consolidated endpoints to catalog format"

## Input Requirements
**Required:**
- **Consolidated endpoint inventory CSV** with "Service Name" column (from Workflow 3 outputs)

**Optional:**
- **Domain mapping guidance** (helps with domain categorization)
- **Authentication context** (helps determine auth types)

## Output
Creates catalog conversion in `analysis/`:
- `api_catalog.csv` - Standardized catalog format
- `catalog_conversion_summary.md` - Conversion summary and statistics

## Catalog CSV Schema

### Target Catalog Format
```csv
Service_Name,Endpoint_Name,Endpoint_Category,Endpoint_Description,Domain,Endpoint_Type,Endpoint_Method,Endpoint_Path,Web_Domains,Authentication_Type,API_Spec_URL,Lifecycle_Status,Version,Created,API_Exposure_Type
```

### Source CSV Mapping (from Workflow 3)
Map from consolidated endpoint inventory to catalog format:
- **Service Name** → Service_Name (direct mapping)
- **Endpoint_Path + HTTP_Method** → Generate meaningful Endpoint_Name
- **Endpoint_Type** → Endpoint_Type (direct mapping)
- **Endpoint_Description + Notes** → Endpoint_Description (combine and clean)
- **Business_Domain** → Domain (map to business domains)
- **HTTP_Method** → Endpoint_Method (direct mapping)
- **Endpoint_Path** → Endpoint_Path (direct mapping)
- **Authentication** → Authentication_Type (standardize format)

## Conversion Logic

### Endpoint Name Generation
Create descriptive names using path, method, parameters, and description context:

**CRITICAL**: Use Endpoint_Description and Notes to create specific names that avoid duplicates:
```
/api/v1/records/search?postcode={code} (GET) + "Search by postcode" → "Search Records By Postcode"
/api/v1/records/search?address={addr} (GET) + "Search by address" → "Search Records By Address"
/api/v1/customers (POST) + "Pre-registration" → "Preregister Customer Account"
/api/v1/customers (POST) + "Full account creation" → "Create New Customer Account"
/api/v1/policies/{id}/validate (GET) + "Validation check" → "Validate Policy Details"
/api/v1/policies/{id}/approve (PUT) + "Approval workflow" → "Approve Policy Application"
```

**Naming Rules**:
1. **Use Description Context**: Combine path + method + key details from Endpoint_Description/Notes
2. **Be Specific**: Include distinguishing factors (search criteria, workflow stage, etc.)
3. **Avoid Duplicates**: Check for existing names and add qualifiers
4. **Max 6 Words**: Keep concise but descriptive
5. **Action-Entity-Qualifier**: "Validate Policy Details", "Search Records By Postcode"

### Category Classification
Classify endpoints into categories:
- **System**: Health checks, diagnostics, configuration
- **Process**: Business process operations, workflows
- **Experience**: User interface, customer-facing operations
- **Data**: CRUD operations, data management
- **Integration**: External system interfaces, webhooks

### Domain Mapping
Map endpoints to business domains:
- **Policy**: Policy management, quotes, renewals
- **Claims**: Claims processing, adjustments, settlements
- **Customers**: Customer data, profiles, preferences
- **Agent**: Agent operations, commissions, territories
- **Billing**: Payments, invoicing, accounting
- **Underwriting**: Risk assessment, approvals

### Authentication Type Standardization
Standardize authentication formats:
- "JWT Bearer" → "OAuth"
- "API Key" → "API Key"
- "None" → "None"
- "Basic Auth" → "Basic"
- "Custom" → "Custom"

### Default Values
Set standard defaults:
- **API_Spec_URL**: (blank - to be filled later)
- **Lifecycle_Status**: "Live"
- **Created**: (blank - to be filled later)
- **Version**: Extract from endpoint path or default to "v1"
- **API_Exposure_Type**: Determine from endpoint pattern and authentication

## Processing Instructions

### Direct CSV Creation by Copilot
**IMPORTANT**: Do NOT create PowerShell scripts. Directly create the output CSV file yourself.

### Conversion Process
1. **Load Source CSV**: Read the consolidated endpoint inventory CSV
2. **Filter Endpoints**: Exclude swagger/OpenAPI documentation endpoints
3. **Transform Each Row**: For each business endpoint, create catalog entry
4. **Generate Output Files**: Create `api_catalog.csv` and `catalog_conversion_summary.md`

### Row-by-Row Transformation Logic
For each endpoint in source CSV (excluding swagger endpoints):

**1. Generate Descriptive Endpoint Name**:
- Analyze `Endpoint_Description` and `Notes` for specific context
- Extract distinguishing factors (search criteria, workflow stage, purpose)
- Create specific name to avoid duplicates
- Format: "Action Entity Qualifier" (max 6 words)

**2. Determine Category**:
- System: /health, /status, /config, /diagnostics
- Process: /workflow, /approve, /process, /submit
- Experience: /search, /list, /dashboard, /summary
- Data: Standard CRUD operations
- Integration: /webhook, /callback, /external

**3. Map Domain**:
- Policy: /policy, /quote, /renewal, /coverage
- Claims: /claim, /loss, /settlement, /adjustment
- Customers: /customer, /user, /contact, /profile
- Agent: /agent, /broker, /commission, /territory
- Billing: /payment, /invoice, /billing, /account

**4. Standardize Authentication**:
- "JWT Bearer" → "OAuth"
- "API Key" → "API Key"
- "None"/"Anonymous" → "None"
- "Basic Auth" → "Basic"

**5. Set Default Values**:
- API_Spec_URL: (blank)
- Lifecycle_Status: "Live"
- Created: (blank)
- Version: Extract from path or "v1"
- API_Exposure_Type: Public/Private based on authentication and path

## Conversion Rules

### Endpoint Name Rules
- **Use Title Case**: "Search Records By Postcode"
- **Start with action verb**: Get, Create, Update, Delete, Search, List, Validate, Approve
- **Include entity name**: User, Policy, Claim, Record, Customer
- **Add specific qualifier**: By Postcode, By Address, New Account, Preregister, etc.
- **Use description context**: Leverage Endpoint_Description and Notes for specificity
- **Max 6 words**: Keep concise but descriptive enough to avoid duplicates

### Category Rules
- **System**: /health, /status, /config, /diagnostics
- **Process**: /workflow, /approve, /process, /submit
- **Experience**: /search, /list, /dashboard, /summary
- **Data**: Standard CRUD operations on entities
- **Integration**: /webhook, /callback, /external, /import

### Domain Rules
- **Policy**: /policy, /quote, /renewal, /coverage
- **Claims**: /claim, /loss, /settlement, /adjustment
- **Customers**: /customer, /user, /contact, /profile
- **Agent**: /agent, /broker, /commission, /territory
- **Billing**: /payment, /invoice, /billing, /account
- **Underwriting**: /underwrite, /risk, /approval, /rate

### Web Domains Assignment
Based on endpoint characteristics:
- Internal admin endpoints → "admin.internal.com"
- Customer-facing APIs → "api.customer.com"
- Agent portals → "agent.portal.com"
- Public APIs → "api.public.com"

## Output Quality Standards

### Catalog Completeness
- All source endpoints converted (100% coverage)
- No missing required fields
- Consistent naming conventions
- Proper categorization

### Business Readiness
- Business-friendly endpoint names
- Clear domain classifications
- Appropriate exposure type assignments
- Standard authentication types

## Implementation Requirements

### Direct Output Creation
**CRITICAL**: Do NOT create scripts. Directly create the output CSV file.
- Read the source CSV and transform each row directly
- Create the `api_catalog.csv` file with proper formatting
- Generate the conversion summary markdown file
- No intermediate scripts or automation tools

### Duplicate Name Prevention
**CRITICAL**: Avoid endpoint name collisions by using context:
1. **Analyze Endpoint_Description and Notes** for distinguishing factors
2. **Use specific qualifiers**: "By Postcode", "By Address", "Preregister", "New Account"
3. **Include workflow stage**: "Validate", "Approve", "Submit", "Process"
4. **Add search criteria**: "By ID", "By Status", "By Date Range"
5. **Check for existing names** and add qualifiers to prevent duplicates

Example collision resolution:
```
Original: "Search Records" (3 duplicates)
Resolved:
- "Search Records By Postcode"
- "Search Records By Address"
- "Search Records By Date Range"

Original: "Create Customer" (2 duplicates)
Resolved:
- "Preregister Customer Account"
- "Create New Customer Account"
```

### Naming Examples with Context
Use the full description and notes to create specific names:
```
Path: /api/v1/address/search
Description: "Search address database by postcode lookup"
→ Name: "Search Address By Postcode"

Path: /api/v1/address/search
Description: "Search address database by full address string"
→ Name: "Search Address By String"

Path: /api/v1/customer/register
Description: "Pre-registration for customer account setup"
→ Name: "Preregister Customer Account"

Path: /api/v1/customer/create
Description: "Create complete customer account with full validation"
→ Name: "Create Customer Account"
```

## Success Criteria
- Direct creation of output CSV without intermediate scripts
- Unique and descriptive endpoint names with zero duplicates
- Context-driven naming using full Endpoint_Description and Notes
- Proper business domain mapping
- Standard authentication type classification
- Ready for enterprise API catalog integration