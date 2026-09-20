#!/usr/bin/env bash
# Deploy CS Quest to the Play Store and/or App Store Connect.
#
# Usage:
#   ./deploy.sh                            # prompt for version, deploy Android + iOS
#   ./deploy.sh android                    # Android only
#   ./deploy.sh ios                        # iOS only
#   ./deploy.sh android --track=internal   # push to an Android testing track instead of production
#   ./deploy.sh android --validate-only    # dry-run the Play upload (auth + packaging checks, nothing published)
#   ./deploy.sh --no-bump                  # skip the version prompt, deploy the current build as-is
#   ./deploy.sh --yes                      # skip the version prompt, auto-confirm the bump
#
# What it does:
#   1. Shows the current version and asks you to approve bumping the build number, retry the
#      current build as-is (no bump), or cancel. --no-bump / --yes skip the prompt.
#   2. Runs `flutter analyze` and `flutter test` as a gate — deploy stops if either fails.
#   3. Android: `flutter build appbundle` + uploads the .aab to Google Play via fastlane/supply
#      (service account: android/play-deploy-key.json). Defaults to the production track,
#      submitted for review immediately (this is a real publish — Google still runs its own
#      review before it goes live). Not a draft: use --validate-only to test without publishing.
#   4. iOS: `flutter build ipa` + xcodebuild uploads straight to App Store Connect (uses the
#      Xcode-signed-in Apple ID on this Mac — same as building from Xcode). You still add
#      release notes and submit for review yourself in App Store Connect.
#   5. If the version changed, commits and pushes that change to git.
#
# The script only prints "Deploy complete" after every requested platform's upload has
# actually finished — nothing is backgrounded, so a finished run means a finished deploy.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

TARGET="both"
PROMPT=1
AUTO_YES=0
FASTLANE_ARGS=()

for arg in "$@"; do
  case "$arg" in
    android|ios|both) TARGET="$arg" ;;
    --no-bump) PROMPT=0 ;;
    --yes|-y) AUTO_YES=1 ;;
    --track=*) FASTLANE_ARGS+=("track:${arg#--track=}") ;;
    --validate-only) FASTLANE_ARGS+=("validate_only:true") ;;
    --release-status=*) FASTLANE_ARGS+=("release_status:${arg#--release-status=}") ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

log "Deploy target: $TARGET"

current_version="$(grep '^version:' pubspec.yaml | sed 's/version: //')"
version_name="${current_version%+*}"
build_number="${current_version##*+}"
next_build=$((build_number + 1))
bumped_version="${version_name}+${next_build}"

new_version="$current_version"

if [[ "$PROMPT" == "0" ]]; then
  log "Deploying current version as-is: $current_version (--no-bump)"
elif [[ "$AUTO_YES" == "1" ]]; then
  new_version="$bumped_version"
  log "Bumping build number: $current_version -> $new_version (--yes)"
else
  echo ""
  echo "Current version: $current_version"
  echo "  [Enter]  Bump to $bumped_version and deploy"
  echo "  r        Retry $current_version as-is (no bump)"
  echo "  c        Cancel"
  read -r -p "> " choice
  case "$choice" in
    ""|y|Y|b|B)
      new_version="$bumped_version"
      log "Bumping build number: $current_version -> $new_version"
      ;;
    r|R)
      log "Retrying current version as-is: $current_version"
      ;;
    *)
      log "Cancelled."
      exit 1
      ;;
  esac
fi

if [[ "$new_version" != "$current_version" ]]; then
  sed -i '' "s/^version: .*/version: ${new_version}/" pubspec.yaml
fi

log "Running flutter analyze..."
flutter analyze

log "Running flutter test..."
flutter test

deploy_android() {
  if [[ ! -f "android/play-deploy-key.json" ]]; then
    echo "Missing android/play-deploy-key.json — Android deploy skipped." >&2
    exit 1
  fi
  log "[Android] Building App Bundle and uploading to Google Play..."
  fastlane android deploy "${FASTLANE_ARGS[@]}"
  log "[Android] Upload complete."
}

deploy_ios() {
  if [[ ! -f "ios/ExportOptions/ExportOptions.plist" ]]; then
    echo "Missing ios/ExportOptions/ExportOptions.plist — iOS deploy skipped." >&2
    exit 1
  fi
  log "[iOS] Building archive and uploading to App Store Connect..."
  local log_file
  log_file="$(mktemp)"
  set +e
  flutter build ipa --export-options-plist=ios/ExportOptions/ExportOptions.plist 2>&1 | tee "$log_file"
  local build_status="${PIPESTATUS[0]}"
  set -e
  if [[ "$build_status" == "0" ]]; then
    log "[iOS] Upload complete."
  elif grep -q "Xcode archive done" "$log_file" && grep -q "Flutter failed to list directory" "$log_file"; then
    log "[iOS] Archive and upload succeeded; ignoring Flutter's known harmless local .ipa directory-listing error."
  else
    echo "[iOS] Deploy failed — see log above." >&2
    rm -f "$log_file"
    exit 1
  fi
  rm -f "$log_file"
}

case "$TARGET" in
  android) deploy_android ;;
  ios) deploy_ios ;;
  both) deploy_android; deploy_ios ;;
esac

if [[ "$new_version" != "$current_version" ]]; then
  log "Committing version bump..."
  git add pubspec.yaml
  git commit -m "Bump build number to ${new_version}"
  git push origin main
fi

log "Deploy complete: $TARGET @ $new_version"
