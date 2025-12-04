local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Guezwhoz"
-- config.color_scheme = "Github Light"
config.font = wezterm.font("JetBrains Mono")
config.window_background_opacity = 0.96
config.font_size = 16.0

config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true

-- keybind = cmd+s=text:\x1b:w\r
config.keys = {
	{
		key = "s",
		mods = "CMD",
		action = wezterm.action.SendString("\x1b:w\r"),
	},
}

return config
