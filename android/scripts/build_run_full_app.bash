#!/bin/bash

set -e

adb uninstall com.appclipdemo || true

# clean
sh scripts/cleanup.bash
./gradlew clean

# build bundle
./gradlew app:bundleRelease

# build apks file from bundle based on connected device configuration
bundletool build-apks --bundle=app/build/outputs/bundle/release/app-release.aab  --output=local_app.apks --connected-device --ks=debug.keystore --ks-pass=pass:android --ks-key-alias=androiddebugkey --key-pass=pass:android

# install full app
bundletool install-apks --apks local_app.apks

# run full app
adb shell am start -n com.appclipdemo/com.appclipdemo.MainActivity