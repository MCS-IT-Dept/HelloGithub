#!/bin/bash
# fix_permissions.sh
# Fixes common git "dubious ownership" and file permission issues
# Run this script from within the repository directory

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Repository path: $REPO_DIR"
echo ""

# 1. Fix git safe.directory for the current user
echo "[1/3] Adding safe.directory exception for git..."
git config --global --add safe.directory "$REPO_DIR"
echo "      Done."

# 2. Fix directory/file ownership to match the current user
echo "[2/3] Fixing ownership to current user ($(whoami))..."
sudo chown -R "$(whoami)":"$(id -gn)" "$REPO_DIR"
echo "      Done."

# 3. Set standard permissions (directories: 755, files: 644, scripts: 755)
echo "[3/3] Setting standard file permissions..."
find "$REPO_DIR" -not -path '*/.git/*' -type d -exec chmod 755 {} \;
find "$REPO_DIR" -not -path '*/.git/*' -type f -exec chmod 644 {} \;
chmod 755 "$REPO_DIR/fix_permissions.sh"
echo "      Done."

echo ""
echo "Permissions fixed. You can now run 'git pull' normally."
