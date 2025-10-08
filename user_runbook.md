# .NET Documentation Wizard - User Runbook

## Overview

The .NET Documentation Wizard is an automated workflow that generates comprehensive documentation for any .NET codebase. It creates business overviews, technical specifications, API inventories, and detailed API documentation.

## What You Get

After running this workflow, you'll have a complete `analysis/` folder containing:

- **📊 01_overview.md** - Business context and domain overview with diagrams
- **🏗️ 02_technical_details.md** - Technical architecture and implementation details
- **📋 03_api_inventory.csv** - Complete API inventory with unique identifiers
- **📁 apis/** - Individual documentation files for each API endpoint

## Prerequisites

### Required Tools
- **ripgrep** - For fast endpoint extraction
  ```bash
  # Install ripgrep (if not already installed)
  brew install ripgrep  # macOS
  sudo apt install ripgrep  # Linux
  ```

### Supported .NET Projects
- ✅ .NET 6+ with Minimal APIs
- ✅ ASP.NET Core MVC applications
- ✅ Traditional Web API projects
- ✅ Mixed architectures with multiple patterns

## How to Use

### Step 1: Navigate to Your Repository

Open your .NET project repository in VS Code. The workflow works with any .NET codebase structure.

### Step 2: Trigger the Workflow

Use one of these methods to start the documentation generation:

#### Method A: Chat Command
In the Copilot chat, type:
```
Generate comprehensive documentation for this .NET codebase using the documentation wizard workflow
```

#### Method B: Specific Path
If you want to analyze a specific path within your repository:
```
Run the .NET documentation wizard on the path: ./src/MyApi
```

#### Method C: Full Repository Analysis
To analyze the entire repository:
```
Create complete documentation for this .NET repository
```

### Step 3: Provide Repository Information

The wizard will ask you to confirm:
- **Repository path** - The root path of your .NET project
- **Project name** - Used for file naming and organization

Example interaction:
```
Copilot: I'll analyze your .NET codebase. Please confirm:
- Repository path: /Users/yourname/projects/MyApp
- Project name: MyApp

Would you like me to proceed with the analysis?
```

### Step 4: Monitor Progress

The workflow runs in several phases:

1. **🔍 Endpoint Extraction** - Scans codebase for API patterns
2. **📊 Business Analysis** - Identifies domains and capabilities
3. **🏗️ Technical Analysis** - Documents architecture and patterns
4. **📋 Inventory Creation** - Catalogs all APIs with unique codes
5. **📁 API Documentation** - Creates detailed specs for each endpoint

### Step 5: Review Generated Documentation

Once complete, you'll find:

```
your-repository/
├── analysis/
│   ├── 01_overview.md           # Business overview
│   ├── 02_technical_details.md  # Technical architecture
│   ├── 03_api_inventory.csv     # API inventory
│   └── apis/                    # Individual API docs
│       ├── myapp-api-00001.md
│       ├── myapp-api-00002.md
│       └── ...
```

## Expected Output Examples

### Business Overview (01_overview.md)
- Product purpose and value proposition
- Business domain identification
- Stakeholder analysis
- Domain diagrams using Mermaid
- Key business capabilities

### Technical Details (02_technical_details.md)
- Architecture patterns (Clean Architecture, MVC, etc.)
- Technology stack and frameworks
- Security approaches and patterns
- Database design and data flow
- System integration points

### API Inventory (03_api_inventory.csv)
```csv
Code,Method,Endpoint,Controller,Purpose,Access Level,Domain,File Path,Line Number
myapp-api-00001,GET,/api/products,ProductsController,List all products,External,Catalog,src/Controllers/ProductsController.cs,25
myapp-api-00002,POST,/api/products,ProductsController,Create new product,Internal,Catalog,src/Controllers/ProductsController.cs,45
```

### Individual API Documentation (apis/myapp-api-00001.md)
- Detailed endpoint specification
- Request/response examples
- Authentication requirements
- Error handling scenarios
- Code citations with file paths and line numbers

## Troubleshooting

### Common Issues

#### "ripgrep not found"
```bash
# Install ripgrep
brew install ripgrep  # macOS
sudo apt install ripgrep  # Linux
```

#### "No endpoints found"
- Verify you're in a .NET project directory
- Check that the project contains API controllers or minimal API definitions
- Ensure the project builds successfully

#### "Analysis folder creation failed"
- Check write permissions in the repository directory
- Ensure sufficient disk space
- Verify the path exists and is accessible

### Getting Help

If you encounter issues:

1. **Check Prerequisites** - Ensure ripgrep is installed and accessible
2. **Verify Project Structure** - Confirm you're in a valid .NET project
3. **Review Logs** - Check the Copilot chat for error messages
4. **Manual Fallback** - The workflow can analyze projects without ripgrep (slower but functional)

## Customization Options

### Analyzing Specific Subdirectories
```
Run the documentation wizard on just the API layer: ./src/WebApi
```

### Focusing on Specific Domains
```
Generate documentation focused on the catalog and ordering domains
```

### Adding Business Context
```
Include information about user roles and business processes in the documentation
```

## Best Practices

### Before Running
- Ensure your codebase is in a clean state
- Review any existing documentation to avoid conflicts
- Consider running on a specific branch if needed

### After Generation
- Review the generated documentation for accuracy
- Add business-specific context where needed
- Update API classifications (internal/external) as appropriate
- Consider version controlling the analysis folder

### Maintenance
- Re-run the workflow after significant API changes
- Update business context as the product evolves
- Use the inventory for API governance and security reviews

## Advanced Usage

### Integration with CI/CD
The workflow can be integrated into development pipelines:
```bash
# Example pipeline step
- name: Generate API Documentation
  run: |
    copilot analyze-dotnet-apis --path ./src --output ./docs/analysis
```

### Custom Templates
The workflow supports customization of documentation templates for organization-specific needs.

### Multi-Repository Analysis
For microservice architectures, run the workflow on each service repository to maintain consistent documentation across services.

## Support

For questions or issues with the documentation wizard:
1. Check this runbook for common solutions
2. Review the generated logs for specific error messages
3. Consult your development team for project-specific guidance

---

**Happy documenting! 📚✨**