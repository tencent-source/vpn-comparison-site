# 🚀 Final Deployment Steps

Your site is ready! Follow these steps to deploy:

## Step 1: Create GitHub Organization

1. Go to: **https://github.com/organizations/new**
2. Choose a name (suggested: `best-vpn-comparison` or `vpn-comparison-guide`)
3. Complete the setup (takes 30 seconds)

## Step 2: Create Repository

1. Go to your organization page
2. Click "New repository"
3. **IMPORTANT:** Name it exactly: `YOUR-ORG-NAME.github.io`
   - Example: If org is `best-vpn-comparison`, repo is `best-vpn-comparison.github.io`
4. Make it **Public**
5. **Don't** initialize with README, .gitignore, or license
6. Click "Create repository"

## Step 3: Deploy (Run This)

Open terminal and run:

```bash
cd /Users/ares/vpn-comparison

# Update HTML with your org name (replace YOUR-ORG-NAME)
sed -i '' 's/your-org-name/YOUR-ORG-NAME/g' index.html

# Add remote and push
git remote add origin https://github.com/YOUR-ORG-NAME/YOUR-ORG-NAME.github.io.git
git branch -M main
git add .
git commit -m "Initial commit: VPN comparison website"
git push -u origin main
```

## Step 4: Enable GitHub Pages

1. Go to: `https://github.com/YOUR-ORG-NAME/YOUR-ORG-NAME.github.io/settings/pages`
2. Under "Source": Select "Deploy from a branch"
3. Branch: `main`, Folder: `/ (root)`
4. Click "Save"

## Step 5: Your Site is Live! 🎉

Visit: **https://YOUR-ORG-NAME.github.io**

Wait 1-2 minutes for GitHub to build the site.

---

## Quick Command (After Creating Org & Repo)

Replace `YOUR-ORG-NAME` with your actual org name, then run:

```bash
cd /Users/ares/vpn-comparison
ORG="YOUR-ORG-NAME"
sed -i '' "s/your-org-name/${ORG}/g" index.html
git remote add origin https://github.com/${ORG}/${ORG}.github.io.git 2>/dev/null || git remote set-url origin https://github.com/${ORG}/${ORG}.github.io.git
git branch -M main
git add .
git commit -m "Initial commit: VPN comparison website"
git push -u origin main
```

Then enable Pages in repository settings!

