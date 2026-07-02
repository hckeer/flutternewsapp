#!/usr/bin/env bash
# Build release APK pointed at the production Render API.
set -euo pipefail

FLUTTER="${FLUTTER:-$HOME/flutter/bin/flutter}"
API_URL="${API_URL:-https://flutternewsapp1.onrender.com/api}"

cd "$(dirname "$0")/../mobile"

echo "Building release APK (API: $API_URL) ..."
"$FLUTTER" build apk \
  --release \
  --dart-define=API_BASE_URL="$API_URL"

echo ""
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
echo "Install: adb install -r build/app/outputs/flutter-apk/app-release.apk"
