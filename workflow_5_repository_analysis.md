# Workflow 5: Repository Analysis

## Overview

This workflow creates comprehensive business and technical analysis for repositories, with granular options to run individual analyses or complete repository analysis. It focuses on high-level insights, business context, technical architecture, and security considerations.

## Purpose

- Generate business and technical repository analysis
- Support granular analysis options (individual or combined)
- Create strategic insights for stakeholders
- Provide security and compliance analysis

## Granular Analysis Options

### Individual Analysis Types
1. **"overview only"** → Creates `01_overview.md`
2. **"technical details only"** → Creates `02_technical_details.md`
3. **"sensitive data only"** → Creates `03_sensitive_data_analysis.md`
4. **"business journey only"** → Creates `04_business_critical_journeys.md`
5. **"all analysis"** → Creates all four documents

### Output Structure
```
{wizard_root}/analysis/{repo_name}/{sub_repo}/
├── 01_overview.md                      # Business overview (if requested)
├── 02_technical_details.md             # Technical architecture (if requested)
├── 03_sensitive_data_analysis.md       # Security analysis (if requested)
├── 04_business_critical_journeys.md    # Business journey mapping (if requested)
└── analysis_execution_summary.md       # Summary of completed analyses
```

## Trigger Commands and Analysis Selection

### Individual Analysis Commands
```
"Run overview only analysis for [repo-name]"
"Execute technical details only for [repo-name]/[sub-project]"
"Generate sensitive data analysis only for [repo-name]"
"Create business journey analysis only for [repo-name]"
"Perform all analysis for [repo-name]"
```

### Command Processing Logic
```
IF command contains "overview only" → Execute Overview Analysis
IF command contains "technical details only" → Execute Technical Analysis
IF command contains "sensitive data only" → Execute Sensitive Data Analysis
IF command contains "business journey only" → Execute Business Journey Analysis
IF command contains "all analysis" → Execute All Four Analyses
```

## Analysis Components

### 🔍 **Analysis 1: Repository Overview (01_overview.md)**

**Template**: `templates/01_overview_template.md`
**Focus**: Business context and domain understanding

#### Analysis Scope
- **Business Domain Identification**: Analyze namespaces, folder structure, entity models
- **Product Purpose Analysis**: Extract business context from README, documentation
- **Stakeholder Mapping**: Identify user roles from authentication and authorization patterns
- **Domain Modeling**: Create business domain diagrams and relationships
- **Value Proposition**: Understand business capabilities and features

#### Key Analysis Areas
```powershell
# Business domain extraction from code structure
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.cs" |
    Select-String -Pattern "namespace.*\.(Domain|Models|Entities)" -AllMatches

# Entity model analysis for business understanding
Select-String -Path "repositories\{repo}\*.cs" -Pattern "class.*(Order|Product|User|Customer|Invoice)" -Recurse

# README analysis for business context
Get-Content "repositories\{repo}\README.md" | Select-Object -First 50
```

### 🏗️ **Analysis 2: Technical Details (02_technical_details.md)**

**Template**: `templates/02_technical_details_template.md`
**Focus**: Architecture patterns and technical implementation

#### Analysis Scope
- **Architecture Pattern Recognition**: Clean Architecture, DDD, MVC, layered
- **Technology Stack Documentation**: Frameworks, libraries, versions
- **Security Implementation Patterns**: Authentication, authorization, data protection
- **Data Architecture**: Database design, ORM patterns, data flow
- **Integration Points**: External services, APIs, message queues

#### Key Analysis Areas
```powershell
# Architecture pattern detection
Select-String -Path "repositories\{repo}\*.cs" -Pattern "IRepository|IService|IMapper|MediatR" -Recurse

# Technology stack analysis from project files
Get-ChildItem "repositories\{repo}" -Recurse -Filter "*.csproj" |
    ForEach-Object { Select-String -Path $_.FullName -Pattern "<PackageReference" }

# Security pattern analysis
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[Authorize\]|Identity|JWT|OAuth" -Recurse

# Database and ORM patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "DbContext|Entity.*Configuration|FromSql" -Recurse
```

### 🔒 **Analysis 3: Sensitive Data Analysis (03_sensitive_data_analysis.md)**

**Template**: `templates/03_sensitive_data_template.md`
**Focus**: Security, compliance, and sensitive data handling

#### Analysis Scope
- **Sensitive Data Pattern Detection**: PII, financial, authentication data
- **Security Implementation Review**: Encryption, hashing, secure storage
- **Compliance Considerations**: GDPR, PCI-DSS, regulatory requirements
- **Data Flow Analysis**: How sensitive data moves through the system
- **Risk Assessment**: Security vulnerabilities and business impact

#### Sensitive Data Detection Patterns
```powershell
# PII indicators
Select-String -Path "repositories\{repo}\*.cs" -Pattern "email|phone|address|ssn|passport|name.*first|name.*last" -Recurse -CaseSensitive:$false

# Financial indicators
Select-String -Path "repositories\{repo}\*.cs" -Pattern "credit.*card|payment|billing|account.*number|transaction|balance" -Recurse -CaseSensitive:$false

# Authentication indicators
Select-String -Path "repositories\{repo}\*.cs" -Pattern "password|token|secret|credential|private.*key" -Recurse -CaseSensitive:$false

# Confidential indicators
Select-String -Path "repositories\{repo}\*.cs" -Pattern "confidential|internal|private|admin.*only|classified" -Recurse -CaseSensitive:$false
```

#### Security Pattern Analysis
```powershell
# Encryption and hashing patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "encrypt|decrypt|hash|salt|bcrypt|aes" -Recurse -CaseSensitive:$false

# Data protection implementation
Select-String -Path "repositories\{repo}\*.cs" -Pattern "DataProtection|IDataProtector|Protect\(|Unprotect\(" -Recurse

# Input validation patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "\[Required\]|\[StringLength\]|\[RegularExpression\]|ModelState\.IsValid" -Recurse
```

### 🚀 **Analysis 4: Business Critical Journeys (04_business_critical_journeys.md)**

**Template**: `templates/04_business_critical_journeys_template.md`
**Focus**: Business process flows and critical user journeys

#### Analysis Scope
- **API Workflow Mapping**: Identify sequential API call patterns
- **User Journey Analysis**: Map user interactions and business processes
- **Critical Path Identification**: Revenue-generating and customer-critical workflows
- **Integration Dependencies**: External service dependencies and failure points
- **Business Impact Assessment**: Risk analysis for system failures

#### Journey Identification Patterns
```powershell
# Critical business operations
Select-String -Path "repositories\{repo}\*.cs" -Pattern "order|purchase|payment|checkout|registration|login" -Recurse -CaseSensitive:$false

# Controller dependencies and workflow chains
Select-String -Path "repositories\{repo}\*.cs" -Pattern "redirect.*action|return.*view.*|await.*service\." -Recurse

# External integration points
Select-String -Path "repositories\{repo}\*.cs" -Pattern "httpclient|webclient|api.*client|third.*party" -Recurse -CaseSensitive:$false

# Transaction and unit of work patterns
Select-String -Path "repositories\{repo}\*.cs" -Pattern "transaction|commit|rollback|unit.*of.*work" -Recurse -CaseSensitive:$false
```

## Execution Framework

### Phase 1: Analysis Selection and Setup
1. **Command Parsing**: Determine which analyses to execute
2. **Repository Validation**: Confirm access to source repository
3. **Output Preparation**: Create necessary folders and files
4. **Context Gathering**: Collect repository metadata and structure

### Phase 2: Individual Analysis Execution

#### Overview Analysis Execution
```powershell
if ($analysisType -eq "overview" -or $analysisType -eq "all") {
    # Business domain discovery
    $domains = Get-BusinessDomains -RepoPath $repoPath

    # Entity model analysis
    $entities = Get-BusinessEntities -RepoPath $repoPath

    # README and documentation analysis
    $businessContext = Get-BusinessContext -RepoPath $repoPath

    # Generate overview document
    Generate-OverviewDocument -Domains $domains -Entities $entities -Context $businessContext
}
```

#### Technical Details Execution
```powershell
if ($analysisType -eq "technical" -or $analysisType -eq "all") {
    # Architecture pattern detection
    $architecturePatterns = Detect-ArchitecturePatterns -RepoPath $repoPath

    # Technology stack analysis
    $techStack = Analyze-TechnologyStack -RepoPath $repoPath

    # Security implementation review
    $securityPatterns = Analyze-SecurityPatterns -RepoPath $repoPath

    # Generate technical details document
    Generate-TechnicalDocument -Architecture $architecturePatterns -TechStack $techStack -Security $securityPatterns
}
```

#### Sensitive Data Analysis Execution
```powershell
if ($analysisType -eq "sensitive" -or $analysisType -eq "all") {
    # Sensitive data pattern scanning
    $sensitiveData = Scan-SensitiveDataPatterns -RepoPath $repoPath

    # Security implementation review
    $securityControls = Analyze-SecurityControls -RepoPath $repoPath

    # Compliance assessment
    $complianceFindings = Assess-ComplianceRequirements -SensitiveData $sensitiveData

    # Generate sensitive data analysis document
    Generate-SensitiveDataDocument -Data $sensitiveData -Controls $securityControls -Compliance $complianceFindings
}
```

#### Business Journey Analysis Execution
```powershell
if ($analysisType -eq "journey" -or $analysisType -eq "all") {
    # Critical business process identification
    $businessProcesses = Identify-BusinessProcesses -RepoPath $repoPath

    # API workflow mapping
    $apiWorkflows = Map-ApiWorkflows -RepoPath $repoPath

    # Integration dependency analysis
    $dependencies = Analyze-IntegrationDependencies -RepoPath $repoPath

    # Generate business journey document
    Generate-BusinessJourneyDocument -Processes $businessProcesses -Workflows $apiWorkflows -Dependencies $dependencies
}
```

### Phase 3: Cross-Analysis Integration

#### Data Correlation
- **Security and Business**: Link sensitive data findings with business processes
- **Technical and Journey**: Connect architecture patterns with user workflows
- **Overview and Technical**: Align business domains with technical implementation

#### Consistency Validation
- **Domain Alignment**: Ensure business domains consistent across analyses
- **Technology Consistency**: Verify technical findings align across documents
- **Reference Accuracy**: Validate cross-document references and citations

### Phase 4: Summary and Reporting

#### Analysis Execution Summary
```powershell
$summary = @{
    "Requested_Analyses" = $requestedAnalyses
    "Completed_Analyses" = $completedAnalyses
    "Files_Generated" = $generatedFiles
    "Analysis_Duration" = $executionTime
    "Key_Findings" = $keyFindings
    "Recommendations" = $recommendations
}

Generate-ExecutionSummary -Summary $summary -OutputPath "analysis\{repo}\analysis_execution_summary.md"
```

## Error Handling and Fallbacks

### Missing Repository Context
- **Limited Documentation**: Work with available code and structure
- **README Missing**: Extract context from code comments and structure
- **Access Restrictions**: Document limitations and provide partial analysis

### Insufficient Data for Analysis
- **Sparse Codebase**: Focus on available patterns and structure
- **Legacy Code**: Adapt analysis for older .NET patterns
- **Incomplete Projects**: Document findings with confidence levels

### Template Processing Issues
- **Missing Templates**: Use generic analysis structure
- **Variable Substitution**: Handle missing data gracefully
- **Formatting Problems**: Ensure valid Markdown output

## Performance Optimizations

### Selective Analysis Execution
```powershell
# Only execute requested analyses
$analysisMap = @{
    "overview" = { Execute-OverviewAnalysis }
    "technical" = { Execute-TechnicalAnalysis }
    "sensitive" = { Execute-SensitiveDataAnalysis }
    "journey" = { Execute-BusinessJourneyAnalysis }
}

foreach ($analysis in $requestedAnalyses) {
    & $analysisMap[$analysis]
}
```

### Parallel Processing for "All Analysis"
```powershell
if ($analysisType -eq "all") {
    # Execute all analyses in parallel
    $jobs = @(
        Start-Job -ScriptBlock { Execute-OverviewAnalysis }
        Start-Job -ScriptBlock { Execute-TechnicalAnalysis }
        Start-Job -ScriptBlock { Execute-SensitiveDataAnalysis }
        Start-Job -ScriptBlock { Execute-BusinessJourneyAnalysis }
    )

    Wait-Job $jobs
    Receive-Job $jobs
}
```

## Success Criteria

A successful execution should:
1. **Requested Analysis Completion**: All requested analyses completed successfully
2. **Quality Documentation**: All generated documents follow templates and contain meaningful insights
3. **Consistency**: Cross-analysis consistency and reference accuracy
4. **Business Value**: Actionable insights for stakeholders and decision-makers
5. **Technical Accuracy**: Correct identification of patterns and implementations

## Integration Points

### Input Dependencies
- **Optional Enhancement**: Can use endpoint inventory for better business journey analysis
- **Repository Access**: Requires source code access for analysis

### Output Usage
- **Strategic Planning**: Provides business and technical insights for decision-making
- **Security Assessment**: Identifies security and compliance considerations
- **Architecture Review**: Documents current state for improvement planning

## Template Dependencies

### Required Templates
- `templates/01_overview_template.md`
- `templates/02_technical_details_template.md`
- `templates/03_sensitive_data_template.md`
- `templates/04_business_critical_journeys_template.md`
- `templates/analysis_execution_summary_template.md`

This workflow provides flexible, granular analysis capabilities while maintaining comprehensive insights for complete repository understanding.