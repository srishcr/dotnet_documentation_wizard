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

### Phase 2: Multi-Type Endpoint Documentation

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

#### 2.2 WebForm Documentation
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

#### Documentation Template Usage
```powershell
# Template processing for different endpoint types
switch ($endpoint.Endpoint_Type) {
    "REST API" { $template = "templates/rest_api_endpoint_template.md" }
    "WebForm" { $template = "templates/webform_endpoint_template.md" }
    "WCF Service" { $template = "templates/wcf_service_endpoint_template.md" }
    "ASMX" { $template = "templates/asmx_service_endpoint_template.md" }
    default { $template = "templates/generic_endpoint_template.md" }
}
```

### Phase 5: Validation and Gap Detection

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
$newControllers = rg "class.*Controller" "repositories\{repo}" --type cs |
    Where-Object { $_ -notin $originalFiles }

$newWebMethods = rg "\[WebMethod\]" "repositories\{repo}" --type cs |
    Where-Object { $_ -notin $originalWebMethods }

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