# wDesk Browser for Arch Linux

pacman repository for wDesk Browser. It holds only built packages.

## Install

Add this to the end of `/etc/pacman.conf`:

```
[wdesk]
SigLevel = Optional TrustAll
Server = https://github.com/emranmostafa/wdesk-browser-repo/releases/download/x86_64
```

Then:

```
sudo pacman -Sy wdesk-browser
```

## Update

```
sudo pacman -Syu
```
