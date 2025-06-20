# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:/$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/rikai:/usr/local/bin:$PATH"

export MOZ_ENABLE_WAYLAND=1

# Aliases
if [[ -e ~/.config/rikai/aliases ]]; then
  source ~/.config/rikai/aliases
fi

# Computer specific aliases and sources, not meant to be commited
if [[ -e ~/.config/rikai/custom ]]; then
  source ~/.config/rikai/custom
fi

#~vivaldi
export BROWSER=vivaldi
#~end-vivaldi
