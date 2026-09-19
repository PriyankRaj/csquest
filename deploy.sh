#!/usr/bin/env bash
# Deploy CS Quest to the Play Store and/or App Store Connect.
#
# Usage:
#   ./deploy.sh                 # bump build number, deploy Android + iOS
#   ./deploy.sh android         # Android only
#   ./deploy.sh ios             # iOS only
#   ./deploy.sh android --track=internal   # push to an Android testing track instead of production
#   ./deploy.sh android --validate-only    # dry-run the Play upload (auth + packaging checks, nothing published)
#   ./deploy.sh --no-bump        # skip the automatic build-number bump
#
# What it does:
#   1. Bumps the build number in pubspec.yaml (the `+N` after the version), unless --no-bump.
#   2. Runs `flutter analyze` and `flutter test` as a gate — deploy stops if either fails.
#   3. Android: `flutter build appbundle` + uploads the .aab to Google Play via fastlane/supply
#      (service account: android/play-deploy-key.json). Defaults to the production track,
#      submitted for review immediately (this is a real publish — Google still runs its own
#      review before it goes live). Not a draft: use --validate-only to test without publishing.
#   4. iOS: `flutter build ipa` + xcodebuild uploads straight to App Store Connect (uses the
#      Xcode-signed-in Apple ID on this Mac — same as building from Xcode). You still add
#      release notes and submit for review yourself in App Store Connect.
#   5. Commits and pushes the version bump to git.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

TARGET="both"
BUMP=1
FASTLANE_ARGS=()

for arg in "$@"; do
  case "$arg" in
    android|ios|both) TARGET="$arg" ;;
    --no-bump) BUMP=0 ;;
    --track=*) FASTLANE_ARGS+=("track:${arg#--track=}") ;;
    --validate-only) FASTLANE_ARGS+=("validate_only:true") ;;
    --release-status=*) FASTLANE_ARGS+=("release_status:${arg#--release-status=}") ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

echo "==> Deploy target: $TARGET"

if [[ "$BUMP" == "1" ]]; then
  current_version="$(grep '^version:' pubspec.yaml | sed 's/version: //')"
  version_name="${current_version%+*}"
  build_number="${current_version##*+}"
  next_build=$((build_number + 1))
  new_version="${version_name}+${next_build}"
  echo "==> Bumping build number: $current_version -> $new_version"
  sed -i '' "s/^version: .*/version: ${new_version}/" pubspec.yaml
else
  echo "==> Skipping build-number bump (--no-bump)"
fi

echo "==> Running flutter analyze..."
flutter analyze

echo "==> Running flutter test..."
flutter test

deploy_android() {
  if [[ ! -f "android/play-deploy-key.json" ]]; then
    echo "Missing android/play-deploy-key.json — Android deploy skipped." >&2
    exit 1
  fi
  echo "==> Deploying Android via fastlane..."
  fastlane android deploy "${FASTLANE_ARGS[@]}"
}

deploy_ios() {
  if [[ ! -f "ios/ExportOptions/ExportOptions.plist" ]]; then
    echo "Missing ios/ExportOptions/ExportOptions.plist — iOS deploy skipped." >&2
    exit 1
  fi
  echo "==> Deploying iOS via fastlane..."
  fastlane ios deploy
}

case "$TARGET" in
  android) deploy_android ;;
  ios) deploy_ios ;;
  both) deploy_android; deploy_ios ;;
esac

if [[ "$BUMP" == "1" ]]; then
  echo "==> Committing version bump..."
  git add pubspec.yaml
  git commit -m "Bump build number to ${new_version}"
  git push origin main
fi

echo "==> Done."
