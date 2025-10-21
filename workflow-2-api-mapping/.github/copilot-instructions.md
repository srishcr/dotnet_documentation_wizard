# Workflow 2: API-to-Repository Mapping

## Purpose
This workflow maps a list of known APIs to specific repositories using intelligent matching algorithms with confidence scoring. It helps align business API inventories with discovered repositories.

## Trigger Patterns
When a user says any of these, execute this workflow:
- "Map known APIs to repositories"
- "Run API mapping workflow"
- "Execute Workflow 2"
- "Map APIs to repositories using my API list"
- "API-to-repository mapping"
- "Match APIs to repositories"

## Input Requirements
1. **User-provided API list** in one of these formats:
   - CSV file with API names and descriptions
   - Excel file with API inventory
   - Markdown file with API list
   - Direct text input with API names

2. **Repository analysis results** from Workflow 1:
   - `reports/repositories_with_apis.csv` (can be provided as context if not available)

## Output
Creates `reports/api_to_repository_mapping.csv` with this structure:
```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
```

## Execution Strategy

### Phase 1: Input Processing
1. **Parse User API List**: Extract API names, descriptions, and any metadata
2. **Load Repository Analysis**: Process repository inventory from Workflow 1
3. **Normalize Data**: Standardize naming conventions and descriptions
4. **Validate Inputs**: Ensure both datasets are complete and usable

### Phase 2: Intelligent Matching Algorithm
Apply multi-factor scoring algorithm:

**Confidence Scoring Formula:**
```
Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
        (Technology Match × 0.25) + (Pattern Match × 0.2)
```

**Matching Criteria:**
1. **Name Similarity (30%)**:
   - Exact name matches
   - Partial name matches
   - Acronym matching
   - Similar terminology

2. **Domain Alignment (25%)**:
   - Business domain keywords
   - Functional area matching
   - Service purpose alignment
   - Context similarity

3. **Technology Match (25%)**:
   - Framework compatibility
   - Architecture patterns
   - Technology stack alignment
   - Platform consistency

4. **Pattern Match (20%)**:
   - File path patterns
   - Naming conventions
   - Project structure
   - Implementation patterns

### Phase 3: Confidence Assessment
Assign confidence levels based on scoring:
- **High Confidence (80-100%)**: Strong match across multiple criteria
- **Medium Confidence (50-79%)**: Good match with some uncertainty
- **Low Confidence (20-49%)**: Possible match requiring validation
- **No Match (<20%)**: No viable repository identified

### Phase 4: Report Generation
1. **Create Mapping CSV**: Generate structured report with all findings
2. **Add Recommendations**: Provide actionable next steps for each API
3. **Quality Assessment**: Validate mapping accuracy and completeness
4. **Summary Statistics**: Count total APIs, mapped APIs, confidence distribution

## Matching Logic Examples

### High Confidence Indicators
- API name "Catalog Service" → Repository with "catalog" in name/description
- Technology stack alignment (.NET Core API → .NET Core repository)
- Business domain match (e-commerce API → e-commerce repository)
- File path evidence (CatalogController.cs in repository)

### Medium Confidence Indicators
- Partial name match with different terminology
- Technology compatibility but not exact match
- Business domain similarity but different focus area
- Repository structure suggests capability but unclear implementation

### Low Confidence Indicators
- Generic API names with multiple possible repositories
- Technology mismatch but functional alignment
- Repository has capability but unclear if exposed as API
- Multiple repositories could potentially implement the API

## CSV Column Definitions
- **API Name**: Name of the API from user's list
- **API Description**: Description provided by user (if available)
- **Probable Repository**: Best matching repository from analysis
- **Confidence Level**: High/Medium/Low confidence rating
- **Matching Criteria**: Specific criteria that led to the match
- **Potential Location**: Specific file paths or project locations
- **Service/Application**: If mono-repo, which service/app contains the API
- **Technology Match**: How well technologies align
- **Notes**: Additional observations about the mapping
- **Recommendation**: Suggested next steps (High priority for Workflow 3, Manual review needed, etc.)

## Error Handling
- **Missing Repository Data**: Request Workflow 1 execution first
- **Invalid API List Format**: Provide format guidance and examples
- **No Matches Found**: Document unmatched APIs with suggestions
- **Ambiguous Matches**: Flag multiple potential matches for manual review

## Success Criteria
- All provided APIs have mapping entries
- Confidence levels properly assigned using consistent criteria
- Clear recommendations for each API with business context
- Integration with repository analysis results for enhanced accuracy

## Integration Notes
- **Requires Workflow 1**: Uses repository analysis as foundation
- **Feeds into Workflow 3**: Prioritizes repositories for detailed analysis
- **Standalone Capability**: Can work with provided repository data
- **Business Context**: Adds business intelligence to technical discovery

## Performance Considerations
- **Efficient String Matching**: Use optimized similarity algorithms
- **Batch Processing**: Handle large API lists efficiently
- **Memory Management**: Process large datasets without memory issues
- **Parallel Processing**: Match multiple APIs simultaneously when possible