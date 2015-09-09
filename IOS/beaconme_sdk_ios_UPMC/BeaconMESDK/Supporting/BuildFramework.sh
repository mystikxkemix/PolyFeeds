#!/bin/sh

set -e

export FRAMEWORK_LOCATION="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework"

# Create the path to the real Headers die
mkdir -p "${FRAMEWORK_LOCATION}/Versions/A/Headers"
 
# Create the required symlinks
/bin/ln -sfh A "${FRAMEWORK_LOCATION}/Versions/Current"
/bin/ln -sfh Versions/Current/Headers "${FRAMEWORK_LOCATION}/Headers"
/bin/ln -sfh "Versions/Current/${PRODUCT_NAME}" \
             "${FRAMEWORK_LOCATION}/${PRODUCT_NAME}"
 
# Copy the public headers into the framework
/bin/cp -a "${TARGET_BUILD_DIR}/${PUBLIC_HEADERS_FOLDER_PATH}/" \
           "${FRAMEWORK_LOCATION}/Versions/A/Headers"