# Workflow 3: Endpoint Inventory - Troubleshooting Guide

## Common Issues

### "No endpoints found"
**Cause**: Repository doesn't contain recognizable endpoint patterns
**Solutions**:
- Verify you're targeting a .NET project directory
- Check that the project contains API controllers or endpoint definitions
- Ensure the project builds successfully
- Look for non-standard endpoint implementations

### "PowerShell pattern detection failed"
**Cause**: PowerShell execution issues on Windows
**Solutions**:
- Ensure Windows PowerShell is available (pre-installed on Windows)
- Verify file paths use Windows path separators (backslashes)
- Check that Select-String commands have proper syntax
- Try CMD fallback commands if PowerShell fails

### "Analysis folder creation failed"
**Cause**: Permission or path issues
**Solutions**:
- Check write permissions in the target directory
- Ensure sufficient disk space
- Verify the target repository path exists and is accessible
- Create the analysis folder manually if needed

### "Incomplete endpoint detection"
**Cause**: Complex or non-standard endpoint patterns
**Solutions**:
- Review repository structure for unusual organization
- Check for custom frameworks or non-standard implementations
- Look for virtual endpoints defined in configuration files
- Consider manual review for complex legacy applications

### "CSV format errors"
**Cause**: Data formatting or encoding issues
**Solutions**:
- Ensure all required CSV columns are present
- Check for proper escaping of commas and quotes in data
- Verify no missing values in critical columns
- Validate CSV syntax using external tools

## Performance Issues

### "Scanning takes too long"
**Optimization Steps**:
1. **Use Parallel Processing**: Analyze different endpoint types simultaneously
2. **Pattern Prioritization**: Check most common patterns first
3. **File Type Filtering**: Skip non-relevant files (tests, bin, obj)
4. **Early Termination**: Stop scanning once sufficient patterns found

### "Memory usage too high"
**Memory Management**:
1. **Stream Processing**: Don't load entire files into memory
2. **Batch Operations**: Process files in smaller chunks
3. **Resource Cleanup**: Clear variables between scans
4. **Pattern Matching**: Use file system operations over content reading

## Detection Issues

### "Virtual endpoints not found"
**Configuration Analysis**:
- Check web.config for URL rewriting rules
- Review Global.asax for custom routing
- Look for route attributes in controllers
- Examine startup configuration files

### "Legacy endpoints missed"
**Legacy Detection**:
- Verify ASPX and ASCX file detection
- Check for WebMethod attributes in code-behind
- Look for ASMX and SVC service files
- Review custom HTTP handlers (ASHX files)

### "Modern patterns not detected"
**Modern Framework Support**:
- Check for Minimal API patterns in Program.cs
- Look for SignalR Hub implementations
- Verify OData controller detection
- Review GraphQL endpoint definitions

## Validation Issues

### "Endpoint classification incorrect"
**Classification Problems**:
- Review endpoint type detection logic
- Check for mixed implementations (REST + WebForms)
- Verify framework version detection
- Look for custom endpoint implementations

### "Missing metadata"
**Metadata Extraction**:
- Ensure file path and line number accuracy
- Check parameter extraction from method signatures
- Verify authentication pattern detection
- Review business domain inference logic

## Environment Issues

### "Cross-platform compatibility"
**Platform-Specific Issues**:
```bash
# Linux/Mac alternatives for Windows PowerShell commands
find repositories/REPO -name "*.cs" -exec grep -l "\[ApiController\]" {} \;
find repositories/REPO -name "*Controller.cs" | wc -l
grep -r "MapGet\|MapPost" repositories/REPO --include="*.cs"
```

### "Large repository handling"
**Enterprise Scale Issues**:
- Implement progressive analysis for very large repos
- Use streaming file operations
- Set reasonable timeout limits
- Provide progress indicators for long operations

## Quality Assurance

### "Confidence scoring low"
**Improve Detection Confidence**:
- Cross-reference multiple detection methods
- Validate virtual endpoints have implementations
- Check for common framework patterns
- Review endpoint count against repository complexity

### "Gap detection accuracy"
**Validation Improvements**:
- Compare with manual endpoint count estimates
- Cross-check with build output or documentation
- Validate against known API specifications
- Review missed patterns in similar projects

## Getting Help

If issues persist:
1. **Check Prerequisites**: Ensure repository is valid .NET project
2. **Review Logs**: Examine detection output for specific errors
3. **Manual Validation**: Test detection commands on individual files
4. **Fallback Options**: Use alternative detection methods
5. **Community Support**: Check similar repository patterns