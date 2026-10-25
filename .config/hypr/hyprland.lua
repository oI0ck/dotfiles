hl.monitor({
   output   = "",
   mode     = "3840x2160@160.00Hz",
   position = "auto",
   scale    = "1",
})

local terminal    = "foot"
local fileManager = "thunar"
local menu        = "rofi -show drun"
local lockScreen  = "hyprlock"

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.on("hyprland.start", function()
   hl.exec_cmd("gentoo-pipewire-launcher restart")
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("waybar")
   hl.exec_cmd("mako")
end)

hl.config({
   general = {
      gaps_in  = 0,
      gaps_out = 0,
      border_size = 4,
      col = {
         active_border   = "rgba(b23f1eaa)",
         inactive_border = "rgba(595959aa)",
      },
      resize_on_border = false,
      layout = "dwindle",
   },

   decoration = {
      active_opacity = 1.0,
      inactive_opacity = 1.0,

      shadow = {
         enabled      = true,
         range        = 4,
         render_power = 3,
         color        = 0x1a1a1aee,
      },

      blur = {
         enabled  = true,
         size     = 3,
         passes   = 1,
         vibrancy = 0.1696,
      },
   },

   animations = {
      enabled = true,
   },

   dwindle = {
      preserve_split = true,
   },

   master = {
      new_status = "master",
   },

   scrolling = {
      fullscreen_on_one_column = true,
   },

   misc = {
      force_default_wallpaper = 1,
      disable_hyprland_logo   = true,
   },

   input = {
      kb_layout  = "pl",
      kb_variant = "",
      kb_model   = "",
      kb_options = "ctrl:nocaps",
      kb_rules   = "",

      follow_mouse = 1,
      sensitivity = -0.7,
      touchpad = {
         natural_scroll = false,
      },
   },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = false,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = false,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = false,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = false,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = false,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = false,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = false,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = false,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = false,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = false,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = false,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = false,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = false,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = false,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = false,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = false,  speed = 7,    bezier = "quick" })

hl.gesture({
   fingers = 3,
   direction = "horizontal",
   action = "workspace",
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
   local key = i % 10 -- 10 maps to key 0
   hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
   hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd("hyprlock"))
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))

local suppressMaximizeRule = hl.window_rule({
   -- Ignore maximize requests from all apps. You'll probably like this.
   name  = "suppress-maximize-events",
   match = { class = ".*" },

   suppress_event = "maximize",
})

hl.window_rule({
   -- Fix some dragging issues with XWayland
   name  = "fix-xwayland-drags",
   match = {
      class      = "^$",
      title      = "^$",
      xwayland   = true,
      float      = true,
      fullscreen = false,
      pin        = false,
   },

   no_focus = true,
})

hl.window_rule({
   name  = "move-hyprland-run",
   match = { class = "hyprland-run" },

   move  = "20 monitor_h-120",
   float = true,
})
