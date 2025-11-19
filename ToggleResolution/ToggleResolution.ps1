# Check if DisplaySettings module is installed, if not install it
if (-not (Get-Module -ListAvailable -Name DisplaySettings)) {
    Write-Host "DisplaySettings module not found. Installing..."
    Install-Module -Name DisplaySettings -Force -Scope CurrentUser
    Write-Host "DisplaySettings module installed successfully."
} else {
    Write-Host "DisplaySettings module is already installed."
}

function Set-Resolution {
    param (
        [int]$Width,
        [int]$Height
    )

    Set-DisplayResolution -Width $Width -Height $Height
}

function Get-Resolution {
    param (
        [int]$Width,
        [int]$Height
    )

    $resolutionFromModule = Get-DisplayResolution

    $resolution = [PSCustomObject]@{
        Width  = $resolutionFromModule.dmPelsWidth
        Height = $resolutionFromModule.dmPelsHeight
    }
return $resolution
}

$resolution = Get-Resolution

if ($resolution.Width -eq 3440 -and $resolution.Height -eq 1440) {
    Set-Resolution -Width 2560 -Height 1440
}

if ($resolution.Width -eq 2560 -and $resolution.Height -eq 1440) {
    Set-Resolution -Width 3440 -Height 1440
}

# Close the terminal window
exit