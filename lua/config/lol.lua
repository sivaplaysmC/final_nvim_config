local opt = {
	colors = {
		primary = "#d70000",
		string = "#fff",
	},
}
require("noirbuddy").setup(opt)
-- Require colorbuddy...
local colorbuddy = require("colorbuddy")

-- And then modify as you like
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local groups = colorbuddy.groups
local styles = colorbuddy.styles

-- Override specific highlight groups...
Group.new("TelescopeTitle", colors.primary)
Group.new("TelescopeBorder", colors.secondary)
Group.new("CursorLineNr", colors.primary, colors.noir_9)
Group.new("Searchlight", nil, colors.secondary)
Group.new("@string", colors.noir_7)
Group.new("@punctuation", colors.noir_2)

-- Add font styles to highlight groups...
Group.new("@constant", colors.noir_2, nil, styles.bold)
Group.new("@method", colors.noir_0, nil, styles.bold + styles.italic)

-- Link highlight groups...
Group.link("SignifySignAdd", groups.DiffAdd)
Group.link("SignifySignChange", groups.DiffChange)
Group.link("SignifySignDelete", groups.DiffDelete)

Group.new("@string", colors.string, colors.background, styles.italic)
Group.new("luaFunctionCall", groups.Function, groups.Function, groups.Function)

-- etc.
