# Workflow 1: Repository Discovery and API Identification

## Overview
A specialized workflow for enterprise-scale repository scanning to identify which repositories contain .NET API definitions. Optimized for large codebases with efficient Windows PowerShell commands.

## Purpose
- Identify repositories containing .NET API definitions
- Analyze repository structure and mono-repo compositions
- Create high-level summaries of repository purposes
- Generate actionable insights for subsequent workflows

## Quick Start

### Trigger Commands
```
Find all repositories with APIs in the repositories folder
```
```
Scan repositories for API definitions using Workflow 1
```
```
Run repository API discovery workflow
```

### Prerequisites
- Access to `repositories/` folder
- Read permissions for repository scanning
- Windows PowerShell (for optimal performance)

### Expected Output
```
reports/
└── repositories_with_apis.csv    # Repository inventory with API analysis
```

## Features

### Ultra-Fast Scanning
- **File system only** - minimal content reading
- **Windows PowerShell optimized** commands
- **Early termination** for non-.NET repositories
- **Parallel processing** capabilities

### Comprehensive Detection
- **MVC Controllers**: `*Controller.cs` files
- **Minimal APIs**: `app.Map*` patterns
- **Web API Attributes**: `[ApiController]`, `[Route]`
- **Project Structure**: `.csproj`, `.sln` files

### Enterprise Scale Support
- Handles **20-30M LOC** across **60-70 repositories**
- **Maximum 5 file reads** per repository
- **Batch operations** for efficiency
- **Progress indicators** for large scans

## Output Format

### CSV Structure
| Column | Description | Example |
|--------|-------------|---------|
| Repository Path | Relative path from repositories folder | `eShopOnWeb-main` |
| Contains APIs | Boolean indicator | `Yes`, `No` |
| Repository Type | Structure type | `Single App`, `Mono Repo`, `Library` |
| Summary | High-level description | `E-commerce web application` |
| Potential API Files | Comma-separated API files | `src/PublicApi/Controllers/CatalogController.cs` |
| Technology Stack | Key technologies | `.NET 8, ASP.NET Core, Clean Architecture` |
| Mono Repo Structure | Individual applications | `PublicApi, Web, BlazorAdmin` |
| Notes | Additional observations | `Well-structured Clean Architecture` |

### Example Output
```csv
Repository Path,Contains APIs,Repository Type,Summary,Potential API Files,Technology Stack,Mono Repo Structure,Notes
eShopOnWeb-main,Yes,Mono Repo,E-commerce web application,src/PublicApi/Controllers/,...,.NET 8 ASP.NET Core,PublicApi;Web;BlazorAdmin,Clean Architecture
MyLibrary,No,Library,Utility library,N/A,.NET Standard 2.0,N/A,No API endpoints found
```

## Performance Characteristics

### Optimized for Large Codebases
- **Pattern detection** over content analysis
- **Streaming processing** for large files
- **Memory management** with resource cleanup
- **Context preservation** through static analysis

### Windows Compatibility
All commands use PowerShell with CMD fallbacks:
```powershell
# Repository discovery
Get-ChildItem repositories\ -Directory

# API detection
Select-String -Path "repositories\REPO\*.cs" -Pattern "\[ApiController\]" -Recurse

# Framework detection
Get-ChildItem "repositories\REPO" -Recurse -Filter "*.csproj"
```

## Integration

### Standalone Operation
- **No dependencies** on other workflows
- **Self-contained** execution
- **Independent** analysis capabilities

### Output Usage
- **Input for Workflow 2**: API-to-repository mapping
- **Planning for Workflow 3**: Detailed endpoint analysis
- **Prioritization**: Identify high-value repositories

## Error Handling
- **Permission issues**: Graceful fallback with clear messages
- **Corrupted repositories**: Skip with logging
- **Large files**: Memory-safe processing
- **Progress tracking**: Status updates for long operations

## Success Criteria
✅ Complete repository inventory generated
✅ Accurate API detection across all repositories
✅ Valid CSV format with all required columns
✅ Performance optimized for enterprise scale
✅ Technology stack properly identified

## Support
- Check `docs/troubleshooting.md` for common issues
- Review PowerShell requirements for Windows optimization
- Consult execution logs for specific error details