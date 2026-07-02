#!/usr/bin/env bash
# Wireless deploy for Dengue Nepal (run on dev machine with phone on same Wi‑Fi)
set -euo pipefail

ADB="${ADB:-$HOME/android-sdk/platform-tools/adb}"
FLUTTER="${FLUTTER:-$HOME/flutter/bin/flutter}"
API_URL="${API_URL:-http://192.168.1.74:3000/api}"

PHONE_CONNECT="${1:-192.168.1.66:35109}"
PAIR_TARGET="${2:-}"
PAIR_CODE="${3:-}"

export PATH="$HOME/android-sdk/platform-tools:$PATH"

if [[ -n "$PAIR_TARGET" && -n "$PAIR_CODE" ]]; then
  echo "Pairing with $PAIR_TARGET ..."
  "$ADB" pair "$PAIR_TARGET" "$PAIR_CODE"
fi

echo "Connecting to $PHONE_CONNECT ..."
"$ADB" connect "$PHONE_CONNECT"
"$ADB" devices -l

cd "$(dirname "$0")/../mobile"
echo "Launching app (API: $API_URL) ..."
exec "$FLUTTER" run \
  --dart-define=API_BASE_URL="$API_URL" \
  -d "$PHONE_CONNECT"
