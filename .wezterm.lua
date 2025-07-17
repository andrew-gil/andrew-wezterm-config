-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"
config.font_size = 13
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.enable_tab_bar = true
config.leader = { mods = "CTRL", key = "w", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "CTRL",
    key = "v",
    action = wezterm.action.PasteFrom("PrimarySelection")
  },
  {
    mods = "CTRL",
    key = "c",
    action = wezterm.action.CopyTo("PrimarySelection")
  },
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab "CurrentPaneDomain"
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },
  {
    mods = "LEADER",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    mods = "LEADER",
    key = "=",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
}

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a)     -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end   -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW }
  })
end)
-- Finally, return the configuration to wezterm:
return config
