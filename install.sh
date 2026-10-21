#!/bin/bash
# Installs wDesk Browser on Arch Linux:
#
#   curl -fsSL https://raw.githubusercontent.com/emranmostafa/wdesk-browser-repo/main/install.sh | sudo bash
#
# Adds the [wdesk] repository to /etc/pacman.conf (once; a backup of the
# file is kept) and installs the wdesk-browser package. After that,
# `sudo pacman -Syu` keeps wDesk up to date with the rest of the system.
set -euo pipefail

CONF=/etc/pacman.conf
REPO_URL=https://github.com/emranmostafa/wdesk-browser-repo/releases/download/x86_64

if [[ $EUID -ne 0 ]]; then
  echo "Run it with sudo:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/emranmostafa/wdesk-browser-repo/main/install.sh | sudo bash" >&2
  exit 1
fi
if ! command -v pacman >/dev/null; then
  echo "wDesk Browser packages are for Arch Linux (pacman)." >&2
  exit 1
fi
if [[ $(uname -m) != x86_64 ]]; then
  echo "wDesk Browser packages are for x86_64 only." >&2
  exit 1
fi

if grep -q '^\[wdesk\]' "$CONF"; then
  echo "The [wdesk] repository is already in $CONF."
else
  cp "$CONF" "$CONF.before-wdesk"
  printf '\n[wdesk]\nSigLevel = Optional TrustAll\nServer = %s\n' "$REPO_URL" >>"$CONF"
  echo "Added the [wdesk] repository to $CONF (backup: $CONF.before-wdesk)."
fi

# pacman may ask questions (for example to replace the old "wdesk"
# package): answer them in the terminal, not from this script's pipe.
# Without a terminal, take the defaults and replace "wdesk" (--ask 4).
if (: </dev/tty) 2>/dev/null; then
  pacman -Sy --needed wdesk-browser </dev/tty
else
  pacman -Sy --needed --noconfirm --ask 4 wdesk-browser
fi

echo
echo "wDesk Browser is installed: open it from the app menu, or run 'wdesk'."
echo "Updates come with 'sudo pacman -Syu'."
