# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and upgrade system packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Install dependencies
RUN apt-get install -y --fix-missing \
    curl \
    git \
    unzip \
    xz-utils \
    openjdk-11-jdk \
    libgl1-mesa-glx \
    libgl1 \
    libglx-mesa0 \
    libcurl4 \
    perl \
    ca-certificates-java \
    ca-certificates \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    tree \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install the Android SDK
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk \
    && curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip \
    && unzip commandlinetools.zip -d cmdline-tools && rm commandlinetools.zip \
    && yes | cmdline-tools/cmdline-tools/bin/sdkmanager --licenses \
    && cmdline-tools/cmdline-tools/bin/sdkmanager "platform-tools" "platforms;android-31" "platforms;android-32" "platforms;android-30"

# Set environment variables for Android SDK
ENV ANDROID_HOME="/opt/android-sdk"
ENV PATH="$ANDROID_HOM/cmdline-tools/latest/bin:$PATH"
ENV PATH="$ANDROID_HOME/platform-tools:$PATH"

# Set up Git to allow dubious ownership globally
RUN git config --global --add safe.directory '*'

# Install Flutter 3.19.0
RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz && \
    tar xf flutter.tar.xz && \
    mv flutter /usr/local/flutter && \
    rm flutter.tar.xz

# Add Flutter to the PATH
ENV PATH="/usr/local/flutter/bin:$PATH"

# Pre-download Flutter dependencies
RUN flutter precache

# Enable Flutter Web
RUN flutter config --enable-web

# Config andriod sdk to flutter
RUN flutter config --android-sdk /opt/android-sdk

# Run basic check to download additional binaries and ensure everything is set up
RUN flutter doctor -v

# Set the working directory
WORKDIR /app

# Set up an entry point for the container
ENTRYPOINT ["/bin/bash"]
