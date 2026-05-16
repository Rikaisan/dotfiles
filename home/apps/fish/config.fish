if status is-interactive
    # VARS
    set -gx BROWSER zen-browser
    set -gx EDITOR nvim
    set -gx MOZ_ENABLE_WAYLAND 1
    set PATH $HOME/.local/bin/rikai $PATH $HOME/.deno/bin $HOME/.cargo/bin $HOME/.local/bin /usr/local/bin
    set -gx JAVA_HOME /usr/lib/jvm/default-runtime

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