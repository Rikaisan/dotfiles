# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

EDITOR=nvim

plugins=(git)

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Disable Caps Lock
if [[ $XDG_SESSION_TYPE == "x11" ]]; then
	setxkbmap -option ctrl:nocaps
fi

if command -v ng &> /dev/null
then
	# Load Angular CLI autocompletion.
	source <(ng completion script)
fi

source ~/.zshenv

#~hypr
bash ~/.config/hypr/scripts/post_install.sh
#~end-hypr