# Run once on startup 
# archinstall
# In archinstall: Network -> iwd
# finish install script
# reboot
# 
# iwctl
# device list
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connect "YOUR_SSID"

# If want to update packagelist.txt
# sudo pacman -Qeq > packagelist.txt


# boot for configs and organization


#!/usr/bin/env sh

mannual_stuff=""

function pacpkg(){
    # All Packages Installation
    
    sudo pacman -Syu -y
    sudo pacman -S python python-pipx
    pipx ensurepath
    sudo pacman -S --needed - < packagelist.txt
    

    while IFS= read -r pkg || [ -n "$pkg" ];do
	    pkg=$(echo "$pkg" | tr -d '\r' | xargs)

	    [ -z "$pkg" ] || [ "${pkg#\#}" !!= "$pkg" ] && continue

            sudo pacman -S --needed --noconfirm "$pkg"
    done < packagelist.txt

    echo "All packages Installed"


    sudo npm i -g pyright

    pipx install waypaper
    pip3 install git+https://github.com/LazoCoder/Pokemon-Terminal.git
    pipx ensurepath

    sudo pacman -Syu -y
	    
}

function github_setup(){
    
    if [ ! -f "$HOME/.ssh/id_ed25519_Github_Key" ];then
        echo "Github key not found, creating one."
        ssh-keygen -t ed25519 -C "github" -f "$HOME/.ssh/id_ed25519_Github_Key" -sN ""
        cat "$HOME/.ssh/Github_Key.pub"
    fi
    
    
    echo "
    --- INPUT ---
    Github.com
    SSH
    Github_key.pub
    Framework Laptop
    Paste an authentication token
    Login with a web browser
    https://github.com/login/device
    --- INPUT ---"
    gh auth login

}


function clone_and_build(){

   if [ ! -d "$HOME/Downloads" ]; then
	   mkdir "$HOME/Downloads"
   fi



    # yay
    if [ ! -d "$HOME/Download/build_gityay"];then
    git clone https://aur.archlinux.org/yay.git ~/Downloads/build_gityay
    cd ~/Downloads/build_gityay || exit
    makepkg -si
    fi
    
    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    mannual_stuff+="Run nvim, :PlugInstall\n"
    mannual_stuff+="Run nvim, :TSInstall cpp rust python lua javascript typescript\n"

    # Waybar Autohide
    if [ ! -d "$HOME/Downloads/waybar_auto_hide" ];then
    git clone https://github.com/Zephirus2/waybar_auto_hide.git ~/Downloads/waybar_auto_hide
    cd "$HOME/Downloads/waybar_auto_hide" || exit
    cargo build --release
    mkdir -p ~/.config/hypr/scripts
    cp target/release/waybar_auto_hide ~/.config/hypr/scripts/
    fi

    #glfw
    if [ ! -d "$HOME/Downloads/glfw" ];then
    git clone https://github.com/glfw/glfw.git "$HOME/Downloads/glfw"
    mkdir "$HOME/Downloads/glfw/build"
    cd "$HOME/Downloads/glfw/build" || exit
    cmake ..
    sudo make install
    fi



}

function move_all_configs(){
    
    # Configs
    dots=("hypr" "fuzzel" "kitty" "nvim" "waybar" "waypaper")

    for d in "${dots[@]}"; do
	    cp -r "$PWD/.config/$d" "$HOME/.config/"
    done
    
    # Wallpapers
    cp -r "$PWD/wallpapers" "$HOME/Pictures/"

    # Bash
    cp -r "$PWD/.bashrc" "$HOME/.bashrc"
    cp -r "$PWD/.bash_profile" "$HOME/.bash_profile"
}


function start_services(){
    sudo systemctl start tailscaled
#    sudo systemctl enable sddm

}



function display_help(){
	echo -e "./start.sh [Options]
	
	all - Full install, use only if starting from scratch
	packages - Only installs the packages used by mwah
	gitsetup - Sets up github
	builds - Builds up used external non-pacman packages"
}




function notes(){

	echo "If firefox black bars on edges, about:config -> browser.tabs.InTitle -> 0 or 1 or 2"

}









case "$1" in
	"all")
		pacpkg
		clone_and_build
		move_all_configs
		start_services
		github_setup
		echo $mannual_stuff
		;;

	"gitsetup")
		github_setup
		;;

	"packages")
		pacpkg
		;;
	"builds")
		clone_and_build
		;;
	"configs")
		move_all_configs
		;;
	"services")
		start_services
		;;
	-h | --help | help | -help)
		display_help
		;;
	*)
		echo "Unknown command, use -h"
		;;


esac


 
