# Workflow 1: Find Repositories with APIs

## Overview

This workflow scans all repositories in the `repositories/` folder to identify which ones contain API definitions. It creates a comprehensive report analyzing each repository's structure and potential API implementations.

## Purpose

- Identify repositories containing .NET API definitions
- Analyze repository structure and mono-repo compositions
- Create high-level summaries of repository purposes
- Generate actionable insights for subsequent workflows

## Output

Creates `reports/repositories_with_apis.csv` with the following structure:

```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
```

## Execution Steps

### Phase 1: Ultra-Fast Repository Discovery
1. **Quick Repository Scan**: List subdirectories (no deep traversal)
2. **Instant .NET Filter**: Skip non-.NET repos immediately using file existence
3. **Structure Classification**: Basic mono-repo vs single-app detection

**Efficiency Commands (Cross-Platform):**
```powershell
# Phase 1 - Ultra-fast repository listing (Windows)
Get-ChildItem repositories\ -Directory | Select-Object -First 100 | Select-Object Name

# Cross-platform alternative using ripgrep (if available)
rg --files repositories\ | head -100

# Instant .NET detection (per repository) - Windows
Test-Path "repositories\REPO\*.sln" -or (Get-ChildItem "repositories\REPO" -Recurse -Depth 2 -Filter "*.csproj" | Select-Object -First 1)

# Cross-platform using built-in tools
dir repositories\REPO\*.sln 2>nul || dir repositories\REPO\*.csproj /s /b | findstr /m ".*" | head -1
```

### Phase 2: Minimal API Detection (File System Only)
1. **Controller File Counting**: Count `*Controller.cs` files (no reading)
2. **API Project Detection**: Find API-related project names
3. **Pattern Existence Check**: Use grep for API patterns (count matches only)

**Efficiency Commands (Cross-Platform):**
```powershell
# Count controllers without reading content (Windows)
(Get-ChildItem "repositories\REPO" -Recurse -Filter "*Controller.cs").Count

# Check for API projects by naming (Windows)
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj" | Where-Object { $_.Name -match "api|web|service" -case insensitive }

# Quick pattern detection (Windows PowerShell)
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]|MapGet|app\.Map" -Recurse | Select-Object -First 5

# Cross-platform using ripgrep (recommended for large codebases)
rg "\[ApiController\]|MapGet|app\.Map" repositories\REPO --type cs | head -5

# Windows CMD fallback
dir repositories\REPO\*Controller.cs /s /b | find /c ":"
findstr /s /m "\[ApiController\]\|MapGet\|app\.Map" repositories\REPO\*.cs | head -5
```

### Phase 3: Minimal Technology Analysis
1. **Project File Scanning**: Count and categorize .csproj files only
2. **README Skimming**: First 10-20 lines only for business context
3. **Framework Detection**: Target framework from project files only

**Efficiency Commands (Cross-Platform):**
```powershell
# Fast project analysis (Windows)
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj" | Select-Object -First 1 | ForEach-Object { Select-String -Path $_.FullName -Pattern "<TargetFramework>" | Select-Object -First 1 }

# Quick README context (Windows - limit to 20 lines)
if (Test-Path "repositories\REPO\README.md") { Get-Content "repositories\REPO\README.md" | Select-Object -First 20 } else { "No README" }

# Solution structure (Windows - for mono-repo detection)
(Get-ChildItem "repositories\REPO" -Recurse -Filter "*.sln").Count

# Cross-platform using ripgrep
rg "<TargetFramework>" repositories\REPO --type xml | head -1

# Windows CMD alternatives
findstr /s "<TargetFramework>" repositories\REPO\*.csproj | head -1
more +1 repositories\REPO\README.md | head -20 2>nul || echo No README
dir repositories\REPO\*.sln /s /b | find /c ":"
```
2. **Repository Purpose Analysis**: Examine README files, project names, and folder structure
3. **Mono-repo Structure Mapping**: Identify individual services/applications within mono-repos
4. **API File Path Collection**: Document specific files containing API definitions

### Phase 4: Report Generation
1. **CSV Creation**: Generate structured report with all findings
2. **Summary Statistics**: Count total repositories, API-enabled repositories, mono-repos
3. **Validation**: Verify report completeness and accuracy

## Detection Patterns

### .NET Project Indicators
- `*.csproj` files
- `*.sln` solution files
- `Program.cs` or `Startup.cs` files
- `appsettings.json` configuration files

### API Implementation Patterns
- **MVC Controllers**: Files ending with `Controller.cs`
- **Minimal APIs**: Pattern matching for `app.Map*` methods
- **Web API Attributes**: `[ApiController]`, `[Route]`, `[Http*]` attributes
- **Swagger Integration**: References to Swashbuckle, OpenAPI, or swagger configurations

### Technology Stack Indicators
- **Framework**: .NET version from project files
- **Web Framework**: ASP.NET Core, Web API, MVC patterns
- **Authentication**: Identity, JWT, OAuth patterns
- **Database**: Entity Framework, Dapper, database connection strings
- **Architecture**: Clean Architecture, DDD, microservices patterns

## CSV Report Format

| Column | Description | Example Values |
|--------|-------------|----------------|
| Repository Path | Relative path from repositories folder | `eShopOnWeb-main` |
| Contains APIs | Boolean indicator | `Yes`, `No` |
| Repository Type | Type of repository structure | `Single App`, `Mono Repo`, `Library` |
| Summary | High-level description of repository purpose | `E-commerce web application with catalog and ordering` |
| Potential API Files | Comma-separated list of files with API definitions | `src/PublicApi/Controllers/CatalogController.cs, src/Web/Controllers/BasketController.cs` |
| Technology Stack | Key technologies identified | `.NET 8, ASP.NET Core, Entity Framework, Clean Architecture` |
| Mono Repo Structure | If mono-repo, list individual applications | `PublicApi, Web, BlazorAdmin` |
| Notes | Additional observations or recommendations | `Well-structured Clean Architecture, Multiple API projects` |

## Analysis Depth Guidelines

### Ultra-Efficient Analysis Strategy
**For 20-30M lines across 60-70 repositories - EFFICIENCY CRITICAL**

#### 🎯 **Smart Path Traversal (Use ONLY these patterns)**
```powershell
# Primary target directories (check these FIRST) - Windows paths
\src\                     # Main source code
\app\                     # Application root
\api\                     # API-specific folders
\controllers\             # Direct controller folders
\endpoints\               # Endpoint definitions
\web\                     # Web applications

# Windows PowerShell path checking
Test-Path "repositories\REPO\src"
Test-Path "repositories\REPO\app"
Test-Path "repositories\REPO\api"

# Focus search on these directories only
Get-ChildItem "repositories\REPO\src" -Recurse -Filter "*.csproj" 2>$null
Get-ChildItem "repositories\REPO\api" -Recurse -Filter "*Controller.cs" 2>$null
```

#### 🔍 **File Analysis Strategy (MINIMAL reads)**
1. **Repository Root Analysis** (2-3 files max):
   - `.sln` files → Count and identify projects
   - `README.md` → Quick business context (first 20 lines only)
   - `Directory.Build.props` → Technology stack

2. **Project Discovery** (Pattern matching only):
   - Use `find` commands for `*.csproj` files
   - **NO file content reading** - just count and paths
   - Identify projects by naming patterns: `*Api*`, `*Web*`, `*Controller*`

3. **API Detection** (File existence checks only):
   - Check for `*Controller.cs` files (count, don't read)
   - Look for `Program.cs` in API projects (presence, not content)
   - Scan for `[controller]` or `MapGet` patterns using grep (pattern match only)

#### ❌ **NEVER Do These (Token Wasters)**
- ❌ Read controller file contents
- ❌ Examine business logic or service layers
- ❌ Parse configuration files beyond project files
- ❌ Read documentation beyond first few lines of README
- ❌ Analyze test projects or test files
- ❌ Examine build scripts or CI/CD configurations
- ❌ Read any files in `bin/`, `obj/`, `node_modules/`, `.git/`

#### 🚀 **Efficiency Rules**
- **Max 5 file reads per repository** (only project files and README)
- **Use bash commands for counting and pattern detection**
- **Leverage file system structure over file contents**
- **Skip repositories without `.csproj` or `.sln` files immediately**
- **Batch operations using find/grep/ls commands**

### Mono-Repo Handling
For repositories identified as mono-repos:
1. **Individual Service Identification**: List each service/application within the repo
2. **API Distribution Analysis**: Identify which services contain APIs
3. **Service Purpose Classification**: Categorize each service (API, Web UI, Background Service, etc.)
4. **Separate CSV Entries**: Create individual rows for each service in a mono-repo

## Error Handling

### Missing Dependencies
- If repository lacks .NET project files, mark as "No" for Contains APIs
- Document non-.NET repositories for potential exclusion
- Handle corrupted or incomplete repository clones gracefully

### Large Repositories
- Use efficient file scanning patterns (avoid loading large files into memory)
- Implement timeout mechanisms for very large repositories
- Provide progress indicators for long-running scans

### Access Issues
- Handle permission-denied scenarios gracefully
- Document repositories that cannot be analyzed
- Provide alternative analysis suggestions

## Validation Requirements

### Report Accuracy
- Verify all repositories in folder are included
- Confirm API detection accuracy with sample validation
- Ensure CSV format is valid and complete

### Completeness Checks
- All repositories have entries in the report
- No missing data in critical columns
- Mono-repo services are properly broken down

## Success Criteria

A successful execution should:
1. **Complete Coverage**: All repositories in the folder are analyzed
2. **Accurate Detection**: API-containing repositories are correctly identified
3. **Structured Output**: CSV report follows specified format
4. **Actionable Insights**: Report provides sufficient detail for subsequent workflows
5. **Validation**: Report accuracy is verified and documented

## Usage Context

This workflow is the foundation for:
- API inventory planning
- Repository prioritization for detailed analysis
- Understanding the scope of API landscape
- Planning resource allocation for documentation efforts
- Identifying candidates for Workflow 3 (detailed analysis)

## Integration with Other Workflows

### Workflow 2 Integration
- Provides repository mapping foundation for API-to-repository matching
- Supplies technology stack context for API classification
- Offers mono-repo structure insights for precise API location

### Workflow 3 Integration
- Identifies candidates for detailed API documentation
- Provides initial technology stack and structure context
- Supplies file path hints for more efficient detailed analysis