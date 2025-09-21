vim.keymap.set('', '<F5>', ':make <bar> :copen<CR>')

local telescope_builtins = require('telescope.builtin')

vim.keymap.set('n', 'gr', telescope_builtins.live_grep, {})
vim.keymap.set('n', '<C-p>', telescope_builtins.find_files, {})
vim.keymap.set('n', 'zo', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', 'zn', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', 'zp', vim.diagnostic.goto_prev, { noremap = true, silent = true })

vim.api.nvim_create_autocmd({'LspAttach'}, {
    callback = function()
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-]>', telescope_builtins.lsp_references, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-[>', require('actions-preview').code_actions, { noremap = true, silent = true })
    end
})

vim.keymap.set('n', '<C-;>', ':Neotree filesystem reveal left<CR>', { noremap = true, silent = true })
