if status is-interactive
    # VARS
    set -gx BROWSER zen-browser
    set -gx EDITOR nvim
    set -gx MOZ_ENABLE_WAYLAND 1
    set PATH $PATH $HOME/.deno/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/.local/bin/rikai /usr/local/bin

    # CONFIGS
    fish_config theme choose catppuccin-mocha

    # INITS
    starship init fish | source
    zoxide init --cmd cd fish | source

    # Load Angular CLI autocompletion.
    if command -v ng &> /dev/null
	    source <(ng completion script)
    end

    # OTHER
    # Disable Caps Lock
    if test $XDG_SESSION_TYPE = "x11"
        setxkbmap -option ctrl:nocaps
    end
end