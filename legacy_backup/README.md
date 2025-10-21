# Legacy Backup Folder

This folder contains the original monolithic workflow files that have been replaced by the new decoupled mono-repo architecture.

## Contents

### `root_workflow_files/`
Original monolithic workflow files from the root directory:
- `workflow_1_find_apis.md` - Original Workflow 1 implementation
- `workflow_2_map_apis.md` - Original Workflow 2 implementation
- `workflow_3_endpoint_inventory.md` - Original Workflow 3 implementation
- `workflow_4_endpoint_documentation.md` - Original Workflow 4 implementation
- `workflow_5_repository_analysis.md` - Original Workflow 5 implementation

### `original_templates/`
Original centralized template folder containing all templates:
- Endpoint documentation templates (REST, WebForm, WCF, ASMX, etc.)
- Repository analysis templates (overview, technical, security, business)
- CSV templates for inventories and mappings

### `meta_prompts/`
Original meta-prompts and requirements files:
- System requirements and specifications
- Meta-prompt templates for AI instructions

### `docs/`
Original documentation files and migration artifacts:
- `user_runbook.md` - Original comprehensive user guide
- `MIGRATION_SUMMARY.md` - Documentation of the migration process
- `PROJECT_VERIFICATION.md` - Verification report of the cleanup process

## Migration Notes

These files have been **replaced** by the new decoupled architecture:

### Monolithic → Decoupled Mapping
- `workflow_orchestration.md` → Individual workflow READMEs
- `user_runbook.md` → Main README.md + individual workflow guides
- Root `workflow_*.md` files → `workflow-*-*/` folders with complete documentation
- Centralized `templates/` → Distributed to appropriate workflow folders
- `meta_prompts/` → Incorporated into individual `.github/copilot-instructions.md`

### What's Different in New Architecture
1. **Self-Contained Workflows**: Each workflow is now independent
2. **No Dependencies**: Workflows use context instead of file dependencies
3. **Focused Instructions**: Each workflow has specific AI instructions
4. **Better Performance**: Lighter execution with better quality
5. **Easier Maintenance**: Update workflows independently

## Restoration Process

If you need to restore the monolithic version:
1. Copy files from this backup folder back to root
2. Remove the new `workflow-*-*/` folders
3. Update the main README.md to point to monolithic structure

**Note**: The new decoupled architecture is recommended for better performance and maintainability.

---
*Backup created during migration to decoupled mono-repo architecture*