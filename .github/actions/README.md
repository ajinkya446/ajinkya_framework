# GitHub Actions

This directory contains custom GitHub Actions for the ajinkya_framework project.

## Overview

Custom actions allow you to create reusable steps for your workflows. Each action should have:
- `action.yml` - Action metadata and inputs/outputs
- Supporting scripts or Docker configuration

## Structure

```
actions/
├── action-name/
│   ├── action.yml
│   ├── index.js (or other implementation)
│   └── README.md
```

## Example Usage in Workflows

```yaml
- uses: ./.github/actions/action-name
  with:
    input-param: value
```

## Creating New Actions

1. Create a new directory with a descriptive name
2. Add `action.yml` with proper metadata
3. Implement the action logic
4. Document in a README.md file

For more information, see: https://docs.github.com/en/actions/creating-actions
