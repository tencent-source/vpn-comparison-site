# Google AdSense Setup Guide

## Step 1: Sign Up for Google AdSense

1. Go to https://www.google.com/adsense
2. Click "Get Started"
3. Sign in with your Google account
4. Enter your website URL: `https://YOUR-ORG-NAME.github.io`
5. Select your country and payment details
6. Submit for review

**Note:** Approval can take 1-7 days. Google will review your site content and traffic.

## Step 2: Get Your AdSense Publisher ID

Once approved:
1. Log into your AdSense account
2. Go to "Sites" → "Add site" (if not already added)
3. Your Publisher ID will be shown (format: `ca-pub-XXXXXXXXXX`)
4. Copy this ID

## Step 3: Create Ad Units (Optional but Recommended)

1. In AdSense dashboard, go to "Ads" → "By ad unit"
2. Create ad units for different placements:
   - **Banner Ad** (top of page)
   - **In-Article Ad** (middle of content)
   - **Sidebar Ad** (if you add a sidebar later)
3. Each ad unit will have a unique **Ad Slot ID** (format: `1234567890`)
4. Copy these slot IDs

## Step 4: Update Your Website

### Option A: Automated Script (Recommended)

Run this script after you get your AdSense ID:

```bash
cd /Users/ares/vpn-comparison
./update-adsense.sh
```

The script will ask for:
- Your Publisher ID (ca-pub-XXXXXXXXXX)
- Banner Ad Slot ID (optional)
- In-Article Ad Slot ID (optional)

### Option B: Manual Update

1. Open `index.html`
2. Find and replace `YOUR_ADSENSE_ID` with your Publisher ID (3 places)
3. Find and replace `YOUR_AD_SLOT_ID` with your ad slot IDs (2 places)
4. Save and commit:
   ```bash
   git add index.html
   git commit -m "Add AdSense integration"
   git push
   ```

## Step 5: Verify AdSense Integration

1. After pushing changes, wait 5-10 minutes for GitHub Pages to update
2. Visit your site: `https://YOUR-ORG-NAME.github.io`
3. Check that ads are displaying (may take a few hours after approval)
4. In AdSense dashboard, go to "Sites" and verify your site is connected

## Step 6: Monitor Performance

- Check AdSense dashboard regularly for earnings
- Monitor which ad placements perform best
- Adjust ad positions if needed

## Troubleshooting

**Ads not showing?**
- Wait 24-48 hours after approval
- Check browser console for errors
- Verify Publisher ID is correct
- Ensure site is verified in AdSense

**Site not approved?**
- Make sure you have original content (not just copied)
- Ensure site is live and accessible
- Add more content if needed
- Follow AdSense policies strictly

## AdSense Policies to Follow

✅ **DO:**
- Create original, valuable content
- Follow Google's content policies
- Place ads naturally in content
- Maintain good user experience

❌ **DON'T:**
- Click your own ads
- Ask others to click ads
- Place ads too close together
- Use misleading content

## Quick Reference

- **Publisher ID format:** `ca-pub-XXXXXXXXXX`
- **Ad Slot ID format:** `1234567890` (numbers only)
- **Your site URL:** `https://YOUR-ORG-NAME.github.io`

