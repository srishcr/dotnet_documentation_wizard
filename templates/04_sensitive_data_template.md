# Sensitive Data APIs Analysis

**Project**: {PROJECT_NAME}
**Repository Path**: {REPOSITORY_PATH}
**Analysis Date**: {ANALYSIS_DATE}
**Purpose**: Identify APIs handling potentially sensitive data for business security review

## Overview

This document catalogs APIs that appear to handle sensitive data based on technical analysis of the codebase. The classifications are based on field names, data types, and patterns found in the code and should be reviewed by business stakeholders for accuracy and completeness.

## Data Sensitivity Classification

### Classification Methodology
The following patterns were used to identify potentially sensitive data:

- **PII (Personally Identifiable Information)**: Fields containing `email`, `phone`, `address`, `name`, `ssn`, `birth`, `id`
- **Financial Data**: Fields containing `card`, `payment`, `billing`, `price`, `amount`, `account`, `transaction`, `balance`
- **Authentication Data**: Fields containing `password`, `token`, `key`, `secret`, `credential`, `auth`
- **Confidential Business Data**: Fields containing `internal`, `admin`, `config`, `private`, `confidential`

## Sensitive Data APIs Inventory

### APIs Handling PII Data

| API Code | Endpoint | Method | Potential PII Fields | Controller | Purpose |
|----------|----------|---------|---------------------|------------|---------|
{PII_APIS_TABLE}

### APIs Handling Financial Data

| API Code | Endpoint | Method | Potential Financial Fields | Controller | Purpose |
|----------|----------|---------|---------------------------|------------|---------|
{FINANCIAL_APIS_TABLE}

### APIs Handling Authentication Data

| API Code | Endpoint | Method | Authentication Fields | Controller | Purpose |
|----------|----------|---------|----------------------|------------|---------|
{AUTH_APIS_TABLE}

### APIs Handling Confidential Business Data

| API Code | Endpoint | Method | Confidential Fields | Controller | Purpose |
|----------|----------|---------|---------------------|------------|---------|
{CONFIDENTIAL_APIS_TABLE}

## Analysis by Business Domain

### {DOMAIN_NAME_1}
**APIs Analyzed**: {DOMAIN_1_API_COUNT}
**Potentially Sensitive APIs**: {DOMAIN_1_SENSITIVE_COUNT}

#### Sensitive Data Patterns Found:
- {DOMAIN_1_PATTERN_1}
- {DOMAIN_1_PATTERN_2}

#### APIs Requiring Review:
{DOMAIN_1_SENSITIVE_APIS_LIST}

### {DOMAIN_NAME_2}
**APIs Analyzed**: {DOMAIN_2_API_COUNT}
**Potentially Sensitive APIs**: {DOMAIN_2_SENSITIVE_COUNT}

#### Sensitive Data Patterns Found:
- {DOMAIN_2_PATTERN_1}
- {DOMAIN_2_PATTERN_2}

#### APIs Requiring Review:
{DOMAIN_2_SENSITIVE_APIS_LIST}

## Technical Security Observations

### Authentication Patterns Found
- **Bearer Token Authentication**: {BEARER_TOKEN_APIS_COUNT} APIs
- **Cookie-based Authentication**: {COOKIE_AUTH_APIS_COUNT} APIs
- **Basic Authentication**: {BASIC_AUTH_APIS_COUNT} APIs
- **No Authentication Required**: {NO_AUTH_APIS_COUNT} APIs

### Authorization Patterns Observed
- **Role-based Access**: {ROLE_BASED_APIS_COUNT} APIs
- **Policy-based Access**: {POLICY_BASED_APIS_COUNT} APIs
- **Admin-only Access**: {ADMIN_ONLY_APIS_COUNT} APIs
- **Public Access**: {PUBLIC_ACCESS_APIS_COUNT} APIs

### Data Protection Mechanisms Found
- **Input Validation Attributes**: {VALIDATION_APIS_COUNT} APIs
- **Data Annotation Attributes**: {DATA_ANNOTATION_APIS_COUNT} APIs
- **Custom Validation Logic**: {CUSTOM_VALIDATION_APIS_COUNT} APIs

## Field-Level Analysis Summary

### Most Common Sensitive Field Types
1. **Email addresses**: Found in {EMAIL_FIELD_COUNT} APIs
2. **Phone numbers**: Found in {PHONE_FIELD_COUNT} APIs
3. **User names**: Found in {NAME_FIELD_COUNT} APIs
4. **Financial amounts**: Found in {AMOUNT_FIELD_COUNT} APIs
5. **Authentication tokens**: Found in {TOKEN_FIELD_COUNT} APIs

### Request vs Response Data
- **Sensitive data in requests**: {SENSITIVE_REQUEST_COUNT} APIs
- **Sensitive data in responses**: {SENSITIVE_RESPONSE_COUNT} APIs
- **Sensitive data in both**: {SENSITIVE_BOTH_COUNT} APIs

## Potential Compliance Considerations

### GDPR Relevance
**APIs potentially handling EU personal data**: {GDPR_RELEVANT_COUNT}

These APIs may require GDPR compliance review:
{GDPR_APIS_LIST}

### PCI-DSS Relevance
**APIs potentially handling payment card data**: {PCI_RELEVANT_COUNT}

These APIs may require PCI-DSS compliance review:
{PCI_APIS_LIST}

### Industry-Specific Data
**APIs handling potentially regulated data**: {REGULATED_DATA_COUNT}

{REGULATED_DATA_DETAILS}

## Risk Assessment Summary

### High-Risk API Characteristics
**APIs with multiple sensitive data types**: {MULTI_SENSITIVE_COUNT}
**Public APIs handling sensitive data**: {PUBLIC_SENSITIVE_COUNT}
**APIs with no authentication handling sensitive data**: {NO_AUTH_SENSITIVE_COUNT}

### Data Flow Patterns
**APIs accepting sensitive input**: {SENSITIVE_INPUT_COUNT}
**APIs returning sensitive output**: {SENSITIVE_OUTPUT_COUNT}
**APIs processing sensitive data internally**: {SENSITIVE_PROCESSING_COUNT}

## Recommendations for Business Review

### Immediate Review Required
The following APIs should be prioritized for business and security review:

1. **Public APIs handling potentially sensitive data**:
   {PUBLIC_SENSITIVE_APIS_LIST}

2. **APIs with no authentication handling sensitive data**:
   {NO_AUTH_SENSITIVE_APIS_LIST}

3. **APIs handling multiple types of sensitive data**:
   {MULTI_TYPE_SENSITIVE_APIS_LIST}

### Areas for Business Validation
1. **Data Classification Accuracy**: Verify that identified sensitive fields are actually sensitive in business context
2. **Access Control Requirements**: Review whether current authentication/authorization is appropriate
3. **Compliance Requirements**: Determine which regulations apply to identified data types
4. **Data Retention Policies**: Establish policies for sensitive data handling and retention
5. **Third-party Integration**: Review sensitive data sharing with external systems

## Technical Implementation Notes

### Detection Limitations
- Analysis based on field names and patterns; actual data content not examined
- Custom encryption or obfuscation may not be detected
- Business logic for data handling not fully analyzable from code structure
- Dynamic field mapping may not be captured

### False Positives Possible
- Fields named similarly to sensitive data but containing non-sensitive information
- Test or demo data that appears sensitive but isn't used in production
- Internal IDs or codes that match sensitive data patterns

### Recommended Next Steps
1. **Business stakeholder review** of identified APIs and data classifications
2. **Security team assessment** of authentication and authorization adequacy
3. **Compliance team review** of regulatory requirements
4. **Data governance policy** establishment for sensitive data handling

---
*This analysis is based on automated code inspection and should be validated by business and security stakeholders*
*Generated by .NET Documentation Wizard - Sensitive Data Analysis Module*
*Last Updated: {GENERATION_DATE}*