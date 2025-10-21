# Workflow 3: Comprehensive Endpoint Inventory Creation

## Purpose
This workflow creates a comprehensive endpoint inventory for ANY .NET repository, detecting ALL types of endpoints including REST APIs, ASP.NET WebForms, WCF Services, ASMX, Handlers, SignalR, and any other discoverable endpoints. This is the most critical workflow for accurate endpoint discovery.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Create endpoint inventory for repository"
- "Generate comprehensive endpoint inventory"
- "Execute endpoint discovery workflow"
- "Extract all endpoints from [repository-name]"
- "Run Workflow 3"
- "Endpoint inventory creation"
- "Discover endpoints in [repo]/[sub-project]"

## Input Requirements
- **Target repository path** (e.g., "eShopOnWeb-main", "eShopOnWeb-main/PublicApi")
- **Repository access** (read permissions for scanning)
- Optional: Previous workflow context for enhanced analysis

## Output
Creates `analysis/{repo_name}/{sub_repo}/endpoint_inventory.csv` with comprehensive endpoint catalog

## Three-Phase Discovery Architecture

### Phase 1: Physical File Detection
Discover endpoints through file system scanning:

#### REST API Endpoints
```powershell
# MVC/Web API Controllers (Windows)
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*Controller.cs"
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[HttpGet\]|\[HttpPost\]|\[Route\]" -Recurse

# Minimal APIs
Select-String -Path "repositories\{repo}\*.cs" -Pattern "app\.Map(Get|Post|Put|Delete|Patch)" -Recurse
```

#### WebForms Detection
```powershell
# ASPX Pages and User Controls (Windows)
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.aspx"
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.ascx"
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.master"

# WebMethods in code-behind
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[WebMethod\]" -Recurse

# ASHX Handlers
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.ashx"
```

#### WCF and Legacy Services
```powershell
# WCF Services
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[ServiceContract\]|\[ServiceBehavior\]" -Recurse
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.svc"

# ASMX Web Services
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.asmx"
```

### Phase 2: Configuration-Based Discovery (Virtual Endpoints)
Detect endpoints defined through configuration:

#### web.config Analysis
```powershell
# URL Rewriting and Virtual Directories
Select-String -Path "repositories\{repo}\web.config" -Pattern "rewriteMap|urlMappings|virtualDirectory" -Recurse

# HTTP Handlers and Modules
Select-String -Path "repositories\{repo}\*.config" -Pattern "httpHandlers|httpModules" -Recurse
```

#### Route Configuration
```powershell
# ASP.NET Core Routing
Select-String -Path "repositories\{repo}\*.cs" -Pattern "UseEndpoints|MapControllers|MapRazorPages|UseRouting" -Recurse

# MVC Route Configuration
Select-String -Path "repositories\{repo}\*.cs" -Pattern "routes\.MapRoute|RegisterRoutes" -Recurse
```

### Phase 3: Framework-Aware Discovery
Detect framework-specific endpoint patterns:

#### Modern .NET Patterns
```powershell
# Minimal API patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "app\.(Map|Use|Run)" -Recurse

# SignalR Hubs
Select-String -Path "repositories\{repo}\*.cs" -Pattern "class.*Hub|IHubContext" -Recurse

# OData Controllers
Select-String -Path "repositories\{repo}\*.cs" -Pattern "class.*ODataController" -Recurse
```

## Endpoint Classification System

### REST API Endpoints
- **Type**: REST API
- **Detection**: Controllers with HTTP attributes, Minimal API patterns
- **Metadata**: HTTP method, route pattern, parameters

### ASP.NET WebForms
- **Type**: WebForm
- **Detection**: .aspx files, Page_Load methods, WebMethods
- **Metadata**: Page lifecycle, postback events, controls

### WCF Services
- **Type**: WCF Service
- **Detection**: ServiceContract interfaces, .svc files
- **Metadata**: Service operations, bindings, contracts

### Legacy Services
- **Type**: ASMX Service
- **Detection**: .asmx files, WebMethod attributes
- **Metadata**: Web methods, SOAP operations

### HTTP Handlers
- **Type**: Handler
- **Detection**: .ashx files, IHttpHandler implementations
- **Metadata**: Processing logic, request handling

### Virtual Endpoints
- **Type**: Virtual Endpoint
- **Detection**: Configuration-based routing, URL rewriting
- **Metadata**: Virtual path, physical mapping, configuration source

## CSV Schema

### Enhanced Column Structure
```csv
Code,Endpoint_Type,HTTP_Method,Endpoint_Path,Endpoint_Description,Virtual_URL,Physical_Location,Discovery_Method,Configuration_Source,File_Path,Line_Number,Method_Name,Parameters,Authentication,Access_Level,Business_Domain,Framework_Version,Route_Pattern,Endpoint_Status,Dependencies,Notes
```

### Column Definitions
- **Code**: Unique identifier (repo-endpoint-00001)
- **Endpoint_Type**: REST API, WebForm, WCF Service, ASMX, Handler, etc.
- **HTTP_Method**: GET, POST, PUT, DELETE, SOAP, WebSocket, etc.
- **Endpoint_Path**: URL route or service endpoint path
- **Endpoint_Description**: Brief description of endpoint functionality
- **Virtual_URL**: Publicly accessible URL (what users hit)
- **Physical_Location**: Actual implementation file/method
- **Discovery_Method**: File_Scan, Config_Analysis, Framework_Detection
- **Configuration_Source**: web.config, Global.asax, RouteConfig, etc.
- **File_Path**: Relative path from repository root (e.g., src/Controllers/ProductController.cs) - NEVER use absolute paths like C:\xyz\
- **Line_Number**: Line where endpoint is defined
- **Method_Name**: Controller action, page method, or service operation
- **Parameters**: Input parameters (simplified list)
- **Authentication**: Auth requirements detected
- **Access_Level**: Public, Private, Internal (based on accessibility)
- **Business_Domain**: Inferred domain from namespace/folder structure
- **Framework_Version**: .NET Framework version detected
- **Route_Pattern**: How virtual URL maps to implementation
- **Endpoint_Status**: Active, Deprecated, Configured_But_Missing
- **Dependencies**: Required components (IIS_Rewrite, WCF_Runtime, etc.)
- **Notes**: Additional observations

## Multi-Source Information Extraction

For each discovered endpoint:
1. **Virtual URL**: Publicly accessible URL path
2. **Physical Location**: Actual implementation file/method
3. **Discovery Method**: How the endpoint was found
4. **Configuration Source**: Where virtual routing is defined
5. **Route Pattern**: URL-to-implementation mapping
6. **Endpoint Status**: Operational status
7. **Dependencies**: Required framework components
8. **Endpoint Description**: Generate clear, concise description based on method name, parameters, and context

## Efficiency Optimizations

### Large Codebase Handling
- **Parallel Processing**: Analyze different endpoint types simultaneously
- **Pattern Prioritization**: Check most common patterns first
- **Early Termination**: Stop scanning once pattern threshold reached
- **File Type Filtering**: Skip non-relevant files (tests, bin, obj)

### Windows Performance Commands
```powershell
# Batch file discovery
$controllers = Get-ChildItem "repositories\{repo}" -Recurse -Filter "*Controller.cs"
$webforms = Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.aspx"
$services = Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.svc"

# Parallel pattern matching
$controllers | ForEach-Object -Parallel {
    Select-String -Path $_.FullName -Pattern "\[Http(Get|Post|Put|Delete)\]"
}
```

## Quality Assurance and Validation

### Cross-Reference Validation
```powershell
# Validate virtual endpoints have implementations
ForEach ($virtualEndpoint in $virtualEndpoints) {
    $physicalPath = $virtualEndpoint.PhysicalLocation
    if (-not (Test-Path $physicalPath)) {
        Write-Warning "Virtual endpoint $($virtualEndpoint.VirtualURL) references missing file: $physicalPath"
    }
}
```

### Gap Detection
- Common endpoint patterns verification
- Standard framework endpoints checking
- Potentially missed endpoints identification
- Confidence scoring based on discovery completeness

## Error Handling
- **Missing Endpoints**: Validation checks and manual review flags
- **File Access Issues**: Permission handling and corrupted file management
- **Large Files**: Memory-safe processing with size limits
- **Pattern Gaps**: Documentation of potentially missed endpoint types

## Success Criteria
- **Complete Coverage**: All endpoint types detected and cataloged
- **Accurate Classification**: Endpoints properly categorized by type
- **Precise Location**: Exact file paths and line numbers provided
- **Consistent Format**: CSV follows enhanced schema exactly
- **Performance**: Efficient completion even for large repositories

## Integration Notes
- **Standalone Operation**: Works independently of other workflows
- **Optional Enhancement**: Can leverage Workflow 1 & 2 results for context
- **Feeds Workflow 4**: Provides foundation for endpoint documentation
- **Supports Workflow 5**: Enhances repository analysis with endpoint data

## Advanced Features
- **Static Endpoint Extractor**: Optional tool integration for efficiency
- **Context Preservation**: Pre-extract patterns to save AI context
- **Universal Detection**: Support for all .NET endpoint types
- **Enterprise Scale**: Optimized for large codebases