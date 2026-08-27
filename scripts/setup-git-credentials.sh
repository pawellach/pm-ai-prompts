#!/bin/sh
# One-time setup — configures local git credentials for the pawellach GitHub account.
# Run from repo root: sh scripts/setup-git-credentials.sh
#
# Requires: gh CLI authenticated with pawellach account
#   gh auth login  (choose pawellach if prompted)
#
# What it does: sets a local credential helper that calls
#   gh auth token --user pawellach
# so git push/pull to github.com/pawellach/* uses the right account
# without affecting the global gh active account.

set -e

if ! command -v gh > /dev/null 2>&1; then
    echo "ERROR: gh CLI not found. Install from https://cli.github.com/" >&2
    exit 1
fi

if ! gh auth token --user pawellach > /dev/null 2>&1; then
    echo "ERROR: pawellach not authenticated. Run: gh auth login" >&2
    exit 1
fi

git config --local credential.https://github.com.helper ""
git config --local --add credential.https://github.com.helper \
    '!f() { printf "protocol=https\nhost=github.com\nusername=pawellach\npassword=%s\n" "$(gh auth token --user pawellach 2>/dev/null)"; }; f'

echo "Done. This repo will now use the pawellach account for git push/pull."
echo "Test with: git push origin main"
