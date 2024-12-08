vim.cmd([[
   se runtimepath^=~/.vim runtimepath+=~/.vim/after
   let &packpath=&runtimepath
   source ~/.vimrc

   se mouse=c

   se completeopt=menu,menuone,noselect

   se guicursor=a:hor50-Cursor-blinkwait175-blinkoff150-blinkon175
]])

local cmp = require("cmp")
local home = os.getenv("HOME")

local null_ls = require("null-ls")

-- luasnip setup
local luasnip = require("luasnip")

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   }),
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
   },
})

require("luasnip.loaders.from_vscode").lazy_load()

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
   -- Enable completion triggered by <c-x><c-o>
   -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   local bufopts = { noremap = true, silent = true, buffer = bufnr }
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
   vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
   vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
   vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
   vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
   vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
   vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, bufopts)
   vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
   vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
   vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
   vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
   end, bufopts)
end

local lsp_flags = {
   -- This is the default in Nvim 0.7+
   debounce_text_changes = 150,
}

require("lspconfig")["ts_ls"].setup({
   on_attach = on_attach,
   flags = lsp_flags,
   capabilities = capabilities,
})

local util = require("lspconfig.util")
local function get_typescript_server_path(root_dir)
   local global_ts =
      util.path.join(home, ".nvm", "versions", "node", "v18.19.0", "lib", "node_modules", "typescript", "lib")
   local found_ts = ""
   local function check_dir(path)
      found_ts = util.path.join(path, "node_modules", "typescript", "lib")
      if util.path.exists(found_ts) then
         return path
      end
   end
   if util.search_ancestors(root_dir, check_dir) then
      return found_ts
   else
      return global_ts
   end
end

require("lspconfig")["volar"].setup({
   on_attach = on_attach,
   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
   capabilities = capabilities,
   on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
   end,
   init_options = {
      vue = {
         hybridMode = false,
      }
   }
})

require("lspconfig")["cssls"].setup({
   on_attach = on_attach,
   flags = lsp_flags,
   capabilities = capabilities,
})

require("lspconfig")["astro"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

require("lspconfig")["lua_ls"].setup({
   on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
         client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
               runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
               },
               -- Make the server aware of Neovim runtime files
               workspace = {
                  checkThirdParty = false,
                  library = {
                     vim.env.VIMRUNTIME,
                     -- "${3rd}/luv/library"
                     -- "${3rd}/busted/library",
                  },
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
               },
            },
         })

         client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
   end,
   on_attach = on_attach,
   capabilities = capabilities,
})

require("lspconfig")["phpactor"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

require("lspconfig")["intelephense"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = { "intelephense", "--stdio" },
   init_options = {
      globalStoragePath = util.path.join(home, ".intelephense"),
   },
})

require("lspconfig")["jsonls"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

require("lspconfig")["bashls"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

require("lspconfig")["clangd"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

local project_library_path =
   "/home/hali/.local/share/nvim/packages/angular-language-server/node_modules/@angular/language-server"
local cmd =
   { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations", project_library_path }

require("lspconfig")["angularls"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
   cmd = cmd,
   on_new_config = function(new_config, new_root_dir)
      new_config.cmd = cmd
   end,
})

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
project_name = project_name:gsub("%W", "_")
local workspace_folder = vim.fn.expand("$HOME/.cache/jdtls/data/") .. project_name

require("lspconfig")["jdtls"].setup({
   cmd = {
      util.path.join(vim.fn.stdpath("data"), "bin", "jdtls"),
      "-data",
      workspace_folder,
   },
   -- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
   on_attach = on_attach,
   capabilities = capabilities,
   settings = {
      java = {
         format = {
            settings = {
               -- Use Google Java style guidelines for formatting
               -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
               -- and place it in the ~/.local/share/eclipse directory
               url = util.path.join(home, ".local", "share", "eclipse", "eclipse-java-google-style.xml"),
               profile = "GoogleStyle",
            },
         },
      },
   },
})

require("lspconfig")["tailwindcss"].setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

null_ls.setup({
   sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.blade_formatter,
   },
   on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
         vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
         end, { buffer = bufnr, desc = "[lsp] format" })
      end

      if client.supports_method("textDocument/rangeFormatting") then
         vim.keymap.set("x", "<Leader>f", function()
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
         end, { buffer = bufnr, desc = "[lsp] format" })
      end
   end,
})

require("prettier").setup({
   bin = "prettier",
   filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
   },
   cli_options = {
      print_width = 80,
      semi = false,
      shift_width = 2,
   },
})

require("nvls").setup({
   lilypond = {
      options = {
         pdf_viewer = 'zathura'
      }
   }
})

require("mason").setup({
   install_root_dir = vim.fn.stdpath("data"),
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
