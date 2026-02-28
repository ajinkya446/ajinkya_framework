# GitHub Workspace Instructions

This workspace contains all GitHub-related configurations, actions, workflows, and documentation for the ajinkya_framework project.

## Directory Structure

### `.github/actions/`
Custom GitHub Actions for CI/CD pipelines. Place reusable action definitions here.
- Contains action.yml files and supporting scripts
- Used by workflows for automated testing, building, and deployment

### `.github/prompts/`
AI/Copilot prompts and templates for development.
- Contains prompt templates for code generation
- Copilot-specific configurations
- Development guidelines and best practices

### `.github/workflow/`
GitHub Actions workflows for automated processes.
- CI/CD pipelines (testing, linting, building)
- Deployment workflows
- Release automation
- Scheduled jobs

### `.github/confluence/`
Confluence documentation and integration files.
- Confluence space documentation
- API integration scripts
- Knowledge base synchronization

## Getting Started

1. **Actions**: Add custom actions in the `actions/` folder with proper action.yml descriptors
2. **Workflows**: Create workflow files (*.yml) in the `workflow/` folder
3. **Prompts**: Add Copilot/AI prompts in the `prompts/` folder
4. **Confluence**: Maintain documentation sync in the `confluence/` folder

## Best Practices

- Keep workflow files modular and reusable
- Document all custom actions thoroughly
- Version control all configurations
- Test workflows in draft/development branches before merging to main
- Keep Confluence documentation in sync with codebase changes

## Contributing

When adding new workflows or actions:
1. Create in the appropriate subdirectory
2. Add corresponding documentation
3. Test thoroughly before committing
4. Include inline comments for complex logic
5. Update this instructions file if adding new sections
