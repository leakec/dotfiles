-- Monitor config
-- hl.monitor({output="HDMI-A-#", mode="highres", position="auto", scale=1})
-- hl.monitor({output="eDP-1", mode="disabled"})
-- hl.monitor({output="eDP-1", mode="1920x1080@60", position="0x0", scale=1})
hl.monitor({output="", mode="1920x1080@60", position="0x0", scale=1})

-- NVIDIA variables
hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("XDG_SESSION_TYPE","wayland")
hl.env("GBM_BACKEND","nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("GTK_THEME","adw-gtk3-dark")
hl.env("QT_STYLE_OVERRIDE","kvantum-dark")

-- Makes external screen work with nivida-card, but kills primary screen.
-- hl.env("WLR_DRM_DEVICES","/dev/dri/card0:/dev/dri/card1")

hl.config({
    input = {
        numlock_by_default = true
    }
})
