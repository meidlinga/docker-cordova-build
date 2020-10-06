#!/usr/bin/env bash

apt-get update 
#apt upgrade
apt-get -y install npm grunt wget git dos2unix
apt-get -y install openjdk-8-jre-headless openjdk-8-jdk-headless gradle
#apt-get -y install openjdk-11-jre-headless openjdk-11-jdk-headless

# Update Node to the recent stable
echo Node version before update $(node -v)
npm cache clean -f
npm install -g n
n stable
echo Node version after update $(node -v)

npm install -g cordova

mkdir -p /usr/local/android-sdk-linux
pushd /usr/local/android-sdk-linux
wget --quiet https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip
popd

cat >/etc/profile.d/99-android-emu.sh <<EOL
export ANDROID_SDK_ROOT=/usr/local/android-sdk-linux
export PATH=\$PATH:\$ANDROID_SDK_ROOT/tools/bin
export PATH=\$PATH:\$ANDROID_SDK_ROOT/platform-tools
EOL
chmod +x /etc/profile.d/99-android-emu.sh

source /etc/profile.d/99-android-emu.sh

yes | sdkmanager --sdk_root=/usr/local/android-sdk-linux --licenses
sdkmanager --sdk_root=/usr/local/android-sdk-linux "platform-tools" "platforms;android-28" "platforms;android-29" "build-tools;30.0.1" 

mkdir -p /staging
chmod 777 /staging
mkdir -p /build
chmod 777 /build
