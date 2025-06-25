-- Sakkada flexprompt configuration
-- last udpate 2025-05-03T21:12:09.591746+00:00 for flexprompt version 0.18

-- https://github.com/chrisant996/clink-flex-prompt#advanced-configuration (docs)
-- https://gist.github.com/lboulard/a5d039c8e741bbad89a9d73ac03e6284 (gist:example)

-- flexprompt wizard steps values on 0.18 version
-- flexprompt configure -> y12y11211111n -> y to save

-- nerdfont - 2-small/winterminal 3-big/wezterm (set in autoconfig)
-- flexprompt.settings.nerdfonts_version = 3

-- use extended colors - wezterm/winterm
flexprompt.settings.use_8bit_color = true

-- disable frame
flexprompt.settings.left_frame = "none"
flexprompt.settings.right_frame = "none"

-- prompt symbols
flexprompt.settings.symbols =
{
    prompt = { "❯", winterminal = "❯", },
    transient_prompt = "❯",
}

-- Sakkada: 2-line setup
-- ---------------------
-- Note: there are 2 different ways:
-- 1. With lines=two and without top_prompt - unable to configure text before prompt (>) symbol
-- 2. With lines=one and with top_prompt and without right_prompt - allows to configure prompt
--
-- 1. 2-line setup (no top_prompt, left_prompt+right_prompt, lines - two)
-- ----------------------------------------------------------------------
-- flexprompt.settings.lines = "two"
-- flexprompt.settings.top_prompt = ""
-- flexprompt.settings.left_prompt = "{battery:show=95:li}{admin}{histlabel}{env:var=VIRTUAL_ENV_PROMPT:color=38;5;30}{npm}{cwd}{scm:sm:num}"
-- flexprompt.settings.right_prompt = "{exit}{duration}{time:color=darkgreen:format=%H:%M:%S}"
--
-- 2. 2-line setup (top_prompt, left_prompt, no right_prompt, lines - one)
-- -----------------------------------------------------------------------
flexprompt.settings.lines = "one"
flexprompt.settings.top_prompt = "{battery:show=95:li}{admin}{histlabel}{env:var=VIRTUAL_ENV_PROMPT:color=38;5;30}{npm}{cwd}{git:sm:num}"
flexprompt.settings.left_prompt = "{time:color=darkgreen:format=%H:%M:%S}{duration}{exit}"
flexprompt.settings.right_prompt = ""

-- -- Sakkada: added for more bright dots separator
-- -- ---------------------------------------------
-- -- Note: unused, now frame is disabled in current 2-line setup with one line and top_prompt
-- -- frame/back/fore/separator colors
-- -- taken from flexprompt.lua
-- --                 Frame       Back        Fore        Separator
-- -- lightest    = { "38;5;244", "38;5;240", "38;5;248", "38;5;244" },
-- -- light       = { "38;5;242", "38;5;238", "38;5;246", "38;5;242" },
-- -- dark        = { "38;5;240", "38;5;236", "38;5;244", "38;5;240" },
-- -- darkest     = { "38;5;238", "38;5;234", "38;5;242", "38;5;2_38" },
-- flexprompt.settings.frame_color =
-- {
--     "38;5;244",     -- Frame
--     "brightblack",  -- Background
--     "white",        -- Foreground
--     "darkblack",    -- Separator
-- }

-- -- Sakkada: prompt module for rendering PROMPT_CLINK variable
-- -- ----------------------------------------------------------
-- -- Note: unused, now it is replaced by {env} module
-- -- https://github.com/chrisant996/clink-flex-prompt#writing-custom-prompt-modules
-- local function render_prompt(args)
--     local color, altcolor, variable
--     local colors = flexprompt.parse_arg_token(args, "c", "color")
--     local style = flexprompt.get_style()
--
--     value = clink.get_env('PROMPT_CLINK')
--     if not value then
--         return
--     end
--
--     if style == "rainbow" then
--         color = flexprompt.use_best_color("blue", "38;5;19")
--     elseif style == "classic" then
--         color = flexprompt.use_best_color("cyan", "38;5;39")
--     else
--         color = flexprompt.use_best_color("red", "mod_cyan")
--     end
--
--     color, altcolor = flexprompt.parse_colors(colors, color, altcolor) -- luacheck: ignore 321
--
--     return value, color, altcolor
-- end
-- flexprompt.add_module("prompt", render_prompt)
