# Quick Start Guide - Deploy to Vercel

Get your CV Platform deployed to Vercel in 5 minutes.

## Prerequisites

- GitHub account (free at github.com)
- Vercel account (free at vercel.com)
- Supabase account (free at supabase.com)

## Step 1: Get Your Supabase Keys (2 min)

1. Go to https://supabase.com and create a free project
2. Wait for project to initialize (2-3 minutes)
3. Go to **Settings > API** in the left sidebar
4. Copy and save these two values:
   - **Project URL** (starts with `https://`)
   - **Anon public key** (long JWT string)

Create a bucket:
1. Go to **Storage** section
2. Click **Create a new bucket**
3. Name it: `project-images`
4. Check the "Public" checkbox
5. Click Create

## Step 2: Push to GitHub (1 min)

```bash
# Initialize git if needed
git init

# Add all files
git add .

# Commit
git commit -m "CV Platform MVP - Ready for deployment"

# Create repo on GitHub at github.com/new
# Then push (replace YOUR_USERNAME and repo-name):
git remote add origin https://github.com/YOUR_USERNAME/repo-name.git
git branch -M main
git push -u origin main
```

## Step 3: Deploy to Vercel (2 min)

1. Go to https://vercel.com/new
2. Click "Select" next to GitHub in the import options
3. Authorize Vercel with GitHub if prompted
4. Select your repository
5. Click "Import"
6. Configure environment variables:
   - Name: `VITE_SUPABASE_URL`
     Value: (paste your Supabase Project URL)
   - Name: `VITE_SUPABASE_ANON_KEY`
     Value: (paste your Supabase Anon key)
7. Click "Deploy"
8. Wait for build to complete (~2 minutes)

**Done!** Your app is live at the URL shown on screen.

## What You Get

✅ Full-featured CV Platform with:
- Project management
- Image upload & organization
- Dataset versioning
- Placeholder components for:
  - Annotation tool
  - Workflow builder
  - Public dataset hub

✅ Production-ready:
- Optimized Vite build
- Global CDN via Vercel
- Database with Supabase
- Automatic deployments on git push

✅ Zero-cost:
- Free Vercel deployment
- Free Supabase database & storage
- No credit card required

## Next Steps

### Test It Out
1. Visit your Vercel URL
2. Create a test project
3. Upload some images
4. Explore the features

### Customize
- Edit `src/components/Layout.tsx` to change colors
- Update project name in `package.json`
- Add your logo/branding

### Continue Building
The foundation is complete. Next phase:
- [ ] Implement annotation canvas (Module 2)
- [ ] Build workflow builder (Module 3)
- [ ] Create public dataset hub (Module 4)
- [ ] Add user authentication
- [ ] Deploy to custom domain

### Get Help
- Stuck? Check README.md for detailed docs
- Deployment issues? See DEPLOYMENT.md
- Need features? Module specs in spec.pdf

## Troubleshooting

### Build Failed on Vercel
- Check environment variables are added exactly
- No extra spaces in values
- Redeploy from Vercel dashboard

### Images Not Uploading
- Verify `project-images` bucket exists and is public
- Check browser console for errors
- Verify Supabase credentials in .env

### Database Connection Error
- Verify VITE_SUPABASE_URL starts with https://
- Check VITE_SUPABASE_ANON_KEY is the public key
- Restart Vercel deployment

## Share Your App

Your deployed app is live! Share the Vercel URL with:
- Team members
- Users
- Investors
- GitHub community

The free tier is perfect for demos and testing.

---

**Congratulations! Your CV Platform is now live on Vercel.**

For advanced setup and customization, see README.md and DEPLOYMENT.md.
