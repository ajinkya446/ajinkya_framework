#!/bin/bash
set -e

echo "=== Flutter Static Analysis ==="
echo "Running flutter analyze with strict rules..."

# Run flutter analyze and treat warnings as errors
flutter analyze --fatal-warnings --fatal-infos

echo "✓ Static analysis passed!"
