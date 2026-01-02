#!/bin/bash

# AdSense Integration Update Script
# This script updates your index.html with AdSense IDs

set -e

echo "🔧 AdSense Integration Setup"
echo "============================"
echo ""

# Check if index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found!"
    echo "   Please run this script from the vpn-comparison directory"
    exit 1
fi

# Get Publisher ID
echo "Enter your Google AdSense Publisher ID"
echo "(Format: ca-pub-XXXXXXXXXX)"
read -p "Publisher ID: " PUBLISHER_ID

if [ -z "$PUBLISHER_ID" ]; then
    echo "❌ Publisher ID is required!"
    exit 1
fi

# Validate format (basic check)
if [[ ! "$PUBLISHER_ID" =~ ^ca-pub-[0-9]+$ ]]; then
    echo "⚠️  Warning: Publisher ID format looks incorrect"
    echo "   Expected format: ca-pub-XXXXXXXXXX"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Get Ad Slot IDs (optional)
echo ""
echo "Enter your Ad Slot IDs (optional - press Enter to skip)"
read -p "Banner Ad Slot ID: " BANNER_SLOT
read -p "In-Article Ad Slot ID: " ARTICLE_SLOT

# Create backup
echo ""
echo "📋 Creating backup..."
cp index.html index.html.backup
echo "✅ Backup created: index.html.backup"

# Update Publisher ID (3 places)
echo ""
echo "🔄 Updating Publisher ID..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/ca-pub-YOUR_ADSENSE_ID/${PUBLISHER_ID}/g" index.html
else
    # Linux
    sed -i "s/ca-pub-YOUR_ADSENSE_ID/${PUBLISHER_ID}/g" index.html
fi
echo "✅ Publisher ID updated (3 locations)"

# Update Ad Slot IDs if provided
if [ ! -z "$BANNER_SLOT" ]; then
    echo "🔄 Updating Banner Ad Slot ID..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Update first occurrence (banner ad around line 68)
        sed -i '' "68s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${BANNER_SLOT}\"/" index.html
    else
        # Update first occurrence (banner ad)
        sed -i "68s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${BANNER_SLOT}\"/" index.html
    fi
    echo "✅ Banner Ad Slot ID updated"
fi

if [ ! -z "$ARTICLE_SLOT" ]; then
    echo "🔄 Updating In-Article Ad Slot ID..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Update second occurrence (in-article ad around line 196)
        sed -i '' "196s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${ARTICLE_SLOT}\"/" index.html
    else
        # Update second occurrence (in-article ad)
        sed -i "196s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${ARTICLE_SLOT}\"/" index.html
    fi
    echo "✅ In-Article Ad Slot ID updated"
fi

# If only one slot ID provided, use it for both
if [ ! -z "$BANNER_SLOT" ] && [ -z "$ARTICLE_SLOT" ]; then
    echo "💡 Using Banner Slot ID for In-Article ad as well..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "196s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${BANNER_SLOT}\"/" index.html
    else
        sed -i "196s/data-ad-slot=\"YOUR_AD_SLOT_ID\"/data-ad-slot=\"${BANNER_SLOT}\"/" index.html
    fi
    echo "✅ In-Article Ad Slot ID updated (using Banner ID)"
fi

if [ -z "$BANNER_SLOT" ] && [ -z "$ARTICLE_SLOT" ]; then
    echo "⚠️  No ad slot IDs provided - ads will use auto-placement"
    echo "   You can add slot IDs later for better control"
fi

echo ""
echo "✅ AdSense integration complete!"
echo ""
echo "📋 Next steps:"
echo "1. Review the changes:"
echo "   diff index.html.backup index.html"
echo ""
echo "2. Commit and push to GitHub:"
echo "   git add index.html"
echo "   git commit -m 'Add AdSense integration'"
echo "   git push"
echo ""
echo "3. Verify in AdSense dashboard that your site is connected"
echo ""
echo "💡 Tip: If you need to revert, use: cp index.html.backup index.html"
echo ""

