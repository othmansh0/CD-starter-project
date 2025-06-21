# CD Starter Project

A simple iOS calculator app with automated CI/CD pipeline for TestFlight deployment.

## Features

- Basic calculator operations (add, subtract, multiply, divide, power)
- Modern SwiftUI interface with emojis and styling
- Automated testing and deployment pipeline
- GitHub Actions integration with comment-triggered builds

## iOS CI/CD Pipeline

This project uses GitHub Actions and Fastlane for automated iOS app deployment to TestFlight. The pipeline supports multiple build types and includes comprehensive diagnostics.

### Build Commands

Comment on any Pull Request to trigger builds:

- `/build` - Full App Store build and upload to TestFlight
- `/diagnostic` - Development build to test CI pipeline
- `/permissions` - Test API key permissions
- `/setup` - Create missing provisioning profiles

### Setup Requirements

#### 1. Apple Developer Account
- Active Apple Developer Program membership
- App Store Connect access
- Appropriate role permissions (see troubleshooting below)

#### 2. GitHub Secrets Configuration

Add these secrets to your repository (Settings → Secrets → Actions):

```
API_KEY_ID          # App Store Connect API Key ID
API_ISSUER_ID       # App Store Connect Issuer ID  
API_KEY_BASE64      # Base64 encoded .p8 file content
DEVELOPMENT_TEAM    # Apple Developer Team ID
APPLE_ID            # Your Apple ID email (optional)
```

#### 3. App Store Connect API Key

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to Users and Access → Keys
3. Create new API Key with **App Manager** role
4. Download the `.p8` file
5. Base64 encode the file: `base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
6. Add to GitHub secrets as `API_KEY_BASE64`

### Architecture

The CI/CD pipeline uses modern iOS signing approaches:

#### Xcode Cloud Signing
- Uses App Store Connect API keys for authentication
- Leverages `-allowProvisioningUpdates` for automatic profile management
- Eliminates need for manual certificate management in CI

#### Development vs Distribution Certificates
- **Development certificates**: Created automatically by Xcode in CI
- **Distribution certificates**: Require elevated permissions (Admin/App Store Manager role)
- Pipeline gracefully handles permission limitations

#### Fastlane Lanes

1. **`build_and_upload`** - Complete App Store build and TestFlight upload
2. **`diagnostic_dev_build`** - Development build to verify CI setup
3. **`diagnostic_api_permissions`** - Test API key permissions
4. **`setup_profiles`** - Create missing provisioning profiles

### Troubleshooting

#### Common Issues

**"No profiles for 'com.your.bundle.id' were found"**
- Run `/setup` command to create missing provisioning profiles
- Verify bundle identifier matches your app

**"Cloud signing permission error"**
- Your Apple Developer account role lacks Distribution certificate permissions
- Solutions:
  1. Request Admin or App Store Manager role
  2. Ask Admin to create Distribution certificates
  3. Use `/diagnostic` to verify Development builds work

**"There are no local code signing identities found"**
- Expected in CI environments
- Pipeline automatically handles this with cloud signing
- Use `/diagnostic` to test Development certificate creation

#### Permission Requirements

| Build Type | Required Role | Can Create Certificates |
|------------|---------------|------------------------|
| Development | Developer | ✅ Yes (automatic) |
| Distribution | Admin/App Store Manager | ❌ No (requires elevation) |

#### Diagnostic Commands

Use these commands to identify issues:

```bash
# Test API permissions
/permissions

# Test Development build (should always work)
/diagnostic  

# Create missing profiles
/setup

# Full App Store build
/build
```

### Manual Local Development

For local development and testing:

```bash
# Install dependencies
bundle install

# Run diagnostic tests
bundle exec fastlane diagnostic_api_permissions
bundle exec fastlane diagnostic_dev_build

# Create profiles if needed
bundle exec fastlane setup_profiles

# Build and upload
bundle exec fastlane build_and_upload
```

### Security Best Practices

- API keys are stored as encrypted GitHub secrets
- AuthKey.p8 files are created temporarily and cleaned up
- No sensitive data is logged or exposed
- Keychain access is properly managed in CI

### Project Structure

```
.
├── .github/workflows/
│   ├── build-on-comment.yml    # Comment-triggered builds
│   └── test.yml                # Automated testing
├── fastlane/
│   ├── Fastfile                # Build automation
│   └── Appfile                 # App configuration
├── CD starter project/         # iOS app source
└── README.md                   # This file
```

## Development

### Requirements
- Xcode 16.1+
- iOS 16.0+ deployment target
- Swift 5.9+

### Building Locally
1. Open `CD starter project.xcodeproj` in Xcode
2. Select your development team
3. Build and run on simulator or device

### Testing
- Unit tests: `CD starter projectTests`
- UI tests: `CD starter projectUITests`
- Run via Xcode or: `bundle exec fastlane test`

## Contributing

1. Create feature branch from `develop`
2. Make changes and add tests
3. Create Pull Request
4. Use `/diagnostic` to test CI pipeline
5. Use `/build` for full TestFlight deployment

## License

This project is for demonstration purposes. 