# MAestro v0.1.0-alpha Release Creation Script (PowerShell)
# This script creates a GitHub Release using the GitHub REST API

param(
    [Parameter(Mandatory=$false)]
    [string]$GitHubToken
)

# Configuration
$Owner = "wmerzhan"
$Repo = "meta"
$Tag = "v0.1.0-alpha"
$ReleaseTitle = "MAestro v0.1.0-alpha - MVP Release"
$ApiUrl = "https://api.github.com/repos/$Owner/$Repo/releases"

# Get token from parameter or environment variable
if ([string]::IsNullOrEmpty($GitHubToken)) {
    $GitHubToken = $env:GITHUB_TOKEN
}

if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "❌ Error: GitHub Personal Access Token not provided" -ForegroundColor Red
    Write-Host ""
    Write-Host "To create a release, you need a GitHub Personal Access Token:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/settings/tokens/new" -ForegroundColor Cyan
    Write-Host "2. Create a token with 'repo' scope" -ForegroundColor Cyan
    Write-Host "3. Run: `$env:GITHUB_TOKEN='your_token_here'" -ForegroundColor Cyan
    Write-Host "4. Re-run this script" -ForegroundColor Cyan
    exit 1
}

Write-Host "🚀 Creating GitHub Release..." -ForegroundColor Green
Write-Host "Repository: $Owner/$Repo" -ForegroundColor Cyan
Write-Host "Tag: $Tag" -ForegroundColor Cyan
Write-Host "Title: $ReleaseTitle" -ForegroundColor Cyan
Write-Host ""

# Read release notes from file
$ReleaseNotes = Get-Content "RELEASE_NOTES.md" -Raw

# Create request body
$Body = @{
    tag_name = $Tag
    target_commitish = "master"
    name = $ReleaseTitle
    body = $ReleaseNotes
    draft = $false
    prerelease = $true
} | ConvertTo-Json -Depth 10

Write-Host "Sending request to GitHub API..." -ForegroundColor Yellow

# Create release using GitHub API
try {
    $Response = Invoke-WebRequest -Uri $ApiUrl `
        -Method Post `
        -Headers @{
            "Authorization" = "token $GitHubToken"
            "Accept" = "application/vnd.github+json"
            "X-GitHub-Api-Version" = "2022-11-28"
        } `
        -Body $Body `
        -ContentType "application/json" `
        -ErrorAction Stop

    $Release = $Response.Content | ConvertFrom-Json
    $ReleaseUrl = $Release.html_url

    Write-Host ""
    Write-Host "✅ Release created successfully!" -ForegroundColor Green
    Write-Host "📍 URL: $ReleaseUrl" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Visit the release page above to verify" -ForegroundColor Cyan
    Write-Host "2. Share the release with the community" -ForegroundColor Cyan
    Write-Host "3. Create announcement in GitHub Discussions" -ForegroundColor Cyan

    # Open in browser if possible
    if ($PSVersionTable.Platform -eq "Win32NT" -or [string]::IsNullOrEmpty($PSVersionTable.Platform)) {
        Write-Host ""
        Write-Host "Opening release page in default browser..." -ForegroundColor Yellow
        Start-Process $ReleaseUrl
    }
}
catch {
    Write-Host ""
    Write-Host "❌ Release creation failed" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red

    # Try to parse error response
    try {
        $ErrorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
        Write-Host "GitHub API Error:" -ForegroundColor Red
        Write-Host ($ErrorResponse | ConvertTo-Json -Depth 5) -ForegroundColor Red
    }
    catch {
        Write-Host $_.ErrorDetails.Message -ForegroundColor Red
    }

    exit 1
}
