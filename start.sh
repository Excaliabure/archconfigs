# Run once on startup 

# Up to date
sudo pacman -Syu -y

# Core
sudo pacman -S --needed base-devel git go fuzzel 

# UI stuff
sudo pacman -S waybar awww syncthing kitty flameshot fuzzel

# Applications
sudo pacman -S tailscale firefox obsidian dolphin obsidian thunderbird discord freecad

# Utility
sudo pacman -S git vlc vim nvim python

# Transfering desktop
# cp -r ./configs/.bashrc ~/.bashrc
# cp -r ./configs/.bash_profile ~/.bash_profile 

# cp -r ./configs/.config ~/.config 
# cp -r ./wallpapers ~/Pictures/wallpapers
