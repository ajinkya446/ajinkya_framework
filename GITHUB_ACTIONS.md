# GitHub Actions Workflows Documentation

## Overview
This repository uses GitHub Actions to automate code quality checks, testing, and building across all supported platforms.

## Workflows

### 1. **Develop Branch Build & Test** (`develop-build.yml`)
**Trigger**: Pushes to `develop` branch and pull requests to `develop`

**Jobs** (in order):
1. **Static Analysis & Linting** (Ubuntu)
   - Runs `flutter analyze --fatal-warnings --fatal-infos`
   - Fails on any warnings or unused code
   
2. **Unit & Widget Tests** (Ubuntu)
   - Runs all tests with coverage
   - Generates coverage reports

3. **Platform Builds** (parallel after analysis & test pass):
   - **Web** (Ubuntu)
   - **Android** (Ubuntu with Java 11)
   - **iOS** (macOS)
   - **macOS** (macOS)
   - **Windows** (Windows)
   - **Linux** (Ubuntu with required dependencies)

4. **Success Gate**
   - Confirms all builds completed successfully

### 2. **Pull Request Checks** (`pr-checks.yml`)
**Trigger**: PR creation and updates to any branch

**Jobs** (faster validation for PRs):
1. **Static Analysis & Linting** (Ubuntu)
2. **Unit & Widget Tests** (Ubuntu)
3. **Quick Build (Web)** - Fast verification without all platforms
4. **Success Gate**

## Scripts

Located in `/scripts/`:

### `analyze.sh`
```bash
bash scripts/analyze.sh
```
Runs Flutter static analysis with strict rules:
- Treats warnings as errors
- Detects unused code, imports, and variables
- Enforces code quality standards

### `test.sh`
```bash
bash scripts/test.sh
```
Runs all unit and widget tests with coverage reports.

### `build.sh`
```bash
bash scripts/build.sh <platform>
```
Builds for specified platform. Supported platforms:
- `web` - Web release build
- `android` - Android APK release build
- `ios` - iOS release build (no code signing)
- `macos` - macOS release build
- `windows` - Windows release build
- `linux` - Linux release build

## Code Quality Standards

### Analysis Options (`analysis_options.yaml`)
- **Strict error rules**: unused code, missing returns, unreachable code
- **Comprehensive linting**: 100+ lint rules enabled
- **Flutter best practices**: Material Design, key usage, etc.

### What Fails the Build
- ❌ Unused imports
- ❌ Unused variables or functions
- ❌ Unused fields
- ❌ Missing return statements
- ❌ Dead code
- ❌ Any warning from flutter analyze
- ❌ Test failures
- ❌ Build failures on any platform

## Local Development

### Run all checks locally
```bash
# Analysis
bash scripts/analyze.sh

# Tests
bash scripts/test.sh

# Build specific platform
bash scripts/build.sh web
bash scripts/build.sh android
bash scripts/build.sh ios
```

### Fixing Common Issues

**Unused imports**:
```dart
// Remove: import 'package:unused/unused.dart';
```

**Unused variables**:
```dart
// Before
void example() {
  final unused = 42;  // ❌ Unused local variable
}

// After
void example() {
  final value = 42;
  print(value);
}
```

**Unused function parameters**:
```dart
// Before
void callback(String unused) {  // ❌ Unused parameter
  print('done');
}

// After - Option 1: Use it
void callback(String value) {
  print('Called with: $value');
}

// After - Option 2: Prefix with underscore
void callback(String _) {
  print('done');
}
```

## Environment

- **Flutter Version**: 3.x
- **Dart SDK**: ^3.11.0
- **Runners**:
  - Ubuntu (for web, Android, Linux)
  - macOS (for iOS, macOS)
  - Windows (for Windows)

## Dependencies Cached
- Flutter SDK
- Pub packages
- Build artifacts (reduced build time)

## Next Steps

1. Create branch protection rules for `develop`:
   - Require status checks to pass
   - Require PR reviews
   - Dismiss stale reviews on push

2. Monitor workflow runs in GitHub Actions tab

3. Fix any failures immediately to keep `develop` stable

## Disabling/Modifying Workflows

To temporarily disable a workflow, commit changes to:
- Comment out jobs in workflow files
- Or add `if: false` condition to jobs

Example:
```yaml
jobs:
  analyze:
    if: false  # Temporarily disabled
    runs-on: ubuntu-latest
```

## Troubleshooting

**Workflow shows as failing**:
1. Check the failing job logs in Actions tab
2. Run the same script locally: `bash scripts/analyze.sh`
3. Fix the issues locally, test, then commit

**Build takes too long**:
- Ensure you have Flutter cache enabled
- Check runner availability (macOS runners may have queue)
- Consider splitting builds into separate workflows

**Need to update Flutter version**:
- Edit workflow files and change `flutter-version: '3.x'` to desired version
- Test locally first with `flutter --version`
