-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require 'packer'
local use = packer.use

local function uselocal(p, ...)
  local git_projects_dir = os.getenv 'GIT_PROJECTS_DIR'
  if git_projects_dir ~= nil then
    use { git_projects_dir .. '/' .. p, ... }
  end
end

packer.init {
  max_jobs = tonumber(vim.fn.system 'nproc') or 8,
}

packer.startup(function()
  -- Package management
  use 'wbthomason/packer.nvim'

  -- Config
  uselocal 'mapx.nvim'

  -- UI
  use 'Famiu/feline.nvim'
  use 'chriskempson/base16-vim'
  use 'ericbn/vim-relativize'
  use 'folke/which-key.nvim'
  use 'joshdick/onedark.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'liuchengxu/vista.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  --   use 'kyazdani42/nvim-tree.lua'
  uselocal 'nvim-tree.lua'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
  }

  -- Editing
  use 'AndrewRadev/splitjoin.vim'
  use 'andymass/vim-matchup'
  use 'b0o/vim-shot-f'
  use 'chaoren/vim-wordmotion'
  use 'coderifous/textobj-word-column.vim'
  use 'godlygeek/tabular'
  use 'kana/vim-textobj-fold'
  use 'kana/vim-textobj-indent'
  use 'kana/vim-textobj-line'
  use 'kana/vim-textobj-user'
  use 'matze/vim-move'
  use 'mg979/vim-visual-multi'
  use 'sgur/vim-textobj-parameter'
  use 'terryma/vim-expand-region'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'triglav/vim-visual-increment'
  use 'wellle/visual-split.vim'
  uselocal 'vim-buffest'
  -- uselocal 'extended-scrolloff.vim'

  -- Backup, Undo
  use 'chrisbra/Recover.vim'
  use 'mbbill/undotree'

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  use 'folke/trouble.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim'

  -- Code Style, Formatting, Linting
  use 'editorconfig/editorconfig-vim'
  use 'b0o/shellcheck-extras.vim'

  -- Git
  use 'christoomey/vim-conflicted'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'mattn/gist-vim', requires = 'mattn/webapi-vim' }

  -- System
  use 'tpope/vim-eunuch'

  -- Tooling
  --   use 'ludovicchabant/vim-gutentags'

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  -- Code Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-calc'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'octaltree/cmp-look'
  use 'saadparwaiz1/cmp_luasnip'
  use 'ray-x/cmp-treesitter'
  use 'f3fora/cmp-spell'
  use {
    'andersevenrud/compe-tmux',
    branch = 'cmp',
  }

  -- Window Movement and Management
  use 'christoomey/vim-tmux-navigator'
  use 'sindrets/winshift.nvim'

  -- Language-specific
  use 'Akin909/vim-dune'
  use 'mboughaba/i3config.vim'
  use 'rescript-lang/vim-rescript'
  use 'aouelete/sway-vim-syntax'

  -- Documentation
  use 'alx741/vinfo'

  -- Color
  use 'KabbAmine/vCoolor.vim'
  use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

  --- Vim Plugin Development
  use 'bfredl/nvim-luadev'
  use 'folke/lua-dev.nvim'

  -- Misc
  use { 'lewis6991/impatient.nvim', rocks = 'mpack' }
end)