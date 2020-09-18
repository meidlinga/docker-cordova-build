#!/bin/bash

mkdir -p /dummy
pushd /dummy
cordova create dummyproject
pushd dummyproject
cordova platform add /cordova-android --link
cordova build
popd
popd

ls -la /root
ls -la /root/.gradle
ls -la /
ls -la /dummy
ls -la /dummy/dummyproject


