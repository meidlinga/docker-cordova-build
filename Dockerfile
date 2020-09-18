FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

ENV ANDROID_SDK_ROOT="/usr/local/android-sdk-linux"
ENV PATH="${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"

COPY scripts/* /scripts/

RUN /scripts/bootstrap.sh && rm -rf /var/lib/apt/lists/*

ENV GRUNTDIR=/grunt
COPY /grunt/*.json /grunt/
RUN cd $GRUNTDIR && npm install && grunt --help

RUN git clone https://github.com/apache/cordova-android.git --branch 9.0.x /cordova-android

ENV BUILDDIR=/dummybuild
RUN /scripts/create_dummy_project.sh

