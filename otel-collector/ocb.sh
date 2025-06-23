#!/usr/bin/env bash

set -euo pipefail

# Variables
BUILDER_CONFIG="builder-config.yaml"
OCB_BINARY="ocb"
OCB_URL=OCB_URL="https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd/builder/v0.128.0/ocb_0.128.0_linux_amd64"

# Ensure the script is running in the correct directory
if [[ ! -f "${BUILDER_CONFIG}" ]]; then
  echo "Error: ${BUILDER_CONFIG} not found in $(pwd)"
  exit 1
fi

# Download the OCB binary if not present
if [[ ! -f "${OCB_BINARY}" ]]; then
  echo "Downloading OpenTelemetry Collector Builder..."
  wget "${OCB_URL}" -O "${OCB_BINARY}"
  chmod +x "${OCB_BINARY}"
fi

# Build the collector
echo "Building OpenTelemetry Collector..."
./"${OCB_BINARY}" --config "${BUILDER_CONFIG}"

echo "Collector built successfully. Output is in the 'bin' directory."
