-- install setx /M XDG_CONFIG_HOME "%USERPROFILE%\.config"
-- to open in vim run :vs $MYVIMRC

local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set  -- TODO: use only keymap as map
local cmd = vim.api.nvim_command
local default_opts = {noremap = true, silent = true}

-- local skkdlib = require('sakkadalib')  -- not usable now

cmd('set number')
cmd('set relativenumber')       -- Show relative numbers
cmd('set path+=**')             -- Search current directory recursively
cmd('set showcmd')              -- Display current command input
cmd('set wildmenu')             -- Display all matches in menu
-- cmd('set wildmode=longest,full') -- Complete till longest common string first, full second
cmd('set wildcharm=<tab>')      -- Char to invoke wildmenu in macroses
cmd('set wildoptions=pum,tagfile')
cmd('set timeoutlen=1000')      -- Timeout for multikey hotkeys (;j)
cmd('set incsearch')            -- Incremental search
cmd('set hidden')               -- Keep hidden buffers open
cmd('set laststatus=2')         -- Always show statusline
cmd('language en_GB')           -- Vim text messages language
cmd('set virtualedit=block')    -- Cursor may go out of text (like in Far editor)
cmd('set scrolloff=1')          -- Keep gap from cursor and top/bottom of page

cmd('set expandtab')            -- Use spaces instead of tabs
cmd('set shiftwidth=4')         -- Size of tab in spaces
cmd('set tabstop=4')            -- Size of tab in spaces

cmd('set splitbelow')           -- On split, put new window below of current
cmd('set splitright')           -- On split, put new window right of current

cmd('set termguicolors')        -- Enables 24-bit RGB color in the TUI.
cmd('set nocompatible')         --

cmd('set ignorecase')           -- Ignore case in search patterns
cmd('set smartcase')            -- Smartcase: all lower - ignore, any upper - not ignore

cmd('set noshellslash')         -- Windows only: use forward slashes in paths if set
                                -- Note: changes shellescape behaviour and break vifm, so off by default.

cmd('set list')                 -- Enable list mode
cmd('set listchars=tab:«=»,trail:·,extends:▶,precedes:◀,nbsp:␣') -- listchars (●◆•→↲␣⟨⟩◀▶«»·)
-- cmd('set binary')               -- Enable binary mode (for showing "^M" symbols and all other binaries)
cmd('set fileformats=unix')     -- formats that will be tried when starting to edit buffer

cmd('set cmdheight=1')          -- cmd mode line height, default is 1
cmd('set cmdwinheight=10')      -- cmd preview windows height, default is 7, used in ctrl-f cmd history preview, inccommand preview, etc.

cmd('set inccommand=nosplit')   -- preview or not substitutions matches in preview cmd window, default nosplit (no preview)

-- cmd('set fillchars+=vert:\\ ')  -- Set space as separator char on splits

cmd('set statusline=%<%f\\ %h%m%r%y%=:%n\\ %b/0x%B\\ \\ %c-%v,%l(%L)\\ %P')
cmd('set guifont=Consolas\\ NF:h10')  -- neovide config

cmd('set colorcolumn=110')      -- columns that are highlighted with ColorColumn color

cmd('hi StatusLine cterm=none ctermfg=red ctermbg=none')  -- Set space as separator char on splits
cmd('hi StatusLineNC cterm=none ctermfg=green ctermbg=none')  -- Set space as separator char on splits
cmd('hi VertSplit cterm=none ctermfg=red ctermbg=none')  -- Set space as separator char on splits



vim.g.mapleader = ' '

-- map('v', 'S-Y', '"+y', {})
map('i', ';j', '<Esc>', {noremap = true})
map('t', ';j', '<C-\\><C-N>', {noremap = true})
map('v', ';j', '<Esc>', {noremap = true})

map('i', ';v', '<C-R>"', {noremap = true})
map('i', ';V', '<C-R>+', {noremap = true})

map('i', ';u', '<c-g>u', {desc = "Create new change (undo from here)."})

map('i', ';y',  'pumvisible() ? "<c-y>" : ";y"', {desc = "Ctrl-Y in popup menu (pum).", expr = true})
map('i', ';e',  'pumvisible() ? "<c-e>" : ";e"', {desc = "Ctrl-E in pupup menu (pum).", expr = true})

map('i', ';x',  '<c-x>',       {desc = "Ctrl-X sub-mode (wait)."})
map('i', ';xx', '<c-x>',       {desc = "Ctrl-X sub-mode."})
map('i', ';xl', '<c-x><c-l>',  {desc = "C-X C-L - whole lines."})
map('i', ';xn', '<c-x><c-n>',  {desc = "C-X C-N - keywords in the current file."})
map('i', ';xk', '<c-x><c-k>',  {desc = "C-X C-K - keywords in dictionary."})
map('i', ';xt', '<c-x><c-t>',  {desc = "C-X C-T - keywords in thesaurus."})
map('i', ';xi', '<c-x><c-i>',  {desc = "C-X C-I - keywords in the current and included files."})
map('i', ';x]', '<c-x><c-]>',  {desc = "C-X C-] - tags."})
map('i', ';x]', '<c-x><c-t>',  {desc = "C-X C-] - tags."})
map('i', ';xf', '<c-x><c-f>',  {desc = "C-X C-F - file names."})
map('i', ';xd', '<c-x><c-d>',  {desc = "C-X C-D - definitions or macros."})
map('i', ';xv', '<c-x><c-v>',  {desc = "C-X C-V - Vim command-line."})
map('i', ';xu', '<c-x><c-u>',  {desc = "C-X C-U - User defined completion."})
map('i', ';xo', '<c-x><c-o>',  {desc = "C-X C-O - omni completion."})
map('i', ';xs', '<c-x>s',      {desc = "C-X s   - Spelling suggestions."})

-- ctags
map('n', 'gd', 'g<C-]>', {noremap = true})  -- before nvim-cmd/lsp/etc installed
map('n', 'gD', ':ltag <C-R><C-W><CR><C-t>:lopen<CR>', {noremap = true})  -- ltag word-under-cursor > ctrl-t to return back > lopen to show list
map('n', '<Leader>ds', ':stag <C-R><C-W><CR>', {noremap = true})  -- definition split
map('n', '<Leader>dv', ':vert :stag <C-R><C-W><CR>', {noremap = true})  -- definition vertical split
map('n', '<Leader>dp', ':ptag <C-R><C-W><CR>', {noremap = true})  -- definition in preview window

map('n', '<Leader>dw', ':windo ', {noremap = true})  -- prefix for :windo
map('n', '<Leader>dow', ':windo ', {noremap = true})  -- prefix for :windo
map('n', '<Leader>db', ':bufdo ', {noremap = true})  -- prefix for :bufdo
map('n', '<Leader>dob', ':bufdo ', {noremap = true})  -- prefix for :bufdo
map('n', '<Leader>dot', ':tabdo ', {noremap = true})  -- prefix for :tabdo
map('n', '<Leader>doc', ':cfdo', {noremap = true})  -- prefix for :cfdo
map('n', '<Leader>dol', ':lfo ', {noremap = true})  -- prefix for :ldo
map('n', '<Leader>doa', ':argdo ', {noremap = true})  -- prefix for :argdo

map('n', '<leader>ll', ':nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>', {noremap = true})  -- acts like orig CTRL-L, taken from runtime/lua/_editor.lua

map('n', '<leader>qq', ':q<cr>', {noremap = true})  -- quit current window if no confirmation needed
map('n', '<leader>qa', ':qa<cr>', {noremap = true})  -- quit vim if no confirmation needed

map('t', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true})
-- map('t', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true})
map('t', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true})
map('t', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true})
map('t', '<A-q>', '<C-\\><C-N>', {noremap = true})
map('i', '<C-h>', 'pumvisible() ? "<C-h>" : "<C-\\><C-N><C-w>h"', {noremap = true, expr = true})  -- CTRL-H if PUM else switch to left window
map('i', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true})
map('i', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true})
map('i', '<C-l>', 'pumvisible() ? "<C-l>" : "<C-\\><C-n><C-w>l"', {noremap = true, expr = true})  -- CTRL-L if PUM else switch to right window
map('i', '<tab>', 'pumvisible() ? "<C-n><C-p>" : "<tab>"', {noremap = true, expr = true})
map('n', '<C-h>', '<C-w>h', {noremap = true})  -- overlaps default CTRL-H (acts like <BS>)
map('n', '<C-j>', '<C-w>j', {noremap = true})  -- overlaps default CTRL-J (acts like j, <down>, etc.)
map('n', '<C-k>', '<C-w>k', {noremap = true})
map('n', '<C-l>', '<C-w>l', {noremap = true})  -- overlaps default CTRL-L (clear screen, :nohlsearch, :diffupdate)

-- http://neovim.io/doc/user/insert.html#ins-completion
-- map('i', '<C-]>', '<C-X><C-]>', {noremap = true})
-- map('i', '<C-F>', '<C-X><C-F>', {noremap = true})
-- map('i', '<C-D>', '<C-X><C-D>', {noremap = true})
-- map('i', '<C-L>', 'pumvisible() ? "<C-L>" : "<C-X><C-L>"', {noremap = true, expr = true}) -- append symbol if popupmenu is visible else complete whole line (C-x C-l)

map('n', '<A-left>', ':vertical resize +1<CR>', {noremap = true})
map('n', '<A-right>', ':vertical resize -1<CR>', {noremap = true})
map('n', '<A-up>', ':resize -1<CR>', {noremap = true})
map('n', '<A-down>', ':resize +1<CR>', {noremap = true})
map('n', '<A-PageUp>', '<C-W>_<C-W>|', {noremap = true})
map('n', '<A-PageDown>', '<C-W>=', {noremap = true})

map('n', '<Tab>', ':bnext<CR>', {noremap = true})
map('n', '<S-Tab>', ':bNext<CR>', {noremap = true})

map('c', '<Up>', 'wildmenumode() ? "<C-P>" : "<Up>"', {noremap = true, expr = true})
map('c', '<Down>', 'wildmenumode() ? "<C-N>" : "<Down>"', {noremap = true, expr = true})
map('c', '<S-Del>', '<C-\\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>', {noremap = true, expr = false})

map('n', '<Leader>jl', ':ls<cr>', {noremap = true})  -- list all buffers
map('n', '<Leader>vv', ':Vifm<cr>', {noremap = true})
map('n', '<Leader>vc', ':Vifm .<cr>', {noremap = true})
map('n', '<Leader>sw', ':set wrap!<cr>', {noremap = true})
map('n', '<Leader>bd', ':Bdelete<cr>', {noremap = true})  -- bufdelete plugin command: delete current buffer
map('n', '<Leader>fn', ':%s/\\r//g<cr>', {noremap = true})  -- format newline characters - erase all \r
map('n', '<Leader>gvp', '`[v`]', {noremap = true})  -- visual select last paste

-- map('n', '<Leader>jj', ':b <tab><s-tab>', {noremap = true})  -- wildmenu named buffers
keymap('n', '<Leader>jj', function()
    vim.api.nvim_feedkeys(':b \t', 'nt', true)
    vim.schedule(function() if vim.fn.wildmenumode() == 1 then vim.api.nvim_input('') end end)
end, {noremap = true})  -- wildmenu named buffers

-- commands
map('n', '<Leader>;', ':', {noremap = true})

map('n', '<Leader>cvr', ':vimgrep <C-R>" **/*.py', {noremap = true})
map('n', '<Leader>cvw', ':vimgrep <C-R><C-W> **/*.py', {noremap = true})

map('n', '<Leader>cc', ':CC<tab><s-tab>', {noremap = true})
map('n', '<Leader>qfp', ':silent! :colder<cr>', {noremap = true})
map('n', '<Leader>qfn', ':silent! :cnewer<cr>', {noremap = true})
map('n', '<Leader>qfl', ':chistory<cr>', {noremap = true})
map('n', '<Leader>qf', ':echo "Ops... try qfn|qfp|qfl"<cr>', {noremap = true})

-- caution - mixed with built in mappings
keymap('n', 'CC', ':CC<tab><s-tab>', {noremap = true})
keymap('v', 'CC', ':CC<tab><s-tab>', {noremap = true})
-- keymap('n', 'CC', function() vim.api.nvim_feedkeys(':CC\t', 'nt', true) end, {noremap = true})
-- keymap('v', 'CC', function() vim.api.nvim_feedkeys(':CC\t', 'nt', true) end, {noremap = true})

-- before using unimpaired/telescope-for-buffers
-- map('n', '[q', ':cNext<CR>', {noremap = true})  -- moved to hydra
-- map('n', ']q', ':cnext<CR>', {noremap = true})  -- moved to hydra


-- harpoon
local harpoon = require("harpoon")
harpoon:setup()
keymap('n', '<Leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {noremap = true})
keymap('n', '<Leader>ha', function() harpoon:list():append() end, {noremap = true})
keymap('n', '<Leader>hj', function() harpoon:list():next({ui_nav_wrap = true}) end, {noremap = true})
keymap('n', '<Leader>hk', function() harpoon:list():prev({ui_nav_wrap = true}) end, {noremap = true})

-- highlight current word
keymap('n', '<Leader>hw', function()
    vim.fn.setreg('/', vim.fn.expand('<cword>'))
    vim.api.nvim_set_option('hlsearch', true)
end, {noremap = true})  -- set current word as last searched but without jump (highlight)
-- keymap('n', '*', function()
--     if not vim.o.hlsearch then
--         vim.cmd.normal({'*', bang=true})
--         return
--     end
--
--     local cur_word_patt = '\\<' .. vim.fn.expand('<cword>') .. '\\>'
--     local cur_slash_reg = vim.fn.getreg('/')
--     print(cur_word_patt)
--     print(cur_slash_reg)
--
--     if vim.v.hlsearch and cur_word_patt == cur_slash_reg then
--         vim.cmd.normal({'*', bang=true})
--         print(1)
--     elseif cur_word_patt == cur_slash_reg then
--         vim.api.nvim_set_option('hlsearch', 1)
--         print(2)
--     else
--         vim.fn.setreg('/', cur_word_patt)
--         vim.api.nvim_set_option('hlsearch', true)
--         print(3)
--     end
-- end, {noremap = true, silent=true})  -- set current word as last searched but without jump (highlight)
-- vim.keymap.set( 'n', 'n', function()
--   vim.v.searchforward = 1 - vim.v.searchforward
--   print( 'searchforward', vim.v.searchforward )
--   vim.cmd[[silent! normal! n]]
-- end )


-- todo: remove/rename in favor of default Y - copy till end
map('n', 'YY', 'm`0"+yg_``', {noremap = true})  -- copy entire string without end-of-line sign into clipboard to
map('n', 'YL', 'm`0yg_``', {noremap = true})  -- copy entire string without end-of-line sign
map('v', 'Y', '"+y', {noremap = true})

map('n', '<Leader>ww', '<C-W>', {noremap = true})


-- Textobjects
map('x', 'il', '_og_', {noremap = true})
map('x', 'al', '0o$h', {noremap = true})
map('o', 'il', ':norm vil<cr>', {noremap = true})
map('o', 'al', ':norm val<cr>', {noremap = true})

map('x', 'i%', 'ggoGV', {noremap = true})
map('o', 'i%', ':norm vi%<cr>', {noremap = true})

-- Vifm
vim.env.LINES = 30  -- TODO: change lines on windows accorwing current window height

-- Pre LSP / Light version
-- https://stackoverflow.com/questions/934233/cscope-or-ctags-why-choose-one-over-the-other
-- scoop install universal-ctags
-- ctags.exe --options-maybe=c:\sakkada\programs\far3\Profile\Plugins\far3x\CtagsNavigator\ctags.d --recurse --exclude=datadir --exclude=media --exclude=.hg --exclude=.git --exclude=.project --fields=+lnim --languages=python,graphql --python-kinds=+zl --extras=-r -f .tags "*"
-- https://github.com/dhananjaylatkar/cscope_maps.nvim
cmd('set tags=.tags;')  -- search tags file in current directory and all ancestors
cmd('set complete=.,w,b,u,t') -- default=.,w,b,u,t
cmd('set completeopt=longest,popup,menuone') -- default=menu,preview (menu, menuone, longest, preview, noinsert, noselect)
cmd('set omnifunc=syntaxcomplete#Complete')  -- enable omnicompletion realted to current filetype

-- vim.g.omni_sql_default_compl_type = 'syntax'





-- Improvements
-- Diff the original state of file (:help :DiffOrig)
vim.api.nvim_create_user_command(
    'DiffOrig',
    "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis",
    {}
)


-- Restore last cursor position (:help last-position-jump)
vim.api.nvim_create_autocmd(
    {"BufRead"},
    {
        pattern = {"*"},
        command = [[autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
    }
)


-- Custom commands
-- command! -nargs=0 -bar CCQuickFixOpenVert :vert :copen 55 | :set nowrap | :wincmd w
vim.api.nvim_create_user_command(
    'CCQuickFixOpenVert',
    ":vert :copen 55 | :set nowrap | :wincmd w",
    { nargs = 0, bar = true }
)
-- # rg handle --column | nvim - -c "cexpr getbufline(bufnr(), 0, getbufinfo(bufnr())[0]['linecount']) | bprev | Bdelete! | vert :copen 55 | set nowrap | wincmd h | let @/='handle' | set hlsearch"
vim.api.nvim_create_user_command(
    'CCQuickFixFromBuffer',
    "if search('\\v:\\d+:\\d+\\r?$') == 0 | :%s/\\v(.{-1,})(\\r?)$/\\1:1:1\\2/ | :set nohlsearch | endif | :cexpr getbufline(bufnr(), 0, getbufinfo(bufnr())[0]['linecount']) | redraw | CCQuickFixOpenVert",
    { nargs = 0, bar = true }
    -- "if <q-args> == '1' | :%s/\\v(.{-1,})(\\r?)$/\\1:1:1\\2/ | endif | :cexpr getbufline(bufnr(), 0, getbufinfo(bufnr())[0]['linecount']) | CCQuickFixOpenVert",
    -- { nargs = "?", bar = true }
)


-- https://hjkl.substack.com/p/navigate-recent-files-in-vim
vim.api.nvim_create_user_command(
    'CCQuickFixFromOldfiles',
    "call setqflist(map(copy(v:oldfiles), {_, f -> {'filename': f, 'text': '...no last line and col'}})) | CCQuickFixOpenVert",
    { nargs = 0, bar = true }
)
vim.api.nvim_create_user_command(
    -- > :CCQuickFixFromOldfilesFiltered v:val =~ 'test'
    --   where v:val =~ 'test' is second argument for filter function (get all matched by regex)
    -- see also > :help filter()
    --      and > :help expression-syntax
    'CCQuickFixFromOldfilesFiltered',
    "call setqflist(map(filter(copy(v:oldfiles), <q-args>), {_, f -> {'filename': f, 'text': '...no last line and col'}})) | CCQuickFixOpenVert",
    { nargs = '+', complete = 'expression', bar = true }
)
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
            if not v:match('%d+') then
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
    { nargs = "*", complete = 'expression', bar = true }
)

-- command! -nargs=+ -complete=file -bar CCRg :cexpr system('rg --smart-case --column <args>') | CCQuickFixOpenVert | :let @/="\c\v".trim(<q-args>, '"') | :set hlsearch
vim.api.nvim_create_user_command(
    'CCRg',
    ":cexpr system('rg --smart-case     --vimgrep <args>') | CCQuickFixOpenVert | :silent :let @/=\"\\\\c\\\\v\" . trim(<q-args>, '\"') | :set hlsearch",
    { nargs = '+', complete = 'file' }
)
vim.api.nvim_create_user_command(
    'CCRgCaseSensitive',
    ":cexpr system('rg --case-sensitive --vimgrep <args>') | CCQuickFixOpenVert | :silent :let @/=\"\\\\C\\\\v\" . trim(<q-args>, '\"') | :set hlsearch",
    { nargs = '+', complete = 'file' }
)
vim.api.nvim_create_user_command(
    'CCRgRaw',
    ":cexpr system('rg                  --vimgrep <args>') | CCQuickFixOpenVert",
    { nargs = '+', complete = 'file' }
)
vim.api.nvim_create_user_command(
    'CCEchoArgs',
    ':!echo|set /p DUMMY="<lt>mods>: [ <mods> ], <lt>q-mods> (quoted mods): [ <q-mods> ], <lt>q-args> (quoted args): [ <q-args> ], <lt>args>: [ <args> ], <lt>f-args> (function args): [ <f-args> ]"',
    { nargs = "*", complete = 'file' }
)

vim.api.nvim_create_user_command(
    'CCTee',
    function(opts)
        local tmp_in, tmp_out = os.tmpname()..'.in.txt', os.tmpname()..'.out.txt'
        local command = opts.line1..','..opts.line2..'!(tee #tmp_in# | '..opts.args..' > #tmp_out# && cat #tmp_in# && printf "---\\n" && (cat #tmp_out# | sed -e s/$//g) && rm #tmp_in# #tmp_out# && printf "===\\n")'
        -- attempt to run withou tee:
        -- local command = opts.line1..','..opts.line2..'!((cat - > #tmp_in# && cat #tmp_in# && printf "---\\n") && (cat #tmp_in# | '..opts.args..' | sed -e s/$//g) && (rm #tmp_in# && printf "===\\n"))'
        -- (printf "print(1111)\\nprint(2222)" | (cat - > aaa && cat aaa) && (cat aaa | python > bbb && printf \n---\n && cat bbb)) | xxd

        vim.cmd(command:gsub('#tmp_in#', tmp_in):gsub('#tmp_out#', tmp_out))
    end,
    { nargs = "*", complete = 'file', range = true }
)

vim.api.nvim_create_user_command(
    'CCLocListOpenVert',
    ":vert :lopen 55 | :set nowrap | :wincmd w",
    { nargs = 0, bar = true }
)

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
    -- <q-mods> Less <q-args>, :help q-mods, :help q-args
    -- https://www.reddit.com/r/vim/comments/xvhw4w/how_do_you_read_long_messages_in_messages/
    "Less",
    ":call Less(win_getid(), <q-mods>, <q-args>)",
    { nargs = "+", complete = 'command' }
)

-- Plugins
-- --------------------------------------------------------
-- builtin
cmd('packadd cfilter')  -- Cfilter, Lfilter


local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
cmd('echo "' .. install_path:gsub('\\', '/') .. '"')
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
  cmd 'packadd packer.nvim'
end

require('plugins')
require('colorizer').setup()
require('Comment').setup()
require('gitsigns').setup()

-- surrounds
require("nvim-surround").setup({
    move_cursor = "sticky",
    keymaps = {
        insert = "<C-g>s",        -- insert = "<C-g>s",
        insert_line = "<C-g>S",   -- insert_line = "<C-g>S",
        normal = "sf",            -- normal = "ys",
        normal_cur = "sff",       -- normal_cur = "yss",
        normal_line = "sF",       -- normal_line = "yS",
        normal_cur_line = "sFF",  -- normal_cur_line = "ySS",
        visual = "S",             -- visual = "S",
        visual_line = "gS",       -- visual_line = "gS",
        delete = "sd",            -- delete = "ds",
        change = "sc",            -- change = "cs",
        change_line = "sC",       -- change_line = "cS",
    },
})

-- TODO: continue migrating to LAZY.NVIM from HERE

require("flash").setup({
  -- `f`, `F`, `t`, `T`, `;` and `,` motions
  modes = {
    char = {
      enabled = false,
      multi_line = false,
    },
  }
})


keymap({'n', 'x', 'o'}, "ss",    function() require("flash").jump() end,              {noremap = true, desc = "Flash" })
keymap({'n', 'x', 'o'}, "sS",    function() require("flash").treesitter() end,        {noremap = true, desc = "Flash Treesitter" })
keymap({'o'          }, "r",     function() require("flash").remote() end,            {noremap = true, desc = "Remote Flash" })
keymap({'x', 'o'     }, "R",     function() require("flash").treesitter_search() end, {noremap = true, desc = "Treesitter Search" })
keymap({'c'          }, "<c-s>", function() require("flash").toggle() end,            {noremap = true, desc = "Toggle Flash Searc" })

vim.o.background = "dark" -- or "light" for light mode
-- setup must be called before loading the colorscheme
-- Default options:

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
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
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
    Whitespace = {fg = "#3090f0"}, -- listchars: tab,trail,nbsp; (:h hl-Whitespace)
    NonText = {fg = "#f0a010"}, -- listchars: extends,precedes, ~(empty), showbreak, etc.; (:h hl-NonText)
    SpecialKey = {fg = "#30d090"},  -- \r (h hl-SpecialKey)
    FloatBorder = {fg = "#87796B", bg = "#3C3836"},
    FlashMatch = {fg = "#b8bb26"},
    FlashCurrent = {fg = "#FABD2F", bold = true},
    FlashLabel = {fg = "#30d090", bold = true},
  },
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
-- vim.cmd("set background=light")



local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd(
  "TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankgrp,
  }
)

-- augroup numbertoggle
--   autocmd!
--   autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
--   autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
-- augroup END

-- go to last loc when opening a buffer
-- api.nvim_create_autocmd(
--   "BufReadPost",
--   { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
-- )

-- api.nvim_create_autocmd(
--   "UIEnter", {
--     command = "lua vim.print('1111')",
--   }
-- )
--
--
--
--
-- Hydra

local Hydra = require('hydra')

-- https://github.com/anuvyklack/hydra.nvim?tab=readme-ov-file#color
-- Body Color  Basic color Executing NON-HEAD      Executing HEAD
-- ----------  ----------- ---------------------   --------------
-- amaranth    red         Disallow and Continue   Continue
-- teal        blue        Disallow and Continue   Quit
-- pink        red         Allow and Continue      Continue
-- red         red         Allow and Quit          Continue
-- blue        blue        Allow and Quit          Quit

local gitsigns = require('gitsigns')

Hydra(
    {
        name = 'Side scroll',
        mode = 'n',
        body = 'z',
        heads = {
            { 'h', 'zh' },
            { 'l', 'zl', { desc = '←/→' } },
            { 'H', 'zH' },
            { 'L', 'zL', { desc = 'half screen ←/→' } },
        }
    }
)


local hint = [[
 Diff navigation: _c_/_C_: hybrid ↓/↑, _d_/_D_: gitsigns ↓/↑
 Actions:         _p_/_o_: diff put/obtain, _._, _u_, _z_: as is, _<Esc>_: exit 
]]
Hydra(
    {
        name = 'Diff navigation',
        -- hint = [[ Diff navigation: _c_, _C_: hybrid ↓/↑, _d_, _D_: gitsigns ↓/↑, _<Esc>_: exit ]],
        hint = hint,
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
            {'p', 'dp', { desc = 'diff put' },},
            {'o', 'do', { desc = 'diff obtain'},},
            {'z', 'zz', { desc = 'vert center cursor'},},
            {'.', '.', { desc = 'repeat'},},
            {'u', 'u', { desc = 'undo'},},
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
    }
)
local hint = [[
 Diff navigation (reverse): _c_/_C_: hybrid ↑/↓, _d_/_D_: gitsigns ↑/↓
 Actions:                   _p_/_o_: diff put/obtain, _._, _u_, _z_: as is, _<Esc>_: exit 
]]
Hydra(
    {
        name = 'Diffmode navigation (reverse)',
        -- hint = [[ Diff navigation (reverse): _c_, _C_: hybrid ↑/↓, _d_, _D_: gitsigns ↑/↓, _<Esc>_: exit ]],
        hint = hint,
        config = {
            on_key = function() vim.wait(50) end,
            hint = {
                type = 'window',
                position = 'bottom-middle',
            },
        },
        mode = 'n',
        body = '[',
        heads = {
            {'p', 'dp', { desc = 'diff put' },},
            {'o', 'do', { desc = 'diff obtain'},},
            {'z', 'zz', { desc = 'vert center cursor'},},
            {'.', '.', { desc = 'repeat'},},
            {'u', 'u', { desc = 'undo'},},
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
    }
)
Hydra(
    {
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
            { 'q', '<cmd>:cnext<CR>' },
            { 'Q', '<cmd>:cNext<CR>', { desc = '↓/↑' }, },
            { 'l', '<cmd>:lnext<CR>' },
            { 'L', '<cmd>:lNext<CR>', { desc = '↓/↑' }, },
        },
    }
)
Hydra(
    {
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
            { 'q', '<cmd>:cNext<CR>' },
            { 'Q', '<cmd>:cnext<CR>', { desc = '↑/↓' }, },
            { 'l', '<cmd>:lNext<CR>' },
            { 'L', '<cmd>:lnext<CR>', { desc = '↓/↑' }, },
        },
    }
)

-- https://en.wikipedia.org/wiki/Block_Elements
-- :help nvim_open_win() for border options
local hint = [[

   ^ ^        Options
   ^
   _v_ %{ve} virtual edit
   _i_ %{list} invisible characters
   _s_ %{spell} spell
   _S_ %{inccmd} :s preview (inccommand)   
   _w_ %{wrap} wrap
   _c_ %{cul} cursor line and column
   _n_ %{nu} number
   _r_ %{rnu} relative number
   _/_ %{ssl} shellslash
   ^
   ^^^^                        _<Esc>_   

]]

Hydra({
   name = 'Options',
   hint = hint,
   config = {
      color = 'amaranth',
      invoke_on_body = true,
      hint = {
         type = 'window',
         float_opts = {
             border = {'█','▀','█','█','█','▄','█','█'},
             -- border = 'none',
         },
         position = 'middle',
         funcs = {
             ssl = function()
                 return vim.o.shellslash and '[x]' or '[ ]'
             end,
             inccmd = function()
                 return vim.o.inccommand == 'split' and '[x]' or '[ ]'
             end,
         }
      },
   },
   mode = {'n','x'},
   body = '<leader>oo',
   heads = {
      { 'n', function()
         if vim.o.number == true then
            vim.o.number = false
         else
            vim.o.number = true
         end
      end, { desc = 'number' } },
      { 'r', function()
         if vim.o.relativenumber == true then
            vim.o.relativenumber = false
         else
            vim.o.number = true
            vim.o.relativenumber = true
         end
      end, { desc = 'relativenumber' } },
      { 'v', function()
         if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
         else
            vim.o.virtualedit = 'all'
         end
      end, { desc = 'virtualedit' } },
      { 'i', function()
         if vim.o.list == true then
            vim.o.list = false
         else
            vim.o.list = true
         end
      end, { desc = 'show invisible' } },
      { 's', function()
         if vim.o.spell == true then
            vim.o.spell = false
         else
            vim.o.spell = true
         end
      end, { exit = true, desc = 'spell' } },
      { 'S', function()
         if vim.opt.inccommand:get() == 'nosplit' then
            vim.opt.inccommand = 'split'
            vim.opt.cmdwinheight = 20
         else
            vim.opt.inccommand = 'nosplit'
            vim.opt.cmdwinheight = 10  -- default for this config
         end
      end, { desc = 'inccommand (:s prev)' } },
      { 'w', function()
         if vim.o.wrap ~= true then
            vim.o.wrap = true
         else
            vim.o.wrap = false
         end
      end, { desc = 'wrap' } },
      { 'c', function()
         if vim.o.cursorline == true then
            vim.o.cursorline = false
            vim.o.cursorcolumn = false
         else
            vim.o.cursorline = true
            vim.o.cursorcolumn = true
         end
      end, { desc = 'cursor line and column' } },
      { '/',
        function() vim.o.shellslash = not vim.o.shellslash end,
        { desc = 'shellslash' }
      },
      { '<Esc>', nil, { exit = true } }
   }
})





-- local Hydra = require("hydra")
-- local gitsigns = require('gitsigns')

local hint = [[
 _J_: next hunk    _s_: stage hunk        _d_: show deleted   _D_: diff base
 _K_: prev hunk    _S_: stage buffer      _p_: preview hunk   _T_: diff HEAD~ 
 ^ ^               _R_: reset hunk        _I_:    ...inline   _/_: show base
 _b_: blame line   _U_: undo last stage   ^ ^                 _~_: show HEAD~
 _B_: blame full   ^ ^                    _<Enter>_: Neogit   _q_: exit
]]
-- Pink hydra
Hydra({
   name = 'Git',
   hint = hint,
   config = {
      buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
         float_opts = {
             -- border = 'rounded',
             -- border = 'solid',
             -- border = 'shadow',
             border = {'█','▀','█','█','█','▄','█','█'},
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
   mode = {'n','x'},
   body = '<leader>gg',
   heads = {
      { 'J',
         function()
            -- if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'next hunk' } },
      { 'K',
         function()
            -- if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'prev hunk' } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
      { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
      { 'U', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
      { 'R', gitsigns.reset_hunk, { desc = 'reset hunk' } },
      { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
      { 'I', gitsigns.preview_hunk_inline, { desc = 'preview hunk inline' } },
      { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
      { 'b', gitsigns.blame_line, { desc = 'blame' } },
      { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
      { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base file (index by default)
      { '~', function() gitsigns.show('~') end, { exit = true, desc = 'show HEAD file' } }, -- show the HEAD file
      { 'D', function() gitsigns.diffthis(nil, { vertical = true, split = 'rightbelow' }) end, { exit = true, desc = 'diffthis witn base' } },
      { 'T', function() gitsigns.diffthis('~', { vertical = true, split = 'rightbelow' }) end, { exit = true, desc = 'diffthis witn HEAD' } },
      { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
   }
})

-- Neovide
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.guifont = "Consolas NF:h10"




cmd([[
function! MyPopupCallback(id, result)
  if a:result == 1 " If the first item is selected
    echo "Item 1 selected, keeping popup open."
    " Do not close the popup here
  else
    echo "Other item selected, closing popup."
    call popup_close(a:id) " Close the popup for other selections
  endif
endfunction

function! OpenMyPopup()
  let items = ['Option 1', 'Option 2', 'Option 3']
  let opts = {'title': 'My Custom Menu', 'callback': 'MyPopupCallback', 'pos': 'center', 'padding': [1, 2, 1, 2]}
  call popup(items, opts)
endfunction

nnoremap <leader>p :call OpenMyPopup()<CR>
]])




-- Helper function to send an OSC 1337 SetUserVar escape sequence
-- https://wezterm.org/config/lua/pane/get_user_vars.html
local function set_wezterm_user_var(name, b64value)
  -- local escape_seq = string.format("\033]1337;SetUserVar=%s=%s\007", name, b64value)
  local escape_seq = string.format("\27]1337;SetUserVar=%s=%s\007", name, b64value)
  vim.cmd("call chansend(v:stderr, '" .. escape_seq .. "')")
end

local wezterm_group = vim.api.nvim_create_augroup("WezTermUserVar", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = wezterm_group,
  callback = function()
    set_wezterm_user_var("IS_NVIM", "dHJ1ZQ==") -- echo -n true | base64
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = wezterm_group,
  callback = function()
    set_wezterm_user_var("IS_NVIM", "ZmFsc2U=") -- echo -n false | base64
  end,
})
