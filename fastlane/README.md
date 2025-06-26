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

### ios build_and_upload

```sh
[bundle exec] fastlane ios build_and_upload
```

Build and upload the app to TestFlight

### ios test

```sh
[bundle exec] fastlane ios test
```

Run unit tests

### ios setup_dev_signing

```sh
[bundle exec] fastlane ios setup_dev_signing
```

Setup certificates and profiles for development

### ios setup_appstore_signing

```sh
[bundle exec] fastlane ios setup_appstore_signing
```

Setup certificates and profiles for App Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
