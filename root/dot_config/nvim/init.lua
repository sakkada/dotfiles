--------------------------------------------------------------------------------
--// VIM OPTIONS //-------------------------------------------------------------
--------------------------------------------------------------------------------

-- vim.g   - global (g:) editor variables, (:help vim.g)
-- vim.o   - get or set options, works like :set (:help vim.o)
-- vim.opt - manage list- and map-style options from Lua (:help vim.opt)
-- Examples:
--     vim.g.mapleader = ' '
--     vim.o.compatible = false
--     vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
--     vim.opt.wildignore:append { "*.pyc", "node_modules" }

vim.cmd.language('en_GB') -- Vim language

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.compatible = false -- Neovim is always nocompatible
vim.o.termguicolors = true -- Enables 24-bit RGB color in the TUI
vim.o.guifont = 'Consolas NF:h10' -- Font in GUI mode, e.g. in Neovide
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.o.shellslash = false -- Windows only: use forward slashes in paths if set
vim.opt.path:append({ '**' }) -- Search current directory recursively (see :help file-searching)

vim.o.number = true -- Show numbers
vim.o.relativenumber = false -- Show relative numbers
vim.o.colorcolumn = '110' -- Columns that are highlighted with ColorColumn color (strings)

-- Behaviour
vim.o.mouse = 'a' -- Enable 'a' mouse mode (default 'nvi'), (see :help mouse)
vim.o.timeoutlen = 1000 -- Timeout for multikey hotkeys (e.g.: ;j)
vim.o.hidden = true -- Keep hidden buffers open
vim.o.virtualedit = 'block' -- Cursor may go out of text (like in Far editor)
vim.o.scrolloff = 1 -- Keep gap from cursor and top/bottom of page
vim.o.breakindent = true -- Enable break indent
vim.o.updatetime = 2000 -- Decrease update time, default is 4000
vim.o.undofile = true -- Save undo history
vim.o.splitbelow = true -- On split, put new window below of current
vim.o.splitright = true -- On split, put new window right of current
vim.o.confirm = true -- Show yes/no dialog instead of unsaved changes error (see :help confirm)

-- Command-line
vim.o.cmdheight = 1 -- Cmd mode line height, default is 1
vim.o.cmdwinheight = 10 -- Cmd preview window height, default is 7, used in ctrl-f cmd history preview, inccommand preview, etc.
vim.o.showcmd = true -- Display current command input
vim.o.wildmenu = true -- Display all matches in menu
vim.o.wildcharm = 9 -- Char to invoke wildmenu in macroses (9 is <tab>)
vim.opt.wildmode = { 'longest', 'full' } -- Complete till longest common string first, full second
vim.opt.wildoptions = { 'fuzzy', 'pum', 'tagfile' } -- Cmdline completion behaviour (values: fuzzy, pum, tagfile)

-- Status-line
vim.o.statusline = '%<%f %h%m%r%y%=:%n %b/0x%B  %c-%v,%l(%L) %P' -- Status line printf style template
vim.o.laststatus = 2 -- Always show statusline

-- Search
vim.o.incsearch = true -- Incremental search
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Smartcase: all lower - ignore, any upper - not ignore

-- Non-printable characters and newline mode
vim.o.list = true -- Enable list mode: show non-printable characters
vim.opt.listchars = { tab = '«=»', trail = '·', extends = '▶', precedes = '◀', nbsp = '␣' } -- Strings to use in list mode
vim.opt.fileformats = { 'unix' } -- Formats that will be tried when starting to edit buffer

-- Tabs and spaces
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 4 -- Size of indent in spaces
vim.o.tabstop = 4 -- Size of <tab> in spaces

-- Ctags completion and navigation (universal-ctags)
-- https://stackoverflow.com/questions/934233/cscope-or-ctags-why-choose-one-over-the-other
-- https://github.com/dhananjaylatkar/cscope_maps.nvim (cscope support in neovim)
-- usage: ctags --options-maybe=~/.config/ctags --recurse --exclude=dir[ --exclude=dir2] --fields=+lnim --languages=python,graphql --python-kinds=+zl --extras=-r -f .tags "*"
vim.opt.tags = { '.tags;' } -- Search tags file in current directory and all ancestors (see :help file-searching)
vim.opt.complete = { '.', 'w', 'b', 'u', 't' } -- Specifies how ins-completion works, default=.,w,b,u,t
vim.opt.completeopt = { 'longest', 'popup', 'menuone' } -- List of options for Ins-completion, default=menu,popup
vim.o.omnifunc = 'syntaxcomplete#Complete' -- Function for insert mode omni completion (c-x c-o)

-- Schedule settings after `UiEnter` which can increase startup-time
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
  vim.cmd('packadd cfilter') -- Install builtin cfilter-plugin, adds Cfilter, Lfilter
end)

--------------------------------------------------------------------------------
--// VIM KEYMAPS //-------------------------------------------------------------
--------------------------------------------------------------------------------

-- Semicolon prefixed
vim.keymap.set('i', ';j', '<esc>', { desc = 'Esc alias' })
vim.keymap.set('t', ';j', '<c-\\><c-n>', { desc = 'Esc alias' })
vim.keymap.set('v', ';j', '<esc>', { desc = 'Esc alias' })

vim.keymap.set('i', ';v', '<c-r>"', { desc = 'Paste from unnamed register' })
vim.keymap.set('i', ';V', '<c-r>+', { desc = 'Paste from clipboard' })

vim.keymap.set('i', ';u', '<c-g>u', { desc = 'Create new change (undo from here)' })

vim.keymap.set('i', ';y', 'pumvisible() ? "<c-y>" : ";y"', { desc = 'Ctrl-Y in popup menu (pum)', expr = true })
vim.keymap.set('i', ';e', 'pumvisible() ? "<c-e>" : ";e"', { desc = 'Ctrl-E in pupup menu (pum)', expr = true })

vim.keymap.set('i', ';x', '<c-x>', { desc = 'Ctrl-X sub-mode (wait timeoutlen)' })
vim.keymap.set('i', ';xx', '<c-x>', { desc = 'Ctrl-X sub-mode' })
vim.keymap.set('i', ';xl', '<c-x><c-l>', { desc = 'c-x c-l - complete whole lines' })
vim.keymap.set('i', ';xn', '<c-x><c-n>', { desc = 'c-x c-n - complete keywords in the current file' })
vim.keymap.set('i', ';xi', '<c-x><c-i>', { desc = 'c-x c-i - complete keywords in opened files' })
vim.keymap.set('i', ';xt', '<c-x><c-]>', { desc = 'c-x c-] - complete tags' })
vim.keymap.set('i', ';xf', '<c-x><c-f>', { desc = 'c-x c-f - complete file names' })
vim.keymap.set('i', ';xd', '<c-x><c-d>', { desc = 'c-x c-d - complete definitions or macroses' })
vim.keymap.set('i', ';xv', '<c-x><c-v>', { desc = 'c-x c-v - complete vim command-line keywords' })
vim.keymap.set('i', ';xu', '<c-x><c-u>', { desc = 'c-x c-u - user defined completion' })
vim.keymap.set('i', ';xo', '<c-x><c-o>', { desc = 'c-x c-o - omni completion' })
vim.keymap.set('i', ';xs', '<c-x>s', { desc = 'c-x s - Spelling suggestions' })
vim.keymap.set('i', ';xK', '<c-x><c-k>', { desc = 'c-x c-k - keywords in dictionary' })
vim.keymap.set('i', ';xT', '<c-x><c-t>', { desc = 'c-x c-t - keywords in thesaurus' })
vim.keymap.set('i', ';xy', '<c-x><c-y>', { desc = 'c-x c-y - scroll down (insert scroll mode)' })
vim.keymap.set('i', ';xe', '<c-x><c-e>', { desc = 'c-x c-e - scroll up (insert scroll mode).' })

-- Ctags
vim.keymap.set('n', 'gd', 'g<c-]>', { desc = 'Tags: go to defenition' })
vim.keymap.set('n', 'gD', ':ltag <c-r><c-w><cr><c-t>:lopen<cr>', { desc = 'Tags: word-under-cursor tag list' }) -- ltag word-under-cursor > ctrl-t to return back > lopen to show list
vim.keymap.set('n', '<leader>ds', ':stag <c-R><c-w><cr>', { desc = 'Tags: show tag in split' })
vim.keymap.set('n', '<leader>dv', ':vert :stag <c-r><c-w><cr>', { desc = 'Tags: show tag in v-split' })
vim.keymap.set('n', '<leader>dp', ':ptag <c-r><c-w><cr>', { desc = 'Tags: show tag in preview window' })

-- Do* keymaps
vim.keymap.set('n', '<leader>dow', ':windo ', { desc = 'Do* :windo' })
vim.keymap.set('n', '<leader>dob', ':bufdo ', { desc = 'Do* :bufdo' })
vim.keymap.set('n', '<leader>dot', ':tabdo ', { desc = 'Do* :tabdo' })
vim.keymap.set('n', '<leader>doc', ':cfdo', { desc = 'Do* :cfdo' })
vim.keymap.set('n', '<leader>dol', ':lfo ', { desc = 'Do* :ldo' })
vim.keymap.set('n', '<leader>doa', ':argdo ', { desc = 'Do* :argdo' })

vim.keymap.set('n', '<leader>ll', ':nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>', { desc = 'Ctrl-L like clear' }) -- acts like orig CTRL-L, taken from runtime/lua/_editor.lua
vim.keymap.set('n', '<leader>lh', ':set hlsearch<cr>', { desc = 'Set hlsearch' })
vim.keymap.set('n', '<leader>lzz', ':Lazy<cr>', { desc = 'Open Lazy' })
vim.keymap.set('n', '<leader>lzc', ':Lazy check<cr>', { desc = 'Run Lazy check' })

vim.keymap.set('n', '<leader>qq', ':q<cr>', { desc = 'Quit current window' })
vim.keymap.set('n', '<leader>qa', ':qa<cr>', { desc = 'Quit all windows' })

vim.keymap.set('n', '<leader>uw', ':set wrap!<cr>', { desc = 'Toggle wrap' })

vim.keymap.set('n', '<leader>jl', ':ls<cr>', { desc = 'List all buffers' })
vim.keymap.set('n', '<leader>jj', function()
  vim.api.nvim_feedkeys(':b \t', 'nt', true)
  vim.schedule(function()
    if vim.fn.wildmenumode() == 1 then
      vim.api.nvim_input('')
    end
  end)
end, { desc = 'List named buffers in wildmenu' })

vim.keymap.set('n', '<leader>rfn', ':%s/\\r//g<cr>', { desc = 'Run: format newlines - erase all \\r' })

vim.keymap.set('n', '<leader>gvp', '`[v`]', { desc = 'Visual select last paste' })

-- Windows navigation
vim.keymap.set('n', '<c-h>', '<c-w>h', { desc = 'Go to right window' }) -- overlaps default CTRL-H (acts like <BS>)
vim.keymap.set('n', '<c-j>', '<c-w>j', { desc = 'Go to bottom window' }) -- overlaps default CTRL-J (acts like j, <down>, etc.)
vim.keymap.set('n', '<c-k>', '<c-w>k', { desc = 'Go to top window' })
vim.keymap.set('n', '<c-l>', '<c-w>l', { desc = 'Go to left window' }) -- overlaps default CTRL-L (clear screen, :nohlsearch, :diffupdate)
vim.keymap.set('i', '<c-h>', 'pumvisible() ? "<c-h>" : "<c-\\><c-n><c-w>h"', { expr = true, desc = 'Go to left window (if no PUM)' })
vim.keymap.set('i', '<c-j>', '<c-\\><c-n><c-w>j', { desc = 'Go to bottom window' })
vim.keymap.set('i', '<c-k>', '<c-\\><c-n><c-w>k', { desc = 'Go to top window' })
vim.keymap.set('i', '<c-l>', 'pumvisible() ? "<c-l>" : "<c-\\><c-n><c-w>l"', { expr = true, desc = 'Go to right window (if no PUM)' })

vim.keymap.set('i', '<tab>', 'pumvisible() ? "<c-n><c-p>" : "<tab>"', { expr = true })

vim.keymap.set('n', '<a-left>', ':vertical resize +1<cr>', { desc = 'Vertical resize +1' })
vim.keymap.set('n', '<a-right>', ':vertical resize -1<cr>', { desc = 'Vertical resize -1' })
vim.keymap.set('n', '<a-up>', ':resize -1<cr>', { desc = 'Resize -1' })
vim.keymap.set('n', '<a-down>', ':resize +1<cr>', { desc = 'Resize +1' })
vim.keymap.set('n', '<a-pageup>', '<c-w>_<c-w>|', { desc = 'Maximize window size' })
vim.keymap.set('n', '<a-pagedown>', '<c-w>=', { desc = 'Equalize windows sizes' })
vim.keymap.set('n', '<leader>ww', '<c-W>', { noremap = true })

vim.keymap.set('n', '<tab>', ':bnext<cr>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<s-tab>', ':bNext<cr>', { desc = 'Go to previous buffer' })

-- Command line
-- stylua: ignore start
vim.keymap.set('c', '<up>', function() return vim.fn.wildmenumode() == 1 and '<c-p>' or '<up>' end, { expr = true }) -- next suggestion in windmenu
vim.keymap.set('c', '<down>', function() return vim.fn.wildmenumode() == 1 and '<c-n>' or '<down>' end, { expr = true }) -- prev suggestion in windmenu
vim.keymap.set('c', '<s-del>', '<c-\\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>') -- clear cmd line till the end
-- stylua: ignore end

-- Command line commands
vim.keymap.set('n', '<leader>;', ':', { desc = 'Enter command line mode...' })
vim.keymap.set('n', '<leader>cvr', ':vimgrep <c-r>" **/*.*', { desc = 'Vimgrep " register' })
vim.keymap.set('n', '<leader>cvw', ':vimgrep <c-r><c-w> **/*.*', { desc = 'Vimgrep current word' })

vim.keymap.set('n', '<leader>cc', ':CC<tab><s-tab>', { desc = 'Show all CC prefixed custom commands' })
vim.keymap.set('n', 'CC', ':CC<tab><s-tab>', { desc = 'Show all CC prefixed custom commands' })
vim.keymap.set('v', 'CC', ':CC<tab><s-tab>', { desc = 'Show all CC prefixed custom commands' })
-- vim.keymap.set('n', 'CC', function() vim.api.nvim_feedkeys(':CC\t', 'nt', true) end)
-- vim.keymap.set('v', 'CC', function() vim.api.nvim_feedkeys(':CC\t', 'nt', true) end)

-- Quickfix
vim.keymap.set('n', '<leader>qfp', ':silent! :colder<cr>', { desc = 'Prev quickfix list' })
vim.keymap.set('n', '<leader>qfn', ':silent! :cnewer<cr>', { desc = 'Next quickfix list' })
vim.keymap.set('n', '<leader>qfl', ':chistory<cr>', { desc = 'Show list of quickfix lists' })

-- Textobjects
vim.keymap.set('x', 'il', '_og_', { desc = 'Inside line' })
vim.keymap.set('x', 'al', '0o$h', { desc = 'Around line' })
vim.keymap.set('o', 'il', ':norm vil<cr>', { desc = 'Inside line' })
vim.keymap.set('o', 'al', ':norm val<cr>', { desc = 'Around line' })

vim.keymap.set('x', 'i%', 'ggoGV', { desc = 'Whole file' })
vim.keymap.set('o', 'i%', ':norm vi%<cr>', { desc = 'Whole file' })

-- Star/Hash search enhancement (*, #, g*, g#)
-- First press - highlight only, second press - search as usual
local function star_hash(is_star, is_g)
  -- arguments default values
  is_g = is_g or false
  search_key = (is_star == nil or is_star) and '*' or '#'

  -- get current word under cursor and search register content
  local search_reg = vim.fn.getreg('/')
  local current = vim.fn.expand('<cword>')
  local is_keyword = vim.fn.match(current, [[\v^\k+$]]) ~= -1

  -- handle g prefix
  if not is_g and is_keyword then
    current = '\\<' .. current .. '\\>' -- see :help star, \<\> only if iskeyword
  elseif is_g then
    search_key = 'g' .. search_key
  end

  if vim.v.count > 0 then
    vim.cmd.normal({ vim.v.count .. search_key, bang = true }) -- default if count is defined
  elseif vim.v.hlsearch == 1 and current == search_reg then
    vim.cmd.normal({ search_key, bang = true })
  elseif current == search_reg then
    vim.api.nvim_set_option('hlsearch', true)
  else
    vim.fn.setreg('/', current)
    vim.api.nvim_set_option('hlsearch', true)
  end
end
-- stylua: ignore start
vim.keymap.set('n', '*', function() star_hash(true, false) end, { desc = 'Highlight before search' })
vim.keymap.set('n', '#', function() star_hash(false, false) end, { desc = 'Highlight before search' })
vim.keymap.set('n', 'g*', function() star_hash(true, true) end, { desc = 'Highlight before search' })
vim.keymap.set('n', 'g#', function() star_hash(false, true) end, { desc = 'Highlight before search' })
-- stylua: ignore end

--------------------------------------------------------------------------------
--// VIM AUTOCOMMANDS //--------------------------------------------------------
--------------------------------------------------------------------------------

-- WezTerm keybindings support for neovim
-- Helper function to send an OSC 1337 SetUserVar escape sequence
-- https://wezterm.org/config/lua/pane/get_user_vars.html
local function set_wezterm_user_var(name, b64value)
  local escape_seq = string.format('\27]1337;SetUserVar=%s=%s\007', name, b64value)
  vim.cmd("call chansend(v:stderr, '" .. escape_seq .. "')")
end
local wezterm_group = vim.api.nvim_create_augroup('WezTermUserVar', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = wezterm_group,
  callback = function()
    set_wezterm_user_var('IS_NVIM', 'dHJ1ZQ==') -- echo -n true | base64
  end,
})
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = wezterm_group,
  callback = function()
    set_wezterm_user_var('IS_NVIM', 'ZmFsc2U=') -- echo -n false | base64
  end,
})

-- Restore last cursor position (:help last-position-jump)
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { '*' },
  command = [[autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
})

-- Highlight on yank
local highlight_yank_group = vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yankgrp,
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
  end,
})

--------------------------------------------------------------------------------
--// VIM COMMANDS //------------------------------------------------------------
--------------------------------------------------------------------------------
-- stylua: ignore start

-- Diff the original state of file (:help :DiffOrig)
vim.api.nvim_create_user_command(
  'DiffOrig',
  'vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
  {}
)

-- Less command for command output
vim.api.nvim_exec([[
function! Less(winid, mods, args) abort
  execute (len(a:mods) ? a:mods . ' new' : 'botr 30new')
  echo a:args[0]
  call setline(1,split(win_execute(a:winid, a:args),"\n"))
  setl bt=nofile bh=wipe nobl nomod
endfunction
]], false)
vim.api.nvim_create_user_command(
  -- :tab Less map
  -- :topleft Less messages
  -- <q-mods> Less <q-args>, :help <q-mods>, :help <q-args>
  -- https://www.reddit.com/r/vim/comments/xvhw4w/how_do_you_read_long_messages_in_messages/
  'Less',
  ':call Less(win_getid(), <q-mods>, <q-args>)',
  { nargs = '+', complete = 'command' }
)

-- CC prefixed - Custom commnads
-- -----------------------------

-- Command arguments inspection for vim and lua
local command_args_vim = [[:lua vim.notify([=[
Command modifiers and arguments:
See :help <lt>mods>, :help <lt>q-mods>
    :help <lt>args>, :help <lt>q-args>, :help <lt>f-args>, :help q-args-example
----------------------------------------------------------------------
<lt>mods>:                    [ <mods> ],
<lt>q-mods> (quoted mods):    [ <q-mods> ],
<lt>args>:                    [ <args> ],
<lt>q-args> (quoted args):    [ <q-args> ],
<lt>f-args> (function args):  [ <f-args> ]
]=])]]
vim.api.nvim_create_user_command(
  'CCEchoArgsVim',
  command_args_vim,
  { nargs = '*', complete = 'file' }
)

local command_args_lua_tpl = [[
Command handler function opts (modifiers and arguments):
See :help nvim_create_user_command()
------------------------------------
opts = %s
]]
vim.api.nvim_create_user_command(
  'CCEchoArgsLua',
  function(opts)
    vim.notify(string.format(command_args_lua_tpl, vim.inspect(opts)))
  end,
  { nargs = '*', complete = 'file' }
)

-- Location list commands
vim.api.nvim_create_user_command(
  'CCLocListOpenVert',
  function(opts)
    local height = opts.args ~= '' and tonumber(opts.args) or 60
    local command = ':vert :lopen %s | :set nowrap | :wincmd w'
    vim.cmd(command:format(height))
  end,
  { nargs = '?', bar = true }
)

-- Quickfix commands
-- Open vertical quickfix window with optional width (default 60)
vim.api.nvim_create_user_command(
  'CCQuickFixOpenVert',
  function(opts)
    local height = opts.args ~= '' and tonumber(opts.args) or 60
    local command = ':vert :copen %s | :set nowrap | :wincmd w'
    vim.cmd(command:format(height))
  end,
  { nargs = '?', bar = true }
)

-- Fill quickfix from buffer, if no line:col: pattern add 1:1: and open quickfix window
vim.api.nvim_create_user_command(
  'CCQuickFixFromBuffer',
  [[if search('\v:\d+:\d+\r?$') == 0 | :%s/\v(.{-1,})(:.*)?(\r?)$/\1:1:1\2\3/ | :set nohlsearch | endif | :cexpr getbufline(bufnr(), 0, getbufinfo(bufnr())[0]['linecount']) | redraw | CCQuickFixOpenVert]],
  { nargs = 0, bar = true }
)

-- Populate quickfix list with oldfiles
vim.api.nvim_create_user_command(
  'CCQuickFixFromOldfiles',
  [[call setqflist(map(copy(v:oldfiles), {_, f -> {'filename': f, 'text': '-> go to last pos'}})) | CCQuickFixOpenVert]],
  { nargs = 0, bar = true }
)

-- Populate quickfix list with oldfiles and filter with defined expression
-- > :CCQuickFixFromOldfilesFiltered v:key <= 10      # get first 10 items
-- > :CCQuickFixFromOldfilesFiltered v:val =~ 'test'  # get all items matches regex
--   where v:val =~ 'test' is second argument for ":help filter()" function
-- See :help filter()
--     :help expression-syntax
vim.api.nvim_create_user_command(
  'CCQuickFixFromOldfilesFiltered',
  [[call setqflist(map(filter(copy(v:oldfiles), <q-args>), {_, f -> {'filename': f, 'text': '...no last line and col'}})) | CCQuickFixOpenVert]],
  { nargs = '+', complete = 'expression', bar = true }
)

-- Slice quickfix list from start to end (arg1 and arg2)
vim.api.nvim_create_user_command(
  'CCQuickFixSlice',
  function(opts)
    local istart, iend
    local argscount = table.getn(opts.fargs)
    -- arguments validation
    if argscount < 1 or argscount > 2 then
      vim.api.nvim_err_writeln(string.format('Incorrect arguments count, must be 1 or 2 values, got %d.', argscount))
      return nil
    end
    for i, v in ipairs(opts.fargs) do
      if not v:match '%d+' then
        vim.api.nvim_err_writeln(string.format('Incorrect #%d argument value, must be non negative integer, got %s.', i, vim.inspect(v)))
        return nil
      end
    end
    -- slicing
    if argscount == 1 then
      istart, iend = 0, tonumber(opts.fargs[1])
    else
      istart, iend = tonumber(opts.fargs[1]), tonumber(opts.fargs[2])
    end
    vim.fn.setqflist(vim.list_slice(vim.fn.getqflist(), istart, iend))
  end,
  { nargs = '*', complete = 'expression', bar = true }
)

-- Ripgrep commands
vim.api.nvim_create_user_command(
  'CCRg',
  ":cexpr system('rg --smart-case     --vimgrep <args>') | CCQuickFixOpenVert",
  { nargs = '+', complete = 'file' }
)

vim.api.nvim_create_user_command(
  'CCRgCaseSensitive',
  ":cexpr system('rg --case-sensitive --vimgrep <args>') | CCQuickFixOpenVert",
  { nargs = '+', complete = 'file' }
)

vim.api.nvim_create_user_command(
  'CCRgRaw',
  ":cexpr system('rg                  --vimgrep <args>') | CCQuickFixOpenVert",
  { nargs = '+', complete = 'file' }
)
-- stylua: ignore end

--------------------------------------------------------------------------------
--// LAZY PLUGINS and OPTIONS //------------------------------------------------
--------------------------------------------------------------------------------

LAZY_PLUGINS = {
  {
    'ellisonleao/gruvbox.nvim',
    opts = {
      undercurl = false,
      underline = false,
      bold = false,
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = '', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        Whitespace = { fg = '#3090f0' }, -- listchars: tab,trail,nbsp; (:h hl-Whitespace)
        NonText = { fg = '#f0a010' }, -- listchars: extends,precedes, ~(empty), showbreak, etc.; (:h hl-NonText)
        SpecialKey = { fg = '#30d090' }, -- \r (h hl-SpecialKey)
        FloatBorder = { fg = '#87796B', bg = '#3C3836' },
        FlashMatch = { fg = '#b8bb26' },
        FlashCurrent = { fg = '#FABD2F', bold = true },
        FlashLabel = { fg = '#30d090', bold = true },
      },
      dim_inactive = false,
      transparent_mode = false,
    },
    init = function()
      vim.cmd.colorscheme('gruvbox')
      vim.o.background = 'dark'
    end,
  },
  {
    'vifm/vifm.vim',
    cmd = { 'EditVifm', 'Vifm', 'PeditVifm', 'SplitVifm', 'VsplitVifm', 'DiffVifm', 'TabVifm' },
    ft = { 'vifm' },
    init = function()
      vim.g.vifm_replace_netrw = 1
      vim.g.vifm_embed_split = false
      vim.env.LINES = vim.env.LINES - 2

      -- Vifm (set not in lazy keys due to error in vifm.vim plugin: drop on line 33 raises E565)
      vim.keymap.set('n', '<leader>vv', ':Vifm<cr>', { desc = 'Open Vifm in current file realted directory' })
      vim.keymap.set('n', '<leader>vc', ':Vifm .<cr>', { desc = 'Open Vifm in vim CWD directory' })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      '*', -- highlight all files with default config
      css = { rgb_fn = true, hsl_fn = true, css = true, css_fn = true },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'colorizer',
  },
  {
    'wsdjeg/bufdel.nvim',
    cmd = { 'Bdelete' },
    keys = {
      { '<leader>bd', '<cmd>Bdelete<cr>', desc = 'Delete current buffer' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'numtostr/comment.nvim',
    opts = {},
    keys = {
      { 'gc', '<Plug>(comment_toggle_linewise)', { desc = 'Comment toggle linewise' } },
      { 'gb', '<Plug>(comment_toggle_blockwise)', { desc = 'Comment toggle blockwise' } },
      { 'gc', '<Plug>(comment_toggle_linewise_visual)', mode = 'x', { desc = 'Comment toggle linewise (visual)' } },
      { 'gb', '<Plug>(comment_toggle_blockwise_visual)', mode = 'x', { desc = 'Comment toggle blockwise (visual)' } },
    },
    init = function()
      -- drop builtin comment mapping
      vim.keymap.del('n', 'gcc')
    end,
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {
      move_cursor = 'sticky', -- cursor "stick" to the current character
      -- mini.surround like mapping avoids conficts with remote actions in flash/hope/etc.
      -- a (add) changed to f (let it be fence) for the purpose of convenience
      keymaps = {
        insert = ';s', --           -- default is '<c-g>s'
        insert_line = ';S', --      -- default is '<c-g>S'
        normal = 'sf', --           -- default is 'ys'
        normal_line = 'sF', --      -- default is 'yS'
        normal_cur = 'sff', --      -- default is 'yss'
        normal_cur_line = 'sFF', -- -- default is 'ySS'
        visual = 'S', --            -- default is 'S'
        visual_line = 'gS', --      -- default is 'gS'
        delete = 'sd', --           -- default is 'ds'
        change = 'sc', --           -- default is 'cs'
        chage_line = 'sC', --       -- default is 'cS'
      },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          enabled = false,
          multi_line = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { 'ss', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash', },
      { 'sS', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter', },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash', },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search', },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search', },
    },
  },
  {
    'nvimtools/hydra.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
    },
    -- stylua: ignore
    config = function()
      -- https://github.com/anuvyklack/hydra.nvim?tab=readme-ov-file#color
      -- Body Color  Basic color Executing NON-HEAD      Executing HEAD
      -- ----------  ----------- ---------------------   --------------
      -- amaranth    red         Disallow and Continue   Continue
      -- teal        blue        Disallow and Continue   Quit
      -- pink        red         Allow and Continue      Continue
      -- red         red         Allow and Quit          Continue
      -- blue        blue        Allow and Quit          Quit

      local hydra = require('hydra')
      local gitsigns = require('gitsigns')
      local hint
      local prettifier = function(str)
        return vim.fn.substitute(str, [[\v(^|\n)(\s+\.?)]], '\\1', 'g')
      end

      -- Scrolling
      hydra({
        name = 'Side scroll',
        mode = 'n',
        body = 'z',
        heads = {
          { 'h', 'zh' },
          { 'l', 'zl', { desc = '←/→' } },
          { 'H', 'zH' },
          { 'L', 'zL', { desc = 'half screen ←/→' } },
        },
      })

      -- Diff, gitdiff navigation
      local hint = [[
        . Diff navigation: _c_/_C_: hybrid ↓/↑, _d_/_D_: gitsigns ↓/↑
        . Actions:         _p_/_o_: diff put/obtain, _._, _u_, _z_: as is, _<Esc>_: exit 
      ]]
      hydra({
        name = 'Diff navigation',
        hint = prettifier(hint),
        config = {
          on_key = function() vim.wait(50) end,
          hint = {
            type = 'window',
            position = 'bottom-middle',
          },
        },
        mode = 'n',
        body = ']',
        heads = {
          { 'p', 'dp', { desc = 'diff put' } },
          { 'o', 'do', { desc = 'diff obtain' } },
          { 'z', 'zz', { desc = 'vert center cursor' } },
          { '.', '.', { desc = 'repeat' } },
          { 'u', 'u', { desc = 'undo' } },
          {
            'c',
            function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next diff or hunk' },
          },
          {
            'C',
            function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev diff or hunk (↓/↑)' },
          },
          {
            'd',
            function()
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next hunk' },
          },
          {
            'D',
            function()
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev hunk (↓/↑)' },
          },
        },
      })
      local hint = [[
        . Diff navigation (reverse): _c_/_C_: hybrid ↑/↓, _d_/_D_: gitsigns ↑/↓
        . Actions:                   _p_/_o_: diff put/obtain, _._, _u_, _z_: as is, _<Esc>_: exit 
      ]]
      hydra({
        name = 'Diffmode navigation (reverse)',
        hint = prettifier(hint),
        config = {
          on_key = function()
            vim.wait(50)
          end,
          hint = {
            type = 'window',
            position = 'bottom-middle',
          },
        },
        mode = 'n',
        body = '[',
        heads = {
          { 'p', 'dp', { desc = 'diff put' } },
          { 'o', 'do', { desc = 'diff obtain' } },
          { 'z', 'zz', { desc = 'vert center cursor' } },
          { '.', '.', { desc = 'repeat' } },
          { 'u', 'u', { desc = 'undo' } },
          {
            'c',
            function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next diff or hunk' },
          },
          {
            'C',
            function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev diff or hunk (↑/↓)' },
          },
          {
            'd',
            function()
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next hunk' },
          },
          {
            'D',
            function()
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev hunk (↑/↓)' },
          },
        },
      })

      -- Quickfix, Loclist navigation
      hydra({
        name = 'Quickfix/Loclist navigation',
        hint = [[ Quickfix/Loclist navigation: _q_, _Q_: ↓/↑, _l_, _L_: ↓/↑, _<Esc>_: exit ]],
        mode = 'n',
        config = {
          hint = {
            type = 'window',
            position = 'bottom-middle',
          },
        },
        body = ']',
        heads = {
          { 'q', '<cmd>:cnext<cr>' },
          { 'Q', '<cmd>:cNext<cr>', { desc = '↓/↑' } },
          { 'l', '<cmd>:lnext<cr>' },
          { 'L', '<cmd>:lNext<cr>', { desc = '↓/↑' } },
        },
      })
      hydra({
        name = 'Quickfix/Loclist navigation (reverse)',
        hint = [[ Quickfix/Loclist navigation: _q_, _Q_: ↑/↓, _l_, _L_: : ↑/↓, _<Esc>_: exit ]],
        config = {
          hint = {
            type = 'window',
            position = 'bottom-middle',
          },
        },
        mode = 'n',
        body = '[',
        heads = {
          { 'q', '<cmd>:cNext<cr>' },
          { 'Q', '<cmd>:cnext<cr>', { desc = '↑/↓' } },
          { 'l', '<cmd>:lNext<cr>' },
          { 'L', '<cmd>:lnext<cr>', { desc = '↓/↑' } },
        },
      })

      -- Options window
      local hint = [[
        .
        .    Options
        .    ^
        .    _v_ %{ve} virtual edit
        .    _i_ %{list} invisible characters
        .    _s_ %{spell} spell
        .    _S_ %{inccmd} :s preview (inccommand)
        .    _w_ %{wrap} wrap
        .    _c_ %{cul} cursor line and column
        .    _n_ %{nu} number
        .    _r_ %{rnu} relative number
        .    _/_ %{ssl} shellslash
        .    ^
        .                            _<Esc>_    
        .    ^
      ]]
      hydra({
        name = 'Options',
        hint = prettifier(hint),
        config = {
          color = 'amaranth',
          invoke_on_body = true,
          hint = {
            type = 'window',
            float_opts = {
              -- https://en.wikipedia.org/wiki/Block_Elements
              -- :help nvim_open_win() for border options
              border = { '█', '▀', '█', '█', '█', '▄', '█', '█' },
            },
            position = 'middle',
            funcs = {
              ssl = function() return vim.o.shellslash and '[x]' or '[ ]' end,
              inccmd = function() return vim.o.inccommand == 'split' and '[x]' or '[ ]' end,
            },
          },
        },
        mode = { 'n', 'x' },
        body = '<leader>oo',
        heads = {
          {
            'n',
            function()
              if vim.o.number == true then vim.o.number = false else vim.o.number = true end
            end,
            { desc = 'number' },
          },
          {
            'r',
            function()
              if vim.o.relativenumber == true then
                vim.o.relativenumber = false
              else
                vim.o.number = true
                vim.o.relativenumber = true
              end
            end,
            { desc = 'relativenumber' },
          },
          {
            'v',
            function()
              if vim.o.virtualedit == 'all' then vim.o.virtualedit = 'block' else vim.o.virtualedit = 'all' end
            end,
            { desc = 'virtualedit' },
          },
          {
            'i',
            function()
              if vim.o.list == true then vim.o.list = false else vim.o.list = true end
            end,
            { desc = 'show invisible' },
          },
          {
            's',
            function()
              if vim.o.spell == true then vim.o.spell = false else vim.o.spell = true end
            end,
            { exit = true, desc = 'spell' },
          },
          {
            'S',
            function()
              if vim.opt.inccommand:get() == 'nosplit' then
                vim.opt.inccommand = 'split'
                vim.opt.cmdwinheight = 20
              else
                vim.opt.inccommand = 'nosplit'
                vim.opt.cmdwinheight = 10 -- default for this config
              end
            end,
            { desc = 'inccommand (:s prev)' },
          },
          {
            'w',
            function()
              if vim.o.wrap ~= true then vim.o.wrap = true else vim.o.wrap = false end
            end,
            { desc = 'wrap' },
          },
          {
            'c',
            function()
              if vim.o.cursorline == true then
                vim.o.cursorline = false
                vim.o.cursorcolumn = false
              else
                vim.o.cursorline = true
                vim.o.cursorcolumn = true
              end
            end,
            { desc = 'cursor line and column' },
          },
          {
            '/',
            function()
              vim.o.shellslash = not vim.o.shellslash
            end,
            { desc = 'shellslash' },
          },
          { '<Esc>', nil, { exit = true } },
        },
      })

      -- Git, gitsigns navigation
      local hint = [[
        . _J_: next hunk    _s_: stage hunk        _d_: show deleted   _D_: diff base
        . _K_: prev hunk    _S_: stage buffer      _p_: preview hunk   _T_: diff HEAD~
        . ^^                _R_: reset hunk        _I_:    ...inline   _/_: show base
        . _b_: blame line   _U_: undo last stage   ^ ^                 _~_: show HEAD~
        . _B_: blame full   ^ ^                    _<Enter>_: Neogit   _q_: exit       
      ]]
      hydra({
        name = 'Git',
        hint = prettifier(hint),
        config = {
          buffer = bufnr,
          color = 'pink',
          invoke_on_body = true,
          hint = {
            float_opts = {
              border = { '█', '▀', '█', '█', '█', '▄', '█', '█' },
            },
          },
          on_enter = function()
            -- vim.cmd 'mkview'
            -- vim.cmd 'silent! %foldopen!'
            -- vim.bo.modifiable = false
            -- gitsigns.toggle_signs(true)
            -- gitsigns.toggle_linehl(true)
          end,
          on_exit = function()
            -- local cursor_pos = vim.api.nvim_win_get_cursor(0)
            -- vim.cmd 'loadview'
            -- vim.api.nvim_win_set_cursor(0, cursor_pos)
            -- vim.cmd 'normal zv'
            -- gitsigns.toggle_signs(false)
            -- gitsigns.toggle_linehl(false)
            -- gitsigns.toggle_deleted(false)
          end,
        },
        mode = { 'n', 'x' },
        body = '<leader>gg',
        heads = {
          {
            'J',
            function()
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'next hunk' },
          },
          {
            'K',
            function()
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end,
            { expr = true, desc = 'prev hunk' },
          },
          { 's', ':Gitsigns stage_hunk<cr>', { silent = true, desc = 'stage hunk' } },
          { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
          { 'U', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
          { 'R', gitsigns.reset_hunk, { desc = 'reset hunk' } },
          { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
          { 'I', gitsigns.preview_hunk_inline, { desc = 'preview hunk inline' } },
          { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
          { 'b', gitsigns.blame_line, { desc = 'blame' } },
          {
            'B',
            function()
              gitsigns.blame_line({ full = true })
            end,
            { desc = 'blame show full' },
          },
          { '/', gitsigns.show, { exit = true, desc = 'show base file (index by default)' } },
          {
            '~',
            function()
              gitsigns.show('~')
            end,
            { exit = true, desc = 'show HEAD file' },
          },
          {
            'D',
            function()
              gitsigns.diffthis(nil, { vertical = true, split = 'rightbelow' })
            end,
            { exit = true, desc = 'diffthis witn base' },
          },
          {
            'T',
            function()
              gitsigns.diffthis('~', { vertical = true, split = 'rightbelow' })
            end,
            { exit = true, desc = 'diffthis witn HEAD' },
          },
          { '<Enter>', '<cmd>Neogit<cr>', { exit = true, desc = 'Neogit' } },
          { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
        },
      })
    end,
  },
  -- { import = 'plugins' },
}

LAZY_OTIONS = {
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'gruvbox', 'habamax' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

--------------------------------------------------------------------------------
--// LAZY.NVIM BOOTSTRAP AND SETUP //-------------------------------------------
--------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup(LAZY_PLUGINS, LAZY_OTIONS)

-- The next line is called modeline (see :help modeline)
-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
