#!/bin/bash

# MAestro v0.1.0-alpha Release Creation Script
# This script creates a GitHub Release using the GitHub REST API

set -e

# Configuration
OWNER="wmerzhan"
REPO="meta"
TAG="v0.1.0-alpha"
RELEASE_TITLE="MAestro v0.1.0-alpha - MVP Release"

# Check if token is provided
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Error: GITHUB_TOKEN environment variable not set"
    echo ""
    echo "To create a release, you need a GitHub Personal Access Token:"
    echo "1. Go to: https://github.com/settings/tokens/new"
    echo "2. Create a token with 'repo' scope"
    echo "3. Set environment variable: export GITHUB_TOKEN=your_token_here"
    echo "4. Re-run this script"
    exit 1
fi

echo "🚀 Creating GitHub Release..."
echo "Repository: $OWNER/$REPO"
echo "Tag: $TAG"
echo "Title: $RELEASE_TITLE"
echo ""

# Read release notes from file
RELEASE_NOTES=$(cat RELEASE_NOTES.md)

# Escape quotes in release notes
RELEASE_NOTES_JSON=$(echo "$RELEASE_NOTES" | jq -Rs .)

# Create release using GitHub API
API_URL="https://api.github.com/repos/$OWNER/$REPO/releases"

echo "Sending request to GitHub API..."

RESPONSE=$(curl -s -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$API_URL" \
  -d "{
    \"tag_name\": \"$TAG\",
    \"target_commitish\": \"master\",
    \"name\": \"$RELEASE_TITLE\",
    \"body\": $RELEASE_NOTES_JSON,
    \"draft\": false,
    \"prerelease\": true
  }")

# Check if release was created successfully
if echo "$RESPONSE" | grep -q '"id":'; then
    RELEASE_URL=$(echo "$RESPONSE" | jq -r '.html_url')
    echo ""
    echo "✅ Release created successfully!"
    echo "📍 URL: $RELEASE_URL"
    echo ""
    echo "Next steps:"
    echo "1. Visit the release page above to verify"
    echo "2. Share the release with the community"
    echo "3. Create announcement in GitHub Discussions"
else
    echo ""
    echo "❌ Release creation failed"
    echo "Response:"
    echo "$RESPONSE" | jq '.' || echo "$RESPONSE"
    exit 1
fi
