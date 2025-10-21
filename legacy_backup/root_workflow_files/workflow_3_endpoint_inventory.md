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

## Multi-Layer Endpoint Discovery Architecture

### 🎯 **Three-Phase Discovery Approach**

Modern .NET applications implement endpoints across multiple layers:
1. **Physical Endpoints**: Discoverable files (traditional approach)
2. **Virtual Endpoints**: Configuration-based routing (NEW)
3. **Dynamic Endpoints**: Runtime-generated routes (ENHANCED)

### **Phase 1: Physical File Detection (Traditional)**

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

### **Phase 2: Configuration-Based Discovery (NEW)**

#### Virtual Endpoint Detection
- **web.config URL Rewriting**: `<rewriteMap>`, `<urlMappings>` virtual paths
- **Global.asax Routing**: `Application_BeginRequest`, `RewritePath` calls
- **XML Configuration**: Custom configuration files with virtual directory mappings
- **Route Attributes**: `[Route]` attributes creating virtual paths

#### Framework-Specific Virtual Routes
- **ASP.NET Core**: Startup.cs and Program.cs endpoint configurations
- **MVC Routing**: RouteConfig.cs and controller conventions
- **Web API Routing**: Attribute-based routing patterns
- **Custom Frameworks**: Organization-specific routing mechanisms

### **Phase 3: Dynamic Endpoint Analysis (ENHANCED)**

#### Runtime-Generated Endpoints
- **Dynamic Route Registration**: Endpoints registered at application startup
- **Plugin-Based Endpoints**: Dynamically loaded modules with endpoints
- **Convention-Based Routes**: Framework conventions creating implicit endpoints
- **Reflection-Based Discovery**: Runtime type analysis for endpoint discovery

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

### Phase 2A: Physical Endpoint Discovery (Traditional)

#### REST API Detection
```powershell
# MVC/Web API Controllers (Windows)
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*Controller.cs"
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[HttpGet\]|\[HttpPost\]|\[Route\]" -Recurse

# Minimal APIs
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "app\.Map(Get|Post|Put|Delete|Patch)" -Recurse

# Alternative pattern detection
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "class.*Controller|app\.Map(Get|Post)" -Recurse
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

# Additional pattern detection
Select-String -Path "repositories\{repo_name}\*" -Pattern "\[WebMethod\]" -Recurse -Include "*.cs"
```

### Phase 2B: Configuration-Based Discovery (NEW)

#### web.config Analysis
```powershell
# Windows PowerShell
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "web.config" | ForEach-Object {
    Select-String -Path $_.FullName -Pattern "rewriteMap|urlMappings|httpHandlers|httpModules|virtualDirectory"
}

# URL Rewriting Rules
Select-String -Path "repositories\{repo_name}\web.config" -Pattern "<rewrite>|<rules>|<rewriteMap>" -Recurse

# Alternative XML pattern detection
Select-String -Path "repositories\{repo_name}\*.xml","repositories\{repo_name}\*.config" -Pattern "rewriteMap|urlMappings|httpHandlers|virtualDirectory" -Recurse
```

#### Global.asax Routing Analysis
```powershell
# Windows PowerShell
Select-String -Path "repositories\{repo_name}\Global.asax.cs" -Pattern "RewritePath|MapRoute|RegisterRoutes|Application_BeginRequest"

# Route registration patterns
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "routes\.MapRoute|HttpContext\.Current\.RewritePath" -Recurse

# Alternative C# pattern detection
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "RewritePath|MapRoute|RegisterRoutes|Application_BeginRequest" -Recurse
```

#### XML Configuration Files
```powershell
# Windows PowerShell
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.xml" | ForEach-Object {
    Select-String -Path $_.FullName -Pattern "virtualDirectory|serviceUrl|endpoint|route|mappedPath"
}

# Custom configuration patterns
Select-String -Path "repositories\{repo_name}\*.config" -Pattern "virtualPath|physicalPath|urlMapping" -Recurse

# Alternative XML configuration detection
Select-String -Path "repositories\{repo_name}\*.xml","repositories\{repo_name}\*.config" -Pattern "virtualDirectory|serviceUrl|endpoint|route|mappedPath" -Recurse
```

#### Route Attribute Detection
```powershell
# Windows PowerShell
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[Route\(|app\.UseRouting|app\.UseEndpoints" -Recurse

# Framework-specific routing
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "RouteConfig|MapRoute|UseRouting" -Recurse

# Alternative route detection
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[Route\(|app\.UseRouting|app\.UseEndpoints|RouteConfig" -Recurse
```

### Phase 2C: Framework-Aware Discovery (ENHANCED)

#### ASP.NET Core Routing
```powershell
# Startup.cs and Program.cs analysis
Select-String -Path "repositories\{repo_name}\Startup.cs|repositories\{repo_name}\Program.cs" -Pattern "UseEndpoints|MapControllers|MapRazorPages|UseRouting"

# Minimal API endpoints in Program.cs
Select-String -Path "repositories\{repo_name}\Program.cs" -Pattern "app\.Map(Get|Post|Put|Delete|Patch)"
```

#### MVC Convention-Based Routes
```powershell
# RouteConfig.cs analysis
Select-String -Path "repositories\{repo_name}\App_Start\RouteConfig.cs" -Pattern "routes\.MapRoute"

# Controller action detection
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "public.*ActionResult|public.*IActionResult" -Recurse
```

#### WCF and Legacy Services
```powershell
# WCF Services
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[ServiceContract\]|\[ServiceBehavior\]" -Recurse
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.svc"

# ASMX Web Services
Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.asmx"

# Alternative service detection
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[ServiceContract\]" -Recurse
```

### Phase 3: Validation and Gap Detection (NEW)

#### Cross-Reference Validation
```powershell
# Validate virtual endpoints have implementations
ForEach ($virtualEndpoint in $virtualEndpoints) {
    $physicalPath = $virtualEndpoint.PhysicalLocation
    if (-not (Test-Path $physicalPath)) {
        Write-Warning "Virtual endpoint $($virtualEndpoint.VirtualURL) references missing file: $physicalPath"
    }
}

# Check for orphaned configuration entries
Select-String -Path "repositories\{repo_name}\web.config" -Pattern "virtualDirectory" | ForEach-Object {
    # Validate referenced paths exist
}
```

#### Gap Detection and Quality Assurance
```powershell
# Common endpoint patterns that should exist
$commonPatterns = @(
    "/api/health","/api/status","/favicon.ico","/robots.txt",
    "/sitemap.xml","/web.config","/Global.asax"
)

# Check for standard framework endpoints
$frameworkEndpoints = @(
    "UseRouting","UseEndpoints","MapControllers","MapRazorPages"
)

# Detect potentially missed endpoints
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "public.*ActionResult|public.*IActionResult" -Recurse |
    Where-Object { $_.Line -notmatch "Test|Mock|Sample" }
```

#### Confidence Scoring
```powershell
# Calculate discovery confidence based on:
# 1. Physical endpoints found vs project complexity
# 2. Configuration files analyzed
# 3. Virtual endpoints detected
# 4. Known patterns verified

$physicalEndpoints = @($discoveredEndpoints | Where-Object { $_.DiscoveryMethod -eq "File_Scan" })
$virtualEndpoints = @($discoveredEndpoints | Where-Object { $_.DiscoveryMethod -eq "Config_Analysis" })
$totalComplexity = (Get-ChildItem "repositories\{repo_name}" -Recurse -Filter "*.cs").Count

$confidenceScore = [Math]::Min(100, (($physicalEndpoints.Count + $virtualEndpoints.Count * 2) / $totalComplexity * 100))
```

### Phase 4: Enhanced Endpoint Analysis and Classification

#### Multi-Source Information Extraction
For each discovered endpoint, extract:
1. **Virtual URL**: Publicly accessible URL path
2. **Physical Location**: Actual implementation file/method
3. **Discovery Method**: File_Scan, Config_Analysis, Framework_Detection
4. **Configuration Source**: web.config, Global.asax, RouteConfig, etc.
5. **Route Pattern**: How virtual URL maps to physical implementation
6. **Endpoint Status**: Active, Deprecated, Configured_But_Missing
7. **Dependencies**: Required modules, handlers, or framework components

#### Enhanced Classification Logic
```powershell
# Multi-layer endpoint classification
function Classify-Endpoint {
    param($File, $Line, $Pattern, $ConfigSource)

    $classification = @{
        Type = "Unknown"
        Method = "GET"
        VirtualURL = ""
        PhysicalLocation = $File
        DiscoveryMethod = "File_Scan"
        Dependencies = @()
    }

    # REST API Detection
    if ($Pattern -match "HttpGet|HttpPost|HttpPut|HttpDelete") {
        $classification.Type = "REST API"
        $classification.Method = ($Pattern -split "\[")[1] -replace "Http|Attribute|\]", ""
    }

    # Virtual Route Detection
    if ($ConfigSource -and ($ConfigSource -match "web.config|Global.asax")) {
        $classification.DiscoveryMethod = "Config_Analysis"
        $classification.Dependencies += "URL_Rewriting"
    }

    return $classification
}
```

### Phase 5: Enhanced CSV Generation

#### Extended CSV Schema
```csv
Code,Endpoint_Type,HTTP_Method,Endpoint_Path,Virtual_URL,Physical_Location,Discovery_Method,Configuration_Source,File_Path,Line_Number,Method_Name,Parameters,Authentication,Access_Level,Business_Domain,Framework_Version,Route_Pattern,Endpoint_Status,Dependencies,Notes
```

#### New Column Definitions (Enhanced Schema)
- **Virtual_URL**: Publicly accessible URL (what users hit)
- **Physical_Location**: Actual implementation file/method
- **Discovery_Method**: File_Scan, Config_Analysis, Framework_Detection
- **Configuration_Source**: web.config, Global.asax, RouteConfig, etc.
- **Route_Pattern**: How virtual URL maps to implementation
- **Endpoint_Status**: Active, Deprecated, Configured_But_Missing
- **Dependencies**: Required components (IIS_Rewrite, WCF_Runtime, etc.)

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
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "protected void (Page_Load|Button.*_Click|.*_Click)" -Recurse

# Server controls and data binding
Select-String -Path "repositories\{repo_name}\*.aspx" -Pattern "asp:.*runat=""server""|<%.*%>|DataBind\(\)" -Recurse

# ViewState and postback patterns
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "__doPostBack|ViewState|Page\.IsPostBack" -Recurse
```

### Legacy ASP.NET Patterns
```powershell
# Web methods in pages
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "\[WebMethod\].*public static" -Recurse

# Global.asax handlers
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "Application_Start|Session_Start|Application_Error" -Recurse

# HTTP Modules and Handlers
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "IHttpModule|IHttpHandler|ProcessRequest" -Recurse
```

### Modern .NET Patterns
```powershell
# Minimal API patterns
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "app\.(Map|Use|Run)" -Recurse

# SignalR Hubs
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "class.*Hub|IHubContext" -Recurse

# OData Controllers
Select-String -Path "repositories\{repo_name}\*.cs" -Pattern "class.*ODataController" -Recurse
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