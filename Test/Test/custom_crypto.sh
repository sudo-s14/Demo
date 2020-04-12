#!/bin/bash
## CHECKOUT CUSTOM_CRYPTO REPO ###

#PROJECT_CONFIG=(Honey_Release Honey_Debug Honey_CustomCrypto_Debug Honey_CustomCrypto_Release)

PROJECT_CONFIG="${CONFIGURATION}"
# echo "PROJECT_CONFIG: $PROJECT_CONFIG"

CUSTOM_CRYPTO_REPO_TAG="master"
# echo "CUSTOM_CRYPTO_REPO_TAG: $CUSTOM_CRYPTO_REPO_TAG"

PROJECT_CONFIG="Debug"
CUSTOM_CRYPTO_PATH="../customcrypto"
# echo "CUSTOM_CRYPTO_PATH: $CUSTOM_CRYPTO_PATH"

# Support for dmclibv2
function assertSuccess(){
if [ $? -ne 0 ]; then echo "failed to checkout $CUSTOM_CRYPTO_REPO_TAG" && exit 1; fi
}

if [[ $PROJECT_CONFIG =~ "Debug" || $PROJECT_CONFIG =~ "Release" ]]; then
    if [[ ! -d "$CUSTOM_CRYPTO_PATH" ]]; then
        mkdir -p $CUSTOM_CRYPTO_PATH;assertSuccess
        SITE_REPO_URL="https://github.com/myselfshameem/Demo.git"
        echo -e "To proceed with build, \n please clone customcrypto repository at location: ${Bold}${Red} $CUSTOM_CRYPTO_PATH ${Reset} using below git command"
        echo -e "git clone $SITE_REPO_URL --recursive -b $CUSTOM_CRYPTO_REPO_TAG  $CUSTOM_CRYPTO_PATH"
        git clone $SITE_REPO_URL --recursive -b $CUSTOM_CRYPTO_REPO_TAG  $CUSTOM_CRYPTO_PATH; assertSuccess
    else
        echo -e "${Bold}${Red} Custom Crypto folder found at path: $CUSTOM_CRYPTO_PATH."
        echo -e "move to Custom Crypto folder and pull the latest changes(if any)."
        echo -e "do a git reset --hard; git pull;"
        cd $CUSTOM_CRYPTO_PATH
        git reset --hard
        git pull; assertSuccess
        git checkout $CUSTOM_CRYPTO_REPO_TAG; assertSuccess
        echo -e "force exit with success."
        exit 0
    fi
fi
