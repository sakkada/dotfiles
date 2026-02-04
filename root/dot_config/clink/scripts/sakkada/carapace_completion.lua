-- Taken from https://github.com/chrisant996/clink/issues/801#issuecomment-3373927472
settings.add('sakkada.carapace.enable', false, 'Enable carapace completion.')
if not settings.get('sakkada.carapace.enable') then
    return
end

-- IMPORTANT!       If this script is built into carapace to be emitted for
-- IMPORTANT!       the 'cmd-clink' shell integration, then carapace should
-- IMPORTANT!       inject a hard-coded list of known commands in the
-- IMPORTANT!       load_command_list() function, instead of letting the
-- IMPORTANT!       function run carapace yet again.

local function carapace_completion(word, word_index, line_state, match_builder) -- luacheck: no unused
    local command = line_state:getword(line_state:getcommandwordindex())
    if command then
        command = path.getbasename(command)

        match_builder:setnosort()

        -- REVIEW:  setvolatile() forces regenerating completions every time
        -- they're needed, including potentially in the background while typing.
        -- It's ok to use in special cases it it's really needed, but it should
        -- used sparingly and carefully.  Note that in the case of carapace it's
        -- highly inefficient:  regenerating completions means running external
        -- programs, so setvolatile() means external programs may potentially be
        -- run over and over in the background while typing.
        --[[
        match_builder:setvolatile()
        --]]

        os.setenv('CARAPACE_COMPLINE', line_state:getline():sub(1, line_state:getcursor()))

        local file = io.popenyield(string.format('carapace %s cmd-clink ""', command))
        if file then
            for line in file:lines() do
                local matches = string.explode(line, '\t')

                if matches[1] then
                    local desc = matches[4] and matches[3] or nil
                    local appendchar = matches[4] or matches[3] or nil
                    local suppressappend = (not appendchar or appendchar == '') and true or nil
                    match_builder:addmatch({
                        match = matches[1],
                        display = matches[2],
                        description = desc,
                        -- IMPORTANT:  The 'word' type means carapace must take
                        -- full responsibility for (1) how filename and path
                        -- completions will work, (2) how completion coloring
                        -- is applied, and (3) how appendchar and suppressappend
                        -- are applied.
                        type = 'word',
                        appendchar = appendchar,
                        suppressappend = suppressappend,
                    })
                end
            end

            file:close() -- Don't wait for garbage collection to clean it up.

            -- Returning false lets Clink fall back to its default completion
            -- for filenames and paths.
            return not match_builder:isempty()
        end
    end
end

-- List of command names that need to be remapped to avoid registering incorrect
-- completion handlers on Windows.
local remap = {
    ['mkdir'] = 'mkdir.exe',
    ['rmdir'] = 'rmdir.exe',
    -- Etc; this is just a quick list to illustrate the problem and solution.
}

-- Make an argmatcher that forwards everything to the carapace program.
-- This intentionally creates a new argmatcher each time:  Because registering
-- the same argmatcher for all commands would make it so if another script
-- registers a 'foo' argmatcher that carapace already registered, then the two
-- argmatchers will be merged together, which would affect all commands carapace
-- registered argmatchers for.  Making a new argmatcher each time is safer
-- because it ensure that merging only affects the named command, instead of
-- affecting all commands.
local function make_argmatcher(command)
    clink.argmatcher(command):addarg({ nowordbreakchars = "'`=+;,", carapace_completion }):loop(1)
end

local function load_command_list()
    -- See IMPORTANT note at the beginning of this script, if this script is
    -- built into carapace to be emitted for the 'cmd-clink' shell integration.
    local commands = {}
    local file = io.popen('carapace --list --names')
    if file then
        for line in file:lines() do
            table.insert(commands, clink.lower(line))
        end
        file:close() -- Don't wait for garbage collection to clean it up.
    end
    log.info(string.format('carapace reported it knows %u commands.', #commands))
    return commands
end

if not clink.argmatcherloader then
    -- If Clink doesn't support custom argmatcher loaders, then register all
    -- argmatchers immediately.

    -- Function to register the argmatchers.
    local function register_argmatchers()
        for _, name in ipairs(load_command_list()) do
            local r = remap[name]
            name = r or name
            if not clink.getargmatcher(name) then
                make_argmatcher(name)
            end
        end
    end

    -- Defer registering the argmatchers until onbeginedit, to reduce collisions
    -- with other scripts.
    clink.onbeginedit(function()
        if register_argmatchers then
            register_argmatchers()
            -- Nil the function has two effects:
            --  1. Makes sure it's run only once.
            --  2. Allows garbage collection to clean up code and data that's no
            --     longer reachable.
            register_argmatchers = nil
        end
    end)
else
    -- If Clink supports custom argmatcher loaders, then register a callback to
    -- register carapace argmatchers on demand.

    local lookup

    local function initialize_lookup()
        -- Prepare a fast lookup table.
        local any
        lookup = {}
        for _, name in ipairs(load_command_list()) do
            local r = remap[name]
            name = r or name
            lookup[name] = true
            any = true
        end
        return any
    end

    local function loader(command_word, quoted) -- luacheck: no unused
        -- If the command is supported by carapace then return the argmatcher.
        local name = path.getname(command_word)
        local basename = path.getbasename(command_word)
        if lookup[clink.lower(name)] or lookup[clink.lower(basename)] then
            make_argmatcher(command_word)
        end
    end

    -- Register the loader function.  The loader function is only called if the
    -- command actually exists on the computer AND no argmatcher is registered
    -- for it yet.
    if initialize_lookup() then
        clink.argmatcherloader(50, loader)
    end
end
