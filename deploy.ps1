
$ErrorActionPreference = "Stop"

Write-Host "=== Starting Conduit Deployment ==="

# Move to project directory
Set-Location $PSScriptRoot

# Validate Docker Compose configuration
Write-Host "Validating Docker Compose..."
docker compose config --quiet

if ($LASTEXITCODE -ne 0) {
    throw "Docker Compose configuration is invalid."
}

# Pull the latest images from Docker Hub
Write-Host "Pulling latest Docker images..."
docker compose pull

if ($LASTEXITCODE -ne 0) {
    throw "Failed to pull Docker images."
}

# Recreate containers using the latest images
Write-Host "Updating application containers..."
docker compose up -d --remove-orphans

if ($LASTEXITCODE -ne 0) {
    throw "Failed to update containers."
}

# Verify container status
Write-Host "Checking container status..."
docker compose ps

Write-Host "=== Conduit Deployment Completed ==="
