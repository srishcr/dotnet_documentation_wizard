# API Inventory Template - 03_api_inventory.csv

## Template Instructions

This template generates a comprehensive CSV inventory of all API endpoints discovered in the .NET codebase. Each API receives a unique identifier for tracking and cross-referencing with individual API documentation.

### CSV Structure

The inventory follows this column structure:

```csv
Code,Method,Endpoint,Controller,Action,Purpose,Access_Level,Domain,Authentication,User_Roles,Sensitive_Data,Business_Journey,File_Path,Line_Number,Status,Notes
```

### Column Definitions

| Column | Description | Example Values |
|--------|-------------|----------------|
| **Code** | Unique identifier for API | `eshop-api-00001`, `myapp-api-00042` |
| **Method** | HTTP method | `GET`, `POST`, `PUT`, `DELETE`, `PATCH` |
| **Endpoint** | Full endpoint path | `/api/products`, `/api/orders/{orderId}` |
| **Controller** | Controller or endpoint class | `ProductsController`, `CatalogItemListEndpoint` |
| **Action** | Method or action name | `GetProducts`, `CreateOrder`, `Index` |
| **Purpose** | Brief functional description | `List all products`, `Create new order` |
| **Access_Level** | Internal/External classification | `External`, `Internal`, `Public`, `Private` |
| **Domain** | Business domain | `Catalog`, `Orders`, `Identity`, `Payment` |
| **Authentication** | Auth requirement | `Required`, `Optional`, `None`, `Anonymous` |
| **User_Roles** | Allowed user roles | `Customer`, `Admin`, `Staff`, `Public` |
| **Sensitive_Data** | Data sensitivity patterns found | `PII`, `Financial`, `Auth`, `Confidential`, `None` |
| **Business_Journey** | Potential business journey | `User Registration`, `Product Purchase`, `Admin Management` |
| **File_Path** | Source file location | `src/Controllers/ProductsController.cs` |
| **Line_Number** | Line where endpoint is defined | `25`, `42`, `156` |
| **Status** | Implementation status | `Active`, `Deprecated`, `Beta`, `Planned` |
| **Notes** | Additional context | `Paginated response`, `Legacy endpoint` |

### Codification Strategy

#### Code Format
Use this pattern: `{project-name}-api-{sequential-number}`

Examples:
- `eshop-api-00001` for eShop project
- `crm-api-00023` for CRM project
- `blog-api-00156` for Blog project

#### Sequential Numbering
- Start from 00001
- Use zero-padding for consistent sorting
- Increment for each unique endpoint
- Maintain sequence across all domains

### Analysis Approach

#### 1. Extract from Endpoint Scanner Output
Use the static endpoint extractor output as the primary data source:

```plaintext
🚀 MINIMAL API ENDPOINTS
-----------------------------------------------------------------------------------------
HTTP Method & Route: Get("api/catalog-types",
   File: src/PublicApi/CatalogTypeEndpoints/CatalogTypeListEndpoint.cs
   Line: 27
```

#### 2. Classify by Access Level
- **External**: APIs intended for client applications, partners, or public use
- **Internal**: APIs for system-to-system communication, admin tools
- **Public**: Openly accessible without authentication
- **Private**: Restricted access, authentication required

#### 3. Determine Business Domain
Map endpoints to business domains by analyzing:
- Namespace structure
- Entity types in the endpoint
- Business logic context
- Folder organization

#### 4. Identify Authentication Requirements
Look for:
- `[Authorize]` attributes
- `[AllowAnonymous]` attributes
- JWT token validation
- API key requirements
- Role-based restrictions

#### 5. Detect Sensitive Data Patterns
Scan request/response models for:
- **PII indicators**: `email`, `phone`, `address`, `name`, `ssn`
- **Financial indicators**: `card`, `payment`, `billing`, `amount`
- **Authentication indicators**: `password`, `token`, `secret`
- **Confidential indicators**: `internal`, `admin`, `private`

#### 6. Identify Potential Business Journeys
Map APIs to business workflows by analyzing:
- Controller groupings and dependencies
- Sequential API call patterns
- Core business entity operations
- User interaction flows

### Example CSV Content

```csv
Code,Method,Endpoint,Controller,Action,Purpose,Access_Level,Domain,Authentication,User_Roles,Sensitive_Data,Business_Journey,File_Path,Line_Number,Status,Notes
eshop-api-00001,GET,/api/catalog-types,CatalogTypeListEndpoint,Handle,List all catalog types,External,Catalog,None,Public,None,Product Discovery,src/PublicApi/CatalogTypeEndpoints/CatalogTypeListEndpoint.cs,27,Active,Used by product filtering
eshop-api-00002,GET,/api/catalog-brands,CatalogBrandListEndpoint,Handle,List all catalog brands,External,Catalog,None,Public,None,Product Discovery,src/PublicApi/CatalogBrandEndpoints/CatalogBrandListEndpoint.cs,27,Active,Used by product filtering
eshop-api-00003,GET,/api/catalog-items,CatalogItemListPagedEndpoint,Handle,List catalog items with pagination,External,Catalog,None,Public,None,Product Discovery,src/PublicApi/CatalogItemEndpoints/CatalogItemListPagedEndpoint.cs,31,Active,Supports search and filtering
eshop-api-00004,GET,/api/catalog-items/{catalogItemId},CatalogItemGetByIdEndpoint,Handle,Get specific catalog item,External,Catalog,None,Public,None,Product Discovery,src/PublicApi/CatalogItemEndpoints/CatalogItemGetByIdEndpoint.cs,25,Active,Returns detailed product info
eshop-api-00005,POST,/api/catalog-items,CreateCatalogItemEndpoint,Handle,Create new catalog item,Internal,Catalog,Required,Admin,None,Admin Management,src/PublicApi/CatalogItemEndpoints/CreateCatalogItemEndpoint.cs,29,Active,Admin-only product creation
eshop-api-00006,PUT,/api/catalog-items,UpdateCatalogItemEndpoint,Handle,Update existing catalog item,Internal,Catalog,Required,Admin,None,Admin Management,src/PublicApi/CatalogItemEndpoints/UpdateCatalogItemEndpoint.cs,27,Active,Admin-only product updates
eshop-api-00007,DELETE,/api/catalog-items/{catalogItemId},DeleteCatalogItemEndpoint,Handle,Delete catalog item,Internal,Catalog,Required,Admin,None,Admin Management,src/PublicApi/CatalogItemEndpoints/DeleteCatalogItemEndpoint.cs,20,Active,Admin-only product deletion
eshop-api-00008,POST,/api/authenticate,AuthenticateEndpoint,Handle,User authentication,External,Identity,None,Public,Auth,User Authentication,src/PublicApi/AuthEndpoints/AuthenticateEndpoint.cs,29,Active,JWT token generation
eshop-api-00009,GET,/User,UserController,GetCurrentUser,Get current user info,Internal,Identity,Required,Customer,PII,User Profile Management,src/Web/Controllers/UserController.cs,38,Active,User profile data
eshop-api-00010,POST,/Logout,UserController,Logout,User logout,Internal,Identity,Required,Customer,Auth,User Authentication,src/Web/Controllers/UserController.cs,45,Active,Session termination
```

### Classification Guidelines

#### Access Level Classification

**External APIs** - Indicators:
- Public-facing endpoints
- Used by mobile apps or web clients
- No authentication required OR token-based auth
- CORS enabled
- OpenAPI documentation
- Rate limiting implemented

**Internal APIs** - Indicators:
- Admin-only access
- System-to-system communication
- Server-side rendering endpoints
- Management interfaces
- Restricted IP access

#### Domain Classification

Common .NET application domains:
- **Catalog**: Product management, inventory, categories
- **Orders**: Order processing, shopping cart, checkout
- **Identity**: Authentication, user management, roles
- **Payment**: Payment processing, billing, invoicing
- **Inventory**: Stock management, warehousing
- **Content**: CMS, media management, publishing
- **Communication**: Notifications, messaging, emails
- **Reporting**: Analytics, reports, dashboards

#### Authentication Analysis

Look for these patterns:

```csharp
[Authorize] // Authentication required
[AllowAnonymous] // No authentication
[Authorize(Roles = "Admin")] // Role-based auth
[Authorize(Policy = "PolicyName")] // Policy-based auth
```

### Quality Assurance Checklist

Before finalizing the API inventory:

- [ ] All discovered endpoints are included
- [ ] Code numbers are sequential and unique
- [ ] Access levels are accurately classified
- [ ] Domains are logical and consistent
- [ ] Authentication requirements are verified
- [ ] File paths and line numbers are accurate
- [ ] Purpose descriptions are clear and concise
- [ ] User roles are realistic and complete
- [ ] CSV format is valid and parseable

### Analysis Automation Guidelines

#### Pattern Recognition for Classification

**External API Patterns:**
```csharp
// Public APIs - no auth required
app.MapGet("/api/products", GetProducts);

// Client-facing APIs
[Route("api/[controller]")]
public class ProductsController : ControllerBase
```

**Internal API Patterns:**
```csharp
// Admin-only endpoints
[Authorize(Roles = "Admin")]
public class ManageController : Controller

// System internal
[Route("admin/[action]")]
public class AdminController : Controller
```

#### Domain Mapping Strategy

Map endpoints to domains using:
1. **Namespace analysis**: `MyApp.Catalog.*` → Catalog domain
2. **Entity names**: `Product`, `Category` → Catalog domain
3. **Folder structure**: `src/OrderManagement/` → Orders domain
4. **Controller names**: `OrderController` → Orders domain

#### Status Determination

- **Active**: Currently in use, no deprecation markers
- **Deprecated**: Marked with `[Obsolete]` or deprecation comments
- **Beta**: Version indicators, experimental flags
- **Planned**: TODO comments, interface without implementation

### Integration with Individual API Docs

Each API code in the inventory should:
- Map to a corresponding individual API documentation file
- Follow naming convention: `{code}.md` (e.g., `eshop-api-00001.md`)
- Enable easy cross-referencing between inventory and detailed docs
- Support automated documentation generation workflows

### Maintenance Considerations

- Update inventory when new APIs are added
- Review access level classifications periodically
- Validate authentication requirements during security reviews
- Keep user role mappings current with actual system roles
- Use inventory for API governance and security audits