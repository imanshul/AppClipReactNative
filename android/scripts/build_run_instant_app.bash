#!/bin/bash

set -e

adb uninstall com.appclipdemo || true

# clean
sh scripts/cleanup.bash
./gradlew clean

# build bundle
./gradlew instantApp:bundleRelease

# build apks file from bundle based on connected device configuration
bundletool build-apks --bundle=instantApp/build/outputs/bundle/release/instantApp-release.aab --output=local_app.apks --connected-device --ks=debug.keystore --ks-pass=pass:android --ks-key-alias=androiddebugkey --key-pass=pass:android

# unzipping apks file to testing dir
unzip local_app.apks -d testing_locally

# run instant app from specific split /
ia --debug run testing_locally/instant/*.apk