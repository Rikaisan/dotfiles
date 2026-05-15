-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 4,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgb(cba6f7)", "rgb(9aa8fe)"}, angle = 90 },
            inactive_border = "rgb(464966)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        fullscreen_opacity   = 1.0,
        inactive_opacity = 0.98,
        dim_inactive = true,
        dim_strength = 0.1,

        shadow = {
            enabled      = true,
            range        = 50,
            render_power = 25,
            color        = "rgba(0,0,0,0.18)",
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("custom",         { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("easeOutQuart",   { type = "bezier", points = { {0.25, 1},    {0.5, 1}     } })

hl.animation({ leaf = "windows",       enabled = true,  speed = 7, bezier = "custom" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",        enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",   enabled = true,  speed = 8, bezier = "default" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 5, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = 5, bezier = "easeOutQuart", style = "slidevert" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})