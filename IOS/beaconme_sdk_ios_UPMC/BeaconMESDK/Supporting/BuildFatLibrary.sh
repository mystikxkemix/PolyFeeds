#!/bin/sh

set -e
 
# If we're already inside this script then die
if [ -n "$MULTIPLATFORM_BUILD_IN_PROGRESS" ]; then
  exit 0
fi
export MULTIPLATFORM_BUILD_IN_PROGRESS=1

FRAMEWORK_NAME=${PROJECT_NAME}
INPUT_STATIC_LIB="lib${PROJECT_NAME}.a"
FRAMEWORK_LOCATION="${BUILT_PRODUCTS_DIR}/${FRAMEWORK_NAME}.framework"

function build_static_library {
    # Will rebuild the static library as specified
    #     build_static_library sdk
    xcrun xcodebuild -workspace "${SRCROOT}/../${PROJECT_NAME}.xcworkspace"\
        -scheme BeaconMESDK\
        -configuration "${CONFIGURATION}" \
        -sdk "${1}" \
        ONLY_ACTIVE_ARCH=NO \
        BUILD_DIR="${BUILD_DIR}" \
        OBJROOT="${OBJROOT}" \
        BUILD_ROOT="${BUILD_ROOT}" \
        SYMROOT="${SYMROOT}" $ACTION
}
 
function make_fat_library {
    # Will smash 2 static libs together
    #     make_fat_library in1 in2 out
    xcrun lipo -create "${1}" "${2}" -output "${3}"
}

# 1 - Extract the platform (iphoneos/iphonesimulator) from the SDK name
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]; then
  SDK_PLATFORM=${BASH_REMATCH[1]}
else
  echo "Could not find platform name from SDK_NAME: $SDK_NAME"
  exit 1
fi
 
# 2 - Extract the version from the SDK
if [[ "$SDK_NAME" =~ ([0-9]+.*$) ]]; then
  SDK_VERSION=${BASH_REMATCH[1]}
else
  echo "Could not find sdk version from SDK_NAME: $SDK_NAME"
  exit 1
fi
 
# 3 - Determine the other platform
if [ "$SDK_PLATFORM" == "iphoneos" ]; then
  OTHER_PLATFORM=iphonesimulator
else
  OTHER_PLATFORM=iphoneos
fi
 
# 4 - Find the build directory
if [[ "$BUILT_PRODUCTS_DIR" =~ (.*)$SDK_PLATFORM$ ]]; then
  OTHER_BUILT_PRODUCTS_DIR="${BASH_REMATCH[1]}${OTHER_PLATFORM}"
else
  echo "Could not find other platform build directory."
  exit 1
fi


# Build the other platform.
build_static_library "${OTHER_PLATFORM}${SDK_VERSION}"
 
# If we're currently building for iphonesimulator, then need to rebuild
#   to ensure that we get both i386 and x86_64
if [ "$SDK_PLATFORM" == "iphonesimulator" ]; then
    build_static_library "${SDK_NAME}"
fi

# Version autoincrement
xcrun agvtool next-version -all
MARKETING_VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${INFOPLIST_FILE}")
BUILD_NUMBER=${CURRENT_PROJECT_VERSION}
VERSION_STRING="$MARKETING_VERSION"."$BUILD_NUMBER"

# Join the 2 static libs into 1 and push into the .framework
make_fat_library "${BUILT_PRODUCTS_DIR}/${INPUT_STATIC_LIB}" \
    "${OTHER_BUILT_PRODUCTS_DIR}/${INPUT_STATIC_LIB}" \
    "${FRAMEWORK_LOCATION}/Versions/A/${FRAMEWORK_NAME}"

#Ensure that the framework is present in both platform's build directories
cp -a "${FRAMEWORK_LOCATION}/Versions/A/${FRAMEWORK_NAME}" \
    "${OTHER_BUILT_PRODUCTS_DIR}/${FRAMEWORK_NAME}.framework/Versions/A/${FRAMEWORK_NAME}"

# Copy the framework to the desktop
ditto "${FRAMEWORK_LOCATION}" "${HOME}/Desktop/${FRAMEWORK_NAME}-${VERSION_STRING}/${FRAMEWORK_NAME}.framework"
