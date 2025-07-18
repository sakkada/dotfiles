-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.charset = "unicode"
flexprompt.settings.flow = "concise"
flexprompt.settings.frame_color =
{
    "brightblack",
    "brightblack",
    "darkwhite",
    "darkblack",
}
flexprompt.settings.heads = "pointed"
flexprompt.settings.lean_separators = "space"
flexprompt.settings.left_frame = "round"
flexprompt.settings.left_prompt = "{battery}{histlabel}{cwd}{git}{duration}{time:format=%H:%M:%S}"
flexprompt.settings.lines = "one"
flexprompt.settings.nerdfonts_version = 3
flexprompt.settings.nerdfonts_width = 2
flexprompt.settings.powerline_font = true
flexprompt.settings.right_frame = "round"
flexprompt.settings.spacing = "normal"
flexprompt.settings.style = "lean"
flexprompt.settings.symbols =
{
    prompt = "❯",
}
