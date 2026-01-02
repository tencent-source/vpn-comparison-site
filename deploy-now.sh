#!/bin/bash

# One-Click Deployment Script
# This will deploy your VPN comparison site to GitHub Pages

set -e

# Suggested organization name (SEO-friendly for VPN comparison)
SUGGESTED_ORG="best-vpn-comparison"

echo "🚀 VPN Comparison Site - Automated Deployment"
echo "============================================="
echo ""

# Check authentication
echo "🔐 Checking GitHub authentication..."
if ! gh auth status &>/dev/null; then
    echo "❌ Not authenticated. Please run: gh auth login"
    exit 1
fi
echo "✅ Authenticated"
echo ""

# Try suggested org name first
ORG_NAME="$SUGGESTED_ORG"
echo "📋 Using organization: ${ORG_NAME}"
echo ""

# Check if org exists
echo "🔍 Checking if organization exists..."
if gh api "orgs/${ORG_NAME}" &>/dev/null 2>&1; then
    echo "✅ Organization found: ${ORG_NAME}"
else
    echo "⚠️  Organization '${ORG_NAME}' not found"
    echo ""
    echo "📝 Creating organization..."
    echo "   Please go to: https://github.com/organizations/new"
    echo "   Create organization with name: ${ORG_NAME}"
    echo "   (Or use a different name and update this script)"
    echo ""
    read -p "Press Enter after creating the organization, or type a different org name: " CUSTOM_ORG
    
    if [ ! -z "$CUSTOM_ORG" ]; then
        ORG_NAME="$CUSTOM_ORG"
        echo "✅ Using organization: ${ORG_NAME}"
    else
        echo "⏳ Waiting for you to create: ${ORG_NAME}"
        echo "   Once created, this script will continue..."
        read -p "Press Enter when organization is created..."
    fi
    
    # Verify org exists now
    if ! gh api "orgs/${ORG_NAME}" &>/dev/null 2>&1; then
        echo "❌ Organization still not found. Please create it first."
        exit 1
    fi
fi

REPO_NAME="${ORG_NAME}.github.io"
REPO_URL="https://github.com/${ORG_NAME}/${REPO_NAME}.git"
SITE_URL="https://${ORG_NAME}.github.io"

echo ""
echo "📦 Repository: ${REPO_NAME}"
echo "🌐 Site URL: ${SITE_URL}"
echo ""

# Update HTML
echo "📝 Updating HTML..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/your-org-name/${ORG_NAME}/g" index.html
else
    sed -i "s/your-org-name/${ORG_NAME}/g" index.html
fi
echo "✅ HTML updated with organization name"
echo ""

# Initialize git
if [ ! -d ".git" ]; then
    echo "📦 Initializing git..."
    git init
    echo "✅ Git initialized"
fi

# Check/create repository
echo "🔍 Checking repository..."
if gh repo view "${ORG_NAME}/${REPO_NAME}" &>/dev/null 2>&1; then
    echo "✅ Repository exists"
    if git remote | grep -q "origin"; then
        git remote set-url origin "$REPO_URL"
    else
        git remote add origin "$REPO_URL"
    fi
else
    echo "📦 Creating repository..."
    if gh repo create "${ORG_NAME}/${REPO_NAME}" --public --source=. --remote=origin --push=false 2>/dev/null; then
        echo "✅ Repository created"
    else
        echo "⚠️  Auto-create failed. Creating manually..."
        echo "   Go to: https://github.com/organizations/${ORG_NAME}/repositories/new"
        echo "   Name: ${REPO_NAME}"
        echo "   Public, no README"
        read -p "Press Enter after creating repository..."
        if git remote | grep -q "origin"; then
            git remote set-url origin "$REPO_URL"
        else
            git remote add origin "$REPO_URL"
        fi
    fi
fi

# Commit and push
echo ""
echo "📁 Staging files..."
git add .
echo "✅ Files staged"

echo ""
echo "💾 Committing..."
git commit -m "Initial commit: VPN comparison website" 2>/dev/null || echo "⚠️  No new changes"

echo ""
echo "🚀 Pushing to GitHub..."
git branch -M main
if git push -u origin main 2>/dev/null; then
    echo "✅ Pushed successfully!"
else
    echo "⚠️  Push failed, trying again..."
    git push -u origin main || {
        echo "❌ Push failed. Please check authentication."
        exit 1
    }
fi

# Enable Pages
echo ""
echo "⚙️  Enabling GitHub Pages..."
sleep 2
gh api -X POST "repos/${ORG_NAME}/${REPO_NAME}/pages" \
    -f '{"source":{"branch":"main","path":"/"}}' 2>/dev/null || {
    echo "⚠️  Auto-enable failed. Please enable manually:"
    echo "   https://github.com/${ORG_NAME}/${REPO_NAME}/settings/pages"
}

echo ""
echo "🎉 DEPLOYMENT COMPLETE!"
echo "======================"
echo ""
echo "✅ Your site is live at:"
echo "   ${SITE_URL}"
echo ""
echo "⏳ Wait 1-2 minutes for GitHub Pages to build"
echo ""
echo "📋 Next Steps:"
echo "   1. Visit: ${SITE_URL}"
echo "   2. Sign up for AdSense: https://www.google.com/adsense"
echo "   3. Add site: ${SITE_URL}"
echo "   4. Once approved, run: ./update-adsense.sh"
echo ""

