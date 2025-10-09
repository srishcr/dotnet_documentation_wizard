# Workflow 2: Map Known APIs to Repositories

## Overview

This workflow takes a list of known APIs (provided by the user) and maps them to specific repositories and locations within those repositories using the output from Workflow 1. It creates intelligent matching between API names/descriptions and repository contents.

## Purpose

- Map external API lists to specific code repositories
- Identify probable locations of known APIs within repositories
- Create structured mapping for targeted analysis
- Provide foundation for focused API documentation efforts

## Input Requirements

### User-Provided API List
Accepts APIs in multiple formats:
- **CSV file**: with columns like API Name, Description, Endpoint Pattern, etc.
- **Excel file**: standard spreadsheet format
- **Markdown file**: structured list format

Expected input columns (flexible naming):
- API Name/Identifier
- Description (optional)
- Endpoint Pattern (optional, e.g., `/api/catalog/*`)
- Service/Domain (optional)
- Business Function (optional)

### Dependencies
- Requires `reports/repositories_with_apis.csv` from Workflow 1
- Uses repository analysis data for intelligent matching

## Output

Creates `reports/api_to_repository_mapping.csv` with the following structure:

```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
```

## Execution Steps

### Phase 1: Input Processing
1. **API List Parsing**: Read and standardize user-provided API list
2. **Repository Data Loading**: Load results from Workflow 1
3. **Data Validation**: Verify input completeness and format
4. **Preprocessing**: Normalize API names and descriptions for matching

### Phase 2: Matching Analysis
1. **Name-Based Matching**: Direct API name matches with repository/service names
2. **Domain Matching**: Match API domains with repository business domains
3. **Pattern Matching**: Match endpoint patterns with repository structure
4. **Technology Stack Matching**: Align API requirements with repository technologies

### Phase 3: Confidence Scoring
1. **Multi-Factor Scoring**: Combine multiple matching criteria
2. **Confidence Levels**: Assign High/Medium/Low confidence ratings
3. **Alternative Suggestions**: Identify secondary repository candidates
4. **Gap Identification**: Flag APIs with no probable matches

### Phase 4: Report Generation
1. **Structured Mapping**: Create comprehensive mapping report
2. **Summary Statistics**: Generate matching success rates and confidence distribution
3. **Recommendations**: Provide actionable next steps for each API
4. **Validation Notes**: Document matching logic and assumptions

## Matching Criteria

### Primary Matching Patterns

#### 1. Direct Name Matching
- **Repository Names**: Match API names with repository folder names
- **Service Names**: Match with identified services in mono-repos
- **Project Names**: Match with .csproj project names
- **Controller Names**: Match with identified controller file names

#### 2. Domain-Based Matching
- **Business Domains**: Match API business context with repository summaries
- **Functional Areas**: Align API functions with repository purposes
- **Entity Matching**: Match core entities (Product, Order, User) across API and repository descriptions

#### 3. Endpoint Pattern Matching
- **URL Patterns**: Match provided endpoint patterns with repository API structures
- **Route Conventions**: Align with identified routing patterns
- **Controller Patterns**: Match with controller organization

#### 4. Technology Stack Alignment
- **Framework Compatibility**: Ensure API requirements align with repository technologies
- **Authentication Patterns**: Match security requirements with repository implementations
- **Integration Points**: Align external dependencies and integrations

### Confidence Level Definitions

#### High Confidence (80-100%)
- Direct name match + domain alignment
- Endpoint pattern match + technology compatibility
- Multiple matching criteria convergence
- Clear repository purpose alignment

#### Medium Confidence (50-79%)
- Partial name match + some domain alignment
- Technology stack compatibility + business function match
- Single strong matching criterion
- Reasonable but not definitive alignment

#### Low Confidence (20-49%)
- Weak pattern matches
- Generic or ambiguous alignments
- Technology compatibility only
- Requires manual validation

#### No Match (0-19%)
- No meaningful alignment found
- Technology incompatibility
- No repository candidates identified
- May indicate missing repositories

## CSV Report Format

| Column | Description | Example Values |
|--------|-------------|----------------|
| API Name | Name from user-provided list | `Catalog Search API` |
| API Description | Description from input (if available) | `Product search and filtering functionality` |
| Probable Repository | Most likely repository match | `eShopOnWeb-main/src/PublicApi` |
| Confidence Level | Matching confidence | `High`, `Medium`, `Low`, `No Match` |
| Matching Criteria | Primary criteria used for match | `Name + Domain + Technology` |
| Potential Location | Specific files/paths where API might be implemented | `src/PublicApi/Controllers/CatalogController.cs` |
| Service/Application | For mono-repos, specific service identified | `PublicApi` |
| Technology Match | Technology alignment assessment | `Perfect - ASP.NET Core Web API` |
| Notes | Additional observations or concerns | `Multiple similar endpoints found` |
| Recommendation | Suggested next action | `High priority for Workflow 3 analysis` |

## Matching Algorithm

### Step 1: Preprocessing
```
For each API in user list:
1. Normalize name (remove special chars, lowercase)
2. Extract keywords from description
3. Identify potential domain/service indicators
4. Parse endpoint patterns (if provided)
```

### Step 2: Repository Scoring
```
For each API -> Repository combination:
1. Calculate name similarity score (0-100)
2. Assess domain alignment score (0-100)
3. Evaluate technology compatibility (0-100)
4. Check endpoint pattern matches (0-100)
5. Combine scores with weighted algorithm
```

### Step 3: Confidence Assignment
```
Final Score = (Name * 0.3) + (Domain * 0.25) + (Technology * 0.25) + (Pattern * 0.2)
High: Score >= 80
Medium: Score 50-79
Low: Score 20-49
No Match: Score < 20
```

## Advanced Matching Features

### Fuzzy Matching
- Handle variations in API naming
- Account for abbreviations and synonyms
- Match partial names and descriptions

### Multi-Repository Suggestions
- Provide up to 3 repository candidates per API
- Rank alternatives by confidence score
- Document reasoning for each suggestion

### Mono-Repo Handling
- Drill down to specific services within mono-repos
- Map APIs to individual applications
- Provide service-level location specificity

## Analysis Depth Guidelines

### Lightweight Analysis Approach
- ✅ Pattern matching and text analysis
- ✅ Repository metadata comparison
- ✅ Technology stack compatibility checking
- ✅ Structural pattern recognition
- ❌ Detailed code examination
- ❌ Endpoint implementation analysis
- ❌ Business logic validation
- ❌ Authentication/security deep-dive

### Efficiency Focus
- Use pre-computed repository analysis from Workflow 1
- Implement fast text matching algorithms
- Avoid loading large code files
- Focus on metadata and structure analysis

## Error Handling

### Missing Dependencies
- Graceful handling when Workflow 1 output is missing
- Clear error messages for invalid input formats
- Fallback to basic pattern matching when data is incomplete

### Input Validation
- Handle various API list formats (CSV, Excel, Markdown)
- Validate required columns and data quality
- Provide feedback on input format issues

### Ambiguous Matches
- Document cases where multiple repositories match equally
- Provide all reasonable alternatives with explanations
- Flag APIs requiring manual review

## Validation Requirements

### Mapping Accuracy
- Sample validation of high-confidence matches
- Cross-reference with repository contents where possible
- Document assumptions and limitations

### Report Completeness
- Ensure all input APIs have mapping entries
- Verify CSV format validity
- Confirm all confidence levels are assigned

## Success Criteria

A successful execution should:
1. **Complete Coverage**: All provided APIs have mapping entries
2. **Meaningful Matches**: High/Medium confidence matches show clear alignment
3. **Actionable Output**: Report provides clear next steps for each API
4. **Efficiency**: Analysis completes without detailed code examination
5. **Transparency**: Matching logic and confidence rationale are documented

## Usage Scenarios

### Enterprise API Inventory
- Map known business APIs to development repositories
- Identify gaps in repository coverage
- Plan consolidation or migration efforts

### Legacy System Analysis
- Connect documented APIs with actual implementations
- Validate API-to-service mapping assumptions
- Support modernization planning

### Compliance and Governance
- Map regulated APIs to specific codebases
- Ensure proper oversight and documentation
- Support audit and review processes

## Integration with Other Workflows

### Workflow 1 Integration
- Consumes repository analysis results
- Leverages technology stack and structure insights
- Uses mono-repo service mappings

### Workflow 3 Integration
- Provides prioritized list of repositories for detailed analysis
- Supplies specific location hints for efficient API extraction
- Offers confidence-based prioritization for analysis efforts

## Output Usage

The mapping report enables:
- **Targeted Analysis**: Focus Workflow 3 on high-confidence matches
- **Gap Analysis**: Identify APIs not found in any repository
- **Resource Planning**: Prioritize analysis efforts based on confidence levels
- **Validation Planning**: Prepare for manual verification of low-confidence matches