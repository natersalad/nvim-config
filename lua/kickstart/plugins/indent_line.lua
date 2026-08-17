-- Show only the Treesitter scope containing the cursor, not permanent indent guides.

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help ibl`
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

local hooks = require 'ibl.hooks'

-- Recreate the active-scope highlight whenever :colorscheme resets highlights.
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  local primary = vim.g.noctalia_primary
  if type(primary) == 'string' and primary ~= '' then
    vim.api.nvim_set_hl(0, 'IblScope', { fg = primary })
  else
    -- Readable fallback used only before Noctalia's generated theme has loaded.
    vim.api.nvim_set_hl(0, 'IblScope', { link = 'Identifier' })
  end
end)

require('ibl').setup {
  indent = {
    -- Spaces hide permanent guides while preserving cells for the active scope line.
    char = ' ',
    tab_char = ' ',
  },
  scope = {
    -- The active scope follows the cursor and uses Noctalia's IblScope highlight.
    enabled = true,
    char = '│',
    highlight = 'IblScope',
    -- Avoid the horizontal lines beneath opening and closing bracket lines.
    show_start = false,
    show_end = false,
  },
}
