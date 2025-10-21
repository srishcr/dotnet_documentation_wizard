# .NET Documentation Wizard - Mono-Repo

## Overview
A comprehensive collection of specialized, decoupled workflows for documenting .NET codebases. Each workflow is self-contained and focused on a specific aspect of API analysis and documentation.

## Mono-Repo Architecture
This repository contains **5 independent workflow sub-repos**, each designed to be:
- **Self-contained**: Complete with its own copilot instructions, templates, and documentation
- **Decoupled**: Can be used independently without dependencies on other workflows
- **Focused**: Optimized for a specific purpose without complexity overhead
- **Lightweight**: Faster execution and better quality due to focused scope

## Available Workflows

### 🔍 [Workflow 1: Repository Discovery](./workflow-1-repository-discovery/)
**Purpose**: Enterprise-scale repository scanning to identify which repositories contain .NET API definitions
- **Input**: Access to `repositories/` folder
- **Output**: `reports/repositories_with_apis.csv`
- **Features**: Windows PowerShell optimized, handles 20-30M LOC efficiently
- **Trigger**: `"Find all repositories with APIs"`

### 🗺️ [Workflow 2: API Mapping](./workflow-2-api-mapping/)
**Purpose**: Map known API lists to specific repositories using intelligent matching algorithms
- **Input**: User API list + repository analysis (can be provided as context)
- **Output**: `reports/api_to_repository_mapping.csv`
- **Features**: Multi-factor confidence scoring, supports CSV/Excel/Markdown input
- **Trigger**: `"Map known APIs to repositories using my API list"`

### 📋 [Workflow 3: Endpoint Inventory](./workflow-3-endpoint-inventory/)
**Purpose**: Create comprehensive endpoint inventory for ANY repository (ALL endpoint types)
- **Input**: Target repository path
- **Output**: `analysis/{repo}/{sub_repo}/endpoint_inventory.csv`
- **Features**: Universal endpoint detection (REST, WebForms, WCF, ASMX, Handlers, SignalR)
- **Trigger**: `"Create endpoint inventory for repository: [repo-name]"`

### 📚 [Workflow 4: Endpoint Documentation](./workflow-4-endpoint-documentation/)
**Purpose**: Document every endpoint from inventory CSV with validation and gap detection
- **Input**: Endpoint inventory CSV (can be provided as context)
- **Output**: Individual endpoint docs + `missed_endpoints.csv` if gaps found
- **Features**: Universal template system, 100% coverage validation, OWASP security assessment
- **Trigger**: `"Document all endpoints from inventory for [repo-name]"`

### 🔍 [Workflow 5: Repository Analysis](./workflow-5-repository-analysis/)
**Purpose**: Business and technical analysis with granular execution options
- **Input**: Target repository path + analysis type selection
- **Output**: Selected analysis files (overview, technical, security, business journey)
- **Features**: Granular control, individual or combined analysis, enhanced with endpoint context
- **Trigger**: `"Run overview only analysis for [repo-name]"` or `"Perform all analysis for [repo-name]"`

## Quick Start Guide

### Choose Your Workflow
Each workflow is completely independent. Choose based on your specific need:

1. **New Environment**: Start with Workflow 1 to discover all repositories with APIs
2. **API Mapping**: Use Workflow 2 to map known APIs to discovered repositories
3. **Detailed Analysis**: Use Workflow 3 to create comprehensive endpoint inventory
4. **Documentation**: Use Workflow 4 to document all endpoints with validation
5. **Business Analysis**: Use Workflow 5 for targeted business and technical analysis

### Navigation
Each workflow folder contains:
- **README.md**: Complete workflow overview and usage guide
- **.github/copilot-instructions.md**: AI assistant instructions
- **docs/**: Detailed documentation and troubleshooting
- **templates/**: Workflow-specific templates
- **examples/**: Sample inputs and outputs

## Decoupling Benefits

### Individual Workflow Advantages
- **Faster Execution**: No overhead from unused workflows
- **Better Quality**: Focused AI instructions lead to better results
- **Easier Maintenance**: Update workflows independently
- **Clearer Purpose**: Each workflow has a single, clear responsibility
- **Reduced Complexity**: Simpler instructions and fewer edge cases

### Flexible Usage Patterns
- **Standalone**: Use any workflow independently
- **Progressive**: Start simple and add more analysis as needed
- **Targeted**: Focus on specific aspects (security, business, technical)
- **Scalable**: Run workflows in parallel or sequence as appropriate

## Common Usage Patterns

### Discovery Pattern
For new or unknown environments:
```
1. Workflow 1: Find all repositories with APIs
2. Workflow 2: Map known APIs to repositories (if you have an API list)
3. Workflow 3: Create endpoint inventory for priority repositories
```

### Documentation Pattern
For comprehensive endpoint documentation:
```
1. Workflow 3: Create endpoint inventory
2. Workflow 4: Document all endpoints with validation
3. Workflow 5: Add business analysis (optional)
```

### Analysis Pattern
For targeted analysis without full documentation:
```
1. Workflow 5: Run specific analysis type (overview, technical, security, business)
```

### Mapping Pattern
For aligning business APIs with code:
```
1. Workflow 1: Discover repositories (if needed)
2. Workflow 2: Map APIs to repositories
3. Workflow 3: Validate mappings with endpoint inventory
```

## Input/Output Flow

### Workflow Dependencies (Optional)
While each workflow is standalone, they can enhance each other:

```
Workflow 1 Output → Workflow 2 Input (repository analysis)
Workflow 3 Output → Workflow 4 Input (endpoint inventory)
Workflow 3 Output → Workflow 5 Enhancement (endpoint context)
```

### Context-Based Usage
Instead of dependencies, workflows can use **provided context**:
- Workflow 2 can receive repository analysis data in the prompt
- Workflow 4 can receive endpoint inventory CSV in the prompt
- Workflow 5 can receive endpoint data for enhanced analysis

## Technical Features

### Universal Endpoint Support
All workflows support the complete .NET ecosystem:
- **REST APIs**: MVC Controllers, Web API, Minimal APIs
- **ASP.NET WebForms**: ASPX pages, WebMethods, controls
- **WCF Services**: Service contracts, SOAP operations
- **Legacy Services**: ASMX web services
- **HTTP Handlers**: ASHX handlers, custom processors
- **Modern Patterns**: SignalR Hubs, OData, GraphQL

### Enterprise Scale Support
- **Large Codebases**: Optimized for 20-30M LOC across 60-70 repositories
- **Windows Optimization**: PowerShell commands for best performance
- **Memory Efficient**: Streaming processing and resource management
- **Parallel Processing**: Concurrent analysis capabilities

### Quality Assurance
- **Template Compliance**: Standardized output formats
- **Validation**: Built-in quality checks and gap detection
- **Cross-Reference**: Consistency verification across documents
- **Security Integration**: OWASP API Security Top 10 assessment

## Migration from Monolithic Version

### What Changed
- **Decoupled Architecture**: Each workflow is now independent
- **Focused Instructions**: Workflow-specific AI instructions
- **Reduced Complexity**: No orchestration overhead
- **Better Performance**: Faster execution per workflow
- **Flexible Usage**: Use workflows individually or in combination

### How to Migrate
1. **Identify Your Needs**: Choose which workflows you actually need
2. **Start Fresh**: Each workflow has its own clear documentation
3. **Use Context**: Provide data as context instead of dependencies
4. **Progressive Adoption**: Add workflows as needed, not all at once

## Support and Documentation

### Individual Workflow Support
Each workflow folder contains comprehensive documentation:
- **README.md**: Overview and quick start
- **docs/workflow-guide.md**: Detailed execution guidance
- **docs/troubleshooting.md**: Common issues and solutions
- **examples/**: Sample inputs and outputs

### Common Resources
- **Repository Structure**: All workflows expect `repositories/` folder
- **Output Organization**: Centralized `analysis/` and `reports/` folders
- **Template System**: Consistent documentation templates
- **Performance Guidelines**: Optimization for large codebases

## Contributing

### Workflow-Specific Changes
- Modify individual workflows in their respective folders
- Update workflow-specific documentation and templates
- Test workflows independently

### Cross-Workflow Changes
- Update this main README for architectural changes
- Ensure consistency across workflow documentation
- Update common resources and guidelines

---

## Quick Reference

| Need | Workflow | Command |
|------|----------|---------|
| Find APIs in repositories | Workflow 1 | `"Find all repositories with APIs"` |
| Map known APIs | Workflow 2 | `"Map APIs to repositories using my list"` |
| Create endpoint inventory | Workflow 3 | `"Create endpoint inventory for [repo]"` |
| Document endpoints | Workflow 4 | `"Document all endpoints from inventory"` |
| Business analysis | Workflow 5 | `"Run overview analysis for [repo]"` |
| Complete documentation | Multiple | Use Workflows 3 → 4 → 5 |

**Get Started**: Navigate to any workflow folder and follow the README instructions for immediate usage.