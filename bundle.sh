#!/bin/sh

echo "\n\033[4m$(pwd)\033[0m"

_pwd="$(pwd)"


 react-native bundle --entry-file index.js --platform ios --dev false --bundle-output ${_pwd}/scripts/main.ios.jsbundle --assets-dest ${_pwd}
 react-native bundle --entry-file App.js --platform ios --dev false --bundle-output ${_pwd}/scripts/app.ios.jsbundle --assets-dest ${_pwd}
 react-native bundle --entry-file hello.js --platform ios --dev false --bundle-output ${_pwd}/scripts/hello.ios.jsbundle --assets-dest ${_pwd}
