# Require the script to run as Administrator.
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "You must run this script as Administrator!"
    exit 1
}

# Get the directory where the script is located regardless of where it's unzipped.
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Define an array of relative package paths.
$packages = @(
    "$scriptDir\1\Microsoft-Windows-RegulatedPackages-Package~31bf3856ad364e35~amd64~~10.0.19041.1.mum",
    "$scriptDir\2\Microsoft-Windows-RegulatedPackages-wow64-package~31bf3856ad364e35~amd64~~10.0.19041.1.mum",
    "$scriptDir\3\update.mum"
)

# Loop through each package and execute the DISM command.
foreach ($pkg in $packages) {

    if (-Not (Test-Path $pkg))
    {
        Write-Error "Package file not found: $pkg"
        exit 1
    }

    Write-Host "Adding package: $pkg" -ForegroundColor Cyan

    # Execute the DISM command.
    $processInfo = Start-Process -FilePath "dism.exe" `
                    -ArgumentList "/Online", "/Add-Package", "/PackagePath:$pkg" `
                    -Wait -PassThru

    # Check if DISM encountered an error
    if ($processInfo.ExitCode -ne 0)
    {
        Write-Error "DISM failed with exit code $($processInfo.ExitCode) when adding package: $pkg"
        exit $processInfo.ExitCode
    }
}

Write-Host "All packages have been added successfully." -ForegroundColor Green
