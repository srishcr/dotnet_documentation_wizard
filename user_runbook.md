# .NET Documentation Wizard - User Runbook

## Overview

The .NET Documentation Wizard provides three specialized workflows for comprehensive API analysis and documentation across multiple repositories. Each workflow serves a specific purpose in the API discovery and documentation pipeline.

## Available Workflows

### 🔍 Workflow 1: Find Repositories with APIs
**Purpose**: Scan all repositories to identify which ones contain API definitions
**Output**: `reports/repositories_with_apis.csv` - Complete inventory of repositories with API analysis

### 🗺️ Workflow 2: Map Known APIs to Repositories
**Purpose**: Map a list of known APIs to specific repositories and locations
**Output**: `reports/api_to_repository_mapping.csv` - API-to-repository mapping with confidence levels

### 📋 Workflow 3: API/Endpoint Inventory Creation
**Purpose**: Create comprehensive endpoint inventory for ANY repository (ALL endpoint types)
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoint_inventory.csv` - Complete endpoint catalog

### 📚 Workflow 4: Detailed Endpoint Documentation
**Purpose**: Document every endpoint from inventory CSV with validation and gap detection
**Output**: `{wizard_root}/analysis/{repo}/{sub_repo}/endpoints/*.md` + `missed_endpoints.csv` if gaps found

### 🔍 Workflow 5: Repository Analysis
**Purpose**: Business and technical analysis with granular options (individual or combined)
**Output**: Selected analysis files: overview, technical details, security analysis, business journey mapping

## Prerequisites

### Required Tools
- **Windows PowerShell** - For fast pattern detection and file operations (pre-installed on Windows)
- **File system access** - Read permissions for repositories and write permissions for analysis outputs

### Supported .NET Projects
- ✅ .NET 6+ with Minimal APIs
- ✅ ASP.NET Core MVC applications
- ✅ Traditional Web API projects
- ✅ Mixed architectures with multiple patterns

## How to Use Each Workflow

### 🔍 Workflow 1: Find Repositories with APIs

**When to Use**: When you need to understand which repositories in your `repositories/` folder contain APIs

#### Trigger Commands
```
Find all repositories with APIs in the repositories folder
```
```
Scan repositories for API definitions using Workflow 1
```
```
Run repository API discovery workflow
```

**What Happens**:
1. **Ultra-fast scan** of `repositories/` folder (file system only)
2. **Immediate .NET filtering** (skip non-.NET repos instantly)
3. **Minimal API detection** using pattern matching (no file reading)
4. **Efficient mono-repo analysis** using project structure
5. Creates `reports/repositories_with_apis.csv`

⚠️ **For Large Codebases (20-30M LOC)**: This workflow is optimized for efficiency with minimal file reading and maximum use of PowerShell/CMD commands for pattern detection on Windows.

🖥️ **Windows Users**: All commands use PowerShell (Get-ChildItem, Select-String, Test-Path) with CMD fallbacks for optimal Windows performance and compatibility.

**Expected Output**:
```
reports/
└── repositories_with_apis.csv    # Repository inventory with API analysis
```

---

### 🗺️ Workflow 2: Map Known APIs to Repositories

**When to Use**: When you have a list of known APIs and need to find where they're implemented

#### Prerequisites
- Provide a list of APIs in CSV, Excel, or Markdown format
- Workflow 1 must be completed (requires `repositories_with_apis.csv`)

#### Trigger Commands
```
Map known APIs to repositories using my API list: [path/to/api-list.csv]
```
```
Run API mapping workflow with the provided API inventory
```
```
Execute Workflow 2 to map APIs to repositories
```

**What Happens**:
1. Processes your API list
2. Matches APIs to repositories using intelligent algorithms
3. Assigns confidence levels to matches
4. Creates `reports/api_to_repository_mapping.csv`

**Expected Output**:
```
reports/
├── repositories_with_apis.csv        # From Workflow 1
└── api_to_repository_mapping.csv     # New mapping report
```

---

### 📋 Workflow 3: API/Endpoint Inventory Creation

**When to Use**: When you need comprehensive endpoint discovery for any repository

#### Prerequisites
- Target repository path
- Repository should contain .NET projects

#### Trigger Commands
```
Create endpoint inventory for repository: [repo-name]
```
```
Generate comprehensive endpoint inventory using Workflow 3
```
```
Execute endpoint discovery workflow for [repo-name]/[sub-project]
```
```
Extract all endpoints from [repository-name]
```

**What Happens**:
1. **Comprehensive endpoint discovery** (ALL types: REST APIs, WebForms, WCF, ASMX, etc.)
2. **Advanced pattern detection** including legacy ASP.NET WebForms
3. **Accurate classification** of endpoint types
4. **Precise location tracking** with file paths and line numbers
5. Creates `endpoint_inventory.csv`

**Expected Output**:
```
{wizard_root}/analysis/{repo_name}/{sub_repo}/
└── endpoint_inventory.csv    # Complete endpoint catalog
```

---

### 📚 Workflow 4: Detailed Endpoint Documentation

**When to Use**: When you have endpoint inventory and need comprehensive documentation

#### Prerequisites
- `endpoint_inventory.csv` from Workflow 3
- Access to source repository

#### Trigger Commands
```
Document all endpoints from inventory for [repo-name]
```
```
Execute endpoint documentation workflow 4 for [repo-name]/[sub-project]
```
```
Generate comprehensive endpoint docs using Workflow 4
```
```
Create detailed documentation for all endpoints in CSV
```

**What Happens**:
1. **Processes endpoint inventory CSV** from Workflow 3
2. **Documents ALL endpoint types** (REST, WebForms, WCF, etc.)
3. **Validates 100% coverage** and finds gaps
4. **Creates missed_endpoints.csv** if gaps discovered during validation
5. Generates individual documentation files

**Expected Output**:
```
{wizard_root}/analysis/{repo_name}/{sub_repo}/
├── endpoints/                      # Individual endpoint docs
│   ├── {repo}-endpoint-00001.md
│   ├── {repo}-endpoint-00002.md
│   └── ...
└── missed_endpoints.csv           # Gaps found during validation (if any)
```

---

### 🔍 Workflow 5: Repository Analysis

**When to Use**: When you need business/technical analysis with granular control

#### Prerequisites (Optional)
- Repository path for analysis
- Can be enhanced with endpoint inventory

#### Granular Trigger Commands
```
Run overview only analysis for [repo-name]
```
```
Execute technical details only for [repo-name]/[sub-project]
```
```
Generate sensitive data analysis only for [repo-name]
```
```
Create business journey analysis only for [repo-name]
```
```
Perform all analysis for [repo-name]
```

**What Happens**:
Based on your command, creates one or more of:
1. **Business overview** (01_overview.md)
2. **Technical architecture** (02_technical_details.md)
3. **Security/sensitive data analysis** (03_sensitive_data_analysis.md)
4. **Business journey mapping** (04_business_critical_journeys.md)

**Expected Output**:
```
{wizard_root}/analysis/{repo_name}/{sub_repo}/
├── 01_overview.md                      # If "overview only" or "all analysis"
├── 02_technical_details.md             # If "technical only" or "all analysis"
├── 03_sensitive_data_analysis.md       # If "sensitive data only" or "all analysis"
├── 04_business_critical_journeys.md    # If "business journey only" or "all analysis"
└── analysis_execution_summary.md       # Summary of completed analyses
```

## Common Workflow Patterns

### Complete Analysis Pattern (Recommended)
For comprehensive endpoint analysis and documentation:
1. **Workflow 1** → Discover all repositories with APIs
2. **Workflow 3** → Create endpoint inventory for priority repositories
3. **Workflow 4** → Document all endpoints from inventory
4. **Workflow 5** → Generate business and technical analysis

### Targeted Documentation Pattern
For specific repository endpoint documentation:
1. **Workflow 3** → Create endpoint inventory for target repository
2. **Workflow 4** → Document all endpoints with validation
3. **Workflow 5** → Add business analysis (optional)

### API Mapping Pattern
For mapping known APIs to repositories:
1. **Workflow 1** → Discover repositories with APIs
2. **Workflow 2** → Map known API list to repositories
3. **Workflow 3** → Create inventory for mapped repositories

### Granular Analysis Pattern
For specific analysis needs:
- **Workflow 5** → Run only needed analysis ("overview only", "technical only", etc.)

## Centralized Analysis Structure

All workflows now create analysis files in a centralized structure:

```
dotnet_documentation_wizard/
├── analysis/                           # Centralized analysis folder
│   ├── eShopOnWeb-main/               # Repository-specific analysis
│   │   ├── PublicApi/                 # Sub-project analysis
│   │   │   ├── endpoint_inventory.csv
│   │   │   ├── endpoints/
│   │   │   ├── 01_overview.md
│   │   │   └── ...
│   │   ├── Web/                       # Another sub-project
│   │   └── BlazorAdmin/
│   └── AnotherRepository/
│       ├── endpoint_inventory.csv
│       └── endpoints/
├── reports/                           # Workflow 1 & 2 outputs
└── repositories/                      # Source repositories
```

This structure allows:
- **Multiple repository analysis** without conflicts
- **Mono-repo sub-project separation**
- **Easy comparison** across repositories
- **Organized documentation** management

## Example Trigger Scenarios

### Scenario 1: New Enterprise Environment
```
Find all repositories with APIs in the repositories folder
```
*Follow up after Workflow 1 completes:*
```
Map known APIs to repositories using my API list: ./known_apis.csv
```

### Scenario 2: Legacy System Documentation
```
Generate comprehensive documentation for this repository using Workflow 3
```

### Scenario 3: API Compliance Audit
```
Run repository API discovery workflow
```
*Then for each high-priority repository:*
```
Execute Workflow 3 detailed analysis on [repository-name]
```

## Expected Output Examples

### Workflow 1: repositories_with_apis.csv
```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
eShopOnWeb-main,Yes,Mono Repo,E-commerce web application,src/PublicApi/Controllers/,...,.NET 8 ASP.NET Core,PublicApi;Web;BlazorAdmin,Clean Architecture
MyLibrary,No,Library,Utility library for data processing,N/A,.NET Standard 2.0,N/A,No API endpoints found
```

### Workflow 2: api_to_repository_mapping.csv
```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
Catalog API,Product search and filtering,eShopOnWeb-main/src/PublicApi,High,Name + Domain + Technology,src/PublicApi/Controllers/CatalogController.cs,PublicApi,Perfect - ASP.NET Core Web API,Multiple catalog endpoints found,High priority for Workflow 3
```

### Workflow 3: Complete Analysis Folder
```
target-repository/
├── analysis/
│   ├── 01_overview.md                    # Business context and domain analysis
│   ├── 02_technical_details.md           # Architecture and technical patterns
│   ├── 03_api_inventory.csv              # Complete API catalog
│   ├── 04_sensitive_data_apis.md         # Sensitive data handling analysis
│   ├── 05_business_critical_journeys.md  # Business workflow analysis
│   ├── workflow_execution_summary.md     # Comprehensive execution report
│   └── apis/                             # Individual API documentation
│       ├── myapp-api-00001.md            # Detailed API specifications
│       ├── myapp-api-00002.md            # With OWASP security assessment
│       └── ...
```

## Troubleshooting

### Common Issues by Workflow

#### Workflow 1 Issues
**"No repositories found in repositories folder"**
- Ensure repositories are placed in the `repositories/` folder
- Check folder permissions and access rights
- Verify folder structure is correct

**"Repository scanning failed"**
- Some repositories may be corrupted or incomplete
- Check individual repository access permissions
- Review the CSV output for specific error details

#### Workflow 2 Issues
**"Workflow 1 output not found"**
- Ensure Workflow 1 has been completed successfully
- Check that `reports/repositories_with_apis.csv` exists
- Run Workflow 1 first before attempting Workflow 2

**"API list format not recognized"**
- Ensure your API list is in CSV, Excel, or Markdown format
- Check that required columns are present
- Verify file path is accessible

**"Low confidence matches"**
- Review repository summaries from Workflow 1
- Consider providing more detailed API descriptions
- Manual validation may be required for ambiguous matches

#### Workflow 3 Issues
**"PowerShell pattern detection failed"**
- Ensure Windows PowerShell is available (pre-installed on Windows)
- Verify file paths use Windows path separators (backslashes)
- Check that Select-String commands have proper syntax

**"No endpoints found"**
- Verify you're targeting a .NET project directory
- Check that the project contains API controllers or minimal API definitions
- Ensure the project builds successfully

**"Analysis folder creation failed"**
- Check write permissions in the repository directory
- Ensure sufficient disk space
- Verify the target repository path exists and is accessible

### Getting Help

If you encounter issues:

1. **Check Prerequisites** - Ensure all required tools are installed
2. **Verify Project Structure** - Confirm target repositories are valid .NET projects
3. **Review Workflow Dependencies** - Ensure previous workflows are completed when required
4. **Check Logs** - Review Copilot chat for specific error messages
5. **Manual Fallback** - Workflows can handle various fallback scenarios

## Workflow-Specific Customization

### Workflow 1 Customization
```
Find repositories with APIs in the repositories folder, focusing on microservices architecture
```
```
Scan repositories for API definitions and include security framework analysis
```

### Workflow 2 Customization
```
Map known APIs to repositories with emphasis on financial services APIs
```
```
Execute Workflow 2 with high-confidence matching only
```

### Workflow 3 Customization
```
Generate comprehensive documentation with focus on GDPR compliance analysis
```
```
Run detailed analysis with emphasis on security patterns and authentication
```

## Best Practices

### Workflow Selection Strategy
- **Start with Workflow 1** for new environments or comprehensive discovery
- **Use Workflow 2** when you have existing API inventories to map
- **Apply Workflow 3** for detailed documentation of priority repositories

### Sequential Execution
- Allow each workflow to complete before starting the next
- Review outputs between workflows to guide next steps
- Use results from earlier workflows to prioritize later analyses

### Data Management
- Version control the `reports/` folder for tracking changes over time
- Maintain backup copies of API lists and mapping results
- Consider archiving old analysis folders before re-running Workflow 3

## Advanced Usage Patterns

### Enterprise API Governance
1. **Discovery Phase**: Run Workflow 1 across all repositories
2. **Mapping Phase**: Use Workflow 2 to align with business API registry
3. **Documentation Phase**: Execute Workflow 3 on business-critical repositories
4. **Maintenance Phase**: Re-run workflows periodically for updates

### Security Audit Preparation
1. **Repository Inventory**: Use Workflow 1 to identify all API-containing repositories
2. **Critical API Identification**: Apply Workflow 2 to map high-risk APIs
3. **Detailed Security Analysis**: Run Workflow 3 with focus on OWASP assessment

### Migration Planning
1. **Current State Analysis**: Use all three workflows to document existing landscape
2. **Dependency Mapping**: Leverage business journey analysis from Workflow 3
3. **Priority Assessment**: Use confidence levels and security ratings for planning

## Support

For questions or issues with the documentation wizard:
1. Check this runbook for common solutions
2. Review the generated logs for specific error messages
3. Consult your development team for project-specific guidance

---

**Happy documenting! 📚✨**