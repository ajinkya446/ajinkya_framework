# Quick Start Guide

**For Developers Getting Started with Ajinkya Framework**

---

## 5-Minute Quick Start

### 1. Clone & Setup (2 minutes)
```bash
git clone https://github.com/ajinkya446/ajinkya_framework.git
cd ajinkya_framework
git checkout develop
flutter pub get
```

### 2. Verify Installation (1 minute)
```bash
flutter doctor
flutter test
```

### 3. Run the App (2 minutes)
```bash
flutter run
# or for specific platform:
flutter run -d ios      # iOS
flutter run -d android  # Android
flutter run -d chrome   # Web
```

---

## Project Structure Overview

```
lib/
├── main.dart           # App entry point
├── config/             # App configuration
├── features/           # Feature modules
├── core/               # Shared utilities
└── providers/          # State management
```

---

## Common Commands

### Development
```bash
flutter run                    # Run app
flutter run --debug           # Debug mode
flutter run --release         # Release mode
flutter pub get               # Get dependencies
flutter pub upgrade           # Upgrade packages
flutter clean                 # Clean build
```

### Testing & Quality
```bash
flutter test                  # Run all tests
flutter test --coverage       # Generate coverage
flutter analyze               # Lint code
flutter format lib/           # Format code
```

### Building
```bash
flutter build apk             # Android APK
flutter build appbundle       # Android App Bundle
flutter build ios             # iOS build
flutter build web             # Web build
```

---

## Development Workflow

### Creating a New Feature
1. Create feature folder: `lib/features/feature_name/`
2. Structure: `presentation/`, `domain/`, `data/`
3. Write domain layer first (business logic)
4. Implement data layer (API/DB)
5. Create presentation layer (UI)
6. Write tests for each layer

### Branching Strategy
- `main`: Production ready
- `develop`: Development branch
- `feature/*`: Feature branches
- `hotfix/*`: Bug fix branches

### Pull Request Process
1. Create branch from `develop`
2. Make changes and write tests
3. Push and create PR
4. Get code review
5. Merge after approval

---

## Key Packages Used

| Package | Purpose | Version |
|---------|---------|---------|
| flutter_bloc | State management | ^8.0.0 |
| provider | State management | ^6.0.0 |
| http | API calls | ^1.0.0 |
| hive | Local storage | ^2.0.0 |
| get_it | Service locator | ^7.0.0 |
| equatable | Value equality | ^2.0.0 |
| mockito | Testing | ^5.0.0 |

---

## Useful Links

- [Framework Overview](./FRAMEWORK_OVERVIEW.md) - Detailed documentation
- [Deployment Guide](./DEPLOYMENT_GUIDE.md) - Build and deploy instructions
- [GitHub Repository](https://github.com/ajinkya446/ajinkya_framework)
- [Flutter Docs](https://flutter.dev/docs)

---

## Getting Help

- Check [Framework Overview](./FRAMEWORK_OVERVIEW.md) Troubleshooting section
- Review existing code examples in features/
- Ask in team Slack channel
- Create GitHub issue for bugs
