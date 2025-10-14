# Workflow 3: API/Endpoint Inventory Creation

## Overview

This workflow creates a comprehensive endpoint inventory for any .NET repository, detecting ALL types of endpoints including REST APIs, ASP.NET WebForms, WCF Services, and any other discoverable endpoints. This is the most critical workflow for accurate endpoint discovery and forms the foundation for detailed documentation.

## Purpose

- Generate complete endpoint inventory for a specific repository
- Detect ALL endpoint types (not just REST APIs)
- Create accurate `endpoint_inventory.csv` for subsequent analysis
- Handle complex repository structures and legacy .NET applications

## Output

Creates `{wizard_root}/analysis/{repo_name}/{sub_repo}/endpoint_inventory.csv`

## Comprehensive Endpoint Detection

### 🎯 **All Endpoint Types Supported**

#### 1. **REST API Endpoints**
- **MVC Controllers**: `*Controller.cs` files with `[HttpGet]`, `[HttpPost]`, etc.
- **Web API Controllers**: Classes inheriting from `ApiController` or `ControllerBase`
- **Minimal APIs**: `app.MapGet()`, `app.MapPost()`, etc. in Program.cs or extension methods

#### 2. **ASP.NET WebForms**
- **ASPX Pages**: `*.aspx` files with server-side methods
- **Code-Behind**: `*.aspx.cs` files with `Page_Load`, button click handlers
- **User Controls**: `*.ascx` and `*.ascx.cs` files
- **Master Pages**: `*.master` and `*.master.cs` files
- **ASHX Handlers**: `*.ashx` generic handlers

#### 3. **WCF Services**
- **Service Contracts**: Interfaces with `[ServiceContract]` attribute
- **Service Implementations**: Classes with `[ServiceBehavior]`
- **SVC Files**: `*.svc` service endpoints

#### 4. **Legacy ASP.NET**
- **ASMX Web Services**: `*.asmx` files with `[WebMethod]`
- **ASPX Web Methods**: Static methods with `[WebMethod]` in code-behind

#### 5. **Other Endpoints**
- **SignalR Hubs**: Classes inheriting from `Hub`
- **OData Endpoints**: `ODataController` implementations
- **GraphQL Endpoints**: GraphQL schema definitions
- **Custom HTTP Handlers**: `IHttpHandler` implementations

## Execution Steps

### Phase 1: Repository Analysis and Setup
1. **Path Validation**: Confirm target repository exists and is .NET project
2. **Output Structure**: Create `{wizard_root}/analysis/{repo_name}/{sub_repo}/`
3. **Technology Detection**: Identify .NET frameworks and project types
4. **Scope Determination**: Single project vs mono-repo analysis

**Windows-Compatible Commands:**
```powershell
# Repository validation
Test-Path "repositories\{repo_name}"
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.csproj" -Depth 3

# Output folder creation
New-Item -Path "analysis\{repo_name}\{sub_repo}" -ItemType Directory -Force
```

### Phase 2: Comprehensive Endpoint Discovery

#### REST API Detection
```powershell
# MVC/Web API Controllers (Windows)
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*Controller.cs"
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[HttpGet\]|\[HttpPost\]|\[Route\]" -Recurse

# Minimal APIs
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "app\.Map(Get|Post|Put|Delete|Patch)" -Recurse

# Cross-platform using ripgrep (recommended)
rg "class.*Controller|app\.Map(Get|Post)" "repositories\{repo_name}" --type cs
```

#### WebForms Detection
```powershell
# ASPX Pages and User Controls (Windows)
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.aspx"
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.ascx"
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.master"

# WebMethods in code-behind
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[WebMethod\]" -Recurse

# ASHX Handlers
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.ashx"

# Cross-platform
rg "\[WebMethod\]|\.aspx|\.ascx|\.ashx" "repositories\{repo_name}"
```

#### WCF and Legacy Services
```powershell
# WCF Services
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[ServiceContract\]|\[ServiceBehavior\]" -Recurse
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.svc"

# ASMX Web Services
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.asmx"

# Cross-platform
rg "\[ServiceContract\]|\.svc|\.asmx" "repositories\{repo_name}"
```

### Phase 3: Endpoint Analysis and Classification

#### Endpoint Information Extraction
For each discovered endpoint, extract:
1. **Endpoint Path/URL**: Route, page name, or service address
2. **HTTP Method**: GET, POST, PUT, DELETE, or WebForm postback
3. **Endpoint Type**: REST API, WebForm, WCF Service, etc.
4. **File Location**: Exact file path and line number
5. **Method/Handler Name**: Specific method or event handler
6. **Parameters**: Input parameters and data types
7. **Authentication**: Authorization attributes or requirements

#### Classification Logic
```powershell
# Controller analysis for REST APIs
Select-String -Path $controllerFile -Pattern "public.*Action.*\(" -AllMatches

# WebForm page analysis
Select-String -Path $aspxFile -Pattern "Page_Load|Button.*_Click" -AllMatches

# Parameter extraction
Select-String -Path $file -Pattern "\[FromBody\]|\[FromQuery\]|Request\.Form" -AllMatches
```

### Phase 4: CSV Generation

#### CSV Structure: endpoint_inventory.csv
```csv
Code,Endpoint_Type,HTTP_Method,Endpoint_Path,File_Path,Line_Number,Method_Name,Parameters,Authentication,Access_Level,Business_Domain,Framework_Version,Notes
```

#### Column Definitions
- **Code**: Unique identifier (repo-endpoint-00001)
- **Endpoint_Type**: REST API, WebForm, WCF Service, ASMX, Handler, etc.
- **HTTP_Method**: GET, POST, PUT, DELETE, or POSTBACK for forms
- **Endpoint_Path**: URL route, page path, or service endpoint
- **File_Path**: Relative path to source file
- **Line_Number**: Line where endpoint is defined
- **Method_Name**: Controller action, page method, or service operation
- **Parameters**: Input parameters (simplified list)
- **Authentication**: Auth requirements detected
- **Access_Level**: Public, Private, Internal (based on accessibility)
- **Business_Domain**: Inferred domain from namespace/folder structure
- **Framework_Version**: .NET Framework version detected
- **Notes**: Additional observations

## Advanced Detection Patterns

### WebForms Specific Patterns
```powershell
# Page methods and event handlers
rg "protected void (Page_Load|Button.*_Click|.*_Click)" --type cs

# Server controls and data binding
rg "asp:.*runat=\"server\"|<%.*%>|DataBind\(\)" --type html

# ViewState and postback patterns
rg "__doPostBack|ViewState|Page\.IsPostBack" --type cs
```

### Legacy ASP.NET Patterns
```powershell
# Web methods in pages
rg "\[WebMethod\].*public static" --type cs

# Global.asax handlers
rg "Application_Start|Session_Start|Application_Error" --type cs

# HTTP Modules and Handlers
rg "IHttpModule|IHttpHandler|ProcessRequest" --type cs
```

### Modern .NET Patterns
```powershell
# Minimal API patterns
rg "app\.(Map|Use|Run)" --type cs

# SignalR Hubs
rg "class.*Hub|IHubContext" --type cs

# OData Controllers
rg "class.*ODataController" --type cs
```

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

## Error Handling

### Missing Endpoints
- **Validation Check**: Compare discovered count with expected patterns
- **Manual Review Flag**: Mark repositories requiring manual inspection
- **Pattern Gaps**: Document endpoint types that might be missed

### File Access Issues
- **Permission Handling**: Skip inaccessible files with logging
- **Corrupted Files**: Handle encoding and format issues gracefully
- **Large Files**: Skip extremely large files that might cause memory issues

## Success Criteria

A successful execution should:
1. **Complete Coverage**: All endpoint types detected and cataloged
2. **Accurate Classification**: Endpoints properly categorized by type
3. **Precise Location**: Exact file paths and line numbers provided
4. **Consistent Format**: CSV follows specified structure exactly
5. **Performance**: Completes efficiently even for large repositories

## Integration Points

### Input from Previous Workflows
- **Workflow 1 Results**: Repository structure and technology insights
- **Workflow 2 Results**: API mapping context for focused analysis

### Output for Next Workflows
- **Workflow 4**: Uses endpoint_inventory.csv for documentation generation
- **Workflow 5**: Uses endpoint data for business and security analysis

## Usage Examples

### Trigger Commands
```
"Create endpoint inventory for repository: [repo-name]"
"Generate comprehensive endpoint inventory using Workflow 3"
"Execute endpoint discovery workflow for [repo-name]/[sub-project]"
"Run Workflow 3 endpoint analysis on [specific-path]"
```

### Expected Interaction
```
User: "Create endpoint inventory for eShopOnWeb-main/PublicApi"

Copilot:
1. Analyzing repository structure...
2. Discovering REST API endpoints...
3. Scanning for WebForms and legacy endpoints...
4. Processing WCF services...
5. Generating endpoint inventory CSV...
6. Created: analysis/eShopOnWeb-main/PublicApi/endpoint_inventory.csv
7. Summary: 47 endpoints discovered (32 REST APIs, 8 WebForms, 7 WCF Services)
```

## Template Integration

Uses `templates/endpoint_inventory_template.csv` for consistent CSV structure and formatting guidelines.

This workflow forms the critical foundation for accurate endpoint documentation and should be executed before Workflows 4 and 5 for optimal results.