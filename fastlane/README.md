fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios diagnostic_api_permissions

```sh
[bundle exec] fastlane ios diagnostic_api_permissions
```

🧪 DIAGNOSTIC: Test API permissions

### ios diagnostic_dev_build

```sh
[bundle exec] fastlane ios diagnostic_dev_build
```

🏗️ DIAGNOSTIC: Test Development build (should succeed)

### ios setup_profiles

```sh
[bundle exec] fastlane ios setup_profiles
```

⚙️ Setup lane: Create missing provisioning profiles

### ios build_and_upload

```sh
[bundle exec] fastlane ios build_and_upload
```

🚀 Build and upload to TestFlight

### ios test_local_setup

```sh
[bundle exec] fastlane ios test_local_setup
```

🧪 LOCAL TEST: Test certificate import without API keys

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
