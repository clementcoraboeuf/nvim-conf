---- zbirenbaum/copilot.lua
local M = {
  status = '',
}

require('copilot').setup {
  panel = {
    enabled = false,
    auto_refresh = true,
    keymap = {
      jump_prev = '[[',
      jump_next = ']]',
      accept = '<CR>',
      refresh = 'gr',
      open = '<M-CR>',
    },
    layout = {
      position = 'bottom', -- | top | left | right
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = false,
      prev = false,
      dismiss = false,
      -- accept = '<M-l>',
      -- accept_word = false,
      -- accept_line = false,
      -- next = '<M-]>',
      -- prev = '<M-[>',
      -- dismiss = '<C-]>',
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = true,
    gitcommit = true,
    gitrebase = true,
    hgcommit = true,
    svn = true,
    cvs = true,
    ['.'] = true,
  },
  -- Node.js version must be > 16.x
  copilot_node_command = vim.env.HOME .. '/.asdf/shims/node',
  server_opts_overrides = {},
}

require('copilot.api').register_status_notification_handler(function(data)
  M.status = data.status
  vim.schedule(function()
    vim.cmd [[redrawstatus]]
  end)
end)

return M
