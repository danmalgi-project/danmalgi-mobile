#!/usr/bin/env bash

set -euo pipefail

git ls-files '*.dart' | grep -v '^lib/core/generated/' | xargs dart format
dart run import_sorter:main
dart run build_runner build --delete-conflicting-outputs
flutter analyze --no-fatal-infos