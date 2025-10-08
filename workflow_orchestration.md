# .NET Documentation Wizard - Workflow Orchestration

## Workflow Overview

This is the main coordination script for the .NET Documentation Wizard. It guides the entire documentation generation process from endpoint extraction through final document creation.

## Execution Phases

### Phase 1: Preparation and Validation
1. **Repository Path Validation**
2. **Endpoint Extraction**
3. **Analysis Folder Setup**

### Phase 2: Documentation Generation
4. **Business Overview Creation** (`01_overview.md`)
5. **Technical Details Creation** (`02_technical_details.md`)
6. **API Inventory Creation** (`03_api_inventory.csv`)
7. **Individual API Documentation** (`apis/*.md`)

### Phase 3: Security and Business Analysis
8. **Sensitive Data API Analysis** (`04_sensitive_data_apis.md`)
9. **Business Critical Journey Analysis** (`05_business_critical_journeys.md`)

### Phase 4: Validation and Finalization
10. **API Documentation Validation**
11. **Cross-Reference Validation**
12. **Workflow Execution Summary**

## Detailed Workflow Instructions

### Phase 1: Preparation and Validation

#### Step 1: Repository Path Validation

**Objective**: Ensure we're working with a valid .NET repository

**Actions**:
1. Confirm the repository path exists and is accessible
2. Verify .NET project structure (look for `.csproj`, `.sln` files)
3. Check for typical .NET folder structure (`src/`, `Controllers/`, etc.)

**Validation Checks**:
```bash
# Check for .NET project indicators
find $REPO_PATH -name "*.csproj" -o -name "*.sln"
find $REPO_PATH -type d -name "Controllers" -o -name "Endpoints"
```

**Error Handling**:
- If no .NET project files found, ask user to confirm path
- If path doesn't exist, request correct repository path
- Provide guidance on supported .NET project types

#### Step 2: Endpoint Extraction

**Objective**: Extract all API endpoints using the static analyzer

**Actions**:
1. Navigate to the endpoint extractor directory
2. Execute the extraction script with the repository path
3. Parse and validate the output

**Execution**:
```bash
cd static_dotnet_endpoint_extractor
./extract_dotnet_api_endpoints.sh "$REPOSITORY_PATH"
```

**Expected Output**: `{project-name}_rigrep_endpoints.txt`

**Validation**:
- Verify extraction file was created
- Check that endpoints were found (not zero total)
- Parse the structured output for downstream use

**Fallback Strategy**:
If endpoint extractor fails:
1. Perform manual file scanning using `grep_search` and `file_search`
2. Look for common .NET API patterns
3. Continue with reduced efficiency but full functionality

#### Step 3: Analysis Folder Setup

**Objective**: Create the documentation structure

**Actions**:
1. Create `analysis/` folder in the repository root
2. Create `analysis/apis/` subfolder for individual API docs
3. Set up any required supporting directories

**Folder Structure**:
```
repository/
├── analysis/
│   ├── 01_overview.md
│   ├── 02_technical_details.md
│   ├── 03_api_inventory.csv
│   ├── 04_sensitive_data_apis.md
│   ├── 05_business_critical_journeys.md
│   ├── workflow_execution_summary.md
│   └── apis/
│       ├── {project}-api-00001.md
│       ├── {project}-api-00002.md
│       └── ...
```

### Phase 2: Documentation Generation

#### Step 4: Business Overview Creation

**Template**: `templates/01_overview_template.md`
**Output**: `analysis/01_overview.md`

**Analysis Focus**:
1. **Domain Discovery**:
   - Analyze namespace structure for business domains
   - Examine entity models and DTOs
   - Review controller organization
   - Identify bounded contexts

2. **Business Logic Analysis**:
   - Review service layer implementations
   - Analyze business rules and validations
   - Understand workflow patterns
   - Identify key business capabilities

3. **Stakeholder Identification**:
   - Analyze controller endpoints for user types
   - Review authorization attributes for roles
   - Examine API access patterns
   - Identify internal vs external usage

**Key Code Analysis Areas**:
- Entity models (`public class Order`, `public class Product`)
- Service interfaces and implementations
- Controller action methods and their purposes
- Business validation logic
- Domain-specific namespaces

**Mermaid Diagram Generation**:
- Create domain relationship diagrams
- Show business process flows
- Illustrate user journey maps

#### Step 5: Technical Details Creation

**Template**: `templates/02_technical_details_template.md`
**Output**: `analysis/02_technical_details.md`

**Analysis Focus**:
1. **Architecture Pattern Recognition**:
   - Identify Clean Architecture, MVC, or other patterns
   - Analyze project structure and dependencies
   - Review dependency injection configurations
   - Document layer separation

2. **Technology Stack Documentation**:
   - Parse `.csproj` files for package references
   - Identify .NET version and framework
   - Document major libraries and their versions
   - Review `Program.cs` or `Startup.cs` configurations

3. **Security Implementation Analysis**:
   - Review authentication configuration
   - Analyze authorization policies
   - Document security middleware
   - Identify data protection patterns

4. **Data Architecture Documentation**:
   - Analyze Entity Framework context
   - Review database models and relationships
   - Document data access patterns
   - Identify caching strategies

**Key Files to Analyze**:
- `Program.cs` or `Startup.cs` (configuration)
- `.csproj` files (dependencies)
- `DbContext` classes (data architecture)
- Service registration patterns
- Middleware pipeline configuration

#### Step 6: API Inventory Creation

**Template**: `templates/03_api_inventory_template.md`
**Output**: `analysis/03_api_inventory.csv`

**Process**:
1. **Parse Endpoint Extraction Output**:
   - Process each endpoint from the extraction report
   - Extract HTTP method, route, controller, and file location
   - Generate unique sequential codes

2. **Classify Each API**:
   - Determine access level (External/Internal/Public/Private)
   - Assign business domain based on namespace/controller
   - Analyze authentication requirements
   - Identify user roles and permissions

3. **Generate CSV Entries**:
   - Apply consistent codification scheme
   - Populate all required columns
   - Ensure data quality and completeness

**Classification Logic**:
```csharp
// External API indicators
[Route("api/[controller]")]
public class ProductsController : ControllerBase

// Internal API indicators
[Authorize(Roles = "Admin")]
public class ManageController : Controller

// Public API indicators
[AllowAnonymous]
app.MapGet("/api/catalog", GetCatalog);
```

#### Step 7: Individual API Documentation with Security Analysis

**Template**: `templates/individual_api_template.md`
**Output**: `analysis/apis/{project}-api-{code}.md`

**Enhanced Analysis Focus**:
1. **Sensitive Data Detection**:
   - Scan request/response models for sensitive field patterns
   - Identify PII, financial, authentication, and confidential data indicators
   - Document data classification without making business assumptions
   - Flag potential compliance considerations for business review

2. **Technical Security Patterns**:
   - Document authentication mechanisms found in code
   - Identify authorization patterns and access controls
   - Note encryption usage patterns where visible
   - Report on input validation approaches

3. **OWASP API Security Top 10 Assessment**:
   - Evaluate each API against the OWASP API Security Top 10 (2023) framework
   - Provide red/amber/green risk status for each security category
   - Document technical implementation context for identified risks
   - Include business impact analysis for potential security vulnerabilities
   - Generate actionable security recommendations

**Detection Patterns for Sensitive Data**:
- **PII Indicators**: Field names containing `email`, `phone`, `address`, `name`, `ssn`
- **Financial Indicators**: Fields with `card`, `payment`, `billing`, `price`, `amount`, `account`
- **Authentication Indicators**: `password`, `token`, `key`, `secret`, `credential`
- **Confidential Indicators**: `internal`, `admin`, `config`, `private`

### Phase 5: Security and Business Analysis

#### Step 8: Sensitive Data API Analysis
**Template**: `templates/04_sensitive_data_template.md`
**Output**: `analysis/04_sensitive_data_apis.md`

**Objective**: Create comprehensive inventory of APIs handling potentially sensitive data

**Analysis Focus**:
1. **Data Classification Inventory**:
   - Catalog APIs by data sensitivity patterns found in code
   - Group APIs by sensitive data types (PII, Financial, Auth, Confidential)
   - Document field-level analysis of request/response models
   - Present findings for business security review

2. **Technical Security Observations**:
   - Report authentication requirements found in code
   - Document authorization patterns observed
   - Note any encryption or security annotations
   - Identify public vs protected endpoint patterns

#### Step 9: Business Critical Journey Analysis
**Template**: `templates/05_business_critical_journeys_template.md`
**Output**: `analysis/05_business_critical_journeys.md`

**Objective**: Identify and map potential business-critical API workflows

**Analysis Focus**:
1. **API Workflow Mapping**:
   - Identify API call sequences from code analysis
   - Map controller dependencies and service interactions
   - Document user flow patterns observable in the codebase
   - Present potential business journey candidates for stakeholder review

2. **Usage Pattern Analysis**:
   - Identify high-frequency endpoint patterns
   - Document APIs with complex business logic
   - Note APIs handling core entity operations (users, orders, payments)
   - Flag APIs that appear to be integration points

### Phase 6: Validation and Finalization

#### Step 10: API Documentation Validation

**Objective**: Ensure all APIs from the inventory have corresponding documentation files

**Actions**:
1. **Parse API Inventory**:
   - Read the `03_api_inventory.csv` file
   - Extract all API codes (e.g., eshop-api-00001, eshop-api-00002, etc.)
   - Create a comprehensive list of expected documentation files

2. **Validate Existing Documentation**:
   - Scan the `analysis/apis/` directory for existing API documentation files
   - Compare existing files against the expected list from the inventory
   - Identify missing API documentation files

3. **Generate Missing Documentation**:
   - For each missing API documentation file:
     - Extract API details from the inventory (endpoint, method, controller, etc.)
     - Use the individual API template to create comprehensive documentation
     - Analyze the specific controller/endpoint implementation
     - Generate the missing `{api-code}.md` file in the `analysis/apis/` directory

4. **Validation Report**:
   - Create a validation summary showing:
     - Total APIs in inventory
     - Number of documentation files found
     - Number of missing files identified
     - Number of files created during validation
     - List of any files that couldn't be created (with reasons)

**Validation Process**:
```
1. Parse CSV inventory → Extract API codes
2. List existing API docs → Compare with expected
3. Identify gaps → Generate missing docs
4. Create validation report → Ensure 100% coverage
```

#### Step 11: Cross-Reference Validation

**Objective**: Ensure consistency across all documentation

**Validation Checks**:
1. **API Inventory Consistency**:
   - Verify all APIs in CSV have corresponding individual docs
   - Check that API codes are unique and sequential
   - Validate file naming conventions

2. **Cross-Reference Accuracy**:
   - Ensure business domains are consistent across documents
   - Verify technical details match API implementations
   - Check that stakeholder roles align with API access levels

3. **Documentation Quality**:
   - Validate markdown syntax
   - Check for broken internal links
   - Ensure all templates have been fully populated

#### Step 12: Documentation Website Generation

**Objective**: Create a navigable website from the generated documentation for easy access and browsing

**Actions**:
1. **Website Structure Setup**:
   - Create `analysis/docs/` directory for website files
   - Copy all markdown files from `analysis/` to `analysis/docs/`
   - Organize files in logical navigation structure

2. **MkDocs Configuration**:
   - Create `analysis/mkdocs.yml` configuration file:
     ```yaml
     site_name: "[Project] API Documentation"
     site_description: "Comprehensive API documentation and analysis"

     nav:
       - 'Overview': 'index.md'
       - 'Technical Details': '02_technical_details.md'
       - 'API Inventory': '03_api_inventory.md'
       - 'Sensitive Data APIs': '04_sensitive_data_apis.md'
       - 'Business Critical Journeys': '05_business_critical_journeys.md'
       - 'API Documentation':
           - 'apis/index.md'
           # Auto-generate API navigation from inventory
       - 'Execution Summary': 'workflow_execution_summary.md'

     theme:
       name: 'material'
       palette:
         primary: 'blue'
         accent: 'light-blue'
       features:
         - navigation.tabs
         - navigation.sections
         - toc.integrate

     markdown_extensions:
       - tables
       - fenced_code
       - toc:
           permalink: true
     ```

3. **Homepage Creation**:
   - Copy `01_overview.md` as `analysis/docs/index.md`
   - Ensure it serves as effective homepage with navigation links

4. **API Documentation Index**:
   - Create `analysis/docs/apis/index.md` with links to all API documentation
   - Parse `03_api_inventory.csv` to auto-generate API navigation
   - Group APIs by business domain for logical organization

5. **Website Generation**:
   - Install MkDocs if not available: `pip install mkdocs mkdocs-material`
   - Generate static website: `cd analysis && mkdocs build`
   - Create `analysis/site/` directory with generated website

6. **Alternative: Docsify Setup**:
   - If MkDocs unavailable, create Docsify configuration
   - Create `analysis/docs/index.html` with Docsify setup:
     ```html
     <!DOCTYPE html>
     <html>
     <head>
       <meta charset="UTF-8">
       <title>[Project] API Documentation</title>
       <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/vue.css">
     </head>
     <body>
       <div id="app"></div>
       <script>
         window.$docsify = {
           name: '[Project] API Documentation',
           repo: '',
           loadSidebar: true,
           subMaxLevel: 2,
           search: 'auto'
         }
       </script>
       <script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
       <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/search.min.js"></script>
     </body>
     </html>
     ```
   - Create `analysis/docs/_sidebar.md` with navigation structure

7. **Local Development Server**:
   - Provide instructions for running local development server
   - MkDocs: `cd analysis && mkdocs serve`
   - Docsify: `cd analysis/docs && python -m http.server 3000`

8. **Deployment Guidance**:
   - Include deployment instructions for common platforms:
     - GitHub Pages (via MkDocs gh-deploy)
     - Netlify (drag and drop site/ folder)
     - Azure Static Web Apps
     - Internal documentation servers

#### Step 13: Workflow Execution Summary

**Objective**: Create comprehensive summary of all generated assets and validation results

**Actions**:
1. **Generate Summary Document**:
   - Create `analysis/workflow_execution_summary.md`
   - Use the workflow execution summary template
   - Include comprehensive validation results and asset inventory

2. **Summary Content**:
   - **Documentation Assets Created**: Complete list with file paths and descriptions
   - **API Coverage Analysis**: Detailed breakdown of documented vs discovered APIs
   - **Validation Results**: Success/failure statistics with remediation actions
   - **Quality Metrics**: Documentation completeness and consistency scores
   - **Domain Analysis**: Business domain coverage and technical insights
   - **Maintenance Recommendations**: Next steps and upkeep guidance

3. **Final Validation Report**:
   - Confirm 100% API documentation coverage achieved
   - Verify all cross-references are valid
   - Ensure documentation assets are complete and accessible
   - Provide user with clear next steps

**Template Usage**: Use `templates/workflow_execution_summary_template.md` for consistent structure and comprehensive reporting.

## Error Handling Strategies

### Common Issues and Resolutions

#### Endpoint Extractor Failures
**Issue**: ripgrep not found or extraction fails
**Resolution**:
- Fall back to manual scanning with `grep_search`
- Use `file_search` to find controller files
- Continue with reduced efficiency

#### Large Codebase Handling
**Issue**: Context limits exceeded during analysis
**Resolution**:
- Process APIs in batches
- Focus on high-priority endpoints first
- Use targeted file reading instead of full codebase scanning

#### Missing Documentation Context
**Issue**: Unable to determine business context
**Resolution**:
- Focus on technical specifications
- Flag areas requiring manual review
- Provide templates for business stakeholders to complete

### Progress Tracking

Throughout the workflow:
1. **Use TODO Management**: Track progress through each phase
2. **Provide Status Updates**: Keep user informed of current activities
3. **Handle Interruptions**: Allow for user input and corrections
4. **Validate Incrementally**: Check quality at each step

## Quality Assurance

### Documentation Standards
- Ensure all markdown is valid and well-formatted
- Verify CSV structure and data integrity
- Check for completeness and consistency
- Validate cross-references and links

### Content Quality
- Verify technical accuracy through code analysis
- Ensure business context is meaningful and relevant
- Check that examples are realistic and helpful
- Validate that classifications are accurate

### Completeness Verification
- Confirm all discovered APIs are documented
- Ensure all template sections are populated
- Verify that supporting diagrams are generated
- Check that file naming conventions are followed

## Success Criteria

A successful workflow execution should result in:
1. **Complete Documentation Set**: All required files generated including security and business analysis
2. **Comprehensive API Coverage**: 100% of discovered APIs documented with validation confirmation
3. **Security Analysis**: Sensitive data patterns identified and catalogued for business review
4. **Business Journey Mapping**: Potential business-critical workflows identified and analyzed
5. **Consistent Quality**: Uniform formatting and structure across all documentation
6. **Actionable Insights**: Business and technical value clearly articulated with specific review recommendations
7. **Validation Transparency**: Complete workflow execution summary with coverage statistics
8. **Maintainable Assets**: Documentation that can be easily updated and maintained

## Workflow Extensibility

The workflow is designed to be:
- **Configurable**: Templates can be customized for organization needs
- **Scalable**: Handles projects from small APIs to large enterprise systems
- **Flexible**: Works with various .NET architectural patterns
- **Maintainable**: Easy to update as APIs evolve

## Usage Examples

### Triggering the Workflow

**Simple Trigger**:
```
Generate comprehensive documentation for this .NET codebase
```

**With Specific Path**:
```
Create documentation for the repository at /path/to/dotnet/project
```

**With Focus Areas**:
```
Generate documentation focusing on the API architecture and business domains
```

### Expected User Interaction

The workflow will:
1. Confirm repository path and project name
2. Request any specific focus areas or requirements
3. Provide progress updates during each phase
4. Present summary of generated documentation
5. Offer next steps and maintenance recommendations