local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'

-- GPU Front End

-- config.webgpu_power_preference = 'HighPerformance'
--
-- local preferred_gpu_api
-- if is_windows then
--     preferred_gpu_api = 'Dx12'
-- else
--     preferred_gpu_api = 'Vulkan'
-- end
--
-- for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
--   if gpu.backend == preferred_gpu_api and gpu.device_type == 'DiscreteGpu' then
--     config.webgpu_preferred_adapter = gpu
--     break
--   end
-- end
--
-- config.front_end = "WebGpu"

-- Font
config.font = wezterm.font('JetBrainsMono NF', { weight = 'Medium' })
config.font_size = 10
-- config.freetype_render_target = 'HorizontalLcd'

-- Window Appearance
local ui_font_name
if is_windows then
    ui_font_name = 'Segoe UI'
else
    ui_font_name = 'Roboto'
end

config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"

config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
}

config.window_frame = {
    font = wezterm.font(ui_font_name),
    font_size = 10,
    active_titlebar_bg = '#2d2d2d'
}

config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = '#1f1f1f',
            fg_color = '#ffffff',
        },
    },
}

config.command_palette_font_size = 11
-- config.command_palette_font = wezterm.font('ui_font_name')
config.command_palette_bg_color = '#2d2d2d'
config.command_palette_fg_color = '#cacaca'

-- Terminal Appearance
config.default_cursor_style = 'BlinkingBar'
config.color_scheme = 'vscode-dark'
config.bold_brightens_ansi_colors = 'BrightOnly'

-- Config
if is_windows then
    config.default_prog = { 'powershell.exe' }
end

config.window_close_confirmation = 'NeverPrompt'
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 255
config.animation_fps = 60

-- Launcher
if is_windows then
    config.launch_menu = {
        {
            label = 'Powershell',
            args = { 'powershell.exe' }
        },
        {
            label = 'Developer Powershell (VS 2022)',
            args = {
                'powershell.exe',
                '-NoExit',
                '-Command',
                '$vspath = &"${env:ProgramFiles(x86)}\\Microsoft Visual Studio\\Installer\\vswhere.exe" -latest -property installationpath; \
                &{Import-Module "$vspath\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll"; \
                Enter-VsDevShell -VsInstallPath $vspath -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"}'
            }
        },
        {
            label = 'Command Prompt',
            args = { 'cmd.exe' }
        },
    }
end


-- Keymaps
config.keys = {
    -- Paste from clipboard
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'PrimarySelection' },
    -- Navigate panes
    { key = 'h', mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left'},
    { key = 'j', mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down'},
    { key = 'k', mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up'},
    { key = 'l', mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right'},
    -- Open the Launcher
    { key = 'Space', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncher }
}

return config
