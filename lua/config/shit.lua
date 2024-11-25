-- local Popup = require("nui.popup")
-- local Layout = require("nui.layout")
-- local Split = require("nui.layout.split")
--
-- -- vim.highlight
-- vim.cmd([[hi Body guibg=#1D2021]])
--
-- local function window_factory(p)
--   type = type or "Normal"
--   local popup = Popup({
--     enter = p,
--     border = {
--       style = "none",
--     },
--   })
--   return popup
-- end
--
-- local popup_one = window_factory(false)
-- -- local popup_two = window_factory(false)
--
-- local Split = require("nui.split")
--
-- local split = Split({
--   relative = "editor",
--   position = "bottom",
--   size = "100%",
-- })
--
-- local layout = Layout(
--   split,
--   Layout.Box({
--     Layout.Box(popup_one, { size = "100%" }),
--   })
-- )
--
-- layout:mount()

local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}
dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
