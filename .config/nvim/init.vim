call plug#begin()


Plug 'ellisonleao/gruvbox.nvim', { 'as': 'gruvbox'         }
Plug 'rebelot/kanagawa.nvim',    { 'as': 'kangawa'         }
Plug 'catppuccin/nvim',          { 'as': 'catppuccin'      } 
Plug 'folke/tokyonight.nvim',    { 'as': 'tokyonight'      } " 7/10       
Plug 'rose-pine/neovim',         { 'as': 'rose-pine'       } 
Plug 'EdenEast/nightfox.nvim',   { 'as': 'nightfox'        }       
Plug 'sainnhe/gruvbox-material', { 'as': 'gruvbox-material'} 
Plug 'sainnhe/everforest',       { 'as': 'everforest'      } 
Plug 'navarasu/onedark.nvim', { 'as': 'onedark'}
Plug 'scottmckendry/cyberdream.nvim', { 'as': 'cyberdream'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'


call plug#end()

" --- Configs ---

set number
set termguicolors
set background=dark
"set scrolloff=999
command! -nargs=1 L execute 'normal!' . <q-args> . 'Gzz'
"autocmd FileType c,cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

" --- Color Schemes ---
"colorscheme gruvbox
"colorscheme kanagawa
"colorscheme catppuccin 
"colorscheme tokyonight
"colorscheme rose-pine 
colorscheme nightfox
"colorscheme gruvbox-material
"colorscheme everforest
"colorscheme onedark
"colorscheme cyberdream


" --- Function Highlighter ---


lua << EOF
-- 1. Setup Treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if status_ok then
  configs.setup({
    ensure_installed = { "lua", "python", "javascript", "typescript", "c", "cpp", "rust" },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  })
end


-- 2. Setup Clangd using Neovim 0.11+ native LSP config
vim.lsp.config('clangd', {
  -- defaults are handled automatically by nvim-lspconfig package
})
vim.lsp.enable('clangd')
EOF
