#
# ~/.bashrc
#

### OepnFOAM ###


alias cproj='cd /home/excal/Sync/Web/Stuff/cpluspractice/proj1'

set bell-style none

###



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\w\$ '


export TERMINAL="kitty"
alias ansys='/home/excal/ansys_inc/v261/Framework/bin/Linux64/runwb2'



MY_POKEMON=("lucario" "zekrom" "fearow" "sandslash" "ninetails" "persian" "growlith" "rapidash" "goldeen" "electabuzz" "tauros" "gyrados" "ditto" "eevee" "jolteon" "snorlax" "zapados" "dragonair" "mewtwo" "bayleef" "cyndaquil" "typhlosion" "furret" "flaaffy" "marill" "unown" "mantine" "skarmory" "lugia" "celebi" "blazekin" "mightyena" "swellow" "aggron" "flygon" "absol" "rayquaza")

if [[ $TERM == "xterm-kitty" ]]; then
#  echo "kitty window id: " $KITTY_WINDOW_ID
   source /home/excal/venv/bin/activate
#  pokemon "${MY_POKEMON[$RANDOM % ${#MY_POKEMON[@]}]}"
  
else
  :
fi

# Default
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


#### Custom

export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\w\$ '
