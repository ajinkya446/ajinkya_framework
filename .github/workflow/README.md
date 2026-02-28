# Workflows

This directory contains GitHub Actions workflows for CI/CD pipelines and automated processes.

## Overview

Workflows automate tasks in your repository, such as:
- Continuous Integration (testing, linting)
- Continuous Deployment (building, releasing)
- Scheduled jobs (cleanup, reporting)
- Pull request automation

## Structure

Workflow files should be named with `.yml` or `.yaml` extension.

```
workflow/
├── ci.yml                  # Continuous Integration
├── deploy.yml              # Deployment pipeline
├── lint.yml                # Code quality checks
└── release.yml             # Release automation
```

## Workflow Template

```yaml
name: Workflow Name
on: [push, pull_request]

jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Step name
        run: echo "Hello World"
```

## Common Triggers

- `push` - Triggered on push events
- `pull_request` - Triggered on PR events
- `schedule` - Triggered on cron schedule
- `workflow_dispatch` - Manual trigger

For more information, see: https://docs.github.com/en/actions/using-workflows
