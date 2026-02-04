-- Clink is available at https://chrisant996.github.io/clink
-- Settings available via 'clink set'.
-- Get keycode via `clink echo`

-- Popup window colors
-- https://en.wikipedia.org/wiki/ANSI_escape_code#SGR
-- https://chrisant996.github.io/clink/clink.html#color_popup
local ansi = {
    fg8 = '38;5;',
    bg8 = '48;5;',
    fg24 = '38;2;',
    bg24 = '48;2;',
}
local popup_theme = {
    -- gruvbox like 24bit theme
    gruvbox = {
        items       = ansi.fg24 .. '226;210;171;' .. ansi.bg24 .. '40;40;40', -- The items color (e.g. bright white on blue).
        desc        = ansi.fg24 .. '186;171;146;' .. ansi.bg24 .. '40;40;40', -- The description color.
        border      = ansi.fg24 .. '146;131;116;' .. ansi.bg24 .. '40;40;40', -- The border color (defaults to items color).
        header      = ansi.fg24 .. '254;128;025;' .. ansi.bg24 .. '40;40;40', -- The title color (defaults to border).
        footer      = ansi.fg24 .. '184;187;038;' .. ansi.bg24 .. '40;40;40', -- The footer message color (defaults to border color).
        select      = ansi.fg24 .. '226;210;171;' .. ansi.bg24 .. '70;70;70', -- The selected item color (defaults to reverse video of items color).
        selectdesc  = ansi.fg24 .. '186;171;146;' .. ansi.bg24 .. '70;70;70', -- The selected item description color (defaults to selected item color).
    },
    -- onecolor 8bit theme from 22-29 to 25-32, and in similar way any pairs
    -- change only fg-borger and all bg-*
    onecolor = {
        items       = ansi.fg8 .. '015;' .. ansi.bg8 .. '23', -- The items color (e.g. bright white on blue).
        desc        = ansi.fg8 .. '252;' .. ansi.bg8 .. '23', -- The description color.
        border      = ansi.fg8 .. '030;' .. ansi.bg8 .. '23', -- The border color (defaults to items color).
        header      = ansi.fg8 .. '015;' .. ansi.bg8 .. '23', -- The title color (defaults to border).
        footer      = ansi.fg8 .. '015;' .. ansi.bg8 .. '23', -- The footer message color (defaults to border color).
        select      = ansi.fg8 .. '015;' .. ansi.bg8 .. '30', -- The selected item color (defaults to reverse video of items color).
        selectdesc  = ansi.fg8 .. '252;' .. ansi.bg8 .. '30', -- The selected item description color (defaults to selected item color).
    },
}

-- https://chrisant996.github.io/clink/clink.html#rl.getkeybindings
function sakkada_showkeybindings(rl_buffer)
    local bindings = rl.getkeybindings()
    if #bindings <= 0 then
        rl_buffer:refreshline()
        return
    end

    local items = {
        height = 30,
        searchmode = 'filter',
        colors = popup_theme.gruvbox, -- Override the popup colors using any colors in this table.
    }
    for _, kb in ipairs(bindings) do
        table.insert(items, {
            value = kb.binding, -- Return the binding when selected, so it can be invoked.
            display = kb.key, -- Display the key name.
            description = kb.binding .. '\t' .. kb.desc, -- Also display the command and description.
        })
    end

    -- Show a popup that lists the items from above.
    local binding, _, index = clink.popuplist('Key Bindings', items)
    rl_buffer:refreshline()
    if binding then
        -- Invoke the selected binding (a command or macro).
        rl.invokecommand(binding)
    end
end

if rl.setbinding then
    settings.add('sakkada.allow_lua_config', false, "Allow sakkada's lua configuration setup.")
    if settings.get('sakkada.allow_lua_config') then
        -- FZF custom keybindings
        --
        -- FZF default keybindings are:
        -- ---------------------------
        -- Ctrl-t       - fzf_file             (fzf files and just paste it into prompt, replaces default "forward-char")
        -- Ctrl-r       - fzf_history          (fzf history and just paste it into prompt, replaces default "reverse-search-history")
        -- Meta-c       - fzf_directory        (fzf directories and cd into it, replaces default "clink-copy-cwd")
        -- Meta-b       - fzf_bindings         (fzf bindings and emit keybinding event, replaces default "backward-word")
        -- Ctrl-I       - fzf_complete         (fzf complete, works in most cases line default "complete", replaces default "complete")
        -- Ctrl-Space   - fzf_complete_force   (fzf complate force, fzf completions and just paste it into prompt, replaces default clink-select-complete")
        --
        -- Default fzf keybindings is disabled by setting fzf.default_bindings value to false
        -- Hide almost all fzf keybindings behind Ctrl-f chord (key sequence binding, like builtin `Ctrl-X,Ctrl-R` for reloading clink)
        -- It replaces default "forward-char", so add double Ctrl-F first to add access to default functionality

        -- Restored defaults
        rl.setbinding([["\C-F\C-F"]], [[forward-char]])                     -- Ctrl-F,Ctrl-F    - default Ctrl-F "forward-char"

        -- Replaced defaults by FZF and restored defaults
        rl.setbinding([["\C-Fr"]], [[reverse-search-history]])              -- Ctrl-F,r         - default Ctrl-R "reverse-search-history"
        rl.setbinding([["\C-R"]], [["luafunc:fzf_history"]])                -- Ctrl-R           - fzf history

        rl.setbinding([["\C-Fc"]], [[complete]])                            -- Ctrl-F,c         - default Ctrl-I "complete"
        rl.setbinding([["\C-I"]], [["luafunc:fzf_complete"]])               -- Ctrl-I           - fzf complete

        -- Customized FZF
        rl.setbinding([["\C-Ff"]], [["luafunc:fzf_file"]])                  -- Ctrl-F,f         - fzf files
        rl.setbinding([["\C-Fd"]], [["luafunc:fzf_directory"]])             -- Ctrl-F,d         - fzf directories
        rl.setbinding([["\C-Fb"]], [["luafunc:fzf_bindings"]])              -- Ctrl-F,b         - fzf bindings
        rl.setbinding([["\C-Fz"]], [["luafunc:fzf_complete_force"]])        -- Ctrl-F,z         - fzf complete force
        rl.setbinding([["\e[27;7;32~"]], [["luafunc:fzf_complete_force"]])  -- Ctrl-Alt-Space   - fzf complete force
        rl.setbinding([["\e[Z"]], [["luafunc:fzf_complete_force"]])         -- Shift-Tab        - fzf complete force

        rl.setbinding([["\C-@"]], [[clink-select-complete]])                -- Ctrl-@           - clink complete (nvim, wsl tmux)
        rl.setbinding([["\e\C-@"]], [["luafunc:fzf_complete_force"]])       -- Ctrl-Alt-@       - fzf complete force (wsl tmux)

        -- Leader key simulation
        -- Leader key is ; (semicolon). To print semicolon itself, just press it twice, the following
        -- keystroke will be entered: ";(semicolon) (space)^H(ctrl-h aka backspace)".
        -- Note: this is experimental feature, need some time to test it (20241122).
        rl.setbinding([[";;"]], [["; "]])                                 -- ;;               - enter semicolon itself
        rl.setbinding([[";h"]], [["luafunc:sakkada_showkeybindings"]])      -- ;h               - show clink popup with all keybindings to show or select and run

        rl.setbinding([[";ff"]], [["luafunc:fzf_file"]])                    -- ;ff              - fzf files
        rl.setbinding([[";fd"]], [["luafunc:fzf_directory"]])               -- Ctrl-F,d         - fzf directories

        -- Luaexec plugin
        rl.setbinding([[";xl"]], [["luafunc:clink_execute_lua"]])           -- ;xl (C-x,C-l) toggle Lua execute mode
        rl.setbinding([[";xk"]], [["luafunc:clink_expand_lua_var"]])        -- ;xk (C-x,C-k) expand the value of the Lua variable under the cursor

        -- Gismos abbr plugin
        rl.setbinding([[";x "]], [["luafunc:abbr_expand"]])                 -- ;x{spabe} -> from doc: CTRL-X,SPACE expands the preceding abbreviation if possible
        rl.setbinding([[";xa"]], [["luafunc:abbr_popup"]])                  -- ;xa       -> from doc: CTRL-X,A show abbreviations and their expansions in a popup list

        rl.setbinding([[";xd"]], [["luafunc:doskey_popup"]])                -- ;xd       -> from doc: CTRL-X,D show doskey aliases and their expansions in a popup list
    end
end
