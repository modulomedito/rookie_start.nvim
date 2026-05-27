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
vim.o.textwidth = 100
vim.o.timeoutlen = 300
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
vim.keymap.set("i", "kj", "<Esc>", {
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

-- Quickfix list
vim.keymap.set("n", "<F10>", ":cnext<CR>", {
    silent = true,
    desc = "Next quickfix item",
})
vim.keymap.set("n", "<F11>", ":cclose<CR>", {
    silent = true,
    desc = "Close quickfix list",
})
vim.keymap.set("n", "<F8>", ":copen<CR>", {
    silent = true,
    desc = "Open quickfix list",
})
vim.keymap.set("n", "<F9>", ":cprevious<CR>", {
    silent = true,
    desc = "Previous quickfix item",
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
vim.keymap.set("n", "<leader>tm", "<cmd>vs|term<CR>", {
    silent = true,
    desc = "Open terminal in split",
})
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
    vim.cmd("silent !git pull")
    vim.cmd("silent !git add .")
    vim.cmd('silent !git commit -m "update by vim"')
    vim.cmd("silent !git push")
    vim.cmd("silent !git fetch")
    vim.cmd("!git log --oneline --graph --all --decorate")
end, {
    silent = true,
    desc = "Git sync & log",
})

-- Command mode
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

-- Terminal mode
vim.keymap.set("t", "kj", [[<C-\><C-n>]], {
    desc = "Exit terminal mode",
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
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
    desc = "Exit terminal mode",
})

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
        vim.opt_local.textwidth = 100
        vim.cmd("silent! setlocal noundofile")

        -- nnoremap <silent><buffer> <leader>f :PanguAll<CR>
        vim.keymap.set("n", "<leader>f", ":PanguAll<CR>", {
            silent = true,
            buffer = true,
            desc = "GitCommit: PanguAll",
        })

        -- nnoremap <silent><buffer> <C-q> :q<Bar>call timer_start(1000, {-> execute('RkGitGraph')})<CR>
        vim.keymap.set("n", "<C-q>", function()
            vim.cmd("q")
            vim.defer_fn(function()
                vim.cmd("RkGitGraph")
            end, 200)
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
        vim.opt_local.textwidth = 100
    end,
})

local group_markdown = vim.api.nvim_create_augroup("RkMarkdown", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    group = group_markdown,
    pattern = "markdown",
    callback = function()
        vim.opt_local.textwidth = 80
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
    "modulomedito/rookie_enhance_telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("rookie_enhance_telescope").setup()
    end,
})

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

add_lazy({ "NMAC427/guess-indent.nvim" })

add_lazy({ "hotoo/pangu.vim" })

-- Highlight words/patterns
add_lazy({ "azabiong/vim-highlighter" })

-- Calculator
add_lazy({ "fedorenchik/VimCalc3" })

add_lazy({ "tpope/vim-surround" })

-- Show vim marks
add_lazy({ "kshenoy/vim-signature" })

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
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
            },
        })

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, {
            desc = "[S]earch [H]elp",
        })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
            desc = "[S]earch [K]eymaps",
        })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, {
            desc = "[S]earch [F]iles",
        })
        vim.keymap.set("n", "<C-p>", builtin.find_files, {
            desc = "[S]earch [F]iles",
        })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, {
            desc = "[S]earch [S]elect Telescope",
        })
        vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, {
            desc = "[S]earch current [W]ord",
        })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, {
            desc = "[S]earch by [G]rep",
        })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {
            desc = "[S]earch [D]iagnostics",
        })
        vim.keymap.set("n", "<leader>sr", builtin.resume, {
            desc = "[S]earch [R]esume",
        })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {
            desc = '[S]earch Recent Files ("." for repeat)',
        })
        vim.keymap.set("n", "<leader>sc", builtin.commands, {
            desc = "[S]earch [C]ommands",
        })
        vim.keymap.set("n", "<leader>b", builtin.buffers, {
            desc = "[ ] Find existing buffers",
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("telescope-lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                local buf = event.buf
                vim.keymap.set("n", "grr", builtin.lsp_references, {
                    buffer = buf,
                    desc = "[G]oto [R]eferences",
                })
                vim.keymap.set("n", "gri", builtin.lsp_implementations, {
                    buffer = buf,
                    desc = "[G]oto [I]mplementation",
                })
                vim.keymap.set("n", "grd", builtin.lsp_definitions, {
                    buffer = buf,
                    desc = "[G]oto [D]efinition",
                })
                vim.keymap.set("n", "gO", builtin.lsp_document_symbols, {
                    buffer = buf,
                    desc = "Open Document Symbols",
                })
                vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, {
                    buffer = buf,
                    desc = "Open Workspace Symbols",
                })
                vim.keymap.set("n", "grt", builtin.lsp_type_definitions, {
                    buffer = buf,
                    desc = "[G]oto [T]ype Definition",
                })
            end,
        })

        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, {
            desc = "[/] Fuzzily search in current buffer",
        })

        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, {
            desc = "[S]earch [/] in Open Files",
        })

        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, {
            desc = "[S]earch [N]eovim files",
        })
    end,
})

-- Autoformat
add_lazy({
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fo",
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
                vim.cmd("normal! m6")
                vim.cmd("%s/\\s\\+$//e")
                if vim.bo.filetype == "markdown" then
                    vim.cmd("PanguAll")
                end
                -- local ok, conform = pcall(require, "conform")
                -- if ok then
                --     conform.format({
                --         lsp_fallback = true,
                --         async = false,
                --     })
                -- else
                --     vim.lsp.buf.format()
                -- end
                vim.cmd("w")
                vim.cmd("normal! `6zz")
                vim.cmd("noh")
            end,
            mode = "n",
            desc = "Format and save (conform)",
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
-- MY_NOTES
-- =================================================================================================
