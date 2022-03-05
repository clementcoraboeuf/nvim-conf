---- lukas-reineke/indent-blankline.nvim
vim.cmd [[highlight link IndentBlanklineSpaceChar Comment]]
require('indent_blankline').setup {
  show_whitespace = true,
  show_end_of_line = true,
  use_treesitter = true,
  buftype_exclude = { 'terminal' },
  filetype_exclude = { 'help' },
}

---- lewis6991/gitsigns.nvim
require('gitsigns').setup {
  on_attach = require('user.mappings').on_gistsigns_attach,
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

---- sindrets/winshift.nvim
require('winshift').setup {
  highlight_moving_win = true, -- Highlight the window being moved
  focused_hl_group = 'Visual', -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = '',
  },
}

---- matze/vim-move
vim.g.move_key_modifier = 'C'

vim.g.matchup_matchparen_offscreen = { method = 'popup' }

---- mbbill/undotree
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffCommand = 'delta'

-- luukvbaal/stabilize.nvim
require('stabilize').setup()

-- Shatur/neovim-session-manager
require('session_manager').setup {
  autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
  autosave_last_session = false,
}

-- require('souvenir').setup {
--   session_path = vim.fn.stdpath('data') .. '/souvenirs/'
-- }

---- fatih/vim-go
vim.g.go_doc_keywordprg_enabled = 0

---- mg979/vim-visual-multi
vim.g.VM_custom_motions = {
  ['<M-,>'] = ',', -- Remap , to <M-,> because , conflicts with <localleader>
}

---- rcarriga/nvim-notify
require('notify').setup {
  render = 'default',
  background_colour = '#252137',
  stages = 'slide',
}

---- ThePrimeagen/git-worktree.nvim
require('git-worktree').setup {
  -- change_directory_command = <str> -- default: "cd",
  -- update_on_change = <boolean> -- default: true,
  -- update_on_change_command = <str> -- default: "e .",
  -- clearjumps_on_change = <boolean> -- default: true,
  -- autopush = <boolean> -- default: false,
}

---- chentau/marks.nvim
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { "<", ">", "." },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = { '', 'Nui', 'TelescopePrompt' },
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  -- bookmark_0 = {
  --   sign = "⚑",
  --   virt_text = "hello world"
  -- },
  mappings = {}
}