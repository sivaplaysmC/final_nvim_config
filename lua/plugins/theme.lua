---@diagnostic disable: need-check-nil, undefined-field, unused-local
---@type LazySpec
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				vim.cmd([[colors lackluster]])
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		---@type CatppuccinOptions
		opts = {
			no_italic = false,
			term_colors = true,
			transparent_background = false,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = { "bold" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
			},
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#111111",
					crust = "#161616",
				},
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
			custom_highlights = function(colors)
				return {
					CursorLine = { bg = colors.crust },
				}
			end,
		},
	},
	{
		"slugbyte/lackluster.nvim",
		opts = {

			tweak_higlights = {
				Visual = {
					overwrite = true,
					guibg = "#555555",
					guifg = "#ffffff",
				},
			},
		},
	},
}
