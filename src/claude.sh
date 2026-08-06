#!/usr/bin/env bash
# Wrapper to run the official Claude Code CLI inside a guix shell --container sandbox, since Guix System has no FHS for its release binary to run against natively
set -euo pipefail

# Minimum toolchain Claude Code's own Bash tool needs to function inside
# the container - kept explicit (not derived from the user profile) so it
# doesn't silently break if that profile lacks e.g. bash.
BASE_PKGS="glibc gcc-toolchain ripgrep nss-certs bash coreutils findutils grep sed gawk which file tar gzip curl git less xclip"

# `guix shell -p PROFILE` can't be combined with plain package args ("--profile
# cannot be used with package options"), so instead resolve the user's own
# installed packages into the same plain-package-arg form as BASE_PKGS and
# merge the two lists, rather than passing the profile itself.
INSTALLED_PKGS=""
if command -v guix >/dev/null 2>&1 && [ -e "$HOME/.guix-profile" ]; then
  INSTALLED_PKGS=$(guix package -p "$HOME/.guix-profile" -I 2>/dev/null \
    | awk 'NF{print $1}' | sort -u | tr '\n' ' ')
fi
ALL_PKGS="$BASE_PKGS $INSTALLED_PKGS"

REAL_CLAUDE=$(readlink -f "$HOME/.local/bin/claude" 2>/dev/null || true)

if [ -z "$REAL_CLAUDE" ] || [ ! -x "$REAL_CLAUDE" ]; then
  echo "error: Claude Code binary not found at ~/.local/bin/claude" >&2
  echo "Run: guix shell --container --network --emulate-fhs $BASE_PKGS --share=\$HOME -- bash -c 'curl -fsSL https://claude.ai/install.sh | bash'" >&2
  exit 1
fi

if [ -z "$INSTALLED_PKGS" ]; then
  echo "warning: could not resolve packages from $HOME/.guix-profile - falling back to BASE_PKGS only" >&2
fi

# Share every top-level host path except the ones that would collide with
# what --emulate-fhs/--container construct themselves: /proc,/sys,/dev are
# kernel pseudo-filesystems the container provides on its own; /bin,/sbin,
# /lib,/lib64,/usr are what --emulate-fhs synthesizes from ALL_PKGS (sharing
# the host's - which barely exist on Guix System - collides with that).
# /etc is skipped since it holds host secrets and emulate-fhs also wants to
# populate parts of it; delete it from EXCLUDE below to include it anyway.
EXCLUDE="proc sys dev bin sbin lib lib64 usr etc"
SHARE_ARGS=()
for d in /*; do
  name="${d#/}"
  case " $EXCLUDE " in
    *" $name "*) continue ;;
  esac
  [ -e "$d" ] && SHARE_ARGS+=(--share="$d")
done

exec guix shell --container --network --emulate-fhs \
  $ALL_PKGS \
  "${SHARE_ARGS[@]}" \
  --preserve='^(TERM|COLORTERM|DISPLAY|XAUTHORITY|SSH_AUTH_SOCK|GPG_TTY|DBUS_SESSION_BUS_ADDRESS|XDG_RUNTIME_DIR|WAYLAND_DISPLAY)$' \
  -- "$REAL_CLAUDE" "$@"
