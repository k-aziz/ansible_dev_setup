local wezterm = require("wezterm")

local config = {}

--- Set default shell here for non-admin systems. (Avoids modifying /etc/shells)
if wezterm.target_triple:match("arm64") then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
else
	config.default_prog = { "/usr/local/bin/fish", "-l" }
end

-- Appearance
config.font = wezterm.font_with_fallback({
	"UbuntuMono Nerd Font Mono",
})
config.font_size = 14

config.color_scheme = "duskfox"

config.window_background_opacity = 0.9

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Keybinds
local act = wezterm.action
config.keys = {
	-- Splitting panes
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Left",
			size = { Percent = 50 },
		}),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Up",
			size = { Percent = 50 },
		}),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	-- Pane activation
	{
		key = "H",
		mods = "SHIFT|CMD",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "SHIFT|CMD",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "K",
		mods = "SHIFT|CMD",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "J",
		mods = "SHIFT|CMD",
		action = act.ActivatePaneDirection("Down"),
	},
	-- Pane resizing
	{
		key = "LeftArrow",
		mods = "CMD",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "DownArrow",
		mods = "CMD",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "UpArrow",
		mods = "CMD",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	-- Close active pane if multiple open
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			if tab and #tab:panes() > 1 then
				window:perform_action(wezterm.action.CloseCurrentPane({ confirm = false }), pane)
			else
				window:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }), pane)
			end
		end),
	},
}

-- Default disables left Option key as a char modifier
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

return config
