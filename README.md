# wDesk Browser for Arch Linux

pacman repository for wDesk Browser. It holds only built packages (x86_64).

## Install

Open a terminal and run:

```
curl -fsSL https://raw.githubusercontent.com/emranmostafa/wdesk-browser-repo/main/install.sh | sudo bash
```

This adds the `[wdesk]` repository to `/etc/pacman.conf` (once, keeping a
backup as `/etc/pacman.conf.before-wdesk`) and installs the `wdesk-browser`
package. Open **wDesk Browser** from the app menu.

From then on wDesk is a normal pacman package:

```
sudo pacman -S wdesk-browser     # install again after removing it
sudo pacman -Syu                 # update (with the rest of the system)
```

If pacman asks to replace the old `wdesk` package, answer **y**.

## Install by hand

The same thing without the script. Add this to the end of `/etc/pacman.conf`:

```
[wdesk]
SigLevel = Optional TrustAll
Server = https://github.com/emranmostafa/wdesk-browser-repo/releases/download/x86_64
```

Then:

```
sudo pacman -Sy wdesk-browser
```

## Uninstall

```
sudo pacman -R wdesk-browser
```

Then remove the three `[wdesk]` lines from `/etc/pacman.conf`. Your
workspaces and browsing data stay in `~/.config/wDesk` until you delete that
folder.
