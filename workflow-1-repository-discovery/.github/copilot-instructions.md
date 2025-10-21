# Workflow 1: Repository Discovery and API Identification

## Purpose
This workflow scans repositories to identify which ones contain .NET API definitions. It's optimized for enterprise-scale scanning across multiple repositories with efficient Windows PowerShell commands.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Find all repositories with APIs"
- "Scan repositories for API definitions"
- "Run repository API discovery"
- "Identify which repositories contain APIs"
- "Execute Workflow 1"
- "Repository discovery workflow"

## Input Requirements
- Access to `repositories/` folder (relative to project root)
- Read permissions for repository scanning

## Output
Creates `reports/repositories_with_apis.csv` with this structure:
```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
```

## Execution Strategy

### Phase 1: Ultra-Fast Repository Discovery
1. Quick repository scan (no deep traversal)
2. Instant .NET filtering using file existence checks
3. Structure classification (mono-repo vs single-app)

### Phase 2: Minimal API Detection
Use file system commands only - NO content reading except:
- Project files (.csproj, .sln)
- First 20 lines of README files only

**Windows PowerShell Commands (Primary):**
```powershell
# Repository listing
Get-ChildItem repositories\ -Directory | Select-Object -First 100

# .NET detection
Test-Path "repositories\REPO\*.sln"
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj" -Depth 2

# API pattern detection
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]|MapGet|app\.Map" -Recurse | Select-Object -First 5

# Controller counting
(Get-ChildItem "repositories\REPO" -Recurse -Filter "*Controller.cs").Count
```

### Phase 3: Technology Analysis
1. Project file scanning for framework detection
2. README skimming (first 20 lines only)
3. Mono-repo structure identification

## Efficiency Rules for Large Codebases (20-30M LOC)
- **Maximum 5 file reads per repository**
- **Use PowerShell/CMD for pattern detection**
- **Skip repositories without .csproj/.sln files immediately**
- **Never read controller file contents**
- **Batch operations using Get-ChildItem, Select-String, Test-Path**

## Success Criteria
- Complete repository inventory generated
- Accurate API detection across all repositories
- Valid CSV format with all required columns
- Performance optimized for large codebase analysis
- Technology stack properly identified

## Error Handling
- Handle permission-denied scenarios gracefully
- Skip corrupted or incomplete repositories
- Provide progress indicators for large scans
- Document repositories that cannot be analyzed

## CSV Column Definitions
- **Repository Path**: Relative path from repositories folder
- **Contains APIs**: Yes/No boolean indicator
- **Repository Type**: Single App, Mono Repo, Library
- **Summary**: High-level description of repository purpose
- **Potential API Files**: Comma-separated list of API files found
- **Technology Stack**: Key technologies identified
- **Mono Repo Structure**: If mono-repo, list individual applications
- **Notes**: Additional observations or recommendations

## Integration Notes
- This workflow is standalone - no dependencies on other workflows
- Output can be used as input for Workflow 2 (API Mapping)
- Results help prioritize repositories for detailed analysis in Workflow 3

## Performance Optimizations
- Early termination for non-.NET repositories
- Parallel processing for multiple repositories
- Memory-efficient file scanning patterns
- Windows-optimized commands for best performance