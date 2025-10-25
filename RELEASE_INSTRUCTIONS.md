# GitHub Release Creation Instructions - v0.1.0-alpha

## Quick Summary

Two methods to create the GitHub Release for MAestro v0.1.0-alpha:

**Method 1 (Recommended):** Use provided scripts with GitHub Personal Access Token
**Method 2:** Manual creation via GitHub web interface

---

## Method 1: Automated Script

### Prerequisites

You need a GitHub Personal Access Token with `repo` scope:

1. Go to: https://github.com/settings/tokens/new
2. Select scopes:
   - ✓ `repo` (Full control of private repositories)
   - ✓ `workflow` (Update GitHub Action workflows) - Optional
3. Click "Generate token"
4. **Copy the token immediately** (you won't see it again!)

### Windows (PowerShell)

```powershell
# Option A: Set environment variable first
$env:GITHUB_TOKEN = "ghp_your_token_here"
.\create-release.ps1

# Option B: Pass token directly
.\create-release.ps1 -GitHubToken "ghp_your_token_here"
```

**Expected Output:**
```
🚀 Creating GitHub Release...
Repository: wmerzhan/meta
Tag: v0.1.0-alpha
Title: MAestro v0.1.0-alpha - MVP Release

Sending request to GitHub API...

✅ Release created successfully!
📍 URL: https://github.com/wmerzhan/meta/releases/tag/v0.1.0-alpha
```

### macOS/Linux (Bash)

```bash
# Option A: Set environment variable
export GITHUB_TOKEN="ghp_your_token_here"
bash create-release.sh

# Option B: Run with token
GITHUB_TOKEN="ghp_your_token_here" bash create-release.sh
```

---

## Method 2: Manual Web Interface (No Token Needed)

### Step-by-Step Instructions

#### 1. Navigate to Releases Page
- Go to: https://github.com/wmerzhan/meta/releases
- Click **"Create a new release"** button (top right)

#### 2. Fill in Release Details

**Tag Name:**
```
v0.1.0-alpha
```

**Target Branch:**
- Select: `master`
- Click **"Create new tag on publish"**

**Release Title:**
```
MAestro v0.1.0-alpha - MVP Release
```

#### 3. Copy Release Notes

**Option A: Full Content**
1. Open: `RELEASE_NOTES.md` in the repository
2. Copy ALL content
3. Paste into GitHub "Describe this release" field

**Option B: Short Summary**
```markdown
## 🎉 MAestro MVP (Minimum Viable Product) - Version 0.1.0-alpha

### What's Included

**Prompt Templates (v1.1.0)**
- 🔬 **Microscope v1.1.0** - AI-guided data extraction with three-tier confidence labeling (🟢🟡🔴)
- 📊 **Compiler v1.1.0** - Structured dataset compilation into analysis-ready formats
- 🎯 **Oracle v1.1.0** - Reproducible analysis generation with R/Python code

### Key Metrics
- ✅ 20/20 QA gates PASS (100% success rate)
- ✅ 7 beta testers across disciplines validated
- ✅ 11 papers tested across 3 disciplines
- ✅ Full documentation and case studies included

### Getting Started
1. Clone: `git clone https://github.com/wmerzhan/meta.git`
2. Read: `docs/quickstart.md`
3. Join: GitHub Discussions & Issues

See full release notes in RELEASE_NOTES.md for complete details.
```

#### 4. Set Release Type

- ✓ Check: **"This is a pre-release"** (alpha status)
- Leave unchecked: "This is a latest release"

#### 5. Publish

- Click **"Publish release"** button
- Confirm if prompted

#### 6. Verify

- Release should appear in: https://github.com/wmerzhan/meta/releases
- GitHub notifications sent to watchers
- Badge on main page updates to show version

---

## Verification Checklist

After creating the release, verify these items:

- [ ] Release visible at: https://github.com/wmerzhan/meta/releases/tag/v0.1.0-alpha
- [ ] Tag `v0.1.0-alpha` created and linked correctly
- [ ] Release notes display with proper formatting
- [ ] Pre-release badge shows "Pre-release"
- [ ] Badge on repository shows version `0.1.0-alpha`
- [ ] Documentation links work
- [ ] GitHub Actions Deploy Docs runs successfully

---

## Post-Release Actions

### 1. Create Announcement in Discussions

**URL:** https://github.com/wmerzhan/meta/discussions/new

**Category:** Announcements

**Title:**
```
🎉 MAestro v0.1.0-alpha MVP Release - Community Launch
```

**Body:**
```markdown
We're thrilled to announce the official release of **MAestro v0.1.0-alpha**!

## What This Means
This is our MVP (Minimum Viable Product) - all core functionality is complete and validated:
- 20/20 QA gates PASS ✅
- 7 beta testers across disciplines ✅
- Production-ready prompt templates ✅
- Comprehensive documentation ✅

## Getting Started
👉 [Download v0.1.0-alpha](https://github.com/wmerzhan/meta/releases/tag/v0.1.0-alpha)
📖 [Documentation](https://maestro-meta.github.io)
🚀 [Quick Start](https://maestro-meta.github.io/quickstart/)

## Share Your Feedback
- 🐛 [Report issues](https://github.com/wmerzhan/meta/issues)
- 💬 [Join discussions](https://github.com/wmerzhan/meta/discussions)
- ⭐ [Star the repository](https://github.com/wmerzhan/meta)

Let's transform meta-analysis workflows together! 🔬
```

### 2. Share on Social Media

**GitHub Release:** https://github.com/wmerzhan/meta/releases/tag/v0.1.0-alpha

**Documentation:** https://maestro-meta.github.io

**Sample Messages:**

```
🎉 Excited to announce MAestro v0.1.0-alpha - the MVP release of our AI-assisted meta-analysis framework!

✅ 20/20 QA gates passing
✅ 7 researchers validated
✅ Ready for production use

Join the community: https://github.com/wmerzhan/meta

#ResearchTech #MetaAnalysis #AI #OpenSource
```

### 3. Track Initial Metrics

Update your spreadsheet with:
- Release date: October 25, 2025
- Initial GitHub stars: [check on release day]
- Initial watchers: [check on release day]
- Initial discussions: [count in discussions]

See `docs/launch/metrics-dashboard.md` for full tracking details.

---

## Troubleshooting

### Script Fails with "Token not found"

**Solution:**
1. Verify token is set:
   - PowerShell: `$env:GITHUB_TOKEN`
   - Bash: `echo $GITHUB_TOKEN`
2. Generate new token at: https://github.com/settings/tokens/new
3. Ensure token has `repo` scope
4. Try again

### Script Says "Release creation failed"

**Common causes:**
1. **Invalid token** - Generate a new one
2. **Token expired** - Regenerate with new expiration
3. **Token lacks permissions** - Ensure `repo` scope is selected
4. **Tag already exists** - Cannot create duplicate release
   - Solution: Delete tag and try again, or change tag version

**Delete existing tag:**
```bash
git tag -d v0.1.0-alpha
git push origin :refs/tags/v0.1.0-alpha
```

### Web Interface Says "Tag already exists"

**Solution:**
Use Method 1 with the existing tag (release will be created without creating new tag)

### Release Created But Docs Aren't Building

**Check:**
1. GitHub Actions status: https://github.com/wmerzhan/meta/actions
2. Deploy Docs workflow should show ✅ passed
3. If failed, check workflow logs for mkdocs errors

**Manual fix:**
1. Go to: https://github.com/wmerzhan/meta/actions
2. Find "Deploy Docs" workflow
3. Click latest run
4. Check logs for specific error
5. If China character anchor issues - this is expected warning, not error

---

## FAQs

**Q: Why do I need a token?**
A: GitHub API requires authentication. Personal tokens are safe - they're only valid for your account and can be revoked anytime.

**Q: Can I use my GitHub password instead?**
A: No, GitHub requires Personal Access Tokens for API authentication. Passwords are disabled for security.

**Q: What permissions does the token need?**
A: Minimum is `repo` scope. That's it - no need for write access to workflows or other permissions.

**Q: Is my token secure?**
A: Yes. The script only uses it to create a release. Never commit your token to Git.

**Q: What if I lose my token?**
A: Go to https://github.com/settings/tokens and generate a new one. Old one is automatically invalid.

**Q: Can I use the web interface instead of scripts?**
A: Yes! Method 2 works perfectly and requires no token. Just go to the releases page and fill in the form.

---

## Help & Support

- 🆘 Script issues? Check GitHub Actions logs
- ❓ GitHub questions? Visit: https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository
- 🐛 Found a bug? Open an issue in the repo

---

**Ready to launch? Pick a method and follow the steps above!** 🚀
