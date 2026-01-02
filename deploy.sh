#!/bin/bash
# One-command deployment - just provide your org name!

if [ -z "$1" ]; then
    echo "Usage: ./deploy.sh YOUR-ORG-NAME"
    echo "Example: ./deploy.sh best-vpn-comparison"
    exit 1
fi

ORG="$1"
REPO="${ORG}.github.io"

echo "🚀 Deploying to: https://${ORG}.github.io"
echo ""

# Update HTML
sed -i '' "s/your-org-name/${ORG}/g" index.html
echo "✅ HTML updated"

# Git setup
git remote add origin "https://github.com/${ORG}/${REPO}.git" 2>/dev/null || \
git remote set-url origin "https://github.com/${ORG}/${REPO}.git"

git branch -M main
git add .
git commit -m "Initial commit: VPN comparison website" 2>/dev/null || echo "Already committed"
git push -u origin main

echo ""
echo "✅ Deployed! Enable Pages at:"
echo "   https://github.com/${ORG}/${REPO}/settings/pages"
echo ""
echo "🌐 Your site: https://${ORG}.github.io"
