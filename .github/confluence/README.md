# Confluence Documentation

This directory manages documentation synchronization with Confluence and internal knowledge base.

## Overview

Confluence integration ensures:
- Documentation stays in sync with code
- Team knowledge is centralized
- Easy reference and collaboration
- Version control of documentation

## Structure

```
confluence/
├── spaces/
│   ├── development/
│   └── api-docs/
├── templates/
│   └── page-template.md
├── sync-config.yml
└── api-integration.md
```

## Content Organization

### Development Space
- Architecture decisions
- Setup guides
- Contributing guidelines
- Development workflows

### API Documentation
- Endpoint documentation
- Request/response examples
- Authentication details
- Error codes and handling

### Templates
- Standard page layouts
- Documentation templates
- Code snippet templates

## Sync Process

1. Update Markdown files in this directory
2. Run sync script to update Confluence
3. Review changes in Confluence UI
4. Commit changes to git

## Integration

- Uses Confluence REST API
- OAuth2 authentication
- Automated page creation/updates
- Version control maintained

## Best Practices

- Keep documentation in Markdown format
- Use consistent naming conventions
- Include metadata (authors, dates, status)
- Link to related pages
- Update regularly with code changes

## Reference Links

- [Confluence API Documentation](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/)
- [Markdown to Confluence Guide](https://confluence.atlassian.com/doc/markdown-macro-363175488.html)
