#!/bin/bash

# Automated GitHub Pages Deployment for Organization
# This script handles the complete deployment process

set -e

echo "🚀 Automated GitHub Pages Deployment"
echo "====================================="
echo ""

# Check if gh is authenticated
if ! gh auth status &>/dev/null; then
    echo "❌ GitHub CLI not authenticated!"
    echo "   Please run: gh auth login"
    exit 1
fi

# Get organization name
echo "Enter your GitHub organization name:"
echo "(This will be used for the URL: https://ORG-NAME.github.io)"
read -p "Organization name: " ORG_NAME

if [ -z "$ORG_NAME" ]; then
    echo "❌ Organization name is required!"
    exit 1
fi

# Validate org name (basic check)
if [[ ! "$ORG_NAME" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$ ]] || [[ ${#ORG_NAME} -gt 39 ]]; then
    echo "❌ Invalid organization name format!"
    echo "   Must be alphanumeric with hyphens, 1-39 characters"
    exit 1
fi

REPO_NAME="${ORG_NAME}.github.io"
REPO_URL="https://github.com/${ORG_NAME}/${REPO_NAME}.git"

echo ""
echo "📋 Configuration:"
echo "   Organization: ${ORG_NAME}"
echo "   Repository: ${REPO_NAME}"
echo "   URL: https://${ORG_NAME}.github.io"
echo ""

# Check if org exists
echo "🔍 Checking organization..."
if gh api "orgs/${ORG_NAME}" &>/dev/null; then
    echo "✅ Organization found: ${ORG_NAME}"
else
    echo "⚠️  Organization '${ORG_NAME}' not found or you don't have access"
    echo ""
    echo "Would you like to:"
    echo "1. Create a new organization (you'll need to do this manually)"
    echo "2. Use a different organization name"
    echo "3. Continue anyway (repository might fail)"
    read -p "Choice (1/2/3): " choice
    
    if [ "$choice" = "1" ]; then
        echo ""
        echo "📝 To create an organization:"
        echo "   1. Go to: https://github.com/organizations/new"
        echo "   2. Create organization: ${ORG_NAME}"
        echo "   3. Run this script again"
        exit 0
    elif [ "$choice" = "2" ]; then
        echo "Please run this script again with the correct organization name"
        exit 0
    fi
fi

# Update HTML with org name
echo ""
echo "📝 Updating HTML with organization name..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/your-org-name/${ORG_NAME}/g" index.html
else
    sed -i "s/your-org-name/${ORG_NAME}/g" index.html
fi
echo "✅ HTML updated"

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo ""
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git initialized"
fi

# Check if repo exists, create if not
echo ""
echo "🔍 Checking repository..."
if gh repo view "${ORG_NAME}/${REPO_NAME}" &>/dev/null; then
    echo "✅ Repository exists: ${REPO_NAME}"
    if git remote | grep -q "origin"; then
        git remote set-url origin "$REPO_URL"
    else
        git remote add origin "$REPO_URL"
    fi
    echo "✅ Remote configured"
else
    echo "📦 Creating repository: ${REPO_NAME}"
    if gh repo create "${ORG_NAME}/${REPO_NAME}" --public --source=. --remote=origin --push=false; then
        echo "✅ Repository created"
    else
        echo "❌ Failed to create repository"
        echo "   You may need to create it manually at:"
        echo "   https://github.com/organizations/${ORG_NAME}/repositories/new"
        echo "   Name it: ${REPO_NAME}"
        exit 1
    fi
fi

# Add and commit files
echo ""
echo "📁 Staging files..."
git add .
echo "✅ Files staged"

echo ""
echo "💾 Committing changes..."
git commit -m "Initial commit: VPN comparison website" || echo "⚠️  No new changes to commit"

# Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
git branch -M main
if git push -u origin main; then
    echo "✅ Code pushed successfully!"
else
    echo "❌ Push failed. You may need to:"
    echo "   1. Check your authentication: gh auth status"
    echo "   2. Push manually: git push -u origin main"
    exit 1
fi

# Enable GitHub Pages
echo ""
echo "⚙️  Enabling GitHub Pages..."
if gh api -X PATCH "repos/${ORG_NAME}/${REPO_NAME}" -f '{"has_pages":true}' &>/dev/null; then
    # Set pages source
    gh api -X POST "repos/${ORG_NAME}/${REPO_NAME}/pages" \
        -f '{"source":{"branch":"main","path":"/"}}' &>/dev/null || true
    echo "✅ GitHub Pages enabled"
else
    echo "⚠️  Could not automatically enable Pages"
    echo "   Please enable manually:"
    echo "   https://github.com/${ORG_NAME}/${REPO_NAME}/settings/pages"
fi

echo ""
echo "🎉 Deployment Complete!"
echo "======================"
echo ""
echo "✅ Your site is live at:"
echo "   https://${ORG_NAME}.github.io"
echo ""
echo "📋 Next Steps:"
echo "   1. Wait 1-2 minutes for GitHub Pages to build"
echo "   2. Visit: https://${ORG_NAME}.github.io"
echo "   3. Sign up for AdSense: https://www.google.com/adsense"
echo "   4. Add your site URL to AdSense: https://${ORG_NAME}.github.io"
echo "   5. Once approved, run: ./update-adsense.sh"
echo ""
echo "🔧 If Pages doesn't work:"
echo "   Go to: https://github.com/${ORG_NAME}/${REPO_NAME}/settings/pages"
echo "   Enable: Deploy from branch → main → / (root)"
echo ""

