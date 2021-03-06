#!/bin/bash

printf "......................\nresignAndPackage start\n\n"

# Name of your app.
APP="Grape"
# Your сertificate name.
CERT="UberGrape GmbH (Y8DPE6DGC7)"
# Path to project.
PROJECT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}/..")" ; pwd -P )
# The path of your app to sign.
APP_PATH="$PROJECT_PATH/dist/mas/$APP.app"
# The path to the location you want to put the signed package.
RESULT_PATH="$PROJECT_PATH/dist/mas/$APP.pkg"
# The name of certificates you requested.
APP_KEY="3rd Party Mac Developer Application: $CERT"
INSTALLER_KEY="3rd Party Mac Developer Installer: $CERT"
# The path of your plist files.
PARENT_PLIST="build/entitlements.mas.plist"
CHILD_PLIST="build/entitlements.mas.inherit.plist"
FRAMEWORKS_PATH="$APP_PATH/Contents/Frameworks"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/Electron Framework.framework/Versions/A/Electron Framework"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/Electron Framework.framework/Versions/A/Libraries/libffmpeg.dylib"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/Electron Framework.framework/Libraries/libffmpeg.dylib"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/Electron Framework.framework"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/$APP Helper.app/Contents/MacOS/$APP Helper"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$FRAMEWORKS_PATH/$APP Helper.app/"
codesign -s "$APP_KEY" -f --entitlements "$CHILD_PLIST" "$APP_PATH/Contents/MacOS/$APP"
codesign -s "$APP_KEY" -f --entitlements "$PARENT_PLIST" "$APP_PATH"
productbuild --component "$APP_PATH" /Applications --sign "$INSTALLER_KEY" "$RESULT_PATH"

printf "\nresignAndPackage end\n......................\n"