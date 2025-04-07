-- Sakkada Wezterm config
-- Source: https://wezfurlong.org/wezterm/config/files.html
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- TODO: https://github.com/wez/wezterm/discussions/628
--   EG: https://github.com/azzamsa/dotfiles/tree/master/wezterm/.config/wezterm

-- Help: https://wezfurlong.org/wezterm/config/lua/wezterm.gui/index.html
-- module exposes gui layer functions, may not exists, need checking,
-- if gui module not presents (e.g. is case of multiplexing) - do nothing
local gui = wezterm.gui
if not wezterm.gui then
    return config
end

-- Key bindings and Key tables
-- ---------------------------
-- Help: https://wezfurlong.org/wezterm/config/default-keys.html
--       https://wezfurlong.org/wezterm/config/keys.html
--       > wezterm show-keys --lua      -- show current key tables and bindings
--       > wezterm -n show-keys --lua   -- show default key tables and bindings
local act = wezterm.action -- name it "act" like in "wezterm show-keys --lua"
local key_table_extend = function(table_full, table_diff)
    for index, value in pairs(table_diff) do
        table.insert(table_full, value)
    end
    return table_full
end

local copy_mode = {
    { key = "/", mods = "NONE", action = wezterm.action({ Search = { CaseInSensitiveString = "" } }) },
    { key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) },
    { key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },
    { key = "S", mods = "SHIFT", action = wezterm.action.CopyMode({ SetSelectionMode = "SemanticZone" }) },
    { key = "q", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) },
    { key = "RightArrow", mods = "CTRL", action = wezterm.action({ CopyMode = "MoveForwardWordEnd" }) },
    { key = "LeftArrow", mods = "CTRL", action = wezterm.action({ CopyMode = "MoveBackwardWord" }) },
    { key = "Backspace", mods = "CTRL", action = wezterm.action({ CopyMode = "ClearPattern" }) }, -- Ctrl-U
    { key = "y", mods = "SHIFT", action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },
    { key = "Y", mods = "SHIFT", action = wezterm.action(
        act.Multiple({
            act.CopyTo 'ClipboardAndPrimarySelection',
            act.ClearSelection,
            act.CopyMode 'ClearSelectionMode',
        })
    ),}, -- copy selection, clear current selection and stay in CopyMode
    { key = "Y", mods = "CTRL|SHIFT", action = wezterm.action_callback(
        function(window, pane)
            local ansi = window:get_selection_escapes_for_pane(pane)
            window:copy_to_clipboard(ansi)
        end
    ),}, -- copy selection with escape sequences (raw, as-is)
    { key = "Enter", mods = "NONE", action = wezterm.action({ CopyMode = "PriorMatch" }) },
    { key = "Enter", mods = "SHIFT", action = wezterm.action({ CopyMode = "NextMatch" }) },
    { key = "Enter", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
}

local search_mode = {
    { key = "RightArrow", mods = "NONE", action = "ActivateCopyMode" },
    { key = "Enter", mods = "CTRL", action = "ActivateCopyMode" },
    { key = "Enter", mods = "SHIFT", action = wezterm.action({ CopyMode = "NextMatch" }) },
    { key = "Backspace", mods = "CTRL", action = wezterm.action({ CopyMode = "ClearPattern" }) }, -- Ctrl-U
}

config.leader = { key = "Q", mods = "CTRL" } -- Leader is Ctrl-Shift-Q
config.keys = {
    { key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByLine(-1) },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByLine(1) },
    { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.ActivatePaneDirection('Up') },
    { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.ActivatePaneDirection('Down') },
    { key = "PageUp", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByPage(-1) },
    { key = "PageDown", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByPage(1) },
    { key = "PageUp", mods = "SHIFT", action = wezterm.action.MoveTabRelative(-1) },
    { key = "PageDown", mods = "SHIFT", action = wezterm.action.MoveTabRelative(1) },
    { key = "J", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("open-in-nvim") },
    { key = "M", mods = "CTRL|SHIFT", action = wezterm.action_callback(
        function(window, pane)
            window:perform_action(wezterm.action.ActivateCopyMode, pane)
            window:perform_action(wezterm.action({ CopyMode = "ClearSelectionMode" }), pane)
            window:perform_action(wezterm.action({ CopyMode = { SetSelectionMode = "Cell" } }), pane)
        end
    ),}, -- start CopyMode always with "Cell" selection mode (in any search status cases)
    { key = "F", mods = "CTRL|SHIFT", action=wezterm.action_callback(
        function(window, pane)
            local selection = window:get_selection_text_for_pane(pane)
            window:perform_action(wezterm.action({ Search = { CaseInSensitiveString = selection } }), pane)
        end
    )}, -- start Search with "ignore-case" (like CurrentSelectionOrEmptyString but "ignore-case")
    -- leader section
    { key = 'q', mods = 'LEADER', action = wezterm.action.SendKey({ key = 'q', mods = 'CTRL|SHIFT' }), },
    { key = 'F', mods = "LEADER|CTRL", action = wezterm.action.QuickSelect },
    { key = 'Q', mods = 'LEADER|CTRL', action = wezterm.action.QuickSelectArgs(
        {
            label = 'Open url',
            patterns = { '(?:http|https|ftp|git|hg|tg|tonsite|skype)://\\S+' },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end),
        }
    )}, -- start QuickSelect with open url in browser action
    { key = "W", mods = "LEADER|CTRL", action = wezterm.action.ActivateKeyTable(
        { name = "resize_mode", one_shot = false, prevent_fallback = true }
    )},
    { key = '|', mods = "LEADER|SHIFT", action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = '-', mods = "LEADER", action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    -- disable section
    -- disable all possible CTRL-SHIFT-# / SUPER-# tab activation hotkeys
    { key = "!", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "!", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "1", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "1", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "@", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "@", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "2", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "2", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "#", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "#", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "3", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "3", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "$", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "$", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "4", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "4", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "%", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "%", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "5", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "5", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "^", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "^", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "6", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "6", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "&", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "&", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "7", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "7", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "*", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "*", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "8", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "8", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    { key = "(", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "(", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "9", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "9", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
    -- disable splitter keybindings
    { key = '\"', mods = 'ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '\"', mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '\'', mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '%', mods = 'ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '%', mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
    { key = '5', mods = 'SHIFT|ALT|CTRL', action = wezterm.action.DisableDefaultAssignment },
}

config.key_tables = {
    resize_mode = {
        { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "LeftArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "RightArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "UpArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 3 }) },
        { key = "DownArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 3 }) },
        { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Left') },
        { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Right') },
        { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Up') },
        { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection('Down') },
        { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "h", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 10 }) },
        { key = "l", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 10 }) },
        { key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 10 }) },
        { key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 10 }) },
        { key = "H", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "L", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "K", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "J", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "W", mods = "CTRL", action = "PopKeyTable" },
        { key = "Escape", action = "PopKeyTable" },
    }, -- custom key-table (very similar to neovim hydra functionality)
    copy_mode = key_table_extend(wezterm.gui.default_key_tables().copy_mode, copy_mode),
    search_mode = key_table_extend(wezterm.gui.default_key_tables().search_mode, search_mode),
}

-- Wezterm configuration
config.scrollback_lines = 9999
config.enable_scroll_bar = true

-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
-- config.keys = {
--   {
--     key = '|',
--     mods = 'LEADER|SHIFT',
--     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
--   },
--   {
--     key = 'a',
--     mods = 'LEADER|CTRL',
--     action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
--   },
-- }

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
-- config.win32_system_backdrop = 'Acrylic'

-- todo: shift-space in copy mode - linewise select

config.colors = {
    -- The default text color
    -- foreground = 'silver',
    -- The default background color
    -- background = 'black',
    background = "#112222",

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    -- cursor_bg = '#52ad70',
    cursor_bg = "#ffffff",
    -- Overrides the text color when the current cell is occupied by the cursor
    -- cursor_fg = 'black',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = '#52ad70',

    -- the foreground color of selected text
    -- selection_fg = 'black',
    -- the background color of selected text
    -- selection_bg = '#fffacd',

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    -- scrollbar_thumb = '#222222',
    -- scrollbar_thumb = '#4E49EE',
    -- scrollbar_thumb = 'Orange',
    -- scrollbar_thumb = '#ffa500',
    -- scrollbar_thumb = '#333333',
    scrollbar_thumb = "#8e4009",
    scrollbar_thumb = "#a06000",

    -- The color of the split lines between panes
    split = "#8e4009",

    -- ansi =    { 'black', 'maroon', 'green', 'olive',  'navy', 'purple',  'teal', 'silver', },
    -- brights = { 'grey',  'red',    'lime',  'yellow', 'blue', 'fuchsia', 'aqua', 'white', },

    -- Arbitrary colors of the palette in the range from 16 to 255
    -- indexed = { [136] = '#af8700' },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    -- compose_cursor = 'orange',

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    -- copy_mode_active_highlight_bg = { Color = '#f00000' },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    -- copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    -- copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    -- copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

    -- quick_select_label_bg = { Color = 'peru' },
    -- quick_select_label_fg = { Color = '#ffffff' },
    -- quick_select_match_bg = { AnsiColor = 'Navy' },
    -- quick_select_match_fg = { Color = '#ffffff' },
    --
    --

    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        -- background = '#0b0022',

        -- The active tab is the one that has focus in the window
        active_tab = {
            bg_color = "#112222",
            fg_color = "#aaaaaa",
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = "#333333",
            fg_color = "#808080",
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = "#112f2f",
            fg_color = "#808080",
        },

        -- The new tab button that let you create new tabs
        new_tab = {
            bg_color = "#333333",
            fg_color = "Orange",
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over the new tab button
        new_tab_hover = {
            bg_color = "#333333",
            fg_color = "#ffff00",
        },
    },
}

config.debug_key_events = false
config.enable_scroll_bar = true

-- For example, changing the color scheme:
config.max_fps = 120
config.color_scheme = "AdventureTime"
config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme = "Tango (base16)"
config.color_scheme = "Tango (terminal.sexy)"
config.color_scheme = "Tartan (terminal.sexy)"
config.command_palette_font_size = 11.0
config.font_size = 10
-- config.font_rules = {
--   {
--     intensity = 'Bold',
--     italic = false,
--     font = wezterm.font_with_fallback {
--       -- family = 'Consolas NF',
--       family = 'FiraCode Nerd Font Mono Bold',
--     },
--   },
-- }
-- config.font_shaper = 'Allsorts'
config.font_shaper = "Harfbuzz"
-- config.font = wezterm.font(
--     "Consolas NF",
--     -- 'FiraCode Nerd Font Mono Ret',
--     -- 'FiraCode Nerd Font Mono SemBd',
--     -- 'FiraCode Nerd Font Mono Bold',
--     -- 'FiraCode Nerd Font Mono Light',
--     -- 'FiraCode Nerd Font Mono Med',
--     -- 'FiraCode Nerd Font Mono',
--     -- 'Cascadia Code',
--     { weight = "Regular" }
-- )
config.font = wezterm.font_with_fallback({
    { family = 'Consolas', weight = 'Regular' },
    'Symbol Nerd Fort Mono',
})

-- config.front_end = "OpenGL"
-- config.front_end = "Software"
config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW | INTEGRATED_BUTTONS"
config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
config.integrated_title_button_color = "Orange"
config.integrated_title_button_style = "Windows" -- Windows|Gnome|MacOsNative
config.integrated_title_button_alignment = "Right"
config.window_frame = {
    -- inactive_titlebar_bg = '#353535',
    -- active_titlebar_bg = '#2b2042',
    -- inactive_titlebar_fg = '#cccccc',
    -- active_titlebar_fg = '#ffffff',
    -- inactive_titlebar_border_bottom = '#2b2042',
    -- active_titlebar_border_bottom = '#2b2042',
    -- button_fg = '#fccccc',
    -- button_bg = '#fb2042',
    -- button_hover_fg = '#ff0fff',
    -- button_hover_bg = '#3bf052',
    -- border_left_width = '0px',
    -- border_right_width = '0px',
    -- border_top_height = '0px',
    -- border_bottom_height = '2px',
    -- border_left_color = 'red',
    -- border_right_color = 'red',
    -- border_bottom_color = 'red',
    -- border_top_color = 'red',
    -- button_fg = '#fccccc',
    -- button_bg = '#fb2042',

    -- active_titlebar_bg = '#2bf0f2',
    -- inactive_titlebar_bg = '#35f535',
    -- active_titlebar_fg = '#ff00ff',
    -- inactive_titlebar_fg = '#cccc00',
    -- active_titlebar_border_bottom = '#2b20f2',
    -- inactive_titlebar_border_bottom = '#fb2042',
    --

    -- font = wezterm.font({ family = "Consolas", weight = "Regular" }),
    font = wezterm.font_with_fallback({
        { family = 'Consolas', weight = 'Regular' },
        'Symbol Nerd Fort',
    }),

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 10.0,
}

config.default_cursor_style = "BlinkingUnderline" -- "BlinkingBar"
config.underline_thickness = "1px"
config.animation_fps = 60
config.cursor_blink_rate = 250
config.cursor_thickness = "2px"
config.cursor_blink_ease_in = "Linear"
config.cursor_blink_ease_out = "Linear"
-- config.force_reverse_video_cursor = true

config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 80

-- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- config.use_fancy_tab_bar = false
-- config.tab_bar_style = {
--   active_tab_left = wezterm.format {
--     { Background = { Color = '#0b0022' } },
--     { Foreground = { Color = '#2b2042' } },
--     { Text = SOLID_LEFT_ARROW },
--   },
--   active_tab_right = wezterm.format {
--     { Background = { Color = '#0b0022' } },
--     { Foreground = { Color = '#2b2042' } },
--     { Text = SOLID_RIGHT_ARROW },
--   },
--   inactive_tab_left = wezterm.format {
--     { Background = { Color = '#0b0022' } },
--     { Foreground = { Color = '#1b1032' } },
--     { Text = SOLID_LEFT_ARROW },
--   },
--   inactive_tab_right = wezterm.format {
--     { Background = { Color = '#0b0022' } },
--     { Foreground = { Color = '#1b1032' } },
--     { Text = SOLID_RIGHT_ARROW },
--   },
-- }

config.window_padding = {
    left = 5,
    right = 8,
    top = 8,
    bottom = 4,
}
config.anti_alias_custom_block_glyphs = true
config.status_update_interval = 500

config.allow_win32_input_mode = true  -- default true, set to false to allow <ctrl+space> and similar key sequences

-- Wezterm events handling
-- -----------------------
-- https://wezfurlong.org/wezterm/config/lua/wezterm/on.html

-- custom event, open current pane history in newtab neovim
-- https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#custom-events
wezterm.on("open-in-nvim", function(window, pane)
    local file = io.open("c:/sakkada/temp/wezterm_buf.txt", "w")
    file:write(pane:get_lines_as_text(3000))
    file:close()
    window:perform_action(
        wezterm.action({
            SpawnCommandInNewTab = {
                args = { "nvim", "c:/sakkada/temp/wezterm_buf.txt", "-c", "call cursor(3000,0)" } 
            },
        }),
        pane
    )
end)

-- show title of current key table (mode) in right status area
-- https://wezfurlong.org/wezterm/config/lua/window-events/update-right-status.html
wezterm.on("update-right-status", function(window, pane)
    local name = window:active_key_table()
    if name then
        name = "KeyTable: " .. name
    end
    window:set_right_status(name or "")

    -- -- overrides opacity if any key table is enabled
    -- -- disabled cause set_config_overrides makes with ~1 second lag
    -- -- also does not work with custom key tables (resize_mode)
    -- local overrides = window:get_config_overrides() or {}
    -- if name then
    --     overrides.window_background_opacity = 0.8
    -- else
    --     overrides.window_background_opacity = 1.0
    -- end
    -- window:set_config_overrides(overrides)
end)

-----
-- -- Equivalent to POSIX basename(3)
-- -- Given "/foo/bar" returns "bar"
-- -- Given "c:\\foo\\bar" returns "bar"
-- function basename(s)
--   return string.gsub(s, '(.*[/\\])(.*)', '%2')
-- end
--
-- wezterm.on('update-right-status', function(window, pane)
--   local info = pane:get_foreground_process_info()
--   if info then
--     window:set_right_status(
--       tostring(info.pid) .. ' ' .. basename(info.executable)
--     )
--     print(info)
--   else
--     window:set_right_status ''
--   end
-- end)
-----

-- colorize tab title with unseen output
-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    -- get tab title with tab index to imitate default behaviour
    local tab_title = tostring(tab.tab_index + 1) .. ": " .. tab.active_pane.title

    -- active tab
    if tab.is_active then
        return tab_title
    end

    -- inactive tab with unseen output
    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
            has_unseen_output = true
            break
        end
    end
    if has_unseen_output then
        return {
            -- { Background = { Color = "#7F5216" } },
            -- { Background = { Color = "#54360F" } },
            -- { Background = { Color = "#4C300D" } },
            -- { Background = { Color = "#1C2235" } },
            -- { Background = { Color = "#141D38" } },
            -- { Background = { Color = "#3F250A" } },
            { Background = { Color = "#332022" } },
            -- { Foreground = { Color = "#cccccc" } },
            { Foreground = { Color = "#999999" } },
            { Text = tab_title },
        }
    end

    -- inactive tab
    return tab_title
end)

-- Wezterm Plugins
-- ---------------
-- https://github.com/topics/wezterm-plugin
-- https://github.com/nekowinston/wezterm-bar

return config
