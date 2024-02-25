-- WEZTERM SETUP (START) 
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- GRAPHICS CONFIGURATION
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.backend == 'Vulkan' and gpu.device_type == 'IntegratedGpu' then
        config.webgpu_preferred_adapter = gpu
        config.front_end = 'WebGpu'
        break
    end
end

config.webgpu_power_preference = "HighPerformance"

-- DEFAULT PROGRAM (SHELL)
config.default_prog = { 'C:/Program Files/Git/bin/bash.exe', '-l'} -- GIT BASH
-- config.default_prog = { '/usr/local/bin/bash', '-l'} -- BASH SHELL
-- config.default_prog = { '/usr/local/bin/zsh', '-l'} -- ZSHELL
-- config.default_prog = { '/usr/local/bin/fish', '-l'} -- FISH SHELL
-- config.default_domain = 'WSL:Ubuntu' -- WSL (UBUNTU)
-- config.default_domain = 'WSL:Arch' -- WSL (ARCH)

-- WINDOW AND THEMES
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.90
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0,}
config.enable_scroll_bar = false
config.automatically_reload_config = true

-- FONTS & LINES
config.font = wezterm.font 'Berkeley Mono'
config.font_size = 15.0
config.cell_width = 1.3
config.line_height = 1.3
config.adjust_window_size_when_changing_font_size = false

-- FPS AND ANIMATION
config.max_fps = 60
config.animation_fps = 60
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'
config.cursor_blink_rate = 500

-- TAB BAR
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.show_tabs_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = false

-- ETC
config.hide_mouse_cursor_when_typing = true
config.detect_password_input = true
config.check_for_updates = false
config.hide_mouse_cursor_when_typing = true

-- KEYBINDS

-- LEADER: (CTRL + SPACE)
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

-- CUSTOM ACTIONS
local act = wezterm.action
config.keys = {
    -- Create a new tab in the same domain as the current pane.
    -- NEW TAB: (LEADER + t)
    { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain', }, -- NEW TAB
    { key = 'c', mods = 'LEADER', action = act.CloseCurrentTab {confirm = true} }, -- CLOSE CURRENT TAB
    { key = 'n', mods = 'LEADER', action = act.MoveTabRelative(1) }, -- MOVE TAB NEXT (FORWARD)
    { key = 'p', mods = 'LEADER', action = act.MoveTabRelative(-1) }, -- MOVE TAB PREVIOUS (BACK)
    { key = 'h', mods = 'LEADER', action = act.ActivateTabRelative(-1) }, -- SWITCH TO LEFT TAB
    { key = 'l', mods = 'LEADER', action = act.ActivateTabRelative(1) }, -- SWITCH TO RIGHT TAB


}

-- WEZTERM SETUP (END)
return config
