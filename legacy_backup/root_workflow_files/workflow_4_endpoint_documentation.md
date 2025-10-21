# Workflow 4: Detailed Endpoint Documentation

## Overview

This workflow creates comprehensive documentation for ALL endpoints listed in the `endpoint_inventory.csv` file. It works with any endpoint type (REST APIs, WebForms, WCF Services, etc.) and ensures 100% documentation coverage with validation and gap detection.

## Purpose

- Document every endpoint from the endpoint inventory CSV
- Support ALL endpoint types (REST API, WebForm, WCF, ASMX, etc.)
- Validate 100% documentation coverage
- Generate `missed_endpoints.csv` for any gaps discovered during validation

## Input Requirements

### Required Input
- `endpoint_inventory.csv` from Workflow 3
- Target repository path for code analysis

### Output Structure
```
{wizard_root}/analysis/{repo_name}/{sub_repo}/
├── endpoint_inventory.csv          # Input file
├── endpoints/                      # Individual endpoint docs
│   ├── {repo}-endpoint-00001.md
│   ├── {repo}-endpoint-00002.md
│   └── ... (one file per endpoint)
└── missed_endpoints.csv            # Gaps found during validation
```

## Execution Phases

### Phase 1: Input Processing and Validation
1. **CSV Loading**: Read and parse `endpoint_inventory.csv`
2. **Repository Access**: Validate access to source repository
3. **Output Setup**: Create endpoints documentation folder
4. **Endpoint Classification**: Group endpoints by type for efficient processing

**Windows Commands:**
```powershell
# CSV processing
$endpoints = Import-Csv "analysis\{repo}\{sub_repo}\endpoint_inventory.csv"
$totalEndpoints = $endpoints.Count

# Output folder setup
New-Item -Path "analysis\{repo}\{sub_repo}\endpoints" -ItemType Directory -Force

# Endpoint type grouping
$restApis = $endpoints | Where-Object { $_.Endpoint_Type -eq "REST API" }
$webforms = $endpoints | Where-Object { $_.Endpoint_Type -eq "WebForm" }
$wcfServices = $endpoints | Where-Object { $_.Endpoint_Type -eq "WCF Service" }
```

### Phase 2: Enhanced Multi-Type Endpoint Documentation

#### 2.1 REST API Documentation
**Template**: `templates/rest_api_endpoint_template.md`

**Analysis Focus**:
- Controller and action method analysis
- Request/response model examination
- Authentication and authorization patterns
- Route parameter analysis
- Status code and error handling

```powershell
# Controller method analysis
$controllerPath = "repositories\{repo}\{endpoint.File_Path}"
Select-String -Path $controllerPath -Pattern "public.*{endpoint.Method_Name}" -Context 5,10
```

#### 2.2 Virtual/Configuration-Based Endpoints (NEW)
**Template**: `templates/virtual_endpoint_template.md`

**Analysis Focus**:
- Configuration source analysis (web.config, Global.asax)
- Virtual-to-physical URL mapping
- Route pattern documentation
- Configuration dependency analysis
- Implementation code examination

```powershell
# Virtual endpoint analysis
if ($endpoint.Discovery_Method -eq "Config_Analysis") {
    $configPath = "repositories\{repo}\{endpoint.Configuration_Source}"
    $virtualURL = $endpoint.Virtual_URL
    $physicalLocation = $endpoint.Physical_Location

    # Extract configuration details
    Select-String -Path $configPath -Pattern $endpoint.Route_Pattern -Context 3,3

    # Analyze physical implementation
    if (Test-Path "repositories\{repo}\{endpoint.Physical_Location}") {
        Select-String -Path "repositories\{repo}\{endpoint.Physical_Location}" -Pattern $endpoint.Method_Name -Context 5,10
    }
}
```

#### 2.3 WebForm Documentation
**Template**: `templates/webform_endpoint_template.md`

**Analysis Focus**:
- Page lifecycle and event handlers
- Server control analysis
- ViewState and postback behavior
- Data binding and validation
- Code-behind method examination

```powershell
# WebForm analysis
$aspxPath = "repositories\{repo}\{endpoint.File_Path}"
$codeBackend = $aspxPath -replace "\.aspx$", ".aspx.cs"

# Extract page methods and controls
Select-String -Path $codeBackend -Pattern "protected void.*\(" -AllMatches
Select-String -Path $aspxPath -Pattern "asp:.*runat=\"server\"" -AllMatches
```

#### 2.3 WCF Service Documentation
**Template**: `templates/wcf_service_endpoint_template.md`

**Analysis Focus**:
- Service contract definition
- Operation contract analysis
- Binding and endpoint configuration
- Data contract examination
- Service behavior attributes

```powershell
# WCF service analysis
Select-String -Path $servicePath -Pattern "\[OperationContract\]" -Context 2,5
Select-String -Path $servicePath -Pattern "\[DataContract\]|\[DataMember\]" -AllMatches
```

#### 2.4 ASMX Web Service Documentation
**Template**: `templates/asmx_service_endpoint_template.md`

**Analysis Focus**:
- WebMethod attributes and parameters
- SOAP message structure
- XML serialization patterns
- Service description and WSDL

#### 2.5 Legacy ASP.NET Handler Documentation
**Template**: `templates/handler_endpoint_template.md`

**Analysis Focus**:
- ProcessRequest implementation
- HTTP context handling
- Response generation logic
- Session and state management

### Phase 3: Universal Endpoint Analysis

#### Common Analysis Elements (All Endpoint Types)
1. **Security Analysis**: Authentication, authorization, input validation
2. **Parameter Analysis**: Input parameters, validation, data types
3. **Error Handling**: Exception handling, error responses
4. **Dependencies**: External services, database connections
5. **Performance Considerations**: Caching, async patterns

#### Code Citation and Context
```powershell
# Extract method implementation with context
$methodContext = Select-String -Path $filePath -Pattern $methodPattern -Context 3,10
$lineNumber = $methodContext.LineNumber
$surroundingCode = Get-Content $filePath | Select-Object -Skip ($lineNumber-4) -First 15
```

### Phase 4: Documentation Generation

#### Individual Endpoint Documentation
Each endpoint gets a comprehensive `.md` file with:

##### Universal Sections (All Endpoint Types)
- **Endpoint Overview**: Purpose and functionality
- **Technical Specification**: Method signature, parameters, return types
- **Code Location**: File path, line number, exact citation
- **Security Analysis**: Authentication, authorization, input validation
- **Dependencies**: External dependencies and integrations
- **Error Scenarios**: Error handling and exception cases

##### Type-Specific Sections
- **REST API**: HTTP methods, status codes, request/response examples
- **WebForm**: Page lifecycle, controls, postback behavior
- **WCF Service**: Service contracts, bindings, SOAP messages
- **ASMX**: SOAP operations, XML schema
- **Handler**: HTTP processing, context handling

#### Enhanced Documentation Template Usage
```powershell
# Enhanced template processing for different endpoint types
switch ($endpoint.Endpoint_Type) {
    "REST API" { $template = "templates/rest_api_endpoint_template.md" }
    "WebForm" { $template = "templates/webform_endpoint_template.md" }
    "WCF Service" { $template = "templates/wcf_service_endpoint_template.md" }
    "ASMX Service" { $template = "templates/asmx_service_endpoint_template.md" }
    "Handler" { $template = "templates/handler_endpoint_template.md" }
    "Virtual Route" { $template = "templates/virtual_endpoint_template.md" }
    "URL Rewrite" { $template = "templates/virtual_endpoint_template.md" }
    default { $template = "templates/generic_endpoint_template.md" }
}

# Additional validation for virtual endpoints
if ($endpoint.Discovery_Method -eq "Config_Analysis") {
    # Validate configuration source exists
    $configPath = "repositories\{repo}\$($endpoint.Configuration_Source)"
    if (-not (Test-Path $configPath)) {
        Write-Warning "Configuration source missing: $configPath"
        Add-Content "missed_endpoints.csv" "$($endpoint.Code),Missing_Config_Source,$configPath"
    }

    # Validate physical implementation exists
    $physicalPath = "repositories\{repo}\$($endpoint.Physical_Location)"
    if (-not (Test-Path $physicalPath)) {
        Write-Warning "Physical implementation missing: $physicalPath"
        Add-Content "missed_endpoints.csv" "$($endpoint.Code),Missing_Implementation,$physicalPath"
    }
}
```

### Phase 5: Enhanced Validation and Gap Detection

#### 5.1 Multi-Layer Validation
**Enhanced validation covers both physical and virtual endpoints**

```powershell
# Initialize validation tracking
$validationResults = @{
    TotalEndpoints = $endpoints.Count
    DocumentedEndpoints = 0
    FailedEndpoints = @()
    MissingImplementations = @()
    ConfigurationIssues = @()
}

# Validate each endpoint type
foreach ($endpoint in $endpoints) {
    $validationStatus = "Valid"

    # Physical file validation
    if ($endpoint.Discovery_Method -eq "File_Scan") {
        $filePath = "repositories\{repo}\$($endpoint.File_Path)"
        if (-not (Test-Path $filePath)) {
            $validationStatus = "Missing_File"
            $validationResults.FailedEndpoints += $endpoint
        }
    }

    # Virtual endpoint validation
    if ($endpoint.Discovery_Method -eq "Config_Analysis") {
        # Validate configuration source
        $configPath = "repositories\{repo}\$($endpoint.Configuration_Source)"
        if (-not (Test-Path $configPath)) {
            $validationStatus = "Missing_Config"
            $validationResults.ConfigurationIssues += $endpoint
        }

        # Validate physical implementation
        if ($endpoint.Physical_Location -and $endpoint.Physical_Location -ne "N/A") {
            $physicalPath = "repositories\{repo}\$($endpoint.Physical_Location)"
            if (-not (Test-Path $physicalPath)) {
                $validationStatus = "Missing_Implementation"
                $validationResults.MissingImplementations += $endpoint
            }
        }
    }

    # Track documentation status
    if ($validationStatus -eq "Valid") {
        $validationResults.DocumentedEndpoints++
    }
}
```

#### 5.2 Gap Detection and Reporting
**Identify and document all discovered gaps**

```powershell
# Create missed_endpoints.csv if gaps found
if ($validationResults.FailedEndpoints.Count -gt 0 -or
    $validationResults.MissingImplementations.Count -gt 0 -or
    $validationResults.ConfigurationIssues.Count -gt 0) {

    # CSV header
    "Endpoint_Code,Issue_Type,Missing_Resource,Virtual_URL,Expected_Location,Notes" |
        Out-File "analysis\{repo}\{sub_repo}\missed_endpoints.csv"

    # Document missing files
    foreach ($endpoint in $validationResults.FailedEndpoints) {
        "$($endpoint.Code),Missing_File,$($endpoint.File_Path),$($endpoint.Virtual_URL),$($endpoint.File_Path),Physical file not found" |
            Add-Content "analysis\{repo}\{sub_repo}\missed_endpoints.csv"
    }

    # Document missing implementations
    foreach ($endpoint in $validationResults.MissingImplementations) {
        "$($endpoint.Code),Missing_Implementation,$($endpoint.Physical_Location),$($endpoint.Virtual_URL),$($endpoint.Physical_Location),Virtual route target not found" |
            Add-Content "analysis\{repo}\{sub_repo}\missed_endpoints.csv"
    }

    # Document configuration issues
    foreach ($endpoint in $validationResults.ConfigurationIssues) {
        "$($endpoint.Code),Missing_Config,$($endpoint.Configuration_Source),$($endpoint.Virtual_URL),$($endpoint.Configuration_Source),Configuration source not found" |
            Add-Content "analysis\{repo}\{sub_repo}\missed_endpoints.csv"
    }
}
```

#### 5.3 Quality Assurance Metrics
**Calculate and report discovery and documentation quality**

```powershell
# Calculate quality metrics
$totalDiscovered = $endpoints.Count
$successfullyDocumented = $validationResults.DocumentedEndpoints
$documentationCoverage = [Math]::Round(($successfullyDocumented / $totalDiscovered) * 100, 2)

$physicalEndpoints = @($endpoints | Where-Object { $_.Discovery_Method -eq "File_Scan" }).Count
$virtualEndpoints = @($endpoints | Where-Object { $_.Discovery_Method -eq "Config_Analysis" }).Count
$frameworkEndpoints = @($endpoints | Where-Object { $_.Discovery_Method -eq "Framework_Detection" }).Count

# Quality report
Write-Host "=== Workflow 4 Quality Report ==="
Write-Host "Total Endpoints Discovered: $totalDiscovered"
Write-Host "  - Physical Endpoints: $physicalEndpoints"
Write-Host "  - Virtual Endpoints: $virtualEndpoints"
Write-Host "  - Framework Endpoints: $frameworkEndpoints"
Write-Host "Successfully Documented: $successfullyDocumented"
Write-Host "Documentation Coverage: $documentationCoverage%"
Write-Host "Failed Validations: $($validationResults.FailedEndpoints.Count)"
```

#### Documentation Coverage Validation
1. **Inventory Parsing**: Extract all endpoint codes from CSV
2. **File Verification**: Check existence of corresponding `.md` files
3. **Completeness Check**: Verify all required sections are populated
4. **Quality Validation**: Check for meaningful content vs placeholders

```powershell
# Validation process
$inventoryEndpoints = (Import-Csv $inventoryPath).Code
$documentedEndpoints = Get-ChildItem "analysis\{repo}\endpoints\" -Name "*.md" |
    ForEach-Object { ($_ -split '\.')[0] }

$missingDocs = $inventoryEndpoints | Where-Object { $_ -notin $documentedEndpoints }
```

#### Gap Detection and missed_endpoints.csv
When validation finds gaps:

1. **Dynamic Endpoint Discovery**: Re-scan source files for additional endpoints
2. **Pattern Recognition**: Look for common endpoint patterns not in original inventory
3. **Gap Analysis**: Determine why endpoints were missed
4. **Missed Endpoints CSV**: Create detailed list of discovered gaps

**missed_endpoints.csv Structure:**
```csv
Code,Endpoint_Type,Endpoint_Path,File_Path,Line_Number,Discovery_Method,Reason_Missed,Confidence_Level,Notes
```

#### Gap Discovery Patterns
```powershell
# Additional endpoint discovery during validation
$additionalEndpoints = @()

# Look for endpoints not in original inventory
$newControllers = Select-String -Path "repositories\{repo}\*.cs" -Pattern "class.*Controller" -Recurse |
    Where-Object { $_.Filename -notin $originalFiles }

$newWebMethods = Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[WebMethod\]" -Recurse |
    Where-Object { $_.Filename -notin $originalWebMethods }

# Add to missed endpoints list
foreach ($newEndpoint in $additionalEndpoints) {
    # Generate new endpoint entry for missed_endpoints.csv
}
```

### Phase 6: Final Validation and Reporting

#### Coverage Reporting
1. **Total Endpoints**: Count from inventory CSV
2. **Documented Endpoints**: Count of generated documentation files
3. **Missing Documentation**: Count of gaps found
4. **Additional Discovered**: Count of newly discovered endpoints
5. **Quality Score**: Assessment of documentation completeness

#### Validation Summary
```powershell
# Generate validation report
$summary = @{
    "Total_Inventory_Endpoints" = $inventoryEndpoints.Count
    "Documented_Endpoints" = $documentedEndpoints.Count
    "Missing_Documentation" = $missingDocs.Count
    "Additional_Discovered" = $additionalEndpoints.Count
    "Coverage_Percentage" = [math]::Round(($documentedEndpoints.Count / $inventoryEndpoints.Count) * 100, 2)
}
```

## Error Handling

### Missing Source Files
- **File Access Issues**: Skip missing files with logging
- **Permission Problems**: Document access restrictions
- **Corrupted Files**: Handle encoding issues gracefully

### Incomplete Endpoint Data
- **Missing Parameters**: Flag endpoints with insufficient data
- **Unclear Implementation**: Mark for manual review
- **Complex Logic**: Document complexity limitations

### Template Processing Errors
- **Template Missing**: Use generic template as fallback
- **Variable Substitution**: Handle missing template variables
- **Formatting Issues**: Ensure valid Markdown output

## Performance Optimizations

### Batch Processing
```powershell
# Process endpoints in parallel for large inventories
$endpoints | ForEach-Object -Parallel {
    # Generate documentation for each endpoint
    $endpointDoc = Generate-EndpointDocumentation -Endpoint $_
    $docPath = "analysis\{repo}\endpoints\$($_.Code).md"
    $endpointDoc | Out-File -FilePath $docPath -Encoding UTF8
}
```

### Memory Management
- **Streaming Processing**: Process large CSV files in chunks
- **File Handles**: Properly dispose of file resources
- **Cache Management**: Clear caches between endpoint types

## Success Criteria

A successful execution should:
1. **Complete Coverage**: All inventory endpoints have documentation files
2. **Quality Documentation**: All templates properly populated with meaningful content
3. **Gap Detection**: Any missed endpoints identified and documented in missed_endpoints.csv
4. **Validation Success**: 100% coverage achieved or gaps properly documented
5. **Cross-Type Support**: All endpoint types handled appropriately

## Integration Points

### Input Dependencies
- **Workflow 3**: Requires `endpoint_inventory.csv`
- **Repository Access**: Source code access for analysis

### Output Usage
- **Quality Assurance**: Provides comprehensive endpoint documentation
- **Gap Analysis**: Identifies endpoints requiring additional discovery
- **Coverage Metrics**: Enables documentation completeness tracking

## Trigger Commands

```
"Document all endpoints from inventory for [repo-name]"
"Execute endpoint documentation workflow 4 for [repo-name]/[sub-project]"
"Generate comprehensive endpoint docs using Workflow 4"
"Create detailed documentation for all endpoints in CSV"
```

## Template Dependencies

### Required Templates
- `templates/rest_api_endpoint_template.md`
- `templates/webform_endpoint_template.md`
- `templates/wcf_service_endpoint_template.md`
- `templates/asmx_service_endpoint_template.md`
- `templates/handler_endpoint_template.md`
- `templates/generic_endpoint_template.md`

This workflow ensures comprehensive documentation of ALL endpoint types while maintaining quality and coverage validation.