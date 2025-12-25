# Wireless Display Fix I guess

If you get signature error 0x800b0100 mean you have a different Windows build version, you will have to find the ESD package matching your build version on UUP dump or somewhere else.

**Windows update will not work if you have any "illegally" installed packages, you have to remove then via dism, update your Windows, then add them again to use Wireless Display.**
Which you might not need to repeat many times since Win 10 is in EOL and LTSCs aren't receiving any updates really.

A Lazy one click(kinda-sorta-ish) solution for the infamous:

```
Error: 87

A Windows capability name was not recognized.
 ```

problem you get when trying to add the "Wireless Display" feature on Windows 10 LTSC.

This happens because:
`Microsoft-Windows-WirelessDisplay-FOD-Package` requires `Microsoft-Windows-RegulatedPackages-Package`, which is excluded from LTSC.
According to abbodi1406.

This repo contains the necessary packages and a powershell script to fix just that.

I really should not be shipping UUP files so I highly recommend you getting them yourself from UUP dump or somewhere else:

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-RegulatedPackages-Package.ESD

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-RegulatedPackages-WOW64-Package.ESD

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-Client-LanguagePack-Package_en-us-amd64-en-us.esd

After downloading them you should extract each of them to a different folder with 7-zip.
Then add them to your system with:
```
dism /Online /Add-Package /PackagePath:1\Microsoft-Windows-RegulatedPackages-Package~31bf3856ad364e35~amd64~~10.0.19041.1.mum

dism /Online /Add-Package /PackagePath:2\Microsoft-Windows-RegulatedPackages-wow64-package~31bf3856ad364e35~amd64~~10.0.19041.1.mum

dism /Online /Add-Package /PackagePath:3\update.mum
```

Or you can use this repo.
# Instructions

1. Download the whole repo
2. Unzip the thing
3. Run the powershell script as Administrator
4. Reboot
5. Run `DISM /Online /Add-Capability /CapabilityName:App.WirelessDisplay.Connect~~~~0.0.1.0` as Administrator, or just simply add the feature from Windows setting.
