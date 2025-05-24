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
				ensure_installed = { "gopls", "starpls", "yamlls", "eslint", "tailwindcss", "ts_ls", "jsonls" },
			})
		end,
	},
	-- move to different file?
	{
		-- I might need to get rid of none-ls as it's binaries are incompatible with docker. Or is it?
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			local stylua = null_ls.builtins.formatting.stylua
			stylua.command = "docker run johnnymorganz/stylua --"

			null_ls.setup({
				sources = {
					-- todo: somehow mason should be configured to automatically install this. I installed it through mason UI.
					stylua,
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
		"lspcontainers/lspcontainers.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function() end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local lspcontainers = require("lspcontainers")
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

			vim.lsp.log_level = vim.log.levels.DEBUG
			lspconfig.lua_ls.setup({
				cmd = lspcontainers.command("lua_ls", {
					image = "thecherka/luals:latest",
				}),
				settings = {
					Lua = {
						diagnostics = {
							enable = true, -- Ensure this is true
							-- ... other diagnostic settings ...
						},
					},
				},
			})

			local pylspcmd = require("lspcontainers").command("pylsp", {
				image = "thecherka/pylsp:latest",
			})
			lspconfig.pylsp.setup({
				cmd = pylspcmd,
			})

			lspconfig.nil_ls.setup({
				cmd = require("lspcontainers").command("nil", { image = "thecherka/nil-lsp:latest" }),
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
