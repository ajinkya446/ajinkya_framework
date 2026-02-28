# Branch Protection Policy

**Effective Date:** February 28, 2026

---

## Overview

This document outlines the branch protection rules for the Ajinkya Framework repository. These rules ensure code quality, security, and controlled releases.

---

## Branch Protection Rules

### Master Branch (`main`)

#### Rule Summary
Direct pushes to the master branch are **prohibited**. All changes must come through Pull Requests from the develop branch.

#### Specific Rules

| Rule | Status | Details |
|------|--------|---------|
| **Require Pull Request** | ✅ Enabled | All changes require a PR |
| **Require Code Review** | ✅ Enabled | Minimum 1 approval required |
| **Dismiss Stale Reviews** | ✅ Enabled | Reviews become invalid if new commits added |
| **Enforce on Admins** | ✅ Enabled | Rules apply to everyone, including admins |
| **Force Push** | ❌ Disabled | Force pushes are NOT allowed |
| **Delete Branch** | ❌ Disabled | Branch cannot be deleted |
| **Require Status Checks** | ❌ Disabled | (Can be enabled later for CI/CD) |

---

## Workflow

### Standard Development Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                        │
└─────────────────────────────────────────────────────────────┘

    ┌──────────────────────┐
    │   Create Feature     │
    │   Branch from        │
    │   develop            │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Make Changes &     │
    │   Write Tests        │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Push to Feature    │
    │   Branch             │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Create Pull        │
    │   Request to         │
    │   develop branch     │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Code Review        │
    │   (1 approval)       │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Merge to develop   │
    │   (PR merge)         │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Prepare Release    │
    │   from develop       │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Create PR:         │
    │   develop → master   │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   Code Review        │
    │   (1 approval)       │
    └──────────────────────┘
              │
              ▼
    ┌──────────────────────┐
    │   ✅ Merge to master │
    │   Release!           │
    └──────────────────────┘
```

### Step-by-Step Instructions

#### 1. Create Feature Branch
```bash
# Update develop
git checkout develop
git pull origin develop

# Create feature branch from develop
git checkout -b feature/feature-name
```

#### 2. Make Changes & Commit
```bash
# Make your changes
git add .
git commit -m "feat: add new feature"

# Push to remote
git push -u origin feature/feature-name
```

#### 3. Create Pull Request to Develop
```bash
# Create PR using GitHub CLI
gh pr create --base develop --title "feat: add new feature" --body "Description of changes"

# Or create via GitHub web interface
```

#### 4. Get Code Review
- At least **1 approval** is required
- Address feedback and push updates if needed
- Reviewer must approve before merge

#### 5. Merge to Develop
```bash
# Merge PR using GitHub CLI
gh pr merge <pr-number> --merge

# Or merge via GitHub web interface
```

#### 6. Prepare Release (When Ready)
```bash
# Update version
# Update CHANGELOG.md
# Create release notes

git add pubspec.yaml CHANGELOG.md
git commit -m "chore: bump version to X.Y.Z"
git push origin develop
```

#### 7. Create PR from Develop to Master
```bash
# Create release PR
gh pr create \
  --base master \
  --head develop \
  --title "Release version X.Y.Z" \
  --body "Release notes and changelog summary"
```

#### 8. Merge to Master (Release)
```bash
# After approval, merge to master
gh pr merge <pr-number> --merge

# Create release tag
git tag -a vX.Y.Z -m "Release version X.Y.Z"
git push origin vX.Y.Z

# Deploy from master
```

---

## Branch Naming Conventions

### Feature Branches
```
feature/feature-name
feature/user-authentication
feature/dark-mode-support
```

### Bug Fix Branches
```
bugfix/bug-name
bugfix/login-crash
bugfix/api-timeout
```

### Hotfix Branches
```
hotfix/critical-bug
hotfix/security-vulnerability
```

### Release Branches
```
release/1.0.0
release/1.1.0
```

### Documentation Branches
```
docs/api-documentation
docs/setup-guide
```

---

## Rules Explanation

### Why These Rules?

#### 1. Require Pull Request
- **Benefit:** Ensures all code is reviewed before merging
- **Prevents:** Accidental or malicious code changes
- **Quality:** Maintains code standards

#### 2. Require Code Review (1 Approval)
- **Benefit:** At least one developer reviews the code
- **Catches:** Bugs, security issues, code style violations
- **Knowledge:** Team learns from each other

#### 3. Dismiss Stale Reviews
- **Benefit:** Reviews become invalid if new commits are pushed
- **Ensures:** Reviewer approves the final version of code
- **Prevents:** Old approvals on changed code

#### 4. Enforce on Admins
- **Benefit:** No one (including admins) can bypass rules
- **Ensures:** Consistent process for everyone
- **Accountability:** Equal standards for all contributors

#### 5. No Force Pushes
- **Benefit:** Prevents overwriting repository history
- **Ensures:** Commit history is reliable
- **Safety:** Can't accidentally delete commits

#### 6. No Branch Deletion
- **Benefit:** Master branch cannot be accidentally deleted
- **Safety:** Protection against human error
- **Reliability:** Always has a stable base

---

## FAQ

### Q: Can I push directly to master?
**A:** No. All changes must come through Pull Requests.

### Q: What if I'm an admin?
**A:** Rules apply to everyone, including admins.

### Q: Can I force push to master?
**A:** No. Force pushes are disabled on the master branch.

### Q: How do I release to production?
**A:** Create a PR from `develop` to `master`, get 1 approval, then merge.

### Q: What if I need to revert a commit?
**A:** Create a new PR that reverts the changes. Never force push.

### Q: Can I merge without approval?
**A:** No. At least 1 approval is required before merging.

### Q: What if multiple people work on the same feature?
**A:** Use a shared feature branch or multiple PRs to the main feature branch.

---

## Common Workflows

### Scenario 1: Regular Feature Development

```bash
# 1. Create feature branch from develop
git checkout -b feature/new-widget develop

# 2. Make changes and push
git push -u origin feature/new-widget

# 3. Create PR (gh pr create or web interface)

# 4. Get approval from team member

# 5. Merge to develop
gh pr merge --merge

# 6. Delete feature branch
git push origin --delete feature/new-widget
```

### Scenario 2: Bug Fix

```bash
# 1. Create bugfix branch from develop
git checkout -b bugfix/crash-fix develop

# 2. Fix the bug and test
git push -u origin bugfix/crash-fix

# 3. Create PR with description of fix

# 4. Get code review and approval

# 5. Merge to develop
gh pr merge --merge
```

### Scenario 3: Release Management

```bash
# 1. Prepare on develop branch
# - Update version in pubspec.yaml
# - Update CHANGELOG.md
git push origin develop

# 2. Create release PR: develop → master
gh pr create --base master --head develop --title "Release v1.0.0"

# 3. Get approval for release

# 4. Merge to master
gh pr merge --merge

# 5. Create release tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# 6. Deploy from master
# Run deployment pipeline
```

### Scenario 4: Hotfix (Critical Bug in Production)

```bash
# 1. Create hotfix branch from master
git checkout -b hotfix/security-patch master

# 2. Fix critical issue and test thoroughly
git push -u origin hotfix/security-patch

# 3. Create PR to master with detailed explanation

# 4. Get urgent approval

# 5. Merge to master and create hotfix tag
gh pr merge --merge
git tag -a v1.0.1-hotfix -m "Security hotfix"

# 6. Also merge back to develop
git checkout develop
git pull origin develop
git merge master
git push origin develop
```

---

## Tools & Commands Reference

### GitHub CLI Commands

```bash
# Create a pull request
gh pr create --base <base-branch> --title "PR title" --body "Description"

# List pull requests
gh pr list

# View a pull request
gh pr view <pr-number>

# Check out a pull request
gh pr checkout <pr-number>

# Merge a pull request
gh pr merge <pr-number> --merge

# Close a pull request
gh pr close <pr-number>

# Add a review
gh pr review <pr-number> --approve
gh pr review <pr-number> --request-changes
```

### Git Commands

```bash
# Create and switch to feature branch
git checkout -b feature/name develop

# Push branch to remote
git push -u origin feature/name

# Update branch with latest develop
git fetch origin
git rebase origin/develop

# Delete local branch
git branch -d feature/name

# Delete remote branch
git push origin --delete feature/name

# Create and push tag
git tag -a v1.0.0 -m "Release message"
git push origin v1.0.0
```

---

## Enforcement & Violations

### What Happens If Rules Are Broken?

#### Attempted Direct Push to Master
```bash
$ git push origin master
remote: error: GH006: Protected branch rule violations found on refs/heads/master.
remote: error: At least 1 approving review is required by reviewers with write access.
```

#### Attempted Force Push
```bash
$ git push -f origin master
remote: error: GH006: You cannot force push to a protected branch
```

#### Branch Deletion Attempt
```bash
$ git push origin --delete master
remote: error: GH006: Protected branch rule violations found on refs/heads/master.
```

---

## Governance & Changes

### Reviewing This Policy

This policy is reviewed:
- **Quarterly:** Formal review with team
- **As-needed:** When issues arise
- **Annually:** Full audit and update

### Proposing Changes

1. Discuss in team meeting
2. Create issue for discussion
3. Document proposed changes
4. Get team consensus
5. Update this document
6. Inform all team members

### Exemptions

Exemptions to this policy are rare and require:
1. Documented business case
2. Approval from project lead
3. Security review (if applicable)
4. Temporary duration with expiration date
5. Communication to team

---

## Support

For questions about branch protection:
- **Slack:** #ajinkya-framework
- **Email:** development-team@example.com
- **GitHub Issues:** [Report issues](https://github.com/ajinkya446/ajinkya_framework/issues)

---

## Related Documents

- [Development Guide](./confluence/FRAMEWORK_OVERVIEW.md)
- [Git Workflow](./confluence/FRAMEWORK_OVERVIEW.md#git-workflow)
- [Deployment Guide](./confluence/DEPLOYMENT_GUIDE.md)

---

**Document Owner:** Development Team  
**Last Updated:** February 28, 2026  
**Status:** Active
