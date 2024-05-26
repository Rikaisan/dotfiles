#!/bin/bash

PREFIX="[CHEZMOI]"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "$PREFIX Getting ohmyz.sh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
	echo "$PREFIX .oh-my-zsh already found, skipping..."
fi
