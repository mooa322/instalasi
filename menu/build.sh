#!/bin/bash
# Rebuild menu/menu.zip from the plain-text scripts in menu/src.
#
# setup.sh installs the menu by downloading menu/menu.zip and doing
#   unzip menu.zip && chmod +x menu/* && mv menu/* /usr/local/sbin
# so the archive must contain a single top-level "menu/" directory.
#
# Edit the scripts in menu/src, run this, and commit both.
set -e
cd "$(dirname "$0")"

command -v zip >/dev/null || { echo "zip is not installed"; exit 1; }

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/menu"
cp -a src/. "$STAGE/menu/"
chmod +x "$STAGE/menu/"*

rm -f menu.zip
( cd "$STAGE" && zip -q -r -X menu.zip menu )
mv "$STAGE/menu.zip" menu.zip

echo "menu.zip rebuilt from menu/src ($(unzip -Z1 menu.zip | grep -c '^menu/.') scripts)"
