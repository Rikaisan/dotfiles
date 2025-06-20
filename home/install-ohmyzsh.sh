#!/bin/bash

PREFIX="[OMZ]"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "$PREFIX Getting ohmyz.sh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc --skip-chsh
	chsh -s /bin/zsh
else
	echo "$PREFIX .oh-my-zsh already found, skipping..."
fi
