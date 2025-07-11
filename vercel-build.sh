#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

LFS_VERSION="3.5.0" # Using v3.5.0 - you can check https://github.com/git-lfs/git-lfs/releases for the latest stable
LFS_ARCH="linux-amd64"
LFS_FILENAME="git-lfs-${LFS_ARCH}-v${LFS_VERSION}.tar.gz"
LFS_URL="https://github.com/git-lfs/git-lfs/releases/download/v${LFS_VERSION}/${LFS_FILENAME}"
LFS_EXTRACT_DIR="/tmp/git-lfs-extracted" # Directory where it will be extracted

echo "Downloading Git LFS binary v${LFS_VERSION}..."
curl -L -sS "${LFS_URL}" -o "/tmp/${LFS_FILENAME}"

echo "Extracting Git LFS binary..."
mkdir -p "${LFS_EXTRACT_DIR}" # Create the directory if it doesn't exist
tar -xzf "/tmp/${LFS_FILENAME}" -C "${LFS_EXTRACT_DIR}"

# Verify extraction
if [ ! -f "${LFS_EXTRACT_DIR}/git-lfs-${LFS_VERSION}/git-lfs" ]; then
  echo "Error: Git LFS executable not found after extraction. Check tarball content."
  exit 1
fi

# Add the extracted binary to PATH for the current shell session
export PATH="${LFS_EXTRACT_DIR}/git-lfs-${LFS_VERSION}:$PATH"

# Step 1: Initialize Git LFS in the repository.
# This sets up the necessary Git hooks and configuration locally for the build.
echo "Initializing Git LFS..."
git lfs install --skip-smudge --local # --local ensures it only affects this repo, --skip-smudge avoids immediate pull

# Step 2: Configure the LFS remote URL explicitly.
echo "Configuring LFS remote URL..."
git config lfs.url https://github.com/Desmond09-spec/temigrapher.git/info/lfs

# Step 3: Pull the Git LFS files.
echo "Pulling Git LFS files..."
git lfs pull

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf "/tmp/${LFS_FILENAME}" "${LFS_EXTRACT_DIR}"