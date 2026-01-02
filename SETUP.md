# Quick Setup Guide for GitHub Pages

## Step 1: Create GitHub Organization (if needed)

1. Go to https://github.com/organizations/new
2. Choose "Create a free organization"
3. Choose a name (e.g., `vpn-comparison-org` or your preferred name)
4. Complete the setup

## Step 2: Create Repository

**Option A: Using GitHub Website**
1. Go to your organization page: `https://github.com/YOUR-ORG-NAME`
2. Click "New repository"
3. Repository name MUST be: `YOUR-ORG-NAME.github.io` (replace YOUR-ORG-NAME with your actual org name)
4. Make it Public
5. Don't initialize with README, .gitignore, or license
6. Click "Create repository"

**Option B: Using GitHub CLI (if auth works)**
```bash
cd /Users/ares/vpn-comparison
gh repo create YOUR-ORG-NAME/YOUR-ORG-NAME.github.io --public --source=. --remote=origin
```

## Step 3: Update HTML with Your Organization Name

Before pushing, update the HTML file:

```bash
cd /Users/ares/vpn-comparison
# Replace YOUR-ORG-NAME with your actual organization name
sed -i '' 's/your-org-name/YOUR-ORG-NAME/g' index.html
```

Or manually edit `index.html` and replace all instances of `your-org-name` with your actual organization name.

## Step 4: Initialize Git and Push

```bash
cd /Users/ares/vpn-comparison

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: VPN comparison website"

# Add remote (replace YOUR-ORG-NAME)
git remote add origin https://github.com/YOUR-ORG-NAME/YOUR-ORG-NAME.github.io.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 5: Enable GitHub Pages

1. Go to your repository: `https://github.com/YOUR-ORG-NAME/YOUR-ORG-NAME.github.io`
2. Click "Settings" tab
3. Click "Pages" in the left sidebar
4. Under "Source", select "Deploy from a branch"
5. Choose "main" branch and "/ (root)" folder
6. Click "Save"

Your site will be live at: `https://YOUR-ORG-NAME.github.io` within 1-2 minutes!

## Step 6: Set Up Google AdSense

1. Sign up at https://www.google.com/adsense
2. Once approved, get your Publisher ID (format: `ca-pub-XXXXXXXXXX`)
3. Edit `index.html` and replace:
   - `YOUR_ADSENSE_ID` with your Publisher ID (3 places)
   - `YOUR_AD_SLOT_ID` with your ad slot IDs (2 places)
4. Commit and push the changes:
   ```bash
   git add index.html
   git commit -m "Add AdSense integration"
   git push
   ```
5. Add your site URL in AdSense dashboard for verification

## Troubleshooting

If you get authentication errors:
```bash
gh auth login
# Follow the prompts
```

If you get certificate errors, try:
```bash
gh auth refresh
```

## Next Steps

- Update VPN affiliate links in `index.html`
- Customize colors in `styles.css`
- Add more VPN services as needed
- Monitor AdSense performance

