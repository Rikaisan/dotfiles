require("globals")

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = KB_LANG == "en" and "us, us" or "us, latam",
        kb_variant = KB_LANG == "en" and "basic, intl" or "",
        kb_options = "grp:win_space_toggle",
        kb_model   = "",
        kb_rules   = "",

        follow_mouse = 1,
        float_switch_override_focus = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})