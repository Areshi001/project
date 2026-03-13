# Deployment Guide - CV Platform

This guide covers deploying the CV Platform to Vercel for production use.

## Prerequisites

1. **Supabase Project**
   - Create a free account at https://supabase.com
   - Create a new project
   - Note your Project URL and Anon Key from Settings > API

2. **Vercel Account**
   - Create a free account at https://vercel.com
   - Connect your GitHub account (recommended)

3. **Git Repository**
   - Push code to GitHub or GitLab

## Step 1: Prepare Your Supabase Project

### Set up Storage Bucket

1. Go to your Supabase dashboard
2. Navigate to **Storage** section
3. Click **Create a new bucket**
4. Name: `project-images`
5. Public checkbox: **checked**
6. Click **Create bucket**

### Verify Database Tables

The database schema is automatically created via migrations. Verify all tables exist:
- projects
- images
- annotations
- label_classes
- workflows
- public_datasets
- dataset_likes

Check the **SQL Editor** tab to verify schema.

## Step 2: Deploy to Vercel

### Option A: Via GitHub (Recommended)

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Initial CV Platform deployment"
   git push origin main
   ```

2. **Connect to Vercel**
   - Go to https://vercel.com/new
   - Select your GitHub repository
   - Click "Import"

3. **Configure Project**
   - **Framework**: Vite
   - **Build Command**: `npm run build` (auto-detected)
   - **Output Directory**: `dist` (auto-detected)
   - **Environment Variables**: Add these settings:
     - `VITE_SUPABASE_URL`: Your Supabase Project URL
     - `VITE_SUPABASE_ANON_KEY`: Your Supabase Anon Key

4. **Deploy**
   - Click "Deploy"
   - Wait for build to complete
   - Your app will be live at a *.vercel.app domain

### Option B: Via Vercel CLI

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Deploy**
   ```bash
   vercel
   ```

3. **Follow prompts**
   - Link to existing Vercel project or create new
   - Add environment variables when prompted
   - Confirm deployment

### Option C: Using Docker (Advanced)

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "run", "preview"]
```

## Step 3: Configure Environment Variables

### In Vercel Dashboard

1. Go to your project settings
2. Navigate to **Environment Variables**
3. Add the following variables:
   ```
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```
4. Set environment scope to **Production**, **Preview**, and **Development**
5. Redeploy to apply changes

### Production Settings

For enhanced security in production:

1. **Supabase Dashboard > Settings > Authentication**
   - Disable email confirmation (currently disabled)
   - Configure JWT expiry if adding auth later

2. **Supabase Dashboard > Storage > project-images**
   - Configure bucket policies if needed
   - Enable CORS for your Vercel domain

3. **Vercel > Settings > Security**
   - Configure password protection if needed
   - Set up preview deployment protection

## Step 4: Configure Custom Domain (Optional)

1. Go to Vercel project **Settings > Domains**
2. Click **Add custom domain**
3. Enter your domain name
4. Follow DNS configuration instructions
5. Vercel will issue free SSL certificate automatically

## Step 5: Post-Deployment Verification

### Test the Application

1. Visit your Vercel deployment URL
2. Test each feature:
   - Create a project
   - Upload test images
   - Verify database writes working

### Monitor Performance

1. Vercel Analytics
   - Dashboard shows real-time metrics
   - Check Core Web Vitals
   - Monitor bandwidth usage

2. Supabase Metrics
   - Check database performance
   - Monitor API usage
   - Review error logs

### Check Logs

**Vercel Logs:**
- Go to **Deployments** tab
- Click latest deployment
- View build and runtime logs

**Supabase Logs:**
- Go to **Logs** section
- Check database and auth logs
- Monitor API usage

## Continuous Deployment

### Automatic Deployments

Every push to main branch automatically redeploys:

1. Vercel watches your GitHub repository
2. On push, automatically builds and deploys
3. Preview deployments for pull requests
4. Production deployment only from main branch

### Rollback

If deployment fails:
1. Go to **Deployments** tab
2. Find previous successful deployment
3. Click **•••** menu and select **Promote to Production**

## Scaling & Performance

### Database Performance

For larger datasets, add indexes:
```sql
CREATE INDEX idx_images_projectId ON images(projectId);
CREATE INDEX idx_annotations_imageId ON annotations(imageId);
```

### CDN & Caching

Vercel automatically:
- Serves assets from global CDN
- Compresses resources (gzip/brotli)
- Caches immutable assets
- Optimizes images automatically

### Database Connections

Supabase free tier limits:
- 100MB database size
- 500MB storage
- 1GB transfer
- 2 concurrent connections

For production, consider upgrading to Pro tier.

## Security Checklist

- [ ] Environment variables set in Vercel
- [ ] Supabase RLS policies configured
- [ ] Storage bucket permissions set
- [ ] Custom domain configured (if needed)
- [ ] SSL certificate active
- [ ] Database backups enabled (Supabase)
- [ ] Monitoring alerts configured
- [ ] Error logging enabled

## Monitoring & Alerts

### Set up Monitoring

1. **Vercel Analytics**
   - Enable in project settings
   - Monitor performance metrics
   - Set up critical alerts

2. **Supabase Alerts**
   - Set up database size alerts
   - Configure storage alerts
   - Enable error notifications

## Troubleshooting Deployment

### Build Failures

**Error: Missing environment variables**
- Add VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY
- Redeploy after adding

**Error: npm audit issues**
- Fix known vulnerabilities: `npm audit fix`
- Commit and push changes
- Redeploy

### Runtime Errors

**Supabase connection fails**
- Verify environment variables correct
- Check Supabase project is active
- Verify network connectivity

**Images not uploading**
- Verify `project-images` bucket exists
- Check bucket is public
- Review Supabase logs

## Database Backups

### Automatic Backups

Supabase Pro tier includes automatic daily backups. For free tier:

```bash
# Backup locally
supabase db pull
```

### Restore from Backup

1. Go to Supabase > Settings > Backups
2. Find desired backup point
3. Click "Restore"
4. Confirm restoration

## Maintenance

### Regular Tasks

- [ ] Monitor error logs weekly
- [ ] Review performance metrics
- [ ] Update dependencies monthly
- [ ] Test backup restoration quarterly
- [ ] Review security settings quarterly

### Updates

To update dependencies:
```bash
npm update
npm audit fix
git commit -am "Update dependencies"
git push
```

Vercel will automatically redeploy.

## Support & Resources

- **Vercel Docs**: https://vercel.com/docs
- **Supabase Docs**: https://supabase.com/docs
- **React Flow Docs**: https://reactflow.dev
- **Vite Docs**: https://vitejs.dev

## Cost Estimation

### Supabase (Free Tier)
- 100MB database: sufficient for MVP
- 500MB storage: ~500-1000 images
- Cost: $0/month

### Vercel (Free Tier)
- Unlimited deployments
- Automatic SSL
- Global CDN
- Cost: $0/month (can upgrade if needed)

**Total Cost: $0 for MVP phase**

Upgrade to Pro tiers ($25-100/month each) when:
- Database > 100MB
- Storage > 500MB
- Need priority support
- Require advanced analytics

---

**Your CV Platform is now live on Vercel!**

Next steps:
1. Share your Vercel URL with users
2. Configure custom domain (optional)
3. Monitor performance
4. Iterate based on user feedback
