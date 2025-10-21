# Workflow 2: API-to-Repository Mapping

## Overview
An intelligent workflow that maps known API lists to specific repositories using advanced matching algorithms with confidence scoring. Perfect for aligning business API inventories with discovered repositories.

## Purpose
- Map user-provided API lists to specific repositories
- Apply intelligent multi-factor scoring algorithms
- Assign confidence levels to mappings
- Provide actionable recommendations for each API

## Quick Start

### Trigger Commands
```
Map known APIs to repositories using my API list: [file_path]
```
```
Run API mapping workflow with the provided API inventory
```
```
Execute Workflow 2 to map APIs to repositories
```

### Prerequisites
1. **User API List** in one of these formats:
   - CSV file with API names and descriptions
   - Excel file with API inventory
   - Markdown file with API list
   - Direct text input with API names

2. **Repository Analysis** (optional - can be provided as context):
   - `reports/repositories_with_apis.csv` from Workflow 1
   - Or repository analysis data provided directly

### Expected Output
```
reports/
└── api_to_repository_mapping.csv    # API-to-repository mapping with confidence levels
```

## Features

### Intelligent Matching Algorithm
- **Multi-factor scoring** with weighted criteria
- **Confidence assessment** (High/Medium/Low)
- **Business domain alignment** detection
- **Technology stack compatibility** analysis

### Comprehensive Scoring System
```
Confidence Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
                   (Technology Match × 0.25) + (Pattern Match × 0.2)
```

### Flexible Input Support
- **CSV Files**: Structured API inventories
- **Excel Files**: Business-friendly format
- **Markdown Lists**: Documentation-based lists
- **Direct Input**: Paste API names directly

## Matching Criteria

### Name Similarity (30% weight)
- Exact name matches
- Partial name matches with fuzzy logic
- Acronym and abbreviation matching
- Synonym and terminology alignment

### Domain Alignment (25% weight)
- Business domain keywords detection
- Functional area matching
- Service purpose alignment
- Context and scope similarity

### Technology Match (25% weight)
- Framework compatibility (.NET versions)
- Architecture pattern alignment
- Technology stack consistency
- Platform and runtime matching

### Pattern Match (20% weight)
- File path pattern recognition
- Naming convention alignment
- Project structure indicators
- Implementation pattern matching

## Confidence Levels

### High Confidence (80-100%)
- **Indicators**: Strong match across multiple criteria
- **Example**: "Catalog API" → Repository with CatalogController.cs and e-commerce domain
- **Recommendation**: High priority for detailed analysis

### Medium Confidence (50-79%)
- **Indicators**: Good match with some uncertainty
- **Example**: Technology alignment but generic naming
- **Recommendation**: Review recommended, moderate priority

### Low Confidence (20-49%)
- **Indicators**: Possible match requiring validation
- **Example**: Functional alignment but technology mismatch
- **Recommendation**: Manual validation required

### No Match (<20%)
- **Indicators**: No viable repository identified
- **Recommendation**: API may be in unknown repository or not yet implemented

## Output Format

### CSV Structure
| Column | Description | Example |
|--------|-------------|---------|
| API Name | API from user's list | `Catalog Service API` |
| API Description | User-provided description | `Product catalog management` |
| Probable Repository | Best matching repository | `eShopOnWeb-main/PublicApi` |
| Confidence Level | High/Medium/Low | `High` |
| Matching Criteria | Specific match reasons | `Name + Domain + Technology` |
| Potential Location | File paths or projects | `src/PublicApi/Controllers/CatalogController.cs` |
| Service/Application | Mono-repo service | `PublicApi` |
| Technology Match | Technology alignment | `Perfect - ASP.NET Core Web API` |
| Notes | Additional observations | `Multiple catalog endpoints found` |
| Recommendation | Next steps | `High priority for Workflow 3` |

### Example Output
```csv
API Name,API Description,Probable Repository,Confidence Level,Matching Criteria,Potential Location,Service/Application,Technology Match,Notes,Recommendation
Catalog API,Product search and filtering,eShopOnWeb-main,High,Name + Domain + Technology,src/PublicApi/Controllers/CatalogController.cs,PublicApi,Perfect - ASP.NET Core Web API,Multiple catalog endpoints found,High priority for Workflow 3
User Management,Authentication and user data,UserService-main,Medium,Domain + Technology,Controllers/UserController.cs,N/A,Good - .NET 6 Web API,Generic naming but strong domain match,Review recommended
Payment Gateway,External payment processing,Unknown,No Match,None,N/A,N/A,No matching repository,May be external service or not yet implemented
```

## Input Format Examples

### CSV Format
```csv
API Name,Description,Expected Technology
Catalog API,Product catalog management,.NET Core
Order API,Order processing and management,.NET Framework
Payment API,Payment processing,Any .NET
```

### Excel Format
- Same structure as CSV with additional formatting support
- Multiple sheets supported (uses first sheet with API data)

### Markdown Format
```markdown
# API Inventory
- **Catalog API**: Product catalog management (.NET Core)
- **Order API**: Order processing and management (.NET Framework)
- **Payment API**: Payment processing (Any .NET)
```

### Direct Text Input
```
Catalog API - Product catalog management
Order API - Order processing
Payment API - Payment processing
User Management API - User authentication
```

## Integration

### Input Sources
- **Workflow 1 Output**: Repository analysis for matching
- **Business API Lists**: Enterprise API inventories
- **Documentation**: Existing API documentation
- **Architecture Documents**: System design specifications

### Output Usage
- **Workflow 3 Input**: Prioritized repositories for detailed analysis
- **Business Planning**: API implementation roadmaps
- **Architecture Review**: Gap analysis and alignment assessment
- **Governance**: API inventory management

## Advanced Features

### Batch Processing
- Handle large API lists (100+ APIs)
- Parallel processing for performance
- Memory-efficient processing for enterprise scale

### Quality Assurance
- **Duplicate Detection**: Identify potential duplicate mappings
- **Validation Rules**: Consistency checks across mappings
- **Gap Analysis**: Identify unmapped APIs and repositories

### Customization Options
- **Scoring Weights**: Adjust criteria importance
- **Domain Dictionaries**: Custom business domain keywords
- **Technology Mappings**: Framework compatibility rules

## Error Handling
- **Missing Repository Data**: Clear guidance to run Workflow 1 first
- **Invalid API Format**: Format detection and correction suggestions
- **Ambiguous Matches**: Multiple potential matches flagged for review
- **No Matches**: Unmatched APIs documented with analysis

## Success Criteria
✅ All provided APIs have mapping entries
✅ Confidence levels properly assigned with consistent criteria
✅ Clear recommendations for each API with business context
✅ High-quality matches validated through multiple criteria
✅ Integration with repository analysis for enhanced accuracy

## Support
- Check `docs/input-formats.md` for detailed format specifications
- Review `examples/` folder for sample inputs and outputs
- Consult `docs/troubleshooting.md` for common issues and solutions