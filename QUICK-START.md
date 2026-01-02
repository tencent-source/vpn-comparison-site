# 🚀 Quick Start Guide

## Complete Setup in 3 Steps

### Step 1: Deploy to GitHub Pages
```bash
cd /Users/ares/vpn-comparison
./quick-deploy.sh
```
Follow the prompts and enable GitHub Pages in repository settings.

### Step 2: Sign Up for Google AdSense
1. Go to https://www.google.com/adsense
2. Sign up with your Google account
3. Enter your website: `https://YOUR-ORG-NAME.github.io`
4. Wait for approval (1-7 days)

### Step 3: Add AdSense to Your Site
Once approved, get your Publisher ID from AdSense dashboard, then run:
```bash
cd /Users/ares/vpn-comparison
./update-adsense.sh
```

Enter your Publisher ID when prompted, commit and push:
```bash
git add index.html
git commit -m "Add AdSense integration"
git push
```

**That's it!** Your site is now live with AdSense! 🎉

---

## Need Help?

- **Full setup guide:** See `SETUP.md`
- **AdSense details:** See `adsense-setup.md`
- **Troubleshooting:** Check the README.md

