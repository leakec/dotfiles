-- Get monitor/nvidia info
local monitors = require("monitors")

-- Get colors
local home = os.getenv("HOME")
local colors_path = home .. "/.cache/wal/colors-hyprland.lua"
package.path = package.path .. ";" .. home .. "/.cache/wal/?.lua"
local colors = require("colors-hyprland")

hl.on("hyprland.start", function()
    -- Notification deamon
    hl.exec_cmd("~/.config/hypr/dunst/launch_dunst.sh")

    -- Wallpaper
    hl.exec_cmd("(awww-daemon &) && python ~/.config/hypr/wallpaper/sort_wallpapers.py --randomize-list")

    -- Waybar
    hl.exec_cmd("sleep 15 && ~/.config/hypr/waybar/launch_waybar.sh &> ~/.config/hypr/waybar/dump_waybar_info")

    -- Focus booster
    hl.exec_cmd("~/.config/hypr/scripts/focus-booster")

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data

    -- Watch for idle and turn off screens
    -- Lock after 300 seconds.
    -- Turn off monitors after 330 seconds.
    -- Lock the screen before going to sleep.
    hl.exec_cmd("hypridle")
end)

hl.curve("myBezier", {type="bezier", points={{ 0.05, 0.9}, {0.1, 1.05}}})

hl.config({
    input = {
        kb_layout = us,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = no,
        },
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        repeat_delay = 150,
        repeat_rate = 30
    },
    general = {
        gaps_in = 3,
        gaps_out = 3,
        border_size = 2,
        col = {
            active_border = { colors = {colors.color11, "rgba(59595900)", colors.color14}, angle = 45},
            inactive_border = "rgba(59595900)",
        },
        layout = dwindle,
        allow_tearing = false
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 3,
            passes = 1
        }
        -- drop_shadow = yes,
        -- shadow_range = 4,
        -- shadow_render_power = 3,
        -- col.shadow = rgba(1a1a1aee)
    },
    animations = {
        enabled = yes,
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05,
        animation = windows, 1, 7, myBezier,
        animation = windowsOut, 1, 7, default, "popin 80%",
        animation = border, 1, 10, default,
        animation = borderangle, 1, 8, default,
        animation = fade, 1, 7, default,
        animation = workspaces, 1, 6, default,
    },
    dwindle = {
        preserve_split = yes
    },
    master = {
        new_status = slave
    },
    cursor = {
        no_hardware_cursors = true,
    },
    misc = {
        disable_hyprland_logo = true,
    }
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5
})


-- Gromit MPX
hl.workspace_rule({workspace = "special:gromit", gaps_in = 0, gaps_out = 0})
hl.window_rule({
    name = "gromit",
    match = {
        class = "^(Gromit-mpx)$"
    },
    fullscreen_state = "3 1",
    no_blur = true,
    no_dim = true,
    no_shadow = true,
    suppress_event = "fullscreen"
})

-- xwaylandvideobridge
hl.window_rule({
    name = "xwaylandvideobridge",
    match = {
        class = "^(xwaylandvideobridge)$"
    },
    opacity = "0.0 override 0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = {1, 1},
    no_blur = on
})

-- Flameshot rules
hl.window_rule({
    name = "flameshot",
    match = {
        class = "flameshot"
    },
    suppress_event = "fullscreen",
    float = true,
    no_anim = true,
    border_size = 0,
    rounding = 0,
    stay_focused = true
})

-- Rofi
hl.window_rule({
    name = "Rofi",
    match = {
        class = "Rofi"
    },
    float = true,
})

-- Keybinds
local main_mod = "SUPER"

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + Space", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + W", hl.dsp.exec_cmd("exec, python ~/.config/hypr/wallpaper/sort_wallpapers.py"))
hl.bind(main_mod .. " + CTRL + W", hl.dsp.exec_cmd("~/.config/hypr/wallpaper/rofi_choose_wallpaper"))
hl.bind(main_mod .. " + CTRL + B", hl.dsp.exec_cmd("exec, ~/.config/hypr/waybar/rofi_choose_waybar"))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("python ~/.config/hypr/wallpaper/lock_screen.py"))
hl.bind("Print", hl.dsp.exec_cmd("flameshot gui -r | wl-copy"))
hl.bind(main_mod .. " + ALT + R", hl.dsp.send_shortcut({mods="SUPER + ALT", key="R", window="class:^(com.obsproject.Studio)$"}))

-- Volume controls
hl.bind(main_mod .. " + I", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume --toggle-mic"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume --inc"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume --dec"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume --toggle"))

-- Toggle waybar
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/waybar/toggle_waybar.sh"))

-- Clipboard manager
hl.bind(main_mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Modifying windows
hl.bind(main_mod .. " + SHIFT + M", hl.dsp.window.fullscreen({mode="fullscreen", action="toggle"}))
hl.bind(main_mod .. " + M", hl.dsp.window.fullscreen({mode="maximized", action="toggle"}))
hl.bind(main_mod .. " + F", hl.dsp.window.float("toggle"))

-- Move focus
hl.bind(main_mod .. " + h", hl.dsp.focus({direction="l"}))
hl.bind(main_mod .. " + l", hl.dsp.focus({direction="r"}))
hl.bind(main_mod .. " + j", hl.dsp.focus({direction="u"}))
hl.bind(main_mod .. " + k", hl.dsp.focus({direction="d"}))
hl.bind(main_mod .. " + TAB", hl.dsp.focus({urgent_or_last=true}))

-- Move window with mainMod + ALT + hjkl
hl.bind(main_mod .. " + ALT + h", hl.dsp.window.move({direction="l"}))
hl.bind(main_mod .. " + ALT + l", hl.dsp.window.move({direction="r"}))
hl.bind(main_mod .. " + ALT + j", hl.dsp.window.move({direction="u"}))
hl.bind(main_mod .. " + ALT + k", hl.dsp.window.move({direction="d"}))

-- Switch workspaces with mainMod + [0-9] or
-- scroll through existing workspaces with mainMod + scroll
-- or mainMod + arrowkeys
for k = 1, 9 do
    hl.bind(main_mod .. " + " .. k, hl.dsp.focus({workspace=k}))
end

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({workspace="+1"}))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({workspace="-1"}))
hl.bind(main_mod .. " + Right", hl.dsp.focus({workspace="+1"}))
hl.bind(main_mod .. " + Left", hl.dsp.focus({workspace="-1"}))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- or, move to active window previous or next workspace with 
-- mainMod + SHIFT + Left and Right arrow keys
for k = 1, 9 do
    hl.bind(main_mod .. " + SHIFT + " .. k, hl.dsp.window.move({workspace=k, follow=true}))
end

hl.bind(main_mod .. " + SHIFT + Right", hl.dsp.window.move({workspace="+1", follow=true}))
hl.bind(main_mod .. " + SHIFT + Left", hl.dsp.window.move({workspace="-1", follow=true}))

-- Move active window to a workspace silently (you don't move with it) with mainMod + CTRL + [0-9]
-- or use mainMod + CTRL + Left or Right arrow keys to move to previous or next workspace silently
for k = 1, 9 do
    hl.bind(main_mod .. " + CTRL + " .. k, hl.dsp.window.move({workspace=k, follow=false}))
end

hl.bind(main_mod .. " + CTRL + Right", hl.dsp.window.move({workspace="+1", follow=false}))
hl.bind(main_mod .. " + CTRL + Left", hl.dsp.window.move({workspace="-1", follow=false}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special workspace rules
hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("special"))
hl.bind(main_mod .. " + CTRL + S", hl.dsp.window.move({workspace="special", follow=false}))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({workspace="special", follow=true}))
