#!/usr/bin/env bash
set -euo pipefail

# Install cliamp (bjarneo/cliamp) from GitHub Releases prebuilt binaries.
# Not packaged in Fedora repos / Flathub, so we fetch the static Linux build.
# https://github.com/bjarneo/cliamp

ARCH="$(uname -m)"
case "${ARCH}" in
  x86_64|amd64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)
    echo "Unsupported architecture for cliamp: ${ARCH}" >&2
    exit 1
    ;;
esac

echo "Installing cliamp for linux-${ARCH}..."
curl -fSL --retry 5 \
  "https://github.com/bjarneo/cliamp/releases/latest/download/cliamp-linux-${ARCH}" \
  -o /usr/bin/cliamp
chmod +x /usr/bin/cliamp
/usr/bin/cliamp --version
