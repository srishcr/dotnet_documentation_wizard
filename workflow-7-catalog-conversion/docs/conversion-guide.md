# Catalog Conversion Guide

## Overview
This guide provides detailed instructions for converting consolidated endpoint inventory CSV to enterprise API catalog format using Workflow 7.

## Prerequisites

### Required Input
- **Consolidated Endpoint Inventory CSV** from Workflow 3 outputs
- **Service Name Column**: Must include "Service_Name" as first column
- **Standard Workflow 3 Schema**: All required Workflow 3 columns present

### Expected Source Schema
```csv
Service_Name,Code,Endpoint_Type,HTTP_Method,Endpoint_Path,Endpoint_Description,Virtual_URL,Physical_Location,Discovery_Method,Configuration_Source,File_Path,Line_Number,Method_Name,Parameters,Authentication,Access_Level,Business_Domain,Framework_Version,Route_Pattern,Endpoint_Status,Dependencies,Notes
```

## Conversion Process

### Step 1: Source Validation
Before conversion, validate your source CSV:
- Confirm "Service_Name" column exists as first column
- Verify all endpoints have HTTP methods
- Check endpoint paths are properly formatted
- Ensure authentication fields are populated

### Step 2: Execute Conversion
Use the trigger command:
```
Convert endpoint inventory to catalog format
```

### Step 3: Review Output
Check generated files:
- `api_catalog.csv` - Main catalog output
- `catalog_conversion_summary.md` - Conversion statistics

## Conversion Rules

### Endpoint Name Generation Rules

#### Standard Patterns
| Path Pattern | Method | Generated Name |
|--------------|--------|----------------|
| `/api/v1/users/{id}` | GET | "Get User Details" |
| `/api/v1/users` | POST | "Create User" |
| `/api/v1/users/{id}` | PUT | "Update User" |
| `/api/v1/users/{id}` | DELETE | "Delete User" |
| `/api/v1/users/search` | GET | "Search Users" |
| `/api/v1/users/list` | GET | "List Users" |

#### Business Entity Patterns
| Entity | GET | POST | PUT | DELETE |
|--------|-----|------|-----|--------|
| Policy | "Get Policy Details" | "Create Policy" | "Update Policy" | "Delete Policy" |
| Claim | "Get Claim Details" | "Submit Claim" | "Update Claim" | "Cancel Claim" |
| Customer | "Get Customer Profile" | "Create Customer" | "Update Customer" | "Remove Customer" |
| Agent | "Get Agent Information" | "Register Agent" | "Update Agent" | "Deactivate Agent" |

### Category Classification Rules

#### System Category
- Health check endpoints: `/health`, `/status`
- Configuration endpoints: `/config`, `/settings`
- Diagnostic endpoints: `/diagnostics`, `/metrics`
- Admin endpoints: `/admin/system`

#### Process Category
- Workflow operations: `/workflow`, `/process`
- Business operations: `/approve`, `/submit`, `/process`
- State changes: `/activate`, `/deactivate`, `/suspend`
- Transaction processing: `/payment/process`, `/claim/submit`

#### Experience Category
- Search operations: `/search`, `/find`, `/query`
- List operations: `/list`, `/browse`
- Dashboard endpoints: `/dashboard`, `/summary`
- User interface APIs: `/ui/`, `/portal/`

#### Data Category
- Standard CRUD operations on entities
- Entity management: `/users`, `/policies`, `/claims`
- Reference data: `/lookup`, `/reference`
- Data export/import: `/export`, `/import`

#### Integration Category
- External system interfaces: `/external/`, `/third-party/`
- Webhook endpoints: `/webhook`, `/callback`
- Import/export operations with external systems
- API gateway integrations

### Domain Classification Rules

#### Policy Domain
- Keywords: `policy`, `quote`, `renewal`, `coverage`, `premium`
- Paths: `/policies/`, `/quotes/`, `/coverage/`
- Business context: Insurance policy management

#### Claims Domain
- Keywords: `claim`, `loss`, `settlement`, `adjustment`, `damage`
- Paths: `/claims/`, `/losses/`, `/settlements/`
- Business context: Insurance claims processing

#### Customers Domain
- Keywords: `customer`, `user`, `contact`, `profile`, `individual`
- Paths: `/customers/`, `/users/`, `/contacts/`
- Business context: Customer relationship management

#### Agent Domain
- Keywords: `agent`, `broker`, `commission`, `territory`, `portal`
- Paths: `/agents/`, `/brokers/`, `/commissions/`
- Business context: Agent and broker management

#### Billing Domain
- Keywords: `payment`, `invoice`, `billing`, `account`, `financial`
- Paths: `/payments/`, `/billing/`, `/invoices/`
- Business context: Financial operations

#### System Domain
- Keywords: `health`, `status`, `config`, `admin`, `diagnostic`
- Paths: `/health`, `/status`, `/admin/`, `/system/`
- Business context: System operations and monitoring

### Authentication Type Mapping

#### Standard Mappings
| Source Auth | Target Auth Type |
|-------------|------------------|
| "JWT Bearer" | "OAuth" |
| "Bearer Token" | "OAuth" |
| "API Key" | "API Key" |
| "None" | "None" |
| "Anonymous" | "None" |
| "Basic Auth" | "Basic" |
| "Windows Auth" | "Windows" |
| "Custom" | "Custom" |

### API Exposure Classification

#### Private APIs
- Internal system endpoints
- Admin and configuration APIs
- Backend service integrations
- Endpoints with high-privilege authentication

#### Public APIs
- Customer-facing endpoints
- Public data access
- External integration points
- Partner APIs with appropriate authentication

## Quality Validation

### Required Field Validation
Ensure all catalog entries have:
- Service_Name (from source)
- Endpoint_Name (generated)
- Endpoint_Category (classified)
- Endpoint_Description (combined from source)
- Domain (classified)
- Endpoint_Method (from source)
- Endpoint_Path (from source)

### Business Logic Validation
- Endpoint names follow naming conventions
- Categories align with endpoint functionality
- Domains match business context
- Authentication types are standardized
- Exposure types are appropriate

### Consistency Validation
- Similar endpoints have consistent naming
- Category assignments are logical
- Domain classifications are complete
- Authentication mapping is accurate

## Common Issues and Solutions

### Issue: Missing Endpoint Descriptions
**Solution**: Combine `Endpoint_Description` and `Notes` from source CSV, generate description from path if both empty

### Issue: Unclear Domain Classification
**Solution**: Use keyword analysis on path and description, default to most likely domain based on service name

### Issue: Authentication Type Ambiguity
**Solution**: Map to closest standard type, use "Custom" for unclear cases, document in conversion summary

### Issue: Duplicate Endpoint Names
**Solution**: Add qualifier to distinguish (e.g., "Get User Details - Admin", "Get User Details - Public")

## Post-Conversion Tasks

### 1. Review Generated Names
- Verify endpoint names are business-appropriate
- Check for consistency across similar endpoints
- Ensure names are clear and descriptive

### 2. Validate Classifications
- Confirm category assignments match endpoint functionality
- Verify domain mappings align with business structure
- Check exposure type classifications for security appropriateness

### 3. Complete Missing Fields
- Add `API_Spec_URL` when OpenAPI specifications are available
- Populate `Created` dates with actual endpoint creation dates
- Update `Version` information if more precise versions are known

### 4. Integration Preparation
- Validate catalog format matches target API management platform
- Ensure all governance requirements are met
- Prepare for import into enterprise systems

## Success Metrics

### Conversion Completeness
- 100% of source endpoints successfully converted
- All required catalog fields populated
- No conversion errors or warnings

### Quality Standards
- Consistent endpoint naming conventions
- Logical category and domain classifications
- Appropriate authentication and exposure type assignments
- Business-ready descriptions and documentation