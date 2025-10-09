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

### Phase 1: Repository Discovery
1. **Scan repositories folder**: List all subdirectories in `repositories/`
2. **Validate .NET projects**: Check for .NET project indicators (*.csproj, *.sln, Program.cs)
3. **Identify repository structure**: Determine if mono-repo or single application

### Phase 2: API Detection Analysis
1. **Controller Detection**: Search for files ending with `Controller.cs`
2. **Minimal API Detection**: Look for `MapGet`, `MapPost`, `MapPut`, `MapDelete` patterns
3. **API Attribute Detection**: Search for `[ApiController]`, `[Route]`, `[HttpGet]` attributes
4. **Swagger/OpenAPI Detection**: Look for Swagger configuration and documentation

### Phase 3: Repository Analysis
1. **Technology Stack Identification**: Analyze project files for frameworks and dependencies
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

### High-Level Analysis Only
- ✅ File structure scanning
- ✅ Pattern matching for API indicators
- ✅ Technology stack identification from project files
- ✅ README and documentation review for context
- ❌ Detailed code analysis
- ❌ Individual endpoint extraction
- ❌ Business logic examination
- ❌ Security pattern analysis

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