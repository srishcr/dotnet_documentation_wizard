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
Create meaningful names from paths:
```
/api/v1/users/{id} (GET) → "Get User Details"
/api/v1/users (POST) → "Create User"
/api/v1/users/{id} (PUT) → "Update User"
/api/v1/users/{id} (DELETE) → "Delete User"
/api/v1/policies/search (GET) → "Search Policies"
/api/v1/claims/{id}/status (PUT) → "Update Claim Status"
```

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

## Processing Steps

### Step 1: Load, Filter, and Validate Source CSV
```powershell
# Load consolidated endpoint inventory
$sourceCSV = Import-Csv "path/to/consolidated_endpoint_inventory.csv"

# Filter out swagger/OpenAPI documentation endpoints
$filteredCSV = $sourceCSV | Where-Object {
    $_.Endpoint_Path -notmatch "/swagger|/swagger-ui|/api-docs|/openapi|/docs" -and
    $_.Endpoint_Description -notmatch "swagger|openapi|documentation"
}

# Validate required columns exist
$requiredColumns = @("Service_Name", "Endpoint_Path", "HTTP_Method", "Endpoint_Description", "Notes", "Authentication", "Business_Domain")
```

### Step 2: Transform Each Endpoint
For each row in filtered CSV (excluding swagger endpoints):
1. **Generate Endpoint Name**: Create business-friendly name from path and method
2. **Determine Category**: Classify based on path patterns and functionality
3. **Combine Description**: Merge Endpoint_Description and Notes fields
4. **Map Domain**: Classify into business domain
5. **Standardize Authentication**: Convert to standard format
6. **Determine Exposure**: Classify as Public/Private based on patterns
7. **Extract Version**: Parse version from path or default

### Step 3: Quality Validation
- **Completeness Check**: Ensure all required fields populated
- **Consistency Check**: Verify consistent naming and categorization
- **Duplication Detection**: Identify potential duplicate endpoints
- **Business Logic Validation**: Check domain and category assignments

### Step 4: Generate Outputs
- **API Catalog CSV**: Complete catalog in target format
- **Conversion Summary**: Statistics and transformation details

## Conversion Rules

### Endpoint Name Rules
- Use Title Case (e.g., "Get User Details")
- Start with action verb (Get, Create, Update, Delete, Search, List)
- Include entity name (User, Policy, Claim)
- Be descriptive but concise (max 50 characters)

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

## Success Criteria
- Complete conversion of all endpoints from source CSV
- Consistent and meaningful endpoint names
- Proper business domain mapping
- Standard authentication type classification
- Ready for enterprise API catalog integration