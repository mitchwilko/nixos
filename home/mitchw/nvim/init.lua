-- =====================================================
-- vim-plug bootstrap (auto-install if not already present)
-- =====================================================
-- local data_dir = vim.fn.stdpath("data")
-- local autoload_plug_path = data_dir .. "/site/autoload/plug.vim"
--  
-- if vim.fn.empty(vim.fn.glob(autoload_plug_path)) > 0 then
--   vim.fn.system({
--     "curl",
--     "-fLo",
--     autoload_plug_path,
--     "--create-dirs",
--     "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
--   })
--   vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
-- end
 
-- =====================================================
-- Plugins
-- =====================================================

-- local vim = vim
-- local Plug = vim.fn['plug#']
-- 
-- vim.call('plug#begin')
-- 
-- Plug('itchyny/lightline.vim')
-- Plug('stevearc/oil.nvim', { ['branch'] = 'nvim-0.9' })
-- Plug('echasnovski/mini.icons')
-- 
-- vim.call('plug#end')

-- =====================================================
-- Set default visual basis
-- =====================================================
vim.cmd.colorscheme("mono")
-- vim.g.molokai_original = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.laststatus = 2
vim.opt.mouse = ""

-- vim.opt.colorcolumn = "81"
-- vim.cmd("highlight ColorColumn ctermbg=DarkBlue")
-- Make 81st column stand out
-- vim.fn.matchadd('ColorColumn', '\%81v', 100)

-- =====================================================
-- Cursor shape: block in normal, bar in insert, underline in replace
-- (native Neovim equivalent of the raw t_EI/t_SR/t_SI escape codes)
-- =====================================================
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
  .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
  .. "sm:block-blinkwait175-blinkoff150-blinkon175"

-- If you'd rather keep the exact original raw-escape approach instead
-- of guicursor, uncomment this block and remove the guicursor line above:
-- vim.cmd([[
--   let &t_EI = "\e[1 q"
--   let &t_SR = "\e[3 q"
--   let &t_SI = "\e[5 q"
-- ]])
-- \e[6 q: Steady bar (line).
-- \e[5 q: Blinking bar.
-- \e[2 q: Steady block.

-- =====================================================
-- MY HANDLING OF TABS
-- =====================================================
vim.opt.expandtab = false   -- Stop converting tabs to spaces
vim.opt.tabstop = 4         -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4      -- Set auto-indent width to 4 spaces
-- vim.cmd("retab!")        -- Force-convert all existing space-indents to real tabs

vim.opt.listchars = { tab = "├─>" }
vim.opt.list = true
-- vim.api.nvim_set_hl(0, "Whitespace", {
-- fg = vim.g.atlas_colors["dim"]
--})

-- =====================================================
-- Default opening of splits
-- =====================================================
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.keymap.set('n', "<C-w>n", ':bnext<CR>', { desc = 'Move to Next Buffer' })
vim.keymap.set('n', "<C-w>p", ':bprevious<CR>', { desc = 'Move to Previous Buffer' })

-- Automatically save things sometimes (eg on make)
vim.opt.autowrite = true

-- =====================================================
-- Lightline Config
-- =====================================================
vim.g.lightline = {
  colorscheme = "mono",
}

-- =====================================================
-- Oil Configs
-- =====================================================

require("mini.icons").setup()
vim.g.have_nerd_font = true
require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  use_icons = true,
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  skip_confirm_for_simple_edits = false,
  watch_for_changes = true
})

-- =====================================================
-- Remap netrw-style commands to oil.nvim
-- =====================================================
-- Open parent directory of current file (replaces :Explore / :Ex)
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory in Oil' })

-- Vertical/horizontal split equivalents to :Vexplore / :Sexplore
vim.keymap.set('n', "<C-w>%", '<CMD>vsplit | Oil<CR>', { desc = 'Open Oil in vertical split' })
vim.keymap.set('n', '<C-w>\"', '<CMD>split | Oil<CR>', { desc = 'Open Oil in horizontal split' })

-- =====================================================
-- Markdown Renderer Configs
-- =====================================================

require("render-markdown").setup({})

vim.keymap.set(
    "n",
    "<leader>mr",
    "<cmd>RenderMarkdown toggle<CR>",
    { desc = "Toggle Markdown rendering" }
)

-- =====================================================
-- Comment Colour Toggle Function
-- Toggle Comment highlight color between normal and green(amber)
-- NOTE: requires g.atlas_colors to be defined by your colorscheme
-- (e.g. an "atlas" colorscheme) with 'muted' and 'amber' keys, each
-- a {guicolor, ctermcolor} pair.
-- =====================================================
vim.g.comment_highlight_toggled = 0

local function toggle_comment_color()
  local fg

  if vim.g.comment_highlight_toggled == 1 then
    -- revert to atlas's own comment color
    fg = vim.g.atlas_colors["muted"]
    vim.g.comment_highlight_toggled = 0
    print("Comment color: muted")
  else
    -- use atlas's amber entry if it has one, else hardcode
    fg = vim.g.atlas_colors["amber"]
    vim.g.comment_highlight_toggled = 1
    print("Comment color: amber")
  end

  vim.cmd(string.format("hi Comment guifg=%s ctermfg=%s", fg[1], fg[2]))
end

vim.keymap.set("n", "<C-s>", toggle_comment_color, { noremap = true, silent = true })
