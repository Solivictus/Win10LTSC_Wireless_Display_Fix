# Wireless Display Fix I guess
-------------
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

I really should not be shipping UUP files so I highly recommend you getting them yourself from UUP dump:

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-RegulatedPackages-Package.ESD

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-RegulatedPackages-WOW64-Package.ESD

https://uupdump.net/getfile.php?id=e2d7464a-c8cc-4779-ad1d-36699425f3d3&file=Microsoft-Windows-Client-LanguagePack-Package_en-us-amd64-en-us.esd

# Instructions
----
1. Download the whole repo
2. Unzip the thing
3. Run the powershell script as Administrator
4. Reboot
5. Run `DISM /Online /Add-Capability /CapabilityName:App.WirelessDisplay.Connect~~~~0.0.1.0` as Administrator, or just simply add the feature from Windows setting.
