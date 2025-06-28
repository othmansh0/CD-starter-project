# CD Starter Project

A production-ready iOS calculator app with fully automated CI/CD pipeline for TestFlight deployment.

## Features

- Basic calculator operations (add, subtract, multiply, divide, power)
- Modern SwiftUI interface with emojis and styling
- **Fully automated CI/CD pipeline** with TestFlight integration
- **Comment-triggered builds** via GitHub Actions
- **Automatic TestFlight distribution** to internal testers
- **Export compliance handling** for seamless App Store submission

## iOS CI/CD Pipeline

This project demonstrates a **complete, working iOS CI/CD setup** using GitHub Actions and Fastlane. The pipeline has been battle-tested and includes solutions for common iOS deployment challenges.

### ✅ **Proven Solutions Included**

- **TestFlight Auto Distribution**: Fixed API key permission issues
- **Missing Compliance Resolution**: Automatic export compliance handling
- **Build Number Management**: Race condition protection with buffer system
- **Certificate Management**: Works with Developer role permissions
- **Branch Protection**: Comprehensive conflict resolution

### Build Commands

Comment on any Pull Request to trigger builds:

- **`/build`** - Full App Store build and upload to TestFlight
- **`/diagnostic`** - Development build to test CI pipeline
- **`/permissions`** - Test API key permissions and capabilities
- **`/setup`** - Create missing provisioning profiles
- **`/test`** - Test complete App Store pipeline without distribution
- **`/certificates`** - Check available certificates and signing identities

### Setup Requirements

#### 1. Apple Developer Account
- Active Apple Developer Program membership
- App Store Connect access
- **Developer role is sufficient** (Admin role not required)

#### 2. GitHub Secrets Configuration

Add these secrets to your repository (Settings → Secrets → Actions):

```bash
# Required - App Store Connect API Key
API_KEY_ID          # App Store Connect API Key ID
API_ISSUER_ID       # App Store Connect Issuer ID  
API_KEY_BASE64      # Base64 encoded .p8 file content

# Required - Apple Developer Account  
DEVELOPMENT_TEAM    # Apple Developer Team ID
FASTLANE_USERNAME   # Your Apple ID email

# Optional - For advanced certificate management
MATCH_GIT_URL       # Git repository for certificate storage
MATCH_PASSWORD      # Password for certificate encryption
```

#### 3. App Store Connect API Key Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to **Users and Access → Keys**
3. Create new API Key with **Developer** role (sufficient for uploads)
4. Download the `.p8` file
5. Base64 encode: `base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
6. Add to GitHub secrets as `API_KEY_BASE64`

> **Note**: Developer role works perfectly for TestFlight uploads. Admin role only needed for automatic external distribution (which we handle manually for better control).

### How It Works

#### 🚀 **Automated TestFlight Distribution**

Our setup uses **Almosafer's proven approach** for reliable TestFlight uploads:

```ruby
# Optimized for Developer API key permissions
testflight(
  username: ENV["FASTLANE_USERNAME"],
  skip_waiting_for_build_processing: true,
  changelog: "Automated build with latest features"
)
```

**Benefits:**
- ✅ **Internal testers** get automatic access
- ✅ **External testers** require manual approval (better control)
- ✅ **No API key permission errors**
- ✅ **Works with Developer role**

#### 🔧 **Build Number Management**

Intelligent build number handling with race condition protection:

```ruby
# Fetch latest + buffer for API delays
latest_build = latest_testflight_build_number()
new_build = latest_build + 2  # Buffer for race conditions
```

#### 📋 **Export Compliance Automation**

Automatic handling of export compliance to prevent "Missing Compliance" issues:

- **Custom Info.plist** with proper export compliance settings
- **`ITSAppUsesNonExemptEncryption = NO`** for non-encryption apps
- **Automatic TestFlight availability** without manual compliance submission

#### 🔐 **Smart Certificate Management**

Handles various certificate scenarios gracefully:

- **Match integration** for team certificate sharing
- **Manual certificate import** fallback
- **Development certificate auto-creation** in CI
- **Graceful permission handling** for different Apple Developer roles

### Architecture

#### Fastlane Lanes

| Lane | Purpose | When to Use |
|------|---------|-------------|
| `build_and_upload` | Complete App Store build → TestFlight | Production deployments |
| `diagnostic_dev_build` | Development build test | CI pipeline verification |
| `diagnostic_api_permissions` | API key capability check | Permission troubleshooting |
| `setup_profiles` | Create missing profiles | Initial setup or profile issues |
| `test` | Full pipeline test without upload | Pipeline validation |

#### Build Process Flow

```mermaid
graph TD
    A[PR Comment /build] --> B[Setup CI Environment]
    B --> C[Setup API Key]
    C --> D[Fetch Latest Build Number]
    D --> E[Add Race Condition Buffer]
    E --> F[Setup Code Signing]
    F --> G[Build Archive]
    G --> H[Export with Compliance]
    H --> I[Upload to TestFlight]
    I --> J[Auto-Available to Internal Testers]
```

### Troubleshooting

#### ✅ **Resolved Issues**

These common issues have been **permanently fixed** in our setup:

**❌ "Missing Compliance" Dialog**
- **Fixed**: Custom Info.plist with proper export compliance
- **Result**: Builds automatically available to testers

**❌ "Build number already exists"**
- **Fixed**: Race condition buffer (+2) and timestamp fallback
- **Result**: No more build number conflicts

**❌ "API key permission denied"**
- **Fixed**: Using `testflight()` instead of `upload_to_testflight()`
- **Result**: Works with Developer role permissions

**❌ "UserInterfaceState.xcuserstate conflicts"**
- **Fixed**: Comprehensive `.gitignore` for iOS projects
- **Result**: Clean PRs without merge conflicts

#### 🛠 **Diagnostic Commands**

If you encounter issues, use these commands to identify the problem:

```bash
# Test your API key permissions
/permissions

# Verify CI pipeline works (always succeeds)
/diagnostic  

# Test complete pipeline without upload
/test

# Create missing provisioning profiles
/setup

# Check available certificates
/certificates

# Full production build
/build
```

#### Permission Requirements

| Build Type | Required Role | Auto Distribution | Manual Distribution |
|------------|---------------|-------------------|-------------------|
| Development | Developer | ✅ Works | N/A |
| TestFlight Internal | Developer | ✅ Automatic | N/A |
| TestFlight External | Developer | ❌ Manual Only | ✅ App Store Connect |
| App Store | Developer | ❌ Manual Only | ✅ App Store Connect |

### Local Development

#### Quick Start
```bash
# Install dependencies
bundle install

# Test your setup
bundle exec fastlane diagnostic_api_permissions

# Build locally
bundle exec fastlane build_and_upload
```

#### Development Workflow
1. **Clone repository**
2. **Configure secrets** in GitHub
3. **Test with `/diagnostic`** comment on PR
4. **Deploy with `/build`** comment on PR

### Security & Best Practices

- ✅ **API keys encrypted** in GitHub secrets
- ✅ **Temporary file cleanup** after builds
- ✅ **No sensitive data logging**
- ✅ **Proper keychain management** in CI
- ✅ **Branch protection** with conflict resolution
- ✅ **Comprehensive `.gitignore** for iOS projects

### Project Structure

```
.
├── .github/workflows/
│   ├── build-on-comment.yml    # Comment-triggered builds
│   ├── ios-build-and-deploy.yml # Push-triggered builds
│   └── testing_workflow.yaml   # Automated testing
├── fastlane/
│   ├── Fastfile                # Build automation (battle-tested)
│   ├── Appfile                 # App configuration
│   └── template.env            # Environment template
├── CD starter project/         # iOS app source
├── CD-starter-project-Info.plist # Export compliance configuration
├── .gitignore                  # iOS-specific exclusions
└── README.md                   # This documentation
```

## Development

### Requirements
- **Xcode 16.1+**
- **iOS 16.0+** deployment target
- **Swift 5.9+**
- **Ruby 3.2+** for Fastlane

### Building Locally
1. Open `CD starter project.xcodeproj` in Xcode
2. Select your development team
3. Build and run on simulator or device

### Testing
- **Unit tests**: `CD starter projectTests`
- **UI tests**: `CD starter projectUITests`
- **Fastlane tests**: `bundle exec fastlane test`

## Success Stories

This setup has successfully resolved:

- ✅ **TestFlight build number conflicts** (race conditions)
- ✅ **Missing compliance blocking distribution**
- ✅ **API key permission limitations**
- ✅ **Certificate management complexity**
- ✅ **PR merge conflicts from Xcode files**
- ✅ **Manual export compliance submission**

## Contributing

1. **Create feature branch** from `develop`
2. **Make changes** and add tests
3. **Create Pull Request**
4. **Test with `/diagnostic`** to verify CI
5. **Deploy with `/build`** for TestFlight
6. **Merge** when ready

## Inspiration

This setup incorporates proven patterns from **Almosafer's production iOS CI/CD pipeline**, adapted for general use with comprehensive documentation and troubleshooting guides.

## License

This project is for demonstration and educational purposes. 