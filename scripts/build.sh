#!/bin/bash
set -e

PLATFORM=$1

if [ -z "$PLATFORM" ]; then
  echo "Usage: ./build.sh <platform>"
  echo "Supported platforms: web, windows, linux, android, ios, macos"
  exit 1
fi

echo "=== Building Flutter for $PLATFORM ==="

case "$PLATFORM" in
  web)
    echo "Building web..."
    flutter build web --release
    ;;
  windows)
    echo "Building Windows..."
    flutter build windows --release
    ;;
  linux)
    echo "Building Linux..."
    flutter build linux --release
    ;;
  android)
    echo "Building Android..."
    flutter build apk --release
    ;;
  ios)
    echo "Building iOS..."
    flutter build ios --release --no-codesign
    ;;
  macos)
    echo "Building macOS..."
    flutter build macos --release
    ;;
  *)
    echo "Unknown platform: $PLATFORM"
    echo "Supported platforms: web, windows, linux, android, ios, macos"
    exit 1
    ;;
esac

echo "✓ Build for $PLATFORM completed successfully!"
