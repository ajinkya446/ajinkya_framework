# Deployment Guide

**Complete Instructions for Building and Deploying Ajinkya Framework**

---

## Table of Contents

1. [Pre-Deployment Setup](#pre-deployment-setup)
2. [Android Deployment](#android-deployment)
3. [iOS Deployment](#ios-deployment)
4. [Web Deployment](#web-deployment)
5. [Release Management](#release-management)
6. [Post-Deployment](#post-deployment)

---

## Pre-Deployment Setup

### 1. Version Management

Update the version in `pubspec.yaml`:
```yaml
version: 1.0.0+1  # format: version_number+build_number
```

### 2. Generate Changelog

Create/Update `CHANGELOG.md`:
```markdown
## [1.0.0] - 2026-02-28

### Added
- Initial framework release
- Multi-platform support

### Changed
- Improved performance

### Fixed
- Bug fixes from beta testing
```

### 3. Environment Configuration

Create `.env` files for different environments:
```bash
# .env.development
API_BASE_URL=https://dev-api.example.com
LOG_LEVEL=DEBUG

# .env.staging
API_BASE_URL=https://staging-api.example.com
LOG_LEVEL=INFO

# .env.production
API_BASE_URL=https://api.example.com
LOG_LEVEL=ERROR
```

### 4. Pre-Deployment Checklist

- [ ] All tests passing: `flutter test`
- [ ] Code analysis clean: `flutter analyze`
- [ ] Version updated in pubspec.yaml
- [ ] CHANGELOG.md updated
- [ ] All dependencies up to date
- [ ] Screenshots/docs updated
- [ ] Security audit completed
- [ ] Performance profiling done

---

## Android Deployment

### 1. Generate Signing Key

```bash
# Generate keystore (first time only)
keytool -genkey -v -keystore ~/key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias key -storepass password -keypass password
```

### 2. Configure Signing

Create/Update `android/key.properties`:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=key
storeFile=/path/to/key.jks
```

Update `android/app/build.gradle.kts`:
```kotlin
android {
    signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = file(keystoreProperties['storeFile'])
            storePassword = keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.release
        }
    }
}
```

### 3. Build APK

```bash
# Build APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### 4. Build App Bundle (Recommended for Play Store)

```bash
# Build App Bundle
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### 5. Upload to Play Store

1. Go to [Google Play Console](https://play.google.com/console)
2. Create/select app
3. Navigate to Release → Production
4. Upload AAB file
5. Add release notes
6. Review and publish

### 6. Verification

```bash
# Verify app signature
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk

# Test on device
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

---

## iOS Deployment

### 1. Update App Signing

Open `ios/Runner.xcworkspace` in Xcode:
1. Select Runner project
2. Select Runner target
3. Go to Signing & Capabilities
4. Select Team
5. Update Bundle Identifier

### 2. Build iOS App

```bash
# Build iOS release
flutter build ios --release

# Output: build/ios/iphoneos/Runner.app
```

### 3. Create Archive

```bash
# Using Flutter
flutter build ipa --release

# Output: build/ios/ipa/
```

### 4. Manual Archive (Alternative)

```bash
# Using Xcode command line
xcodebuild -workspace ios/Runner.xcworkspace \
  -scheme Runner -configuration Release \
  -derivedDataPath build/ios \
  -sdk iphoneos -ar arm64 archive
```

### 5. Upload to App Store

Using Xcode:
1. Open Xcode: `open ios/Runner.xcworkspace`
2. Product → Archive
3. Select archive
4. Validate App
5. Upload to App Store

Using Transporter:
```bash
# Export from Xcode and use Transporter app to upload
# Or use xcrun
xcrun altool --upload-app -f "app.ipa" \
  -t ios -u "apple-id@example.com" -p "app-specific-password"
```

### 6. Test Before Release

```bash
# Run tests on iOS
flutter test

# Test on simulator
flutter run -d "iPhone 15 Pro"

# Profile performance
flutter run --profile -d "iPhone 15 Pro"
```

---

## Web Deployment

### 1. Build Web App

```bash
# Build for web
flutter build web --release

# Output: build/web/
```

### 2. Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Initialize Firebase
firebase init hosting

# Configure public directory as 'build/web'

# Deploy
firebase deploy
```

### 3. Deploy to Other Platforms

#### Netlify
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod --dir build/web
```

#### Vercel
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

#### GitHub Pages
```bash
# Build app
flutter build web --release

# Push to gh-pages branch
git subtree push --prefix build/web origin gh-pages
```

### 4. Configure Web App

Update `web/index.html`:
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Ajinkya Framework App">
<title>Ajinkya Framework</title>
```

---

## Release Management

### 1. Create Release Branch

```bash
git checkout -b release/1.0.0 develop
```

### 2. Update Version and Changelog

```bash
# Update pubspec.yaml
version: 1.0.0+1

# Update CHANGELOG.md with release notes
```

### 3. Final Testing

```bash
# Run full test suite
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 4. Merge and Tag

```bash
# Commit version updates
git commit -m "chore: bump version to 1.0.0"

# Merge to main
git checkout main
git merge --no-ff release/1.0.0

# Create tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push changes
git push origin main develop --tags
```

### 5. Create GitHub Release

```bash
# Using GitHub CLI
gh release create v1.0.0 \
  --title "Version 1.0.0" \
  --notes "See CHANGELOG.md for details"
```

---

## Post-Deployment

### 1. Monitoring

- Monitor crash reports
- Track analytics
- Review user feedback
- Check performance metrics

### 2. Hotfix Process

If critical bugs are found:

```bash
# Create hotfix branch
git checkout -b hotfix/1.0.1 main

# Make fixes
# Update version to 1.0.1+2

# Create PR and merge to main and develop
# Create new release tag
```

### 3. Documentation Update

- Update README.md with release notes
- Add screenshots to documentation
- Update API documentation if needed
- Notify team and stakeholders

### 4. Archive Release

```bash
# Store build artifacts
gsutil cp build/app/outputs/flutter-apk/app-release.apk \
  gs://your-bucket/releases/v1.0.0/

gsutil cp build/ios/ipa/*.ipa \
  gs://your-bucket/releases/v1.0.0/
```

---

## Troubleshooting

### Build Errors

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub upgrade

# Full rebuild
flutter build apk --release --verbose
```

### Signing Issues (Android)

```bash
# Verify keystore
keytool -list -v -keystore ~/key.jks

# Remove old signing configuration
rm -rf build/
flutter clean
```

### Code Signing Issues (iOS)

```bash
# Verify certificate
security find-identity -v -p codesigning

# Refresh provisioning profiles
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles/
```

### Deployment Failures

1. Check internet connection
2. Verify credentials
3. Check storage quota
4. Review API rate limits
5. Check platform maintenance status

---

## Deployment Checklist

### Pre-Release
- [ ] Version number updated
- [ ] CHANGELOG.md updated
- [ ] All tests passing
- [ ] Code analysis clean
- [ ] Security audit completed
- [ ] Performance verified

### Release
- [ ] Build successful for all platforms
- [ ] Signing/certificates configured
- [ ] Upload to stores completed
- [ ] Release notes published

### Post-Release
- [ ] Monitor crash reports
- [ ] Check analytics
- [ ] Verify functionality on devices
- [ ] Document release
- [ ] Notify stakeholders

---

## Support

For deployment issues:
- Check [Troubleshooting](#troubleshooting) section
- Review platform-specific documentation
- Contact deployment team
- Check GitHub issues for similar problems

**Last Updated:** February 28, 2026
