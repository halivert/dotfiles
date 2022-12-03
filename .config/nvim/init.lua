vim.cmd([[
   se runtimepath^=~/.vim runtimepath+=~/.vim/after
   let &packpath=&runtimepath
   source ~/.vimrc

   se mouse=c

   se completeopt=menu,menuone,noselect

   se guicursor=a:hor50-Cursor-blinkwait175-blinkoff150-blinkon175
]])

local cmp = require 'cmp'

local null_ls = require("null-ls")

cmp.setup({
   snippet = {
      expand = function(args)
         vim.fn["UltiSnips#Anon"](args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
   }),
   sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
   }, {
      { name = 'buffer' },
   })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
   -- Enable completion triggered by <c-x><c-o>
   -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   local bufopts = { noremap = true, silent = true, buffer = bufnr }
   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
   vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
   vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, bufopts)
   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
   -- This is the default in Nvim 0.7+
   debounce_text_changes = 150,
}

require('lspconfig')['tsserver'].setup {
   on_attach = on_attach,
   flags = lsp_flags,
   capabilities = capabilities,
}

local util = require 'lspconfig.util'
local path = util.path
local volar_path = path.join(vim.fn.stdpath 'data', 'lsp_servers', 'volar', 'node_modules')
local global_ts_server_path = path.join(volar_path, 'typescript', 'lib')

local function get_typescript_lib_path(root_dir)
   local project_root = util.find_node_modules_ancestor(root_dir)
   return project_root and (path.join(project_root, 'node_modules', 'typescript', 'lib'))
       or global_ts_server_path
end

require('lspconfig')['volar'].setup {
   on_attach = on_attach,
   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
   capabilities = capabilities,
   init_options = {
      typescript = {
         tsdk = '/home/hali/.config/yarn/global/node_modules/typescript/lib/tsserverlibrary.js',
      },
   },
   on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.tsdk = get_typescript_lib_path(new_root_dir)
   end,
   settings = {
      volar = { autoCompleteRefs = true },
   },
}

require('lspconfig')['astro'].setup {
   on_attach = on_attach,
   capabilities = capabilities,
}

require('lspconfig')['sumneko_lua'].setup {
   on_attach = on_attach,
   capabilities = capabilities,
}

require('lspconfig')['phpactor'].setup {
   on_attach = on_attach,
   capabilities = capabilities,
}

require('lspconfig')['intelephense'].setup {
   on_attach = on_attach,
   capabilities = capabilities,
}

require('lspconfig')['jsonls'].setup {
   on_attach = on_attach,
   capabilities = capabilities,
}

null_ls.setup({
   sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
      null_ls.builtins.formatting.blade_formatter,
   },
   on_attach = on_attach,
})

require("mason").setup({
   install_root_dir = vim.fn.stdpath "data",

   PATH = "prepend",

   pip = {
      install_args = {},
   },

   log_level = vim.log.levels.INFO,

   max_concurrent_installers = 4,

   github = {
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
   },

   ui = {
      check_outdated_packages_on_open = true,

      border = "none",

      icons = {
         package_installed = "💚",
         package_pending = "⏯",
         package_uninstalled = "❤️",
      },

      keymaps = {
         -- Keymap to expand a package
         toggle_package_expand = "<CR>",
         -- Keymap to install the package under the current cursor position
         install_package = "i",
         -- Keymap to reinstall/update the package under the current cursor position
         update_package = "u",
         -- Keymap to check for new version for the package under the current cursor position
         check_package_version = "c",
         -- Keymap to update all installed packages
         update_all_packages = "U",
         -- Keymap to check which installed packages are outdated
         check_outdated_packages = "C",
         -- Keymap to uninstall a package
         uninstall_package = "X",
         -- Keymap to cancel a package installation
         cancel_installation = "<C-c>",
         -- Keymap to apply language filter
         apply_language_filter = "<C-f>",
      },
   },
})
