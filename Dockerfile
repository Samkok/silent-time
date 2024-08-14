# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and upgrade system packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Install dependencies
RUN apt-get install -y --no-install-recommends \
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
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set up Git to allow dubious ownership globally
RUN git config --global --add safe.directory '*'

# Set environment variables
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools

# Download and install Android SDK
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
    && cd $ANDROID_SDK_ROOT/cmdline-tools \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O tools.zip \
    && unzip tools.zip -d latest \
    && rm tools.zip

# Accept licenses
RUN yes | sdkmanager --licenses

# Install the necessary SDK packages (you can customize this as needed)
RUN sdkmanager --install \
    "platform-tools" \
    "platforms;android-30" \
    "build-tools;30.0.3" \
    "cmdline-tools;latest" \
    "emulator" \
    "extras;android;m2repository" \
    "extras;google;m2repository"

# Install Flutter 3.19.0
RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz && \
    tar xf flutter.tar.xz && \
    mv flutter /usr/local/flutter && \
    rm flutter.tar.xz

# Add Flutter to the PATH
ENV PATH="/usr/local/flutter/bin:$PATH"

# Add Java to PATH
ENV PATH="/usr/lib/jvm/java-11-openjdk-amd64:$PATH"

# Pre-download Flutter dependencies
RUN flutter precache

# Enable Flutter Web
RUN flutter config --enable-web

# Run basic check to download additional binaries and ensure everything is set up
RUN flutter doctor -v

# Set the working directory
WORKDIR /app

# Set up an entry point for the container
ENTRYPOINT ["/bin/bash"]
