-- Monitor config
hl.monitor({output="", mode="preferred", position="auto", scale=1.0})
-- hl.monitor({output="eDP-1", disabled=true})
-- hl.monitor({output="DP-1", mode="highres", position="auto", scale=2.0})

-- Makes external screen work with nivida-card, but kills primary screen.
-- hl.env("WLR_DRM_DEVICES","/dev/dri/card0:/dev/dri/card1")

-- One or more of these was causing hyprland not to launch
-- hl.env("LIBVA_DRIVER_NAME","nvidia")
-- hl.env("XDG_SESSION_TYPE","wayland")
-- hl.env("GBM_BACKEND","nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("GTK_THEME","Arc-Dark")

hl.config({
    input = {
        numlock_by_default = true
    }
})
