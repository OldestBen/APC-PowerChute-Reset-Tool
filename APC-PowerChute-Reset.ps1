# Function to generate a password
function Generate-Password {
    $specialChar = '!'
    $words = @('Midnight', 'Crow', 'Falcon', 'Shadow', 'Ocean', 'Fire', 'Mountain', 'Storm', 'River', 'Stone')
    
    # Pick two random words
    $word1 = $words | Get-Random
    $word2 = $words | Get-Random
    while ($word1 -eq $word2) {
        $word2 = $words | Get-Random
    }

    # Capitalize the first letters if they aren't already
    $password = "${word1}${specialChar}${word2}"
    return $password
}

# Function to validate the username
function Validate-Username {
    param (
        [string]$username
    )
    
    if ($username.Length -ge 6 -and $username.Length -le 128) {
        return $true
    } else {
        Write-Host "Username must be between 6 and 128 characters."
        return $false
    }
}

# Function to validate the password (for reference)
function Validate-Password {
    param (
        [string]$password,
        [string]$username
    )
    
    if ($password.Length -lt 8 -or $password.Length -gt 128) {
        Write-Host "Password must be between 8 and 128 characters."
        return $false
    }

    if ($password -notmatch "[A-Z]") {
        Write-Host "Password must contain at least one uppercase letter."
        return $false
    }

    if ($password -notmatch "[a-z]") {
        Write-Host "Password must contain at least one lowercase letter."
        return $false
    }

    if ($password -match "[0-9]") {
        Write-Host "Password cannot contain numbers."
        return $false
    }

    if ($password -notmatch "[\W_]") {
        Write-Host "Password must contain exactly one special character."
        return $false
    }

    if ($password -like "*$username*") {
        Write-Host "Password cannot contain the username."
        return $false
    }

    return $true
}

# Function to create the pcbeConfig.ini file
function Create-ConfigFile {
    param (
        [string]$username,
        [string]$password,
        [string]$path
    )
    
    $filePath = Join-Path -Path $path -ChildPath "pcbeConfig.ini"

    if (Test-Path $filePath) {
        Remove-Item $filePath -Force
    }
    
    $content = @"
[Credentials]
username=$username
password=$password
"@
    
    Set-Content -Path $filePath -Value $content
    Write-Host "pcbeConfig.ini file created at $filePath"
}

# Function to restart APC PBE Agent service
function Restart-AgentService {
    Write-Host "Restarting APC PBE Agent service..."
    Restart-Service -Name "APCPBEAgent"
    Write-Host "Service restarted."
}

# Main script

# Set the possible installation directories
$paths = @(
    "C:\Program Files\APC\PowerChute Business Edition\Agent",
    "C:\Program Files (x86)\APC\PowerChute Business Edition\Agent"
)

# Check if the PowerChute installation directory exists
$agentPath = $null
foreach ($path in $paths) {
    if (Test-Path -Path $path) {
        $agentPath = $path
        break
    }
}

if (-not $agentPath) {
    Write-Host "PowerChute installation folder not found. Please check the installation path."
    exit
}

# Get the username from the user
$username = Read-Host "Enter a new username"

# Validate the username
if (-not (Validate-Username -username $username)) {
    exit
}

# Generate a password
$password = Generate-Password

# Display the generated password
Write-Host "Generated password: $password"

# Create the configuration file
Create-ConfigFile -username $username -password $password -path $agentPath

# Restart the APC PBE Agent service
Restart-AgentService

Write-Host "Process completed. Please verify the credentials and log in to the PowerChute web interface."
