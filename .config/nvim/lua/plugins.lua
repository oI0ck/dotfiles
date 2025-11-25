local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--depth=1',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        path
    })
end

local plugins = {
    { 'nvim-treesitter/nvim-treesitter' },

    { 'NMAC427/guess-indent.nvim' },

    { 'nvim-lualine/lualine.nvim' },

    -- Autocomplete and LSP
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'lukas-reineke/cmp-under-comparator' },
    { 'p00f/clangd_extensions.nvim' },
    { 'aznhe21/actions-preview.nvim' },

    -- telescope
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },

    -- neotree
    { 'nvim-neo-tree/neo-tree.nvim' },
    { 'MunifTanjim/nui.nvim' },
    { 'nvim-tree/nvim-web-devicons' },

    -- Languages
    { 'rluba/jai.vim' },
    { 'google/vim-jsonnet' },

    -- Themes
    { 'cocateh/vim-gruber-darker' },
    { 'ishan9299/modus-theme-vim' },
    { 'navarasu/onedark.nvim' },
    { 'catppuccin/nvim' },
    { 'deparr/tairiki.nvim' }
}

require('lazy').setup(plugins)

-- This order is for a reason, becuase on Windows clang tends to put itself in
-- the PATH by default, and MSVC does not, and for some reason I always have some
-- bootleg version of gcc in the PATH
require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'python', 'markdown', 'vimdoc', 'lua' },
    sync_install = true,
    highlight = {
        enable = true,
    },
    auto_install = true,
}

require('guess-indent').setup {}

require('lualine').setup {
    options = {
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''}
    },
    sections = {
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                sections = { 'error', 'warn', 'info', 'hint' },
                symbols = { error = '✘', warn = '!', info = '▲', hint = '⚑' },
                colored = true
            }
        },
        lualine_x = {
            'encoding',
            {
                'fileformat',
                symbols = {
                    unix = 'unix',
                    dos = 'dos',
                    mac = 'mac',
                }
            },
            'filetype'
        }
    }
}

local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- yoinked from pajlada
cmp.setup {
    preselect = cmp.PreselectMode.None,
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require('clangd_extensions.cmp_scores'),
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, vim.fn.winwidth(0) - 20)
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<M-j>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<cr>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        {
            name = 'nvim_lsp_signature_help',
            entry_filter = function(entry, _)
                return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
            end,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
    completion = {
        autocomplete = false
    }
}

local lsps = {
    { "rust_analyzer", { autostart = false } },
    { "gopls", { autostart = false } },
    { "clangd", { autostart = false } },
    { "ruby_lsp", { autostart = false, init_options = { formatter = "standard", linters = { "standard" } } } },
    { "pyright", { autostart = false } },
    { "nil_ls", { autostart = false } },
    { "zls", { autostart = false } },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
    },
    underline = false
})

vim.fn.sign_define('DiagnosticSignError', {
    texthl = 'DiagnosticSignError',
    text = '✘',
    numhl = ''
})

vim.fn.sign_define('DiagnosticSignWarn', {
    texthl = 'DiagnosticSignWarn',
    text = '!',
    numhl = ''
})

vim.fn.sign_define('DiagnosticSignInfo', {
    texthl = 'DiagnosticSignInfo',
    text = '▲',
    numhl = ''
})

vim.fn.sign_define('DiagnosticSignHint', {
    texthl = 'DiagnosticSignHint',
    text = '⚑',
    numhl = ''
})

require('telescope').setup {}

local dropdown_theme = require('telescope.themes').get_dropdown({
    result_height = 20;
    width = 0.8;
    prompt_title = '';
    prompt_prefix = 'Files>';
    previewer = false;
})

vim.cmd.colorscheme('tairiki')
