@echo off
:: Windows Firewall Configuration to restrict web access to specific IPs
:: IP ranges:
:: - IPv4: 42.117.25.59/24 (network 42.117.25.0/24)
:: - IPv6: 2405:4802:1d2f:3930:55a3:3266:3fcd:cc6b (with appropriate prefix)

echo Configuring Windows Firewall to restrict web access...

:: Set Domain Profile
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound

:: Block all inbound traffic initially
netsh advfirewall set currentprofile firewallpolicy blockinbound

:: Allow inbound from IPv4 range 42.117.25.0/24
netsh advfirewall add rule ^
    name="Allow Web Access IPv4 42.117.25.0/24" ^
    dir=in ^
    action=allow ^
    remoteip=42.117.25.0/24 ^
    protocol=tcp ^
    localport=80,443

:: Allow inbound from IPv6 range
:: Note: For IPv6, we need to specify the prefix. Assuming /64 prefix for the given address.
netsh advfirewall add rule ^
    name="Allow Web Access IPv6 2405:4802:1d2f:3930::/64" ^
    dir=in ^
    action=allow ^
    remoteip=2405:4802:1d2f:3930::/64 ^
    protocol=tcp ^
    localport=80,443

echo Firewall rules created successfully.
echo.
echo Rules applied:
echo 1. Allow IPv4 42.117.25.0/24 on ports 80, 443
echo 2. Allow IPv6 2405:4802:1d2f:3930::/64 on ports 80, 443
echo.
echo All other inbound traffic will be blocked.
pause