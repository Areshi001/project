# Deploy to Vercel - Step by Step

Your CV Platform is ready to deploy! Follow these exact steps to go live in 5 minutes.

## Step 0: Prepare Supabase (2 minutes)

### Create Supabase Project
1. Go to https://supabase.com
2. Click "Start your project"
3. Sign up with email or GitHub
4. Click "New project"
5. Fill in:
   - Organization: Create or select
   - Name: "cv-platform"
   - Database password: (save this safely!)
   - Region: Closest to you
6. Click "Create new project"
7. Wait 3-5 minutes for database to initialize

### Get Your Keys
1. Once project is created, click into it
2. Go to **Settings** > **API** (left sidebar)
3. You'll see:
   - **Project URL** - Copy this (starts with https://)
   - **Anon public** - Copy this (long JWT string with 'eyJ...')
4. **Save these two values** - you'll need them in 2 minutes

### Create Storage Bucket
1. Go to **Storage** (left sidebar)
2. Click **Create a new bucket**
3. Name: `project-images`
4. Check **Public bucket** ✓
5. Click **Create bucket**

Done! Now you have your Supabase credentials.

## Step 1: Push Code to GitHub (1 minute)

### If you don't have git set up locally:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Initialize and push:
```bash
# From your project directory
git init
git add .
git commit -m "CV Platform - Ready for Vercel deployment"

# Create a NEW repository on GitHub (github.com/new)
# Then run this (replace YOUR_USERNAME and repo-name):
git remote add origin https://github.com/YOUR_USERNAME/repo-name.git
git branch -M main
git push -u origin main
```

Done! Your code is on GitHub.

## Step 2: Deploy to Vercel (2 minutes)

### Connect Vercel to GitHub:
1. Go to https://vercel.com/new
2. You'll see GitHub option at top
3. Click **"GitHub"** button
4. Authorize Vercel (one-time)
5. Select your new repository
6. Click **"Import"**

### Configure Environment Variables:
In the next screen, you'll see "Environment Variables"

Add TWO variables:
```
Name:  VITE_SUPABASE_URL
Value: (Paste your Supabase Project URL from Step 0)

Name:  VITE_SUPABASE_ANON_KEY
Value: (Paste your Supabase Anon Key from Step 0)
```

Make sure:
- ✓ No extra spaces before/after
- ✓ Scope set to "Production"
- ✓ Both variables added

### Deploy:
1. Click **"Deploy"**
2. Wait 2-3 minutes for build to complete
3. You'll see "Congratulations! Deployment successful"
4. Click the domain shown (something like `cv-platform-abc123.vercel.app`)

**You're live!** 🎉

## Verify It's Working

Visit your Vercel domain:
1. Click on the domain link in Vercel
2. You should see the CV Platform landing page
3. Try creating a test project
4. Try uploading a test image
5. Verify images appear in your Supabase storage bucket

## Make It Your Own

### Add Custom Domain (Optional)
1. In Vercel dashboard, go to project **Settings**
2. Click **"Domains"**
3. Type your domain name (e.g., cv-platform.com)
4. Follow DNS configuration instructions
5. Wait 24 hours for DNS to propagate
6. SSL certificate auto-issued

### Customize The App
Edit these files and push to GitHub (auto-redeploys):
- **Site name**: `src/components/Layout.tsx` line 11
- **Colors**: `tailwind.config.js`
- **Branding**: `public/favicon.ico`

Changes auto-deploy within 1-2 minutes!

## Troubleshooting

### Build failed on Vercel
- Check env variables have no typos
- Click "Redeploy" button
- Check build logs for errors

### "Cannot find module" error
- Verify package.json has all dependencies
- Run `npm install` locally
- Push to GitHub to trigger rebuild

### Images not uploading
- Verify storage bucket is public
- Check bucket is named exactly `project-images`
- Check browser console for errors (F12 > Console)

### Database connection error
- Verify VITE_SUPABASE_URL starts with `https://`
- Verify VITE_SUPABASE_ANON_KEY is the public key (starts with eyJ)
- Redeploy after checking variables

## What's Included

Your deployed app has:
✅ Project management (create/delete/view projects)
✅ Image uploading (drag-and-drop)
✅ Dataset organization (train/val/test splits)
✅ Supabase database (automatically synced)
✅ Global CDN (fast delivery worldwide)
✅ Automatic deployments (on every git push)

Ready to build more:
- Annotation tool
- Workflow builder
- Public dataset hub

## Next Steps

### Share Your App
Send this URL to anyone:
```
https://your-domain.vercel.app
```

### Continue Development
Make changes to code → Commit → Push to GitHub → Auto-deploys in 1-2 min

### Scale When Needed
Free tier included:
- 100 automatic deployments/month
- Up to 3 team members
- Preview deployments for PRs

Upgrade when:
- Team > 3 people
- Need private deployments
- Want production analytics

### Deploy Source Code
The zip file includes everything:
- Full source code
- Database schema
- Type definitions
- Documentation
- Vercel config

No additional setup needed!

## Important: Environment Variables

These are already in `.env` file but also set them in Vercel Dashboard:

| Variable | Where to Get |
|----------|-------------|
| VITE_SUPABASE_URL | Supabase Settings > API > Project URL |
| VITE_SUPABASE_ANON_KEY | Supabase Settings > API > Anon public |

These are **public** credentials (safe to embed in frontend).

## Need Help?

### Check These Resources
- README.md - Full documentation
- DEPLOYMENT.md - Detailed deployment guide
- QUICK_START.md - Another quick guide
- Supabase Docs - https://supabase.com/docs
- Vercel Docs - https://vercel.com/docs

### Common Questions

**Q: Can I use a custom domain?**
A: Yes! Add it in Vercel Settings > Domains (see "Add Custom Domain" above)

**Q: Will this cost money?**
A: No! Free tier covers:
- Vercel hosting
- Supabase database (100MB)
- Supabase storage (500MB)

**Q: How do I update the site?**
A: Edit files → commit → push to GitHub → auto-deploys in 1-2 min

**Q: Where are my images stored?**
A: Supabase Storage bucket `project-images`

**Q: Can I download my data?**
A: Yes! Export from Supabase dashboard anytime

## Final Checklist

Before sharing with others:
- [ ] Supabase project created
- [ ] Storage bucket `project-images` created and public
- [ ] Code pushed to GitHub
- [ ] Vercel project deployed
- [ ] Environment variables set in Vercel
- [ ] Domain working (can see the app)
- [ ] Can create a test project
- [ ] Can upload a test image
- [ ] Ready to share!

## You're Done!

Your CV Platform is live on the internet!

Share the Vercel URL with:
- Your team
- Investors
- Friends
- The world!

Next: Build out Modules 2-4 based on user feedback, then you have a complete product.

---

Questions? See the included documentation:
- README.md
- DEPLOYMENT.md
- PROJECT_SUMMARY.md
- QUICK_START.md
