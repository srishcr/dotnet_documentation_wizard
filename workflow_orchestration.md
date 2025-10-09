# .NET Documentation Wizard - Master Workflow Orchestration

## Overview

This is the master coordination guide for the .NET Documentation Wizard's three specialized workflows. Each workflow serves a distinct purpose in the comprehensive API analysis and documentation pipeline.

## Workflow Architecture

### 🔍 **Workflow 1: Find Repositories with APIs**
**Purpose**: Repository discovery and API identification across multiple repositories
**Scope**: Enterprise-scale repository analysis
**Output**: `reports/repositories_with_apis.csv`

### 🗺️ **Workflow 2: Map Known APIs to Repositories**
**Purpose**: Intelligent mapping of known APIs to discovered repositories
**Scope**: API-to-repository alignment with confidence scoring
**Output**: `reports/api_to_repository_mapping.csv`

### 📚 **Workflow 3: Detailed Repository Analysis**
**Purpose**: Comprehensive documentation generation for specific repositories
**Scope**: Deep technical and business analysis with security assessment
**Output**: Complete `analysis/` folder structure

## Workflow Selection Matrix

| User Request Pattern | Workflow | Key Indicators |
|---------------------|----------|----------------|
| "Find repositories with APIs" | Workflow 1 | "find", "scan", "discover", "repositories" |
| "Map APIs to repositories" | Workflow 2 | "map", "match", "API list", "align" |
| "Generate documentation" | Workflow 3 | "documentation", "analyze", "detailed", specific repo |
| "Run repository discovery" | Workflow 1 | Focus on multiple repositories |
| "Execute API mapping" | Workflow 2 | Mentions provided API list |
| "Create comprehensive docs" | Workflow 3 | Focus on single repository analysis |

## Execution Decision Logic

### Workflow Identification Process

1. **Parse User Request**: Analyze user input for workflow indicators
2. **Validate Prerequisites**: Check for required dependencies
3. **Confirm Workflow Selection**: Clarify with user if ambiguous
4. **Execute Selected Workflow**: Follow specific workflow instructions

### Prerequisite Dependencies

#### Workflow 1 Prerequisites
- ✅ Access to `repositories/` folder
- ✅ Read permissions for repository scanning
- ❌ No other dependencies

#### Workflow 2 Prerequisites
- ✅ Completed Workflow 1 (`reports/repositories_with_apis.csv`)
- ✅ User-provided API list (CSV, Excel, or Markdown)
- ✅ File access permissions

#### Workflow 3 Prerequisites
- 🔧 Optional: Results from Workflows 1 & 2 for enhanced context
- ✅ Target repository path
- ✅ Write permissions for analysis folder creation
- 🔧 Optional: `static_dotnet_endpoint_extractor` for efficiency

---

# 🔍 WORKFLOW 1: FIND REPOSITORIES WITH APIs

## Quick Reference
**File**: `workflow_1_find_apis.md`
**Triggers**: "Find repositories with APIs", "Scan repositories", "Repository discovery"
**Output**: `reports/repositories_with_apis.csv`

## Execution Summary (EFFICIENCY CRITICAL - 20-30M LOC)
1. **Ultra-Fast Repository Discovery**: Quick scan with immediate .NET filtering
2. **Minimal API Detection**: File system pattern matching (no content reading)
3. **Lightweight Technology Analysis**: Project files and README headers only
4. **Efficient Report Generation**: CSV creation with minimal data processing

⚠️ **LARGE CODEBASE WARNING**: For 60-70 repositories with millions of lines, use ONLY file system commands, pattern matching, and existence checks. Avoid reading file contents except for .csproj/.sln and first 20 lines of README.

🖥️ **WINDOWS COMPATIBILITY**: All workflows use PowerShell commands (Get-ChildItem, Select-String, Test-Path) with CMD fallbacks. Cross-platform ripgrep is recommended for optimal performance.

## Key Detection Patterns
- Controller files (`*Controller.cs`)
- Minimal API patterns (`MapGet`, `MapPost`, etc.)
- API attributes (`[ApiController]`, `[Route]`)
- Project files (`.csproj`, `.sln`)

---

# 🗺️ WORKFLOW 2: MAP KNOWN APIs TO REPOSITORIES

## Quick Reference
**File**: `workflow_2_map_apis.md`
**Triggers**: "Map APIs to repositories", "API mapping workflow", "Execute Workflow 2"
**Input**: User API list + Workflow 1 results
**Output**: `reports/api_to_repository_mapping.csv`

## Execution Summary
1. **Input Processing**: Parse user API list and repository analysis
2. **Matching Analysis**: Apply multi-factor scoring algorithm
3. **Confidence Assessment**: Assign High/Medium/Low confidence levels
4. **Report Generation**: Create mapping with recommendations

## Confidence Scoring Formula
```
Score = (Name Similarity × 0.3) + (Domain Alignment × 0.25) +
        (Technology Match × 0.25) + (Pattern Match × 0.2)
```

---

# 📚 WORKFLOW 3: DETAILED REPOSITORY ANALYSIS

## Quick Reference
**File**: `workflow_3_detailed_analysis.md`
**Triggers**: "Generate comprehensive documentation", "Detailed analysis", "Execute Workflow 3"
**Output**: Complete `analysis/` folder with all documentation assets

## Execution Summary
1. **Preparation**: Repository validation, endpoint extraction, folder setup
2. **Documentation**: Business overview, technical details, API inventory
3. **Security Analysis**: Sensitive data detection, OWASP assessment
4. **Validation**: Coverage verification, cross-reference checking

## Generated Assets (Workflow 3 Only)
- `01_overview.md` - Business and domain overview
- `02_technical_details.md` - Technical architecture
- `03_api_inventory.csv` - Complete API inventory
- `04_sensitive_data_apis.md` - Sensitive data analysis
- `05_business_critical_journeys.md` - Business journey mapping
- `workflow_execution_summary.md` - Execution report
- `apis/` folder - Individual API documentation

---

## Common Workflow Patterns

### Sequential Analysis Pattern
For comprehensive enterprise analysis:
1. **Execute Workflow 1** → Get complete repository landscape
2. **Execute Workflow 2** → Map known APIs to repositories
3. **Execute Workflow 3** → Generate detailed docs for priority repositories

### Focused Documentation Pattern
For specific repository documentation:
- **Jump to Workflow 3** → If you know the target repository

### API Discovery Pattern
For API inventory and governance:
1. **Execute Workflow 1** → Discover all API-containing repositories
2. **Use results** → Prioritize repositories for detailed analysis

---

## Error Handling and Quality Assurance

### Universal Error Handling
- **Missing Dependencies**: Graceful fallback with clear error messages
- **Large Repositories**: Progressive analysis with context management
- **Permission Issues**: Clear guidance for resolution
- **Validation Failures**: Detailed reporting with remediation steps

### Quality Standards
- **Template Compliance**: All outputs follow standardized templates
- **Cross-Reference Validation**: Consistency across all documents
- **Markdown Syntax**: Valid formatting for all generated files
- **Coverage Requirements**: 100% API documentation (Workflow 3 only)

---

## Integration Points

### File Dependencies
- **Workflow 2** requires output from **Workflow 1**
- **Workflow 3** enhanced by results from **Workflows 1 & 2**
- All workflows use shared **templates/** folder

### Tool Dependencies
- **ripgrep**: Required for Workflow 1 repository scanning
- **static_dotnet_endpoint_extractor**: Optional for Workflow 3 efficiency
- **File system access**: All workflows require appropriate permissions

---

## Success Validation

### Workflow 1 Success Criteria
- ✅ Complete repository inventory generated
- ✅ Accurate API detection across all repositories
- ✅ Valid CSV format with all required columns
- ✅ Technology stack properly identified

### Workflow 2 Success Criteria
- ✅ All provided APIs have mapping entries
- ✅ Confidence levels properly assigned
- ✅ Clear recommendations for each API
- ✅ Valid CSV format with comprehensive data

### Workflow 3 Success Criteria
- ✅ 100% API documentation coverage achieved
- ✅ All templates properly populated
- ✅ Security analysis completed for all APIs
- ✅ Cross-reference validation successful
- ✅ Execution summary comprehensive and actionable

---

## Maintenance and Updates

### Template Management
- **Location**: All templates stored in `templates/` folder
- **Customization**: Templates can be modified for organization-specific needs
- **Versioning**: Consider version control for template changes

### Workflow Updates
- **Individual Workflows**: Each workflow documented in separate `.md` files
- **Coordination**: This file serves as master orchestration guide
- **Dependencies**: Update all related files when making structural changes

### Tool Dependencies
- **ripgrep**: Keep updated for optimal performance
- **static_dotnet_endpoint_extractor**: Maintain and enhance for better coverage
- **MkDocs/Docsify**: Update for latest documentation features

---

## Quick Start Guide

### For New Users
1. **Read**: `user_runbook.md` for comprehensive usage guide
2. **Review**: Individual workflow files for detailed execution steps
3. **Start**: With simple trigger commands from the user runbook

### For Administrators
1. **Templates**: Review and customize templates in `templates/` folder
2. **Configuration**: Ensure tool dependencies are properly installed
3. **Permissions**: Verify file system access for all workflow outputs

### For Developers
1. **Copilot Instructions**: Review `.github/copilot-instructions.md` for implementation details
2. **Extension**: Use individual workflow files as basis for enhancements
3. **Integration**: Consider CI/CD integration patterns for automated documentation

---

*This orchestration file serves as the master coordination guide. For detailed execution instructions, refer to the individual workflow files: `workflow_1_find_apis.md`, `workflow_2_map_apis.md`, and `workflow_3_detailed_analysis.md`.*