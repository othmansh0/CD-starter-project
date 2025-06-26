fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Fastlane Setup

This project uses a simplified fastlane configuration based on the Al-Mosafer pattern, using `match` and `sigh` for proper certificate and provisioning profile management.

## 🚀 Available Lanes

### Main Lanes

#### `build_and_upload`
Builds the app and uploads it to TestFlight. This is the main lane used by CI/CD.

```bash
bundle exec fastlane build_and_upload
```

#### `test`
Runs unit tests for the project.

```bash
bundle exec fastlane test
```

### Development Helper Lanes

#### `setup_dev_signing`
Sets up certificates and provisioning profiles for development builds.

```bash
bundle exec fastlane setup_dev_signing
```

#### `setup_appstore_signing`
Sets up certificates and provisioning profiles for App Store builds.

```bash
bundle exec fastlane setup_appstore_signing
```

## 🔧 Configuration

### Required Environment Variables

The following environment variables need to be configured in your CI/CD system (GitHub Secrets):

#### App Store Connect API Key (Required)
- `API_KEY_ID` - Your App Store Connect API Key ID
- `API_ISSUER_ID` - Your App Store Connect Issuer ID  
- `API_KEY_BASE64` - Your App Store Connect API Key (.p8 file) encoded in base64

#### Apple Developer Account (Required)
- `FASTLANE_USERNAME` - Your Apple Developer account email
- `DEVELOPMENT_TEAM` - Your Apple Developer Team ID

#### App Configuration (Optional)
- `APP_IDENTIFIER` - Your app's bundle identifier (defaults to `com.othmanshahrouri.cd.starter.project`)

#### Match Configuration (Optional)
- `MATCH_GIT_URL` - Git repository URL for storing certificates (if using match)
- `MATCH_PASSWORD` - Password for encrypting certificates in match repository

#### Version Configuration (Optional)
- `VERSION_NUMBER` - Override version number for the build
- `BUILD_NUMBER` - Override build number for the build

### Local Development Setup

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Setup environment variables:**
   Create a `.env` file in the fastlane directory with your configuration:
   ```bash
   # Copy from template
   cp fastlane/template.env fastlane/.env
   
   # Edit with your values
   vim fastlane/.env
   ```

3. **Test the setup:**
   ```bash
   bundle exec fastlane test
   ```

## 🔑 Code Signing Strategy

This setup uses a **two-tier approach** for code signing:

### 1. Match (Preferred)
If `MATCH_GIT_URL` is configured, fastlane will use `match` to:
- Download certificates from a secure git repository
- Automatically handle certificate lifecycle
- Ensure consistent signing across team members

### 2. Sigh (Fallback)
`sigh` is used to:
- Download provisioning profiles from Apple Developer Portal
- Handle profile selection automatically
- Work with both match-managed and existing certificates

### 3. App Store Connect API
The API key provides:
- Automatic provisioning profile creation/updates
- Access to certificates and profiles
- Reduced dependency on manual certificate management

## 🏗️ Build Process

The simplified build process follows these steps:

1. **Setup CI Environment** - Creates temporary keychain for CI
2. **Setup API Key** - Configures App Store Connect authentication
3. **Setup Code Signing** - Downloads certificates and profiles using match/sigh
4. **Build App** - Uses `gym` with simple configuration
5. **Upload to TestFlight** - Automatically uploads IPA to TestFlight

## 🔍 Troubleshooting

### Common Issues

#### "No matching provisioning profiles found"
- Ensure `DEVELOPMENT_TEAM` is set correctly
- Check that your Apple Developer account has the necessary permissions
- Verify the app identifier matches your project configuration

#### "Certificate not found in keychain"
- Make sure `MATCH_GIT_URL` is configured if using match
- Verify API key has the necessary permissions
- Check that certificates exist in your Apple Developer account

#### "API key authentication failed"
- Verify `API_KEY_ID`, `API_ISSUER_ID`, and `API_KEY_BASE64` are set correctly
- Ensure the API key has App Manager or Developer permissions
- Check that the API key hasn't expired

### Debug Mode

To run fastlane with verbose logging:

```bash
bundle exec fastlane build_and_upload --verbose
```

## 📚 Documentation

- [Fastlane Documentation](https://docs.fastlane.tools/)
- [Match Documentation](https://docs.fastlane.tools/actions/match/)
- [Sigh Documentation](https://docs.fastlane.tools/actions/sigh/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
