local Layout = require("telescope.pickers.layout")
local NoiceViewOptions = require("noice").NoiceViewOptions
--
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

local function get_config(height)
	return {
		view = "popup",
		enter = false,
		focusable = false,
		opts = {
			relative = "editor",
			zindex = 65,
			position = {
				row = vim.o.lines - height + 1, -- Positioning at the bottom, 12 lines tall, so start 13 lines from the bottom
				col = 0,
			},
			size = {
				width = vim.o.columns, -- Full width of the terminal
				height = height, -- 12 lines tall
			},
			win_options = {
				winbar = "",
				foldenable = false,
				cursorline = false,
				winhighlight = "Normal:GruvboxBg0,FloatBorder:FzfLuaBorder",
			},
			border = {
				style = {
					top_left = "",
					top = "─",
					top_right = "",
					left = "",
					right = "",
					bottom_left = "",
					bottom = "",
					bottom_right = "",
				},
			},
		},
	}
end

return {
	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		config = function(_, opts) end,
	},

	{
		"luisiacc/gruvbox-baby",
	},

	{ "NTBBloodbath/sweetie.nvim" },

	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({})
		end,
	},

	{
		"RRethy/base16-nvim",
	},

	{ "echasnovski/mini.base16", version = false },

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},

	-- change some telescope options and a keymap to browse plugin files
	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"css",
				"svelte",
				"typescript",
				"tsx",
				"markdown",
				"markdown_inline",
				"python",
				"lua",
				"vim",
				"query",
				"regex",
				"yaml",
				"json",
			},
		},
	},

	-- use mini.starter instead of alpha
	{ import = "lazyvim.plugins.extras.ui.mini-starter" },

	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},

	{
		"stevearc/oil.nvim",
		opts = {
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			keymaps = {
				["gd"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({
								"icon",
								"permissions",
								"size",
								"mtime",
							})
						else
							require("oil").set_columns({
								"icon",
							})
						end
					end,
				},
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"lmburns/lf.nvim",
		dependencies = {
			"akinsho/toggleterm.nvim",
		},
		opts = {
			escape_quit = false,
			border = "rounded",
		},
	},

	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
		opts = {
			widget_guides = { enabled = true },
		},
	},
	{ "anuvyklack/pretty-fold.nvim" },
	{ "vinnymeller/swagger-preview.nvim" },

	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",

			-- { "3rd/image.nvim", opts = { backend = "kitty" } },
		},
		opts = {
			-- configuration goes here
			image_support = false,
		},
	},
	{
		"edolphin-ydf/goimpl.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	},

	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
		opts = {
			rocks = { "magick" }, -- specifies a list of rocks to install
			-- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
		},
	},
	{
		"gbprod/nord.nvim",
	},
	-- {
	-- 	"nvim-java/nvim-java",
	-- 	-- config = false,
	-- 	dependencies = {
	-- 		{
	-- 			"neovim/nvim-lspconfig",
	-- 			opts = {
	-- 				servers = {
	-- 					jdtls = {
	-- 						initializationOptions = {
	-- 							bundles = {
	-- 								"~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.0.jar",
	-- 							},
	-- 						},
	-- 						-- your jdtls configuration goes here
	-- 					},
	-- 				},
	-- 				setup = {
	-- 					jdtls = function()
	-- 						require("java").setup({
	-- 							-- your nvim-java configuration goes here
	-- 						})
	-- 					end,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },

	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<F1>", require("dap").continue, desc = "Find Plugin File" },
			{ "<F2>", require("dap").step_into, desc = "Find Plugin File" },
			{ "<F3>", require("dap").step_over, desc = "Find Plugin File" },
			{ "<F4>", require("dap").step_out, desc = "Find Plugin File" },
			{ "<F5>", require("dap").step_back, desc = "Find Plugin File" },
			{ "<F12>", require("dap").restart, desc = "Find Plugin File" },
		},
	},

	{
		"leoluz/nvim-dap-go",
		opts = {

			dap_configurations = {
				{
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
		},
	},

	-- {
	--   "mfussenegger/nvim-dap",
	--   dependencies = {
	--     "rcarriga/nvim-dap-ui",
	--     "mxsdev/nvim-dap-vscode-js",
	--     -- build debugger from source
	--     {
	--       "microsoft/vscode-js-debug",
	--       version = "1.x",
	--       build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
	--     },
	--   },
	--   config = function()
	--     require("dap-vscode-js").setup({
	--       debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
	--       adapters = { "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" },
	--     })
	--
	--     require("dap").adapters.firefox = {
	--       type = "executable",
	--       command = "node",
	--       args = {
	--         vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
	--       },
	--     }
	--     -- for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
	--     require("dap").configurations.javascript = {
	--       {
	--         type = "pwa-node",
	--         request = "attach",
	--         processId = require("dap.utils").pick_process,
	--         name = "Attach debugger to existing `node --inspect` process",
	--         sourceMaps = true,
	--         resolveSourceMapLocations = {
	--           "${workspaceFolder}/**",
	--           "!**/node_modules/**",
	--         },
	--         cwd = "${workspaceFolder}/src",
	--         skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
	--       },
	--       -- {
	--       --   name = "Debug with Firefox",
	--       --   type = "firefox",
	--       --   request = "launch",
	--       --   sourceMaps = true,
	--       --   reAttach = true,
	--       --   url = "http://localhost:5173",
	--       --   webRoot = "${workspaceFolder}",
	--       --   firefoxExecutable = "/usr/bin/firefox",
	--       -- },
	--       -- {
	--       --   type = "pwa-chrome",
	--       --   name = "Launch Chrome to debug client",
	--       --   request = "launch",
	--       --   url = "http://localhost:5173",
	--       --   sourceMaps = true,
	--       --   protocol = "inspector",
	--       --   port = 9222,
	--       --   webRoot = "${workspaceFolder}/src",
	--       --   skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
	--       -- },
	--       -- {
	--       --   -- use nvim-dap-vscode-js's pwa-node debug adapter
	--       --   type = "pwa-node",
	--       --   -- launch a new process to attach the debugger to
	--       --   request = "launch",
	--       --   -- name of the debug action you have to select for this config
	--       --   name = "Launch file in new node process",
	--       --   -- launch current file
	--       --   program = "${file}",
	--       --   cwd = "${workspaceFolder}",
	--       -- },
	--     }
	--     -- end
	--   end,
	-- },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				winopts = {
					split = "belowright new",
					height = 12,
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		-- enabled = false,
	},
	{
		"foke/noice.nvim",
		-- enabled = false,
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},

				---@type NoiceViewOptions
				hover = { view = "cmdline_output" },
				signature = { view = "cmdline_output" },
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			-- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
			-- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
			local banned_messages = { "No information available" }
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end
		end,
	},
	{
		"gleam-lang/gleam.vim",
		config = function()
			require("lspconfig").gleam.setup({})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				winopts = {
					split = "vsplit tabnew",
					border = "none",
					preview = {
						border = "noborder",
						vertical = "down:70%",
						horizontal = "down:70%",
					},
				},
			})
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
	},
	{
		"stevearc/bufferline.nvim",
		enabled = false,
	},
	{
		"stevearc/conform.nvim",
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
			},
		},
	},
	{ "kiran94/maim.nvim", config = true, cmd = { "Maim", "MaimMarkdown" } },
	{
		"rktjmp/lush.nvim",
	},
	{
		"cranberry-clockworks/coal.nvim",
	},
}
