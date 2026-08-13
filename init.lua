-- =================================================================================================
-- YOUR_SECRET
-- =================================================================================================
vim.opt.rtp:prepend(vim.fn.stdpath("config"))
local secret_path = vim.fn.stdpath("config") .. "/lua/secret.lua"
if vim.fn.filereadable(secret_path) == 0 then
    vim.fn.mkdir(vim.fn.stdpath("config") .. "/lua", "p")
    vim.fn.writefile({ "-- Your secret configurations here" }, secret_path)
end
require("secret")

-- =================================================================================================
-- TABLE_OF_CONTENTS
-- =================================================================================================
-- NVIM_GVAR
-- NVIM_OPTIONS
-- NVIM_DIAGNOSTICS
-- NVIM_KEYMAPS
-- NVIM_AUTOCMDS
-- NVIM_PLUGIN_MANAGER
-- NVIM_PLUGINS
-- NVIM_LAZY_SETUP
-- NVIM_SCRIPTS
-- MY_NOTES

-- =================================================================================================
-- NVIM_GVAR
-- =================================================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.g.fugitive_git_executable = "git"

-- =================================================================================================
-- NVIM_OPTIONS
-- =================================================================================================
vim.o.autoindent = true
vim.o.autoread = true
vim.o.background = "dark"
vim.o.backup = false
vim.o.belloff = "all"
vim.o.breakindent = true
vim.o.cmdheight = 2
vim.o.confirm = true
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileencoding = "utf-8"
vim.o.fileformat = "unix"
vim.o.foldenable = false
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.infercase = true
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.laststatus = 2
vim.o.list = true
vim.o.modeline = true
vim.o.modelines = 5
vim.o.mouse = "a"
vim.o.number = true
vim.o.pumheight = 50
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.shortmess = "flnxtocTO"
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 80
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildcharm = vim.fn.char2nr("\t")
vim.o.wildignorecase = true
vim.o.wildoptions = "pum"
vim.o.wrap = false
vim.o.writebackup = false
vim.opt.colorcolumn = { "81", "101", "121" }
vim.opt.complete = { ".", "w", "b", "u", "t" }
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.fillchars:append({ eob = " " })
vim.opt.formatoptions:append("mB")
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}
vim.opt.path:append("**")
vim.opt.sessionoptions:append({ "tabpages", "globals" })
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

if vim.fn.has("gui_running") == 1 or vim.g.neovide then
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        vim.o.guifont = "Agave Nerd Font:h12"
    else
        vim.o.guifont = "Agave Nerd Font:h16"
    end
    if vim.fn.exists("+guioptions") == 1 then
        vim.opt.guioptions:append("k")
        vim.opt.guioptions:remove("L")
        vim.opt.guioptions:remove("T")
        vim.opt.guioptions:remove("e")
        vim.opt.guioptions:remove("m")
        vim.opt.guioptions:remove("r")
    end
    vim.o.columns = 107
    vim.o.lines = 25
    vim.opt.linespace = 1
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
end

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    vim.o.undodir = vim.fn.expand("$HOME/vimfiles/undo/")
    vim.o.shadafile = vim.fn.expand("$HOME/vimfiles/main.shada")

    if vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1 then
        local pwsh = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
        vim.o.shell = pwsh
        vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
            .. "[Console]::InputEncoding=[Console]::OutputEncoding"
            .. "=[System.Text.Encoding]::UTF8;"
        vim.o.shellquote = ""
        vim.o.shellxquote = ""
        vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
        vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
    else
        vim.o.shell = "cmd.exe"
        vim.o.shellcmdflag = "/s /c"
        vim.o.shellquote = ""
        vim.o.shellxquote = '"'
    end
else
    vim.o.undodir = vim.fn.expand("$HOME/.vim/undo/")
    vim.o.shadafile = vim.fn.expand("$HOME/.vim/main.shada")
end

-- =================================================================================================
-- NVIM_DIAGNOSTICS
-- =================================================================================================
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
    underline = {
        severity = {
            min = vim.diagnostic.severity.WARN,
        },
    },
    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines
})

-- =================================================================================================
-- NVIM_KEYMAPS
-- =================================================================================================
-- Basic mappings
vim.keymap.set("i", "fd", "<Esc>", {
    desc = "Exit insert mode",
})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlights",
})
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {
    desc = "Move focus to left window",
})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {
    desc = "Move focus to right window",
})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {
    desc = "Move focus to lower window",
})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {
    desc = "Move focus to upper window",
})

-- Config editing
vim.keymap.set("n", "<leader>vim", ":vs $MYVIMRC<CR>", {
    silent = true,
    desc = "Open init.lua in split",
})

-- Navigation & Search
local has_telescope, _ = pcall(require, "telescope")
if not has_telescope then
    vim.keymap.set("n", "<C-p>", ":find *", {
        desc = "Find files (fallback)",
    })
end
vim.keymap.set("n", "<leader>gd", "<C-]>", {
    desc = "Jump tag",
})
vim.keymap.set("n", "<leader>Gd", function()
    local url = vim.fn.expand("<cWORD>")
    -- Extract URL from markdown link: [text](url)
    local md_link = url:match("%((https?://[^)]+)%)")
    if md_link then
        url = md_link
    end
    if url and url:match("^https?://") then
        vim.ui.open(url)
    else
        vim.notify("No URL found under cursor", vim.log.levels.WARN)
    end
end, {
    desc = "Open URL in browser",
})

vim.keymap.set("n", "*", "*zz", {
    desc = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1) and "Windows refine search"
        or "macOS refine search",
})
vim.keymap.set("n", "j", "gj", {
    desc = "Move down (display line)",
})
vim.keymap.set("n", "k", "gk", {
    desc = "Move up (display line)",
})
vim.keymap.set("n", "<F2>", ":%s/\\C\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>", {
    desc = "Search and replace word under cursor",
})

-- Line movement
vim.keymap.set("n", "<M-Down>", ":m .+1<CR>==", {
    desc = "Move line down",
})
vim.keymap.set("n", "<M-Up>", ":m .-2<CR>==", {
    desc = "Move line up",
})
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", {
    silent = true,
    desc = "Move line down",
})
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", {
    silent = true,
    desc = "Move line up",
})

-- Window & Tab management
vim.keymap.set("n", "+", ":vertical resize +2<CR>", {
    silent = true,
    desc = "Increase window width",
})
vim.keymap.set("n", "_", ":vertical resize -2<CR>", {
    silent = true,
    desc = "Decrease window width",
})
vim.keymap.set("n", "<C-M-PageDown>", ":tabmove +1<CR>", {
    silent = true,
    desc = "Move tab right",
})
vim.keymap.set("n", "<C-M-PageUp>", ":tabmove -1<CR>", {
    silent = true,
    desc = "Move tab left",
})
vim.keymap.set("n", "<C-S-Tab>", "gT", {
    silent = true,
    desc = "Previous tab",
})
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", {
    silent = true,
    desc = "New tab",
})
vim.keymap.set("n", "<C-Tab>", "gt", {
    silent = true,
    desc = "Next tab",
})
vim.keymap.set("n", "<C-q>", ":q<CR>", {
    silent = true,
    desc = "Close window",
})
vim.keymap.set("n", "<leader><C-q>", ":tabclose<CR>", {
    silent = true,
    desc = "Close tab",
})
vim.keymap.set("n", "<C-w>i", "gt", {
    silent = true,
    desc = "Next tab",
})
vim.keymap.set("n", "<C-w>u", "gT", {
    silent = true,
    desc = "Previous tab",
})
vim.keymap.set("n", "<End>", "gt", {
    silent = true,
    desc = "Next tab",
})
vim.keymap.set("n", "<Home>", "gT", {
    silent = true,
    desc = "Previous tab",
})

-- Utilities
vim.keymap.set("n", "<leader>clr", ":%bd<bar>e #<bar>normal `<CR>", {
    silent = true,
    desc = "Clear all buffers but current",
})
vim.keymap.set("n", "<leader>lh", ":noh<CR>", {
    silent = true,
    desc = "Clear highlights",
})
vim.keymap.set("n", "<leader>da", function()
    local date = os.date("%Y-%m-%d-%w")
    vim.api.nvim_put({ date }, "c", true, true)
end, { desc = "Insert current date at cursor" })
-- vim.keymap.set("n", "<leader>tm", "<cmd>vs|term<CR>", {
--     silent = true,
--     desc = "Open terminal in split",
-- })
vim.keymap.set("n", "K", "i<CR><Esc>", {
    desc = "Insert newline at cursor",
})
vim.keymap.set("n", "O", "O<Space><BS><Esc>", {
    desc = "Insert empty line above",
})
vim.keymap.set("n", "o", "o<Space><BS><Esc>", {
    desc = "Insert empty line below",
})
vim.keymap.set("n", "go", '"0yi):!start <C-r>0<CR>', {
    desc = "Open link under cursor (Windows)",
})

-- Git
vim.keymap.set("n", "<leader>sync", function()
    vim.cmd("wa")
    local function chain(cmds, on_done)
        local i = 0
        local function next_cmd()
            i = i + 1
            if i > #cmds then
                on_done()
                return
            end
            vim.fn.jobstart(cmds[i], {
                on_exit = function(_, code)
                    vim.schedule(function()
                        if code == 0 then
                            next_cmd()
                        else
                            vim.notify(
                                "Git '" .. cmds[i][2] .. "' failed (exit: " .. code .. ")",
                                vim.log.levels.ERROR
                            )
                        end
                    end)
                end,
            })
        end
        next_cmd()
    end
    chain({
        { "git", "pull" },
        { "git", "add", "." },
        { "git", "commit", "-m", "update by vim" },
        { "git", "push" },
        { "git", "fetch" },
    }, function()
        vim.cmd("!git log --oneline --graph --all --decorate")
    end)
end, {
    silent = true,
    desc = "Git sync & log",
})

-- Paste
vim.keymap.set("i", "<C-v>", "<C-r>*", {
    desc = "Paste from clipboard",
})
vim.keymap.set("c", "<C-v>", "<C-r>*", {
    desc = "Paste from clipboard",
})

-- Normal & Visual
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", {
    silent = true,
    desc = "Scroll down and center",
})
vim.keymap.set({ "n", "v" }, "<C-f>", "<C-u>zz", {
    silent = true,
    desc = "Scroll up and center",
})

-- Normal, Visual, Operator-pending
vim.keymap.set({ "n", "v", "o" }, "H", "g^", {
    desc = "Move to start of line",
})
vim.keymap.set({ "n", "v", "o" }, "L", "g_", {
    desc = "Move to end of line",
})

-- Visual mode
vim.keymap.set("v", "/", '"-y/<C-r>-<CR>N', {
    desc = "Search for selection",
})
vim.keymap.set("v", "<C-j>", ":m '><+1<CR>gv=gv", {
    desc = "Move selection down",
})
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", {
    desc = "Move selection up",
})
vim.keymap.set("v", "<F2>", '"-y:%s/<C-r>-\\C/<C-r>-/g<Left><Left>', {
    desc = "Replace selection",
})
vim.keymap.set("v", "<M-Down>", ":m '><+1<CR>gv=gv", {
    desc = "Move selection down",
})
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", {
    desc = "Move selection up",
})
vim.keymap.set("v", "<M-j>", ":m '><+1<CR>gv=gv", {
    silent = true,
    desc = "Move selection down",
})
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", {
    silent = true,
    desc = "Move selection up",
})
vim.keymap.set("v", "<leader>ss", ":sort<CR>", {
    desc = "Sort selection",
})
vim.keymap.set("v", "<leader>Ss", ":sort!<CR>", {
    desc = "Sort selection reverse",
})
vim.keymap.set("v", "<C-b>", '"-di**<C-r>-**<Esc>', {
    silent = true,
    desc = "Surround with bold",
})
vim.keymap.set("v", "y", "ygv<Esc>", {
    desc = "Yank and keep position",
})

-- Select mode
vim.keymap.set("x", "p", "P", {
    desc = "Paste without overwriting register",
})
vim.keymap.set("x", "<CR>", "Jgq", {
    desc = "Built-in format selected lines",
})

-- Terminal mode
vim.keymap.set("t", "fd", [[<C-\><C-n>]], {
    desc = "Exit terminal mode",
})
vim.keymap.set("t", "<C-v>", [[<C-\><C-n>pa]], {
    desc = "Paste and re-enter terminal mode",
})
vim.keymap.set("t", "<S-Enter>", [[<C-v><Enter>]], {
    buffer = true,
    desc = "Send Enter",
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
    desc = "Open diagnostic [Q]uickfix list",
})

-- Exit terminal mode with double Esc
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
--     desc = "Exit terminal mode",
-- })

-- =================================================================================================
-- NVIM_AUTOCMDS
-- =================================================================================================
local binary_group = vim.api.nvim_create_augroup("Binary", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufReadPre", {
    group = binary_group,
    pattern = "*.bin",
    command = "set binary",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = binary_group,
    pattern = "*.bin",
    callback = function()
        if vim.bo.binary then
            vim.cmd("silent %!xxd -c 32")
            vim.bo.filetype = "xxd"
            vim.cmd("redraw")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = binary_group,
    pattern = "*.bin",
    callback = function()
        if vim.bo.binary then
            vim.b.xxd_view = vim.fn.winsaveview()
            vim.cmd("silent %!xxd -r -c 32")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = binary_group,
    pattern = "*.bin",
    callback = function()
        if vim.bo.binary then
            vim.cmd("silent %!xxd -c 32")
            vim.bo.modified = false
            vim.fn.winrestview(vim.b.xxd_view)
            vim.cmd("redraw")
        end
    end,
})

local highlight_yank_group = vim.api.nvim_create_augroup("highlight_yank", {
    clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = highlight_yank_group,
    callback = function()
        vim.hl.on_yank()
    end,
})

local group_gitcommit = vim.api.nvim_create_augroup("RkGitCommit", {
    clear = true,
})

-- Disable undo for git commit messages BEFORE reading the buffer
-- to prevent "E824: Incompatible undo file"
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = group_gitcommit,
    pattern = { "COMMIT_EDITMSG", "MERGE_MSG", "TAG_EDITMSG", "NOTES_EDITMSG" },
    callback = function(args)
        -- Use silent! to suppress the E824 error if it triggers during the setlocal
        vim.cmd("silent! setlocal noundofile")
        -- Proactively delete the undo file if it exists to clear the conflict
        local undofile = vim.fn.undofile(args.file)
        if vim.fn.filereadable(undofile) == 1 then
            vim.fn.delete(undofile)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group_gitcommit,
    pattern = "gitcommit",
    callback = function()
        -- setlocal textwidth=100
        vim.opt_local.textwidth = 80
        vim.cmd("silent! setlocal noundofile")

        -- nnoremap <silent><buffer> <leader>f :PanguAll<CR>
        vim.keymap.set("n", "<leader>fof", ":PanguAll<CR>", {
            silent = true,
            buffer = true,
            desc = "GitCommit: PanguAll",
        })

        vim.keymap.set("n", "<C-q>", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local should_open_gitgraph = not vim.bo[bufnr].readonly
            vim.cmd("q")
            if should_open_gitgraph then
                vim.defer_fn(function()
                    vim.cmd("RkGitGraph")
                end, 200)
            end
        end, {
            silent = true,
            buffer = true,
            desc = "GitCommit: Close and show GitGraph",
        })
    end,
})

local group_gitgraph = vim.api.nvim_create_augroup("RkGitGraph", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_gitgraph,
    pattern = "gitgraph",
    callback = function()
        -- setlocal iskeyword+=- iskeyword+=/
        vim.opt_local.iskeyword:append("-")
        vim.opt_local.iskeyword:append("/")

        -- nnoremap <silent><buffer> gl f)b
        vim.keymap.set("n", "gl", "f)b", {
            silent = true,
            buffer = true,
            desc = "Git: Jump to closing paren and back to beginning of word",
        })
    end,
})

-- C/C++ Indentation
local group_c = vim.api.nvim_create_augroup("RkC", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_c,
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.iskeyword:remove("-")
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        vim.opt_local.cindent = true -- Explicitly use standard C indentation
        vim.opt_local.indentexpr = "" -- Disable Treesitter's indent engine for C
        vim.opt_local.textwidth = 80
    end,
})

local group_markdown = vim.api.nvim_create_augroup("RkMarkdown", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_markdown,
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = false
        vim.cmd([[highlight! link @text.emphasis.markdown_inline Normal]])
        vim.cmd([[highlight! link @markup.italic.markdown_inline Normal]])
    end,
})

-- Auto-update buffers when files change externally
local auto_update_group = vim.api.nvim_create_augroup("AutoUpdate", {
    clear = true,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = auto_update_group,
    command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = auto_update_group,
    callback = function()
        vim.notify("Buffer updated from disk.", vim.log.levels.INFO)
    end,
})

local group_help = vim.api.nvim_create_augroup("RkHelp", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_help,
    pattern = "help",
    callback = function(args)
        vim.keymap.set("n", "gd", "<C-]>", {
            silent = true,
            buffer = args.buf,
            desc = "Help: Jump to tag",
        })
    end,
})

local function apply_warp_transparency()
    if vim.env.TERM_PROGRAM == "WarpTerminal" then
        local transparent_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "SignColumn",
            "LineNr",
            "CursorLineNr",
            "Folded",
            "NonText",
            "SpecialKey",
            "EndOfBuffer",
            "MsgArea",
        }

        for _, group in ipairs(transparent_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end
    end
end

-- Run on startup and re-apply whenever a colorscheme changes
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    pattern = "*",
    callback = apply_warp_transparency,
})

-- =================================================================================================
-- NVIM_PLUGIN_MANAGER
-- =================================================================================================
-- Install the lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Lazy plugins table and helper function
local lazy_plugins = {}
local function add_lazy(config)
    table.insert(lazy_plugins, config)
end

-- =================================================================================================
-- NVIM_PLUGINS
-- =================================================================================================
add_lazy({
    "modulomedito/rookie_git.nvim",
    dependencies = {
        "sindrets/diffview.nvim",
        "lewis6991/gitsigns.nvim",
        "modulomedito/gitgraph.nvim",
        "tpope/vim-fugitive",
    },
    config = function()
        require("rookie_git").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_enhance_nvimtree.nvim",
    dependencies = { "nvim-tree/nvim-tree.lua" },
    config = function()
        require("rookie_enhance_nvimtree").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_smooth.nvim",
    config = function()
        require("rookie_smooth").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_project.nvim",
    config = function()
        require("rookie_project").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_c.nvim",
    config = function()
        require("rookie_c").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_ssl.nvim",
    config = function()
        require("rookie_ssl").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_ai.nvim",
    config = function()
        require("rookie_ai").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_textmanip.nvim",
    config = function()
        require("rookie_textmanip").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_tag.nvim",
    config = function()
        require("rookie_tag").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_hex.nvim",
    config = function()
        require("rookie_hex").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_gitlab.nvim",
    config = function()
        require("rookie_gitlab").setup()
    end,
})

add_lazy({
    "modulomedito/rookie_rg.nvim",
    config = function()
        require("rookie_rg").setup()
    end,
})

-- add_lazy({
--     "modulomedito/rookie_enhance_telescope.nvim",
--     dependencies = {
--         "nvim-telescope/telescope.nvim",
--     },
--     config = function()
--         require("rookie_enhance_telescope").setup()
--     end,
-- })

add_lazy({
    "modulomedito/rookie_lsp.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "williamboman/mason.nvim",
            opts = {},
        },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {},
        },
    },
    config = function()
        require("rookie_lsp").setup()
    end,
})

-- Toggle by :ZenMode
add_lazy({ "folke/zen-mode.nvim" })

add_lazy({ "NMAC427/guess-indent.nvim" })

-- CJK character formatter
add_lazy({
    "hotoo/pangu.vim",
    config = function()
        vim.g.pangu_rule_fullwidth_punctuation = 0
    end,
})

-- Highlight words/patterns
add_lazy({
    "azabiong/vim-highlighter",
    config = function()
        vim.keymap.set({ "n", "v" }, "f<Del>", ":<C-u>Hi clear<CR>", {
            silent = true,
            desc = "Clear highlighters",
        })
    end,
})

-- Calculator
add_lazy({ "fedorenchik/VimCalc3" })

-- Surround with characters
add_lazy({ "tpope/vim-surround" })

-- Text alignment
add_lazy({ "junegunn/vim-easy-align" })

-- Syntax highlight
add_lazy({ "vim-polyglot/vim-polyglot" })

-- PlantUML
add_lazy({
    "charlesnicholson/plantuml.nvim",
    opts = {
        auto_start = true,
        auto_update = true,
        http_port = 8764,
        plantuml_server_url = "http://www.plantuml.com/plantuml",
        auto_launch_browser = "never",
    },
})

-- Mardkown Table Wrap
add_lazy({
    "ice345/markdown-table-wrap.nvim",
    ft = { "markdown", "quarto", "rmd" },
    opts = {
        auto_preview = false,
    },
    keys = {
        {
            "<leader>mt",
            "<cmd>MarkdownTableTogglePreview<cr>",
            desc = "Toggle Markdown table preview",
        },
        { "<leader>mp", "<cmd>MarkdownTablePreview<cr>", desc = "Preview Markdown tables" },
        {
            "<leader>mf",
            "<cmd>MarkdownTableFloatPreview<cr>",
            desc = "Float Markdown table preview",
        },
        {
            "<leader>mr",
            "<cmd>MarkdownTableToggleReader<cr>",
            desc = "Toggle Markdown table reader",
        },
        {
            "<leader>mi",
            "<cmd>MarkdownTableToggleInline<cr>",
            desc = "Toggle Markdown table inline view",
        },
        { "<leader>me", "<cmd>MarkdownTableEditSource<cr>", desc = "Edit Markdown source" },
        {
            "<leader>mc",
            "<cmd>MarkdownTableClosePreview<cr>",
            desc = "Close Markdown table preview",
        },
        {
            "<leader>mT",
            "<cmd>MarkdownTableToggleAutoPreview<cr>",
            desc = "Toggle auto Markdown table preview",
        },
        {
            "<leader>mq",
            "<cmd>MarkdownTableToggleInlineViewport<cr>",
            desc = "Toggle inline table viewport",
        },
        { "<Tab>", "<cmd>MarkdownTableNextCell<cr>", desc = "Next table cell" },
        { "<s-Tab>", "<cmd>MarkdownTablePrevCell<cr>", desc = "Previous table cell" },
        { "]c", "<cmd>MarkdownTableNextRow<cr>", desc = "Next table row" },
        { "[c", "<cmd>MarkdownTablePrevRow<cr>", desc = "Previous table row" },
        {
            "<leader>mj",
            function()
                require("markdown-table-wrap").scroll_view(vim.v.count1)
            end,
            desc = "Scroll rendered table down",
        },
        {
            "<leader>mk",
            function()
                require("markdown-table-wrap").scroll_view(-vim.v.count1)
            end,
            desc = "Scroll rendered table up",
        },
        { "<leader>mgg", "<cmd>MarkdownTableScrollTop<cr>", desc = "Scroll rendered table to top" },
        {
            "<leader>mG",
            "<cmd>MarkdownTableScrollBottom<cr>",
            desc = "Scroll rendered table to bottom",
        },
    },
})

-- Draw ASCII graph
add_lazy({
    "jbyuki/venn.nvim",
    config = function()
        -- venn.nvim: enable or disable keymappings
        function _G.ToggleVenn()
            local venn_enabled = vim.inspect(vim.b.venn_enabled)
            if venn_enabled == "nil" then
                vim.b.venn_enabled = true
                vim.cmd([[setlocal ve=all]])
                -- draw a line on HJKL keystokes
                vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                -- draw a box by pressing "<CR>" with visual selection
                vim.api.nvim_buf_set_keymap(0, "v", "<CR>", ":VBox<CR>", { noremap = true })
            else
                vim.cmd([[setlocal ve=]])
                vim.api.nvim_buf_del_keymap(0, "n", "J")
                vim.api.nvim_buf_del_keymap(0, "n", "K")
                vim.api.nvim_buf_del_keymap(0, "n", "L")
                vim.api.nvim_buf_del_keymap(0, "n", "H")
                vim.api.nvim_buf_del_keymap(0, "v", "<CR>")
                vim.b.venn_enabled = nil
            end
        end
        -- toggle keymappings for venn using <leader>ve
        vim.api.nvim_set_keymap("n", "<leader>ve", ":lua ToggleVenn()<CR>", { noremap = true })
    end,
})

-- Show vim marks
add_lazy({ "kshenoy/vim-signature" })

add_lazy({
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup()
    end,
})

add_lazy({
    "sphamba/smear-cursor.nvim",
    config = function()
        if not vim.g.neovide then
            require("smear_cursor").setup()
        end
    end,
})

add_lazy({
    "MagicDuck/grug-far.nvim",
    config = function()
        local function get_visual_selection()
            local saved_reg = vim.fn.getreg("v")
            vim.cmd('noau normal! "vy')
            local text = vim.fn.getreg("v")
            vim.fn.setreg("v", saved_reg)
            text = text:gsub("\n", "")
            return text
        end

        local function open_grugfar(opts)
            local ok, grugfar = pcall(require, "grug-far")
            if not ok then
                vim.notify("grug-far is not installed", vim.log.levels.WARN)
                return
            end

            local base = {
                startInInsertMode = false,
                prefills = {
                    paths = vim.fn.getcwd(),
                },
            }
            local final_opts = vim.tbl_deep_extend("force", base, opts or {})
            grugfar.open(final_opts)
        end

        vim.keymap.set("n", "<leader><F2>", function()
            local search_text = vim.fn.expand("<cword>")
            open_grugfar({ prefills = { search = search_text } })
        end, { desc = "Rookie Global Replace (grug-far)" })

        vim.keymap.set("v", "<leader><F2>", function()
            local text = get_visual_selection()
            open_grugfar({ prefills = { search = text } })
        end, { desc = "Global Replace Selection (Rookie Toys, grug-far)" })

        vim.keymap.set("n", "<leader><leader><F2>", function()
            if vim.fn.exists(":RkGlobalReplaceUndo") == 2 then
                vim.cmd("RkGlobalReplaceUndo")
                return
            end
            vim.notify(
                "Global replace undo is only available in Telescope flow",
                vim.log.levels.INFO
            )
        end, { desc = "Rookie Global Replace Undo" })
    end,
})

-- Fuzzy Finder (files, lsp, etc)
add_lazy({
    "nvim-telescope/telescope.nvim",
    enabled = true,
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "nvim-tree/nvim-web-devicons",
            enabled = vim.g.have_nerd_font,
        },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                cache_picker = { num_pickers = 0 },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
        })

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")
        -- vim.keymap.set("n", "<leader>sf", builtin.find_files, {
        --     desc = "[S]earch [F]iles",
        -- })
        -- vim.keymap.set("n", "<C-p>", builtin.find_files, {
        --     desc = "[S]earch [F]iles",
        -- })
        vim.keymap.set("n", "<C-p>", function()
            require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
        end, { desc = "Search Files" })

        -- vim.keymap.set("n", "<leader>sh", builtin.help_tags, {
        --     desc = "[S]earch [H]elp",
        -- })
        -- vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
        --     desc = "[S]earch [K]eymaps",
        -- })
        -- vim.keymap.set("n", "<leader>ss", builtin.builtin, {
        --     desc = "[S]earch [S]elect Telescope",
        -- })
        -- vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, {
        --     desc = "[S]earch current [W]ord",
        -- })
        -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, {
        --     desc = "[S]earch by [G]rep",
        -- })
        -- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {
        --     desc = "[S]earch [D]iagnostics",
        -- })
        -- vim.keymap.set("n", "<leader>sr", builtin.resume, {
        --     desc = "[S]earch [R]esume",
        -- })
        -- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {
        --     desc = '[S]earch Recent Files ("." for repeat)',
        -- })
        -- vim.keymap.set("n", "<leader>sc", builtin.commands, {
        --     desc = "[S]earch [C]ommands",
        -- })
        -- vim.keymap.set("n", "<leader>b", builtin.buffers, {
        --     desc = "[ ] Find existing buffers",
        -- })

        -- vim.api.nvim_create_autocmd("LspAttach", {
        --     group = vim.api.nvim_create_augroup("telescope-lsp-attach", {
        --         clear = true,
        --     }),
        --     callback = function(event)
        --         local buf = event.buf
        --         vim.keymap.set("n", "grr", builtin.lsp_references, {
        --             buffer = buf,
        --             desc = "[G]oto [R]eferences",
        --         })
        --         vim.keymap.set("n", "gri", builtin.lsp_implementations, {
        --             buffer = buf,
        --             desc = "[G]oto [I]mplementation",
        --         })
        --         vim.keymap.set("n", "grd", builtin.lsp_definitions, {
        --             buffer = buf,
        --             desc = "[G]oto [D]efinition",
        --         })
        --         vim.keymap.set("n", "gO", builtin.lsp_document_symbols, {
        --             buffer = buf,
        --             desc = "Open Document Symbols",
        --         })
        --         vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, {
        --             buffer = buf,
        --             desc = "Open Workspace Symbols",
        --         })
        --         vim.keymap.set("n", "grt", builtin.lsp_type_definitions, {
        --             buffer = buf,
        --             desc = "[G]oto [T]ype Definition",
        --         })
        --     end,
        -- })

        -- vim.keymap.set("n", "<leader>/", function()
        --     builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        --         winblend = 10,
        --         previewer = false,
        --     }))
        -- end, {
        --     desc = "[/] Fuzzily search in current buffer",
        -- })
        --
        -- vim.keymap.set("n", "<leader>s/", function()
        --     builtin.live_grep({
        --         grep_open_files = true,
        --         prompt_title = "Live Grep in Open Files",
        --     })
        -- end, {
        --     desc = "[S]earch [/] in Open Files",
        -- })
        --
        -- vim.keymap.set("n", "<leader>sn", function()
        --     builtin.find_files({
        --         cwd = vim.fn.stdpath("config"),
        --     })
        -- end, {
        --     desc = "[S]earch [N]eovim files",
        -- })
    end,
})

add_lazy({
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        -- Extend built-in cppcheck linter with MISRA-C:2012 addon
        -- Use full path: the Strawberry Perl cppcheck has a broken cfg path
        -- Remove build-dir func: returns nil when no build/ dir exists,
        -- which creates a hole in the args array → uv.spawn truncates on Windows
        local cppcheck = lint.linters.cppcheck
        cppcheck.cmd = "C:/Program Files/Cppcheck/cppcheck.exe"
        cppcheck.ignore_exitcode = true
        local misra_addon = vim.fn.stdpath("config") .. "/cppcheck_misra_addon.json"
        table.insert(cppcheck.args, 2, "--addon=" .. misra_addon)
        table.insert(cppcheck.args, 3, "--suppress=missingIncludeSystem")
        table.remove(cppcheck.args, 7) -- the nil-returning build-dir function

        -- Per nvim-lint README
        lint.linters_by_ft = {
            c = { "cppcheck" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            group = vim.api.nvim_create_augroup("RkLint", { clear = true }),
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
})

add_lazy({
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fof",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
        {
            "<leader>fo,",
            function()
                local mode = vim.fn.mode()
                local range
                if mode == "v" or mode == "V" or mode == "\x16" then
                    local start_lnum = vim.fn.line("'<")
                    local end_lnum = vim.fn.line("'>")
                    range = tostring(start_lnum) .. "," .. tostring(end_lnum)
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                        "n",
                        false
                    )
                else
                    range = "%"
                end
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                vim.cmd(range .. "s/，/, /ge")
                vim.cmd(range .. "s/、/, /ge")
                vim.cmd("noh")
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
            end,
            mode = { "n", "v" },
            desc = "Convert full-width ， to half-width , ",
        },
        {
            "<leader>fo.",
            function()
                local mode = vim.fn.mode()
                local range
                if mode == "v" or mode == "V" or mode == "\x16" then
                    local start_lnum = vim.fn.line("'<")
                    local end_lnum = vim.fn.line("'>")
                    range = tostring(start_lnum) .. "," .. tostring(end_lnum)
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                        "n",
                        false
                    )
                else
                    range = "%"
                end
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                vim.cmd(range .. "s/。/. /ge")
                vim.cmd("noh")
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
            end,
            mode = { "n", "v" },
            desc = "Convert full-width 。 to half-width . ",
        },
        {
            "<leader>fo)",
            function()
                local mode = vim.fn.mode()
                local range
                if mode == "v" or mode == "V" or mode == "\x16" then
                    local start_lnum = vim.fn.line("'<")
                    local end_lnum = vim.fn.line("'>")
                    range = tostring(start_lnum) .. "," .. tostring(end_lnum)
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                        "n",
                        false
                    )
                else
                    range = "%"
                end
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                vim.cmd(range .. "s/（/ (/ge")
                vim.cmd(range .. "s/）/) /ge")
                vim.cmd("noh")
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
            end,
            mode = { "n", "v" },
            desc = "Convert full-width （） to half-width ( )",
        },
        {
            "<leader>fo;",
            function()
                local mode = vim.fn.mode()
                local range
                if mode == "v" or mode == "V" or mode == "\x16" then
                    local start_lnum = vim.fn.line("'<")
                    local end_lnum = vim.fn.line("'>")
                    range = tostring(start_lnum) .. "," .. tostring(end_lnum)
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                        "n",
                        false
                    )
                else
                    range = "%"
                end
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                vim.cmd(range .. "s/：/: /ge")
                vim.cmd(range .. "s/；/; /ge")
                vim.cmd("noh")
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
            end,
            mode = { "n", "v" },
            desc = "Convert full-width ： to half-width : ",
        },
        {
            "<M-S-f>",
            function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                })
                vim.api.nvim_input("<Esc>")
            end,
            mode = { "n", "v" },
            desc = "Format file or range (conform)",
        },
        {
            "<C-s>",
            function()
                -- Save cursor position (display column, not byte column)
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                -- Remove trailing whitespaces
                vim.cmd("%s/\\s\\+$//e")
                vim.cmd("%s/\\r\\+$//e")
                -- Markdown: insert space between Chinese and English
                if vim.bo.filetype == "markdown" then
                    vim.cmd("%s/\\([\\u4e00-\\u9fa5]\\)\\([a-zA-Z0-9]\\)/\\1 \\2/ge")
                    vim.cmd("%s/\\([a-zA-Z0-9]\\)\\([\\u4e00-\\u9fa5]\\)/\\1 \\2/ge")
                    vim.cmd("%s/,\\([\\u4e00-\\u9fa5]\\)/, \\1/ge")
                end
                -- LSP format
                local ok, conform = pcall(require, "conform")
                if ok then
                    conform.format({
                        lsp_fallback = true,
                        async = false,
                    })
                else
                    vim.lsp.buf.format()
                end
                -- Save file
                vim.cmd("w")
                -- Restore cursor: mark for line, virtcol2col for correct display column
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
                vim.cmd("normal! zz")
                vim.cmd("noh")
            end,
            mode = "n",
            desc = "Format and save (conform)",
        },
        {
            "<C-s>",
            function()
                -- Exit insert mode via feedkeys (process now so formatting runs in normal mode)
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                    "n",
                    false
                )
                -- Save cursor position (display column, not byte column)
                vim.cmd("normal! m6")
                local saved_vcol = vim.fn.virtcol(".")
                -- Remove trailing whitespaces
                vim.cmd("%s/\\s\\+$//e")
                vim.cmd("%s/\\r\\+$//e")
                -- Markdown: insert space between Chinese and English
                if vim.bo.filetype == "markdown" then
                    vim.cmd("%s/\\([\\u4e00-\\u9fa5]\\)\\([a-zA-Z0-9]\\)/\\1 \\2/ge")
                    vim.cmd("%s/\\([a-zA-Z0-9]\\)\\([\\u4e00-\\u9fa5]\\)/\\1 \\2/ge")
                    vim.cmd("%s/,\\([\\u4e00-\\u9fa5]\\)/, \\1/ge")
                end
                -- LSP format
                local ok, conform = pcall(require, "conform")
                if ok then
                    conform.format({
                        lsp_fallback = true,
                        async = false,
                    })
                else
                    vim.lsp.buf.format()
                end
                -- Save file
                vim.cmd("w")
                -- Restore cursor: mark for line, virtcol2col for correct display column
                vim.cmd("normal! `6")
                local lnum = vim.fn.line(".")
                local byte_col = vim.fn.virtcol2col(0, lnum, saved_vcol) or 1
                vim.fn.cursor(lnum, math.max(byte_col, 1))
                vim.cmd("normal! zz")
                vim.cmd("noh")
                vim.api.nvim_feedkeys("a", "n", false) -- "a" = after cursor, undoes <Esc> left-shift
            end,
            mode = "i",
            desc = "Format and save (conform), stay in insert mode",
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = false,
        formatters_by_ft = {
            lua = { "stylua" },
            c = {
                "clang-format",
                "uncrustify",
                stop_after_first = true,
            },
            cpp = {
                "clang-format",
                "uncrustify",
                stop_after_first = true,
            },
            markdown = {
                "prettier",
                "markdownlint",
                stop_after_first = true,
            },
            python = { "autopep8", "black", "isort" },
        },
    },
})

-- Autocompletion
add_lazy({
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "2.*",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
        },
    },
    opts = {
        keymap = {
            preset = "enter",
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 500,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets" },
        },
        snippets = {
            preset = "luasnip",
        },
        fuzzy = {
            implementation = "lua",
        },
        signature = {
            enabled = true,
        },
    },
})

-- Colorscheme
add_lazy({
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            styles = {
                sidebars = "transparent",
                floats = "transparent",
                comments = {
                    italic = false,
                },
            },
        })
        vim.cmd.colorscheme("tokyonight-night")
    end,
})

-- Highlight todo, notes, etc in comments
add_lazy({
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
    },
})

-- Collection of various small independent plugins/modules
add_lazy({
    "nvim-mini/mini.nvim",
    config = function()
        require("mini.ai").setup({
            n_lines = 500,
        })
        require("mini.surround").setup()
        local statusline = require("mini.statusline")
        statusline.setup({
            use_icons = vim.g.have_nerd_font,
        })
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end
    end,
})

-- Highlight, edit, and navigate code
add_lazy({
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        local parsers = {
            "bash",
            "c",
            "diff",
            "html",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "query",
            "vim",
            "vimdoc",
        }
        require("nvim-treesitter").install(parsers)

        local function treesitter_try_attach(buf, language)
            if not vim.treesitter.language.add(language) then
                return
            end
            vim.treesitter.start(buf, language)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = require("nvim-treesitter").get_available()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end
                local installed_parsers = require("nvim-treesitter").get_installed("parsers")
                if vim.tbl_contains(installed_parsers, language) then
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    require("nvim-treesitter").install(language):await(function()
                        treesitter_try_attach(buf, language)
                    end)
                else
                    treesitter_try_attach(buf, language)
                end
            end,
        })
    end,
})

-- Useful plugin to show you pending keybinds.
add_lazy({
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
        -- Delay between pressing a key and opening which-key (milliseconds)
        delay = 0,
        icons = {
            mappings = vim.g.have_nerd_font,
        },
        -- Document existing key chains
        spec = {
            {
                "<leader>s",
                group = "[S]earch",
                mode = { "n", "v" },
            },
            {
                "<leader>t",
                group = "[T]oggle",
            }, -- Enable gitsigns recommended keymaps first
            {
                "<leader>h",
                group = "Git [H]unk",
                mode = { "n", "v" },
            },
            {
                "gr",
                group = "LSP Actions",
                mode = { "n" },
            },
        },
    },
})

add_lazy({
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node

        -- Helper to get filename without extension
        local function get_filename_no_ext()
            return vim.fn.expand("%:t:r")
        end

        -- Helper to get filename for include guard (e.g., FILE_H)
        local function get_year()
            return os.date("%Y")
        end

        local function get_guard()
            local fname = vim.fn.expand("%:t")
            return fname:upper():gsub("%.", "_")
        end

        local doxy = s("doxy", {
            t({
                "/// @brief",
                "/// @details",
                "/// @param[in] None",
                "/// @param[in,out] None",
                "/// @param[out] None",
                "/// @return void",
                "/// @retval None",
            }),
        })

        local adoxy = s("adoxy", {
            t({
                "/// @par AUTOSAR API",
                "/// - Service name:",
                "/// - Syntax:",
                "/// - Service ID[hex]:",
                "/// - Sync/Async:",
                "/// - Reentrancy:",
                "/// - Parameters (in):",
                "/// - Parameters (inout):",
                "/// - Parameters (out):",
                "/// - Return value:",
                "/// - Description:",
                "/// - Available via:",
                "/// @details",
                "/// - Traceability:",
            }),
        })

        local c80 = s("c80", {
            t({
                "//==============================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".c"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==============================================================================",
                "//==============================================================================",
                "// INCLUDE",
                "//==============================================================================",
                '#include "',
            }),
            f(get_filename_no_ext),
            t('.h"'),
            t({
                "",
                "",
                "//==============================================================================",
                "// IMPORTED SWITCH CHECK",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE DEFINE",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE TYPEDEF",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE ENUM",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE STRUCT",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE UNION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE FUNCTION DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE VARIABLE DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC VARIABLE DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// TEST",
                "//==============================================================================",
            }),
        })

        local ac80 = s("ac80", {
            t({
                "//==============================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".c"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==============================================================================",
                "//==============================================================================",
                "// INCLUDE",
                "//==============================================================================",
                '#include "',
            }),
            f(get_filename_no_ext),
            t('.h"'),
            t({
                "",
                "",
                "//==============================================================================",
                "// IMPORTED SWITCH CHECK",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE DEFINE",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE TYPEDEF",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE ENUM",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE STRUCT",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE UNION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE FUNCTION DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE VARIABLE DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC VARIABLE DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PRIVATE FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// TEST",
                "//==============================================================================",
            }),
        })

        local h80 = s("h80", {
            t({
                "//==============================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".h"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==============================================================================",
                "//==============================================================================",
                "// GUARD START",
                "//==============================================================================",
                "#ifndef ",
            }),
            f(get_guard),
            t({ "", "#define " }),
            f(get_guard),
            t({
                "",
                "#ifdef __cplusplus",
                'extern "C" {',
                "#endif",
                "//==============================================================================",
                "// INCLUDE",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC TYPEDEF",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC MACRO",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC ENUM",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC STRUCT",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC UNION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC VARIABLE DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC FUNCTION DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC INLINE FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// GUARD END",
                "//==============================================================================",
                "#ifdef __cplusplus",
                "}",
                "#endif",
                "#endif // #ifndef ",
            }),
            f(get_guard),
        })

        local ah80 = s("ah80", {
            t({
                "//==============================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".h"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==============================================================================",
                "//==============================================================================",
                "// GUARD START",
                "//==============================================================================",
                "#ifndef ",
            }),
            f(get_guard),
            t({ "", "#define " }),
            f(get_guard),
            t({
                "",
                "#ifdef __cplusplus",
                'extern "C"',
                "{",
                "#endif",
                "//==============================================================================",
                "// INCLUDE",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC TYPEDEF",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC MACRO",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC ENUM",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC STRUCT",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC UNION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC VARIABLE DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC FUNCTION DECLARATION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// PUBLIC INLINE FUNCTION DEFINITION",
                "//==============================================================================",
                "",
                "//==============================================================================",
                "// GUARD END",
                "//==============================================================================",
                "#ifdef __cplusplus",
                "}",
                "#endif",
                "#endif // #ifndef ",
            }),
            f(get_guard),
        })

        local c0 = s("c0", {
            t("/// @file "),
            f(get_filename_no_ext),
            t(".c"),
            t({ "", "/// @author " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "",
                "// INCLUDE",
                "",
                '#include "',
            }),
            f(get_filename_no_ext),
            t('.h"'),
            t({
                "",
                "",
                "// IMPORTED SWITCH CHECK",
                "",
                "// PRIVATE DEFINE",
                "",
                "// PRIVATE TYPEDEF",
                "",
                "// PRIVATE ENUM",
                "",
                "// PRIVATE STRUCT",
                "",
                "// PRIVATE UNION",
                "",
                "// PRIVATE FUNCTION DECLARATION",
                "",
                "// PRIVATE VARIABLE DEFINITION",
                "",
                "// PUBLIC VARIABLE DEFINITION",
                "",
                "// PUBLIC FUNCTION DEFINITION",
                "",
                "// PRIVATE FUNCTION DEFINITION",
                "",
                "// TEST",
            }),
        })

        local h0 = s("h0", {
            t("/// @file "),
            f(get_filename_no_ext),
            t(".h"),
            t({ "", "/// @author " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "",
                "// GUARD START",
                "",
                "#ifndef ",
            }),
            f(get_guard),
            t({ "", "#define " }),
            f(get_guard),
            t({
                "",
                "#ifdef __cplusplus",
                'extern "C" {',
                "#endif",
                "",
                "// INCLUDE",
                "",
                "// PUBLIC TYPEDEF",
                "",
                "// PUBLIC DEFINE",
                "",
                "// PUBLIC ENUM",
                "",
                "// PUBLIC STRUCT",
                "",
                "// PUBLIC UNION",
                "",
                "// PUBLIC VARIABLE DECLARATION",
                "",
                "// PUBLIC FUNCTION DECLARATION",
                "",
                "// GUARD END",
                "",
                "#ifdef __cplusplus",
                "}",
                "#endif",
                "#endif // #ifndef ",
            }),
            f(get_guard),
        })

        local c100 = s("c100", {
            t({
                "//==================================================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".c"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==================================================================================================",
                "//==================================================================================================",
                "// INCLUDE",
                "//==================================================================================================",
                '#include "',
            }),
            f(get_filename_no_ext),
            t({ '.h"' }),
            t({
                "",
                "",
                "//==================================================================================================",
                "// IMPORTED SWITCH CHECK",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE DEFINE",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE TYPEDEF",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE ENUM",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE STRUCT",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE UNION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE FUNCTION DECLARATION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE VARIABLE DEFINITION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC VARIABLE DEFINITION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC FUNCTION DEFINITION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PRIVATE FUNCTION DEFINITION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// TEST",
                "//==================================================================================================",
            }),
        })

        local h100 = s("h100", {
            t({
                "//==================================================================================================",
                "",
            }),
            t("/// @file       "),
            f(get_filename_no_ext),
            t(".h"),
            t({ "", "/// @author     " }),
            i(1, "User"),
            t(" ("),
            i(2, "user@email.com"),
            t({
                ")",
                "/// @brief",
                "/// @copyright  Copyright (C) ",
            }),
            f(get_year),
            t({
                ". All rights reserved.",
                "/// @details",
                "//==================================================================================================",
                "//==================================================================================================",
                "// GUARD START",
                "//==================================================================================================",
                "#ifndef ",
            }),
            f(get_guard),
            t({ "", "#define " }),
            f(get_guard),
            t({
                "",
                "#ifdef __cplusplus",
                'extern "C" {',
                "#endif",
                "",
                "//==================================================================================================",
                "// INCLUDE",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC TYPEDEF",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC DEFINE",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC ENUM",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC STRUCT",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC UNION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC VARIABLE DECLARATION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC FUNCTION DECLARATION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// PUBLIC INLINE FUNCTION DEFINITION",
                "//==================================================================================================",
                "",
                "//==================================================================================================",
                "// GUARD END",
                "//==================================================================================================",
                "#ifdef __cplusplus",
                "}",
                "#endif",
                "#endif // #ifndef ",
            }),
            f(get_guard),
        })

        ls.add_snippets("c", { doxy, adoxy, c80, h80, ac80, ah80, c0, h0, c100 })
        ls.add_snippets("cpp", { doxy, adoxy, c80, h80, c0, h0, h100 })

        -- Trigger and Jump keymaps
        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
                    "n",
                    false
                )
            end
        end, { silent = true, desc = "LuaSnip: Expand or jump forward" })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            else
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true),
                    "n",
                    false
                )
            end
        end, { silent = true, desc = "LuaSnip: Jump backward" })

        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true, desc = "LuaSnip: Next choice" })
    end,
})

-- =================================================================================================
-- NVIM_LAZY_SETUP
-- =================================================================================================
require("lazy").setup(lazy_plugins, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- =================================================================================================
-- NVIM_SCRIPTS
-- =================================================================================================
local function paste_as_markdown_table()
    local content = vim.fn.getreg("+")
    if content == "" then
        vim.notify("Clipboard is empty", vim.log.levels.WARN)
        return
    end

    local rows = {}
    local current_row = {}
    local current_field = {}
    local in_quotes = false
    local i = 1
    local len = #content

    local function is_field_all_whitespace()
        for _, ch in ipairs(current_field) do
            if not ch:match("^%s$") then
                return false
            end
        end
        return true
    end

    local function finalize_field()
        local field_str = table.concat(current_field)
        field_str = field_str:gsub("^%s+", ""):gsub("%s+$", "")
        if #field_str >= 2 and field_str:sub(1, 1) == '"' and field_str:sub(-1, -1) == '"' then
            local inner = field_str:sub(2, -2)
            inner = inner:gsub('""', '"')
            field_str = inner
        end
        table.insert(current_row, field_str)
        current_field = {}
    end

    while i <= len do
        local c = content:sub(i, i)
        local next_c = content:sub(i + 1, i + 1)

        if in_quotes then
            if c == '"' then
                if next_c == '"' then
                    table.insert(current_field, '"')
                    i = i + 2
                else
                    in_quotes = false
                    i = i + 1
                end
            elseif c == "\r" then
                if next_c == "\n" then
                    table.insert(current_field, "\n")
                    i = i + 2
                else
                    table.insert(current_field, "\n")
                    i = i + 1
                end
            elseif c == "\n" then
                table.insert(current_field, "\n")
                i = i + 1
            else
                table.insert(current_field, c)
                i = i + 1
            end
        else
            if c == '"' and is_field_all_whitespace() then
                current_field = {}
                in_quotes = true
                i = i + 1
            elseif c == "\t" then
                finalize_field()
                i = i + 1
            elseif c == "\r" then
                if next_c == "\n" then
                    i = i + 2
                else
                    i = i + 1
                end
                finalize_field()
                if #current_row > 0 or i <= len then
                    table.insert(rows, current_row)
                end
                current_row = {}
            elseif c == "\n" then
                i = i + 1
                finalize_field()
                if #current_row > 0 or i <= len then
                    table.insert(rows, current_row)
                end
                current_row = {}
            else
                table.insert(current_field, c)
                i = i + 1
            end
        end
    end

    if #current_field > 0 or #current_row > 0 then
        finalize_field()
        if #current_row > 0 then
            table.insert(rows, current_row)
        end
    end

    if #rows == 0 then
        vim.notify("No valid content in clipboard", vim.log.levels.WARN)
        return
    end

    local max_cols = 0
    for _, row in ipairs(rows) do
        if #row > max_cols then
            max_cols = #row
        end
    end

    for _, row in ipairs(rows) do
        while #row < max_cols do
            table.insert(row, "")
        end
    end

    local col_widths = {}
    for col = 1, max_cols do
        local max_len = 0
        for _, row in ipairs(rows) do
            local cell_text = row[col] or ""
            cell_text = cell_text:gsub("\n", "<br>")
            local len = vim.fn.strdisplaywidth(cell_text)
            if len > max_len then
                max_len = len
            end
        end
        col_widths[col] = math.max(max_len, 3)
    end

    local function pad_cell(text, width)
        local text_width = vim.fn.strdisplaywidth(text)
        local padding = width - text_width
        return " " .. text .. string.rep(" ", padding) .. " "
    end

    local md_lines = {}
    local function render_row(row_data)
        local cells = {}
        for col = 1, max_cols do
            local cell_text = (row_data[col] or ""):gsub("\n", "<br>")
            table.insert(cells, pad_cell(cell_text, col_widths[col]))
        end
        table.insert(md_lines, "|" .. table.concat(cells, "|") .. "|")
    end

    local header_cells = {}
    for col = 1, max_cols do
        table.insert(header_cells, pad_cell("", col_widths[col]))
    end
    table.insert(md_lines, "|" .. table.concat(header_cells, "|") .. "|")

    local sep_cells = {}
    for col = 1, max_cols do
        table.insert(sep_cells, " " .. string.rep("-", col_widths[col]) .. " ")
    end
    table.insert(md_lines, "|" .. table.concat(sep_cells, "|") .. "|")

    for i = 1, #rows do
        render_row(rows[i])
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1

    vim.api.nvim_buf_set_lines(bufnr, row, row, false, md_lines)
    vim.api.nvim_win_set_cursor(0, { row + #md_lines, 0 })
    vim.notify("Pasted " .. #rows .. " rows x " .. max_cols .. " cols as Markdown table")
end

vim.api.nvim_create_user_command("PasteAsMarkdownTable", paste_as_markdown_table, {
    desc = "Convert Excel clipboard content to Markdown table and paste",
})

local function copy_as_csv_table(opts)
    local start_line, end_line
    if opts and opts.line1 and opts.line2 then
        start_line = math.min(opts.line1, opts.line2) - 1
        end_line = math.max(opts.line1, opts.line2)
    else
        local start_pos = vim.fn.getpos("'<")
        local end_pos = vim.fn.getpos("'>")
        if start_pos[2] == 0 and end_pos[2] == 0 then
            vim.notify("Please select a markdown table in visual mode first", vim.log.levels.WARN)
            return
        end
        start_line = math.min(start_pos[2], end_pos[2]) - 1
        end_line = math.max(start_pos[2], end_pos[2])
    end

    if end_line <= start_line then
        vim.notify("Selection is empty", vim.log.levels.WARN)
        return
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    local rows = {}
    local max_cols = 0
    for _, line in ipairs(lines) do
        local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")
        if trimmed == "" then
            goto continue
        end
        if not trimmed:match("^|.*|$") then
            goto continue
        end
        local inner = trimmed:sub(2, -2)
        local is_separator = true
        for cell in vim.gsplit(inner, "|", { plain = true }) do
            local cell_trimmed = cell:gsub("^%s+", ""):gsub("%s+$", "")
            if
                cell_trimmed ~= ""
                and not cell_trimmed:match("^%-+$")
                and not cell_trimmed:match("^:%-+%:?$")
                and not cell_trimmed:match("^%-+%:?$")
            then
                is_separator = false
                break
            end
        end
        if is_separator then
            goto continue
        end

        local cols = {}
        for cell in vim.gsplit(inner, "|", { plain = true }) do
            local cell_text = cell:gsub("^%s+", ""):gsub("%s+$", "")
            cell_text = cell_text:gsub("<br>", "\n")
            table.insert(cols, cell_text)
        end
        if #cols > max_cols then
            max_cols = #cols
        end
        table.insert(rows, cols)
        ::continue::
    end

    if #rows == 0 then
        vim.notify("No valid markdown table rows found in selection", vim.log.levels.WARN)
        return
    end

    local csv_lines = {}
    for _, row in ipairs(rows) do
        while #row < max_cols do
            table.insert(row, "")
        end
        local cells = {}
        for _, cell in ipairs(row) do
            if cell:find("\n") or cell:find(",") or cell:find('"') then
                local escaped = cell:gsub('"', '""')
                table.insert(cells, '"' .. escaped .. '"')
            else
                table.insert(cells, cell)
            end
        end
        table.insert(csv_lines, table.concat(cells, ","))
    end

    local content = table.concat(csv_lines, "\r\n")
    vim.fn.setreg("+", content)
    vim.notify("Copied " .. #rows .. " rows x " .. max_cols .. " cols as CSV table to clipboard")
end

vim.api.nvim_create_user_command("CopyAsCsvTable", copy_as_csv_table, {
    desc = "Convert selected markdown table to CSV format and copy to clipboard",
    range = true,
})

-- =================================================================================================
-- MY_NOTES
-- =================================================================================================
