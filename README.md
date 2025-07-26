# CD Starter Project

A production-ready iOS calculator app with fully automated CI/CD pipeline for TestFlight deployment.

## 🚀 CI/CD Pipeline

This project demonstrates a **complete, working iOS CI/CD setup** using GitHub Actions and Fastlane. The pipeline is clean, battle-tested, and production-ready.

### ✅ **Key Features**

- **Automated TestFlight Distribution** - Works with Developer role permissions
- **Smart Build Number Management** - Automatic increment with conflict resolution
- **Flexible Certificate Management** - Supports both Match and manual certificates
- **Real-time Status Updates** - Emoji reactions on PR comments
- **Export Compliance Handling** - No manual compliance submission needed

## 📱 Usage

### Build Commands

Comment `/build` on any Pull Request to trigger a TestFlight build.

### Status Indicators

Real-time feedback through emoji reactions:
- 👀 **Building** - Build in progress
- 🚀 **Success** - Build uploaded to TestFlight
- 😞 **Failed** - Build failed (check logs)

## ⚙️ Setup

### 1. Apple Developer Account
- Active Apple Developer Program membership
- App Store Connect access
- **Developer role is sufficient** (Admin not required)

### 2. GitHub Secrets

Add these to your repository (Settings → Secrets → Actions):

```bash
# App Store Connect API Key (Required)
API_KEY_ID          # Your API Key ID
API_ISSUER_ID       # Your Issuer ID  
API_KEY_BASE64      # Base64 encoded .p8 file

# Apple Developer Account (Required)
DEVELOPMENT_TEAM    # Your Team ID
FASTLANE_USERNAME   # Your Apple ID email

# Code Signing (Required)
DISTRIBUTION_CERTIFICATE    # Base64 encoded .p12 certificate
DISTRIBUTION_PASSWORD       # Certificate password
APP_STORE_PROFILE_BASE64    # Base64 encoded provisioning profile

# Optional - For team certificate management
MATCH_GIT_URL       # Git repository for certificates
```

### 3. API Key Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com) → Users and Access → Keys
2. Create API Key with **Developer** role
3. Download `.p8` file
4. Base64 encode: `base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
5. Add to GitHub secrets as `API_KEY_BASE64`

## 🏗️ Architecture

### Workflows
- **`testing_workflow.yaml`** - Runs tests on PRs to develop
- **`build-on-comment.yml`** - Builds and deploys on `/build` comments

### Fastlane Lanes
- **`build_and_upload`** - Complete build and TestFlight upload
- **`test`** - Run unit tests

### Build Flow
```
/build comment → Setup Environment → Fetch Build Number → 
Code Signing → Build Archive → Upload to TestFlight → 
Internal Testers Auto-Access
```

## 💻 Local Development

### Requirements
- **Xcode 16.1+**
- **iOS 16.0+** deployment target
- **Ruby 3.2+** for Fastlane

### Quick Start
```bash
# Install dependencies
bundle install

# Run tests
bundle exec fastlane test

# Build for TestFlight (requires secrets)
bundle exec fastlane build_and_upload
```

## 📁 Project Structure

```
├── .github/workflows/          # CI/CD workflows
├── fastlane/                   # Build automation
│   ├── Fastfile               # Main build configuration
│   ├── Appfile                # App settings
│   └── template.env           # Environment template
├── CD starter project/         # iOS app source
└── .gitignore                 # Comprehensive exclusions
```

## 🔒 Security

- ✅ **Encrypted secrets** in GitHub
- ✅ **Temporary file cleanup** after builds
- ✅ **Proper keychain management** in CI
- ✅ **No sensitive data in logs**

## 🤝 Contributing

1. **Create feature branch** from `develop`
2. **Make changes** and add tests
3. **Create Pull Request**
4. **Test with `/build`** command
5. **Merge** when ready

---

**This setup is production-ready and battle-tested. Perfect for learning iOS CI/CD best practices.** 🎯