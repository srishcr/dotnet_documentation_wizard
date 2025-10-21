# Workflow 1: Troubleshooting Guide

## Common Issues

### "No repositories found in repositories folder"
**Cause**: Missing or incorrectly structured repositories folder
**Solutions**:
- Ensure repositories are placed in the `repositories/` folder relative to the project root
- Check folder permissions and access rights
- Verify folder structure is correct
- Ensure the path exists: `repositories/[repo-name]/`

### "Repository scanning failed"
**Cause**: Corrupted or incomplete repositories
**Solutions**:
- Some repositories may be corrupted or incomplete
- Check individual repository access permissions
- Review the CSV output for specific error details
- Verify repositories contain valid .NET projects

### "PowerShell pattern detection failed"
**Cause**: PowerShell execution issues
**Solutions**:
- Ensure Windows PowerShell is available (pre-installed on Windows)
- Verify file paths use Windows path separators (backslashes)
- Check that Select-String commands have proper syntax
- Try CMD fallback commands if PowerShell fails

### "Analysis takes too long"
**Cause**: Large codebase or inefficient scanning
**Solutions**:
- Ensure you're following the efficiency rules (max 5 file reads per repo)
- Skip non-.NET repositories immediately
- Use batch operations with Get-ChildItem and Select-String
- Check for infinite loops in deep directory structures

### "Incomplete API detection"
**Cause**: Missing API patterns or project types
**Solutions**:
- Verify the repository contains .NET projects
- Check that API controllers follow standard naming conventions (*Controller.cs)
- Look for non-standard API implementations (minimal APIs, custom frameworks)
- Review project structure for unusual organization

### "Permission denied errors"
**Cause**: Insufficient file system permissions
**Solutions**:
- Run with appropriate permissions for the repositories folder
- Check that all repository folders are accessible
- Verify read permissions on .csproj and .sln files
- Consider running as administrator if needed

### "Out of memory errors"
**Cause**: Processing too many large files
**Solutions**:
- Ensure you're not reading large files into memory
- Use streaming operations for file pattern detection
- Follow the "file system only" approach
- Skip binary files and build outputs (bin/, obj/)

## Performance Issues

### "Scanning is too slow"
**Optimization Steps**:
1. **Use PowerShell Commands**: Leverage Get-ChildItem, Select-String, Test-Path
2. **Batch Operations**: Process multiple files in single commands
3. **Early Termination**: Skip non-.NET repos immediately
4. **Parallel Processing**: Use ForEach-Object -Parallel for multiple repos
5. **Pattern Prioritization**: Check most common patterns first

### "High memory usage"
**Memory Management**:
1. **Avoid Content Reading**: Use file existence and pattern matching only
2. **Streaming Processing**: Don't load entire files into memory
3. **Resource Cleanup**: Clear variables between repository scans
4. **Limit Scope**: Process one repository at a time for large environments

## Validation Issues

### "CSV format is invalid"
**CSV Troubleshooting**:
- Ensure all columns are present in the header
- Check for proper escaping of commas in data fields
- Verify no missing values in required columns
- Validate that mono-repo structures use semicolon separation

### "Inaccurate API detection"
**Detection Validation**:
- Cross-check with manual inspection of a few repositories
- Verify controller naming conventions are followed
- Check for minimal API patterns in Program.cs files
- Look for Web API attributes in class definitions

### "Technology stack detection issues"
**Framework Detection**:
- Ensure .csproj files are accessible
- Check for valid XML in project files
- Look for TargetFramework elements in project files
- Verify PackageReference elements for technology identification

## Environment Issues

### "Windows-specific commands fail"
**Cross-Platform Fallbacks**:
```bash
# Linux/Mac alternatives
find repositories/REPO -name "*.csproj" | wc -l
find repositories/REPO -name "*Controller.cs" | wc -l
grep -r "\[ApiController\]" repositories/REPO --include="*.cs" | wc -l
```

### "PowerShell not available"
**CMD Alternatives**:
```cmd
dir repositories\REPO\*.csproj /s /b | find /c ":"
dir repositories\REPO\*Controller.cs /s /b | find /c ":"
findstr /s /m "\[ApiController\]" repositories\REPO\*.cs
```

## Data Quality Issues

### "Repository summaries are generic"
**Improvement Steps**:
- Ensure README files are available and readable
- Check for project descriptions in .csproj files
- Look for documentation folders or files
- Review folder structure for business domain hints

### "Technology stack incomplete"
**Enhancement Strategies**:
- Check PackageReference elements in project files
- Look for framework-specific files (Startup.cs, Program.cs)
- Review configuration files (appsettings.json, web.config)
- Examine using statements in source files (limited pattern matching)

## Performance Monitoring

### "Track scanning progress"
**Progress Indicators**:
```powershell
$totalRepos = (Get-ChildItem repositories\ -Directory).Count
$currentRepo = 0

Get-ChildItem repositories\ -Directory | ForEach-Object {
    $currentRepo++
    Write-Progress -Activity "Scanning Repositories" -Status "Processing $($_.Name)" -PercentComplete (($currentRepo / $totalRepos) * 100)
    # Repository analysis here
}
```

### "Memory usage monitoring"
**Resource Tracking**:
```powershell
# Check memory usage periodically
Get-Process -Name "powershell" | Select-Object WorkingSet, PagedMemorySize
[GC]::Collect() # Force garbage collection between repos
```

## Getting Help

If issues persist:
1. **Check Prerequisites**: Ensure all required tools are installed
2. **Verify Project Structure**: Confirm target repositories are valid .NET projects
3. **Review Logs**: Examine PowerShell error messages and warnings
4. **Manual Validation**: Test commands on individual repositories
5. **Fallback Options**: Use alternative detection methods when primary fails