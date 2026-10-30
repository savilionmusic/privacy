#!/bin/sh
# Puts the herm privacy policy online at https://savilionmusic.github.io/privacy/ (public GitHub repo + Pages).
set -eu
cd "$(dirname "$0")"
[ -d .git ] || { git init -q -b main; git add index.html; git commit -q -m "Privacy policy for the herm app"; }
gh repo view savilionmusic/privacy >/dev/null 2>&1 || \
  gh repo create savilionmusic/privacy --public --source . --push --description "Privacy policy for the herm app"
gh api -X POST repos/savilionmusic/privacy/pages -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true
echo "Done: https://savilionmusic.github.io/privacy/ (can take a minute to appear)"
