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

mannual_stuff=""

function pacpkg(){
    # All Packages Installation
    sudo pacman -Syu -y
    sudo pacman -S --needed - < packagelist.txt
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
    # yay
    git clone https://aur.archlinux.org/yay.git ~/Downloads/build_gityay
    cd ~/Downloads/build_gityay || exit
    makepkg -si
    
    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    mannual_stuff+="Run nvim, :PlugInstall\n"
    mannual_stuff+="Run nvim, :TSInstall cpp rust python lua javascript typescript\n"

    # Waybar Autohide
    git clone https://github.com/Zephirus2/waybar_auto_hide.git ~/Downloads/waybarautohide
    cd "$HOME/Downloads/waybar_auto_hide" || exit
    cargo build --release
    mkdir -p ~/.config/hypr/scripts
    cp target/release/waybar_auto_hide ~/.config/hypr/scripts/

}

function move_all_configs(){
    
    # Configs
    dots=("hypr" "fuzzel" "kitty" "nvim" "waybar" "waypaper")
    for d in dots
    do 
	cp "$PWD/.config/$d" "$HOME/.config/"
    done
    
    # Wallpapers
    cp "$PWD/wallpapers" "$HOME/Pictures/"

    # Bash
    cp -r "$PWD/.bashrc" "$HOME/.bashrc"
    cp -r "$PWD/.bash_profile" "$HOME/.bash_profile"
}


function start_services(){
    sudo systemctl start tailscaled
    sudo systemctl enable sddm

}



if [ "$1" == "" ];then
	echo -e "./start.sh [Options]
	
	all - Full install, use only if starting from scratch
	packages - Only installs the packages used by mwah
	gitsetup - Sets up github
	builds - Builds up used external non-pacman packages"
fi

if [ "$1" == "all" ];then
	pacpkg
	clone_and_build
	start_services
fi


if [ "$1" == "gitsetup" ];then

	github_setup

fi





 
