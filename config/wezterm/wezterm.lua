local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0
config.color_scheme = 'GruvboxDark'
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

-- Option 키를 이스케이프 시퀀스로 전달 (tmux Alt 단축키 사용을 위해)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Shift+Enter 등 확장 키 시퀀스 전달 (tmux 내 Claude Code 사용을 위해)
config.enable_kitty_keyboard = true

-- Shift+Enter를 명시적으로 CSI u 시퀀스로 전송 (tmux 투과)
config.keys = {
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString '\x1b[13;2u' },
}

return config
