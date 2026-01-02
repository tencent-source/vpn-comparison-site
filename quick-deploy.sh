#!/bin/bash

# VPN Comparison Website - Quick Deploy Script
# Run this after creating your GitHub organization and repository

set -e

echo "🚀 VPN Comparison Website - Quick Deploy"
echo "========================================"
echo ""

# Get organization name
read -p "Enter your GitHub organization name: " ORG_NAME

if [ -z "$ORG_NAME" ]; then
    echo "❌ Organization name is required!"
    exit 1
fi

REPO_NAME="${ORG_NAME}.github.io"
REPO_URL="https://github.com/${ORG_NAME}/${REPO_NAME}.git"

echo ""
echo "📝 Updating HTML with organization name: ${ORG_NAME}..."

# Update HTML file
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/your-org-name/${ORG_NAME}/g" index.html
else
    # Linux
    sed -i "s/your-org-name/${ORG_NAME}/g" index.html
fi

echo "✅ HTML updated"
echo ""

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git initialized"
    echo ""
fi

# Check if remote exists
if git remote | grep -q "origin"; then
    echo "🔄 Updating remote URL..."
    git remote set-url origin "$REPO_URL"
else
    echo "➕ Adding remote repository..."
    git remote add origin "$REPO_URL"
fi

echo "✅ Remote configured: $REPO_URL"
echo ""

# Add all files
echo "📁 Staging files..."
git add .
echo "✅ Files staged"
echo ""

# Commit
echo "💾 Committing changes..."
git commit -m "Initial commit: VPN comparison website" || echo "⚠️  No changes to commit (files may already be committed)"
echo ""

# Push to GitHub
echo "🚀 Pushing to GitHub..."
echo "   (You may be prompted for GitHub credentials)"
git branch -M main
git push -u origin main

echo ""
echo "✅ Code pushed successfully!"
echo ""
echo "📋 Next Steps:"
echo "1. Go to: https://github.com/${ORG_NAME}/${REPO_NAME}/settings/pages"
echo "2. Enable GitHub Pages:"
echo "   - Source: Deploy from a branch"
echo "   - Branch: main"
echo "   - Folder: / (root)"
echo "3. Your site will be live at: https://${ORG_NAME}.github.io"
echo ""
echo "🔧 Don't forget to:"
echo "- Update AdSense IDs in index.html (search for 'YOUR_ADSENSE_ID')"
echo "- Add your affiliate links to VPN buttons"
echo "- Verify your site in Google AdSense dashboard"
echo ""

