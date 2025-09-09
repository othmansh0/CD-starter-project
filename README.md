# iOS CI/CD Starter Project

A production-ready iOS CI/CD pipeline demonstrating automated testing and TestFlight deployment using GitHub Actions and Fastlane.

## 🎯 **Main Features**

- **Comment-Triggered Builds** - Deploy with `/build` comments on PRs
- **Automated Testing** - Unit tests run on every PR to develop
- **TestFlight Integration** - Direct uploads with auto-distribution to internal testers
- **Smart Build Management** - Automatic build number increment with conflict resolution
- **Flexible Code Signing** - Supports both Match (team) and manual certificate workflows
- **Real-Time Status** - Emoji reactions show build progress (👀 → 🚀/😞)
- **Export Compliance** - Automatic handling, no manual submission needed

## ⚙️ **Tech Stack**

- **CI/CD**: GitHub Actions
- **Build Automation**: Fastlane 2.228.0
- **iOS**: Xcode 16.x, iOS 16.0+ deployment target
- **Language**: Swift 5.0, Ruby 3.2

## 🔄 **Workflows**

### 1. Testing Workflow (`testing_workflow.yaml`)
- **Trigger**: PRs to `develop` branch + manual dispatch
- **Actions**: Checkout → Setup Xcode → Install dependencies → Run tests
- **Job Name**: `test` (referenced by build workflow)

### 2. Build Workflow (`build-on-comment.yml`)  
- **Trigger**: `/build` comments on PRs
- **Validations**: Branch check (develop/feature/*) + test status verification
- **Actions**: Build → Sign → Upload to TestFlight
- **Status**: Real-time emoji reactions on comments

## 📈 **Build Process Flow**

```
PR Comment: /build
    ↓
👀 Building (emoji reaction)
    ↓
Branch Validation (develop/feature/* only)
    ↓
Test Status Check (must not be failed)
    ↓
Environment Setup (Xcode, Ruby, Fastlane)
    ↓
Code Signing (certificates + provisioning profiles)
    ↓
Build Archive (Release configuration)
    ↓
TestFlight Upload (with changelog)
    ↓
🚀 Success / 😞 Failure (emoji reaction)
```

## 🚀 **Quick Start**

### 1. Prerequisites
- Active Apple Developer Program membership
- App Store Connect access (Developer role minimum)
- GitHub repository with Actions enabled

### 2. Required Secrets

Add to **Settings → Secrets → Actions**:

```bash
# App Store Connect API
API_KEY_ID=XXXXXXXXXX          # App Store Connect API Key ID
API_ISSUER_ID=xxxxxxxx-xxxx    # App Store Connect Issuer ID  
API_KEY_BASE64=LS0tLS1CRUd...  # Base64 encoded .p8 file

# Apple Developer Account
DEVELOPMENT_TEAM=XXXXXXXXXX    # Apple Developer Team ID
FASTLANE_USERNAME=you@email.com # Apple ID email

# Code Signing
DISTRIBUTION_CERTIFICATE=MII... # Base64 encoded .p12 certificate
DISTRIBUTION_PASSWORD=password  # Certificate password
APP_STORE_PROFILE_BASE64=MII... # Base64 encoded provisioning profile
```

### 3. API Key Setup Steps
1. Visit [App Store Connect](https://appstoreconnect.apple.com) → Users and Access → Keys
2. Create new key with **Developer** role
3. Download `.p8` file  
4. Convert to Base64: `base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
5. Add to GitHub secrets as `API_KEY_BASE64`

### 4. Usage
1. Create PR to `develop` branch (tests run automatically)
2. Comment `/build` on PR (triggers TestFlight deployment)
3. Monitor emoji reactions: 👀 (building) → 🚀 (success) / 😞 (failed)

## 🏗️ **Project Structure**

```
├── .github/workflows/
│   ├── testing_workflow.yaml      # Automated testing on PRs
│   └── build-on-comment.yml       # Comment-triggered builds
├── fastlane/
│   ├── Fastfile                   # Build automation logic
│   ├── Appfile                    # App configuration
│   ├── Matchfile                  # Certificate management (optional)
│   └── template.env               # Environment variables template
├── CD starter project/            # iOS app source code
├── CD starter projectTests/       # Unit tests
├── CD-starter-project-Info.plist  # Export compliance configuration
├── Gemfile                        # Ruby dependencies
└── .gitignore                     # Comprehensive exclusions
```

## 🔧 **Fastlane Configuration**

### Available Lanes
- `fastlane test` - Run unit tests locally
- `fastlane build_and_upload` - Build and upload to TestFlight

### Key Features
- **Dual Certificate Support**: Match (team sharing) or manual (individual)
- **Build Number Management**: Fetches latest from TestFlight and increments
- **Error Handling**: Graceful handling of build number conflicts
- **CI Optimization**: Temporary keychain management for secure builds

## 💻 **Local Development**

### Setup
```bash
# Clone repository
git clone <your-repo-url>
cd <project-directory>

# Install dependencies
bundle install

# Run tests
bundle exec fastlane test
```

### Xcode Project
- Open `CD starter project.xcodeproj`
- Build and run on simulator/device
- Tests located in `CD starter projectTests/`

## 🔒 **Security & Best Practices**

- ✅ All secrets encrypted in GitHub
- ✅ Temporary file cleanup after builds  
- ✅ Proper keychain management in CI
- ✅ No sensitive data in logs
- ✅ Branch protection with test validation
- ✅ Comprehensive .gitignore for iOS projects

## ⚠️ **Important Notes**

- Only `develop` and `feature/*` branches can trigger builds
- Tests must not be in failed state to proceed with builds
- Build numbers are automatically incremented from TestFlight
- Internal testers receive builds automatically; external testers require manual distribution
