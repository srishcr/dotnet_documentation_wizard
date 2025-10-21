# Workflow 2: API-to-Repository Mapping - Complete Guide

## Overview
This workflow takes a list of known APIs (provided by the user) and maps them to specific repositories and locations using intelligent matching algorithms. It creates structured mapping between API names/descriptions and repository contents.

## Execution Steps

### Phase 1: Input Processing
1. **API List Parsing**: Read and standardize user-provided API list
2. **Repository Data Loading**: Load results from Workflow 1 (or provided context)
3. **Data Validation**: Verify input completeness and format
4. **Preprocessing**: Normalize API names and descriptions for matching

### Phase 2: Matching Analysis
Apply multi-factor analysis across four key dimensions:

#### 1. Name-Based Matching (30% weight)
- **Repository Names**: Match API names with repository folder names
- **Service Names**: Match with identified services in mono-repos
- **Project Names**: Match with .csproj project names
- **Controller Names**: Match with identified controller file names

#### 2. Domain-Based Matching (25% weight)
- **Business Domains**: Match API business context with repository summaries
- **Functional Areas**: Align API functions with repository purposes
- **Entity Matching**: Match core entities (Product, Order, User) across descriptions
- **Context Similarity**: Analyze business domain alignment

#### 3. Technology Stack Alignment (25% weight)
- **Framework Compatibility**: Ensure API requirements align with repository technologies
- **Authentication Patterns**: Match security requirements with implementations
- **Integration Points**: Align external dependencies and integrations
- **Platform Consistency**: Verify compatible technology stacks

#### 4. Pattern Matching (20% weight)
- **URL Patterns**: Match provided endpoint patterns with repository API structures
- **Route Conventions**: Align with identified routing patterns
- **Controller Patterns**: Match with controller organization
- **File Structure**: Analyze repository organization patterns

### Phase 3: Confidence Scoring
Calculate composite score using weighted criteria:

```
Confidence Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
                   (Technology Match × 0.25) + (Pattern Match × 0.2)
```

#### High Confidence (80-100%)
- Direct name match + domain alignment
- Endpoint pattern match + technology compatibility
- Multiple matching criteria convergence
- Clear repository purpose alignment

**Example**: "Catalog API" → Repository with CatalogController.cs in e-commerce domain

#### Medium Confidence (50-79%)
- Partial name match with domain similarity
- Technology compatibility with functional alignment
- Single strong match with supporting evidence
- Repository has capability but unclear implementation

**Example**: "Product Service" → Repository with product-related functionality but generic naming

#### Low Confidence (20-49%)
- Generic name match requiring further validation
- Domain match but technology uncertainty
- Repository potential but unclear API exposure
- Multiple possible repositories identified

**Example**: "Data API" → Multiple repositories with data access patterns

#### No Match (<20%)
- No reasonable repository candidates found
- Significant technology mismatches
- Business domain not represented in scanned repositories
- Potentially external service or not yet implemented

### Phase 4: Report Generation
1. **Structured Mapping**: Create comprehensive mapping report
2. **Summary Statistics**: Generate matching success rates and confidence distribution
3. **Recommendations**: Provide actionable next steps for each API
4. **Validation Notes**: Document matching logic and assumptions

## Detailed Matching Logic

### String Similarity Algorithms
```
- Exact Match: 100% score
- Fuzzy Match: Using Levenshtein distance
- Partial Match: Substring matching with position weighting
- Acronym Match: First letters matching (e.g., "UMS" → "User Management Service")
- Synonym Match: Common terminology alignment
```

### Domain Keyword Analysis
```
E-commerce: catalog, product, cart, order, payment, checkout, inventory
Identity: user, auth, login, permission, role, account, profile
Finance: payment, billing, transaction, account, invoice, charge
Content: document, file, media, upload, storage, asset
Communication: message, notification, email, sms, chat
```

### Technology Compatibility Matrix
```
.NET Framework 4.x ↔ .NET Framework APIs
.NET Core/.NET 5+ ↔ Modern .NET APIs
ASP.NET WebForms ↔ Page-based endpoints
ASP.NET MVC ↔ Controller-based APIs
ASP.NET Core ↔ Modern Web APIs
WCF ↔ SOAP-based services
```

## Input Format Specifications

### CSV Format
```csv
API Name,Description,Domain,Expected Technology,Endpoint Pattern
Catalog API,Product catalog management,E-commerce,.NET Core,/api/catalog/*
Order API,Order processing,E-commerce,.NET Framework,/api/orders/*
User API,User management,Identity,.NET Core,/api/users/*
```

### Excel Format
- Same structure as CSV with additional formatting support
- Multiple sheets supported (uses first sheet with API data)
- Headers can be in any row (automatically detected)

### Markdown Format
```markdown
# Enterprise API Inventory

## E-commerce APIs
- **Catalog API**: Product catalog management (.NET Core)
- **Order API**: Order processing and management (.NET Framework)
- **Payment API**: Payment processing integration

## Identity APIs
- **User Management API**: User authentication and profiles
- **Authorization API**: Role and permission management
```

### Direct Text Input
```
Catalog API - Product catalog management
Order API - Order processing
Payment API - Payment processing
User Management API - User authentication
Notification API - Email and SMS notifications
```

## Advanced Matching Techniques

### Multi-Repository Analysis
For APIs that could span multiple repositories:
1. **Primary Repository**: Main implementation location
2. **Secondary Repositories**: Supporting or dependent implementations
3. **Shared Libraries**: Common functionality across repositories
4. **Integration Points**: Cross-repository dependencies

### Mono-Repo Service Mapping
For mono-repos with multiple services:
1. **Service Identification**: Map API to specific service within repo
2. **Cross-Service Dependencies**: Identify service interactions
3. **Shared Components**: Common libraries and utilities
4. **Service Boundaries**: Clear separation of concerns

### Legacy System Integration
For mixed technology environments:
1. **Technology Bridge Detection**: Integration points between old/new systems
2. **Migration Patterns**: APIs in transition between technologies
3. **Wrapper Services**: Modern APIs wrapping legacy functionality
4. **Hybrid Implementations**: Mixed technology stacks

## Quality Assurance

### Validation Rules
1. **Duplicate Detection**: Identify potential duplicate API mappings
2. **Consistency Checks**: Ensure mapping logic consistency
3. **Gap Analysis**: Identify unmapped APIs and unused repositories
4. **Cross-Reference Validation**: Verify mappings make business sense

### Manual Review Triggers
Flag for manual review when:
- Multiple APIs map to same repository location
- High-value APIs have low confidence scores
- Technology mismatches in high-confidence mappings
- Business-critical APIs have no matches

### Quality Metrics
- **Mapping Coverage**: Percentage of APIs successfully mapped
- **Confidence Distribution**: High/Medium/Low confidence breakdown
- **Repository Utilization**: How many repositories are mapped
- **Validation Accuracy**: Manual review success rate

## Error Handling

### Missing Dependencies
- **No Workflow 1 Data**: Request repository analysis or provide context
- **Invalid API List**: Provide format examples and correction guidance
- **Empty Results**: Guide user through troubleshooting steps

### Data Quality Issues
- **Ambiguous API Names**: Request more detailed descriptions
- **Generic Descriptions**: Suggest domain-specific keywords
- **Technology Conflicts**: Highlight compatibility issues

### Performance Considerations
- **Large API Lists**: Implement batch processing and progress indicators
- **Complex Matching**: Optimize algorithms for enterprise scale
- **Memory Management**: Handle large datasets efficiently

## Success Criteria

### Primary Success Indicators
- ✅ All provided APIs have mapping entries with reasoned analysis
- ✅ Confidence levels properly assigned using consistent criteria
- ✅ Clear recommendations for each API with business context
- ✅ High-quality matches validated through multiple criteria

### Secondary Success Indicators
- ✅ Integration with repository analysis for enhanced accuracy
- ✅ Actionable recommendations for subsequent workflows
- ✅ Gap analysis identifies missing or external APIs
- ✅ Business value alignment clearly documented

## Integration Points

### Input Sources
- **Workflow 1 Output**: Repository analysis for matching foundation
- **Business API Lists**: Enterprise API inventories and catalogs
- **Architecture Documentation**: System design and API specifications
- **Legacy Documentation**: Existing API documentation and registries

### Output Usage
- **Workflow 3 Input**: Prioritized repositories for detailed endpoint analysis
- **Business Planning**: API implementation and modernization roadmaps
- **Architecture Review**: Gap analysis and technology alignment
- **Governance**: API inventory management and compliance tracking