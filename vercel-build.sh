#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Step 1: Install Git LFS by downloading the static binary.
echo "Downloading Git LFS binary..."
curl -sS https://github.com/git-lfs/git-lfs/releases/download/v3.4.0/git-lfs-linux-amd64-v3.4.0.tar.gz -o /tmp/git-lfs.tar.gz

# Step 2: Extract the binary.
echo "Extracting Git LFS binary..."
tar -xzf /tmp/git-lfs.tar.gz -C /tmp

# Step 3: Move the executable to a location in the system's PATH.
echo "Installing Git LFS executable..."
mv /tmp/git-lfs-3.4.0/git-lfs /usr/local/bin/git-lfs

# Step 4: Clean up temporary files.
echo "Cleaning up temporary files..."
rm -rf /tmp/git-lfs*

# Step 5: Configure the LFS remote URL for the current build.
echo "Configuring LFS remote URL..."
git config lfs.url https://github.com/Desmond09-spec/temigrapher.git/info/lfs

# Step 6: Pull the Git LFS files.
echo "Pulling Git LFS files..."
git lfs pull