return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "starpls", "yamlls", "eslint", 'tailwindcss', 'ts_ls', 'jsonls' },
			})
		end,
	},
	-- move to different file?
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- todo: somehow mason should be configured to automatically install this. I installed it through mason UI.
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.gofmt,

					-- todo: null_ls is capable of diagnostics. should figure out what this is and take advantage of it.
				},
			})

			-- todo: format on save?
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,

		-- todo: add barbar plugin to show multiple files at the top. just like goland.
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local configs = require("lspconfig.configs")
			local util = require("lspconfig.util")

			configs.protobuf_language_server = {
				default_config = {
					cmd = { "/Users/tomas/go/bin/protobuf-language-server" },
					filetypes = { "proto", "cpp" },
					root_dir = util.root_pattern(".git"),
					single_file_support = true,
					--  settings = {
					--    ["additional-proto-dirs"] = [
					-- path to additional protobuf directories
					-- "vendor",
					-- "third_party",
					--   ]
					--},
				},
			}

			local lspconfig = require("lspconfig")
			vim.lsp.log_level = vim.log.levels.DEBUG
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							enable = true, -- Ensure this is true
							-- ... other diagnostic settings ...
						},
					},
				},
			})
			lspconfig.gopls.setup({})
			lspconfig.starpls.setup({
				filetypes = { "starlark", "bzl", "bazel", "star", "eslint" },
			})
      lspconfig.protobuf_language_server.setup({})

      lspconfig.tailwindcss.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.eslint.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
			})
		end,
	},
}
