#!/usr/bin/env bash

set -euo pipefail

dart run build_runner build
dart fix --apply --code=unused_import --code=unnecessary_import --code=directives_ordering
git ls-files '*.dart' | grep -v '^lib/core/generated/' | xargs dart format
flutter analyze --no-fatal-infos