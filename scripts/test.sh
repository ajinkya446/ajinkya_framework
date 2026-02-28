#!/bin/bash
set -e

echo "=== Running Flutter Tests ==="

if [ -d "test" ]; then
  flutter test --coverage
  echo "✓ Tests passed!"
else
  echo "⚠ No test directory found, skipping tests"
fi
