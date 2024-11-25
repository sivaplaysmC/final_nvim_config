return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},

	opts = {
		ui = {
			bullets = { char = "-", hl_group = "ObsidianBullet" },
		},

		note_id_func = function(title)
			return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() .. os.date("_%d-%m-%Y_%H-%M-%S")
		end,

		preferred_link_style = "markdown",

		-- wiki_link_func = "use_alias_only",
		--
		workspaces = {
			{
				name = "niggers-and-biggers",
				path = "~/life/life/",
			},
			{
				name = "project-pechacks",
				path = "/home/sivaplays/repos/pechax-documentation/",
			},
			{
				name = "muj",
				path = "~/vaults/muj/",
			},
			{
				name = "personal",
				path = "~/vaults/sivaplays/",
			},
			{
				name = "SEM3",
				path = "~/vaults/SEM3/",
			},

			{
				name = "DLM",
				path = "~/vaults/Digital Logic And Microprocessors/",
			},
			{
				name = "zettelkasten",
				path = "~/vaults/zettlekasten/",
			},
		},
	},
}
