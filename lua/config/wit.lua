-- -- Create three scratch buffers for the floating windows (top, middle, and bottom)
-- local top_buf = vim.api.nvim_create_buf(false, true)
-- local middle_buf = vim.api.nvim_create_buf(false, true)
-- local bottom_buf = vim.api.nvim_create_buf(false, true)
--
-- -- Get the editor's dimensions
-- local total_width = vim.o.columns
-- local total_height = vim.o.lines
--
-- -- Define border size (1 for each side, top + bottom = 2)
-- local border_size = 0
--
-- -- Define window heights, accounting for borders
-- local bottom_height = 12 -- Bottom window is 12 lines in height
-- local middle_height = 1 -- Middle window is 1 line tall
-- local top_height = total_height - bottom_height - middle_height - 2 * border_size -- Top window takes remaining space
--
-- -- Open the top floating window
-- local top_winid = vim.api.nvim_open_win(top_buf, true, {
--   relative = "editor",
--   row = 0, -- Start at the top row
--   col = 0, -- Start at the first column
--   width = total_width - border_size, -- Full width minus borders
--   height = top_height - border_size, -- Height minus borders
--   style = "minimal",
--   border = "none", -- Border style for the top window
-- })
--
-- -- Open the middle floating window (1 line tall)
-- local middle_winid = vim.api.nvim_open_win(middle_buf, true, {
--   relative = "editor",
--   row = top_height, -- Start the middle window right after the top window
--   col = 0,
--   width = total_width - border_size, -- Full width minus borders
--   height = middle_height, -- Middle window is 1 line tall, no borders
--   style = "minimal",
--   border = "none", -- No border for the middle window
-- })
--
-- -- Open the bottom floating window
-- local bottom_winid = vim.api.nvim_open_win(bottom_buf, true, {
--   relative = "editor",
--   row = top_height + middle_height, -- Start the bottom window right after the middle window
--   col = 0,
--   width = total_width - border_size, -- Full width minus borders
--   height = bottom_height - border_size, -- Height minus borders
--   style = "minimal",
--   border = "none", -- Border style for the bottom window
-- })
--
-- -- Keymap to close all three windows with <M-k> (Alt+k)
-- vim.keymap.set("", "<M-k>", function()
--   vim.api.nvim_win_close(top_winid, true)
--   vim.api.nvim_win_close(middle_winid, true)
--   vim.api.nvim_win_close(bottom_winid, true)
-- end, { noremap = true, silent = true })

local Layout = require("telescope.pickers.layout")

require("telescope").setup({
  create_layout = function(picker)
    local function create_window(enter, width, height, row, col, title)
      local bufnr = vim.api.nvim_create_buf(false, true)
      local winid = vim.api.nvim_open_win(bufnr, enter, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        title = title,
      })

      vim.wo[winid].winhighlight = "Normal:Normal"

      return Layout.Window({
        bufnr = bufnr,
        winid = winid,
      })
    end

    local function destroy_window(window)
      if window then
        if vim.api.nvim_win_is_valid(window.winid) then
          vim.api.nvim_win_close(window.winid, true)
        end
        if vim.api.nvim_buf_is_valid(window.bufnr) then
          vim.api.nvim_buf_delete(window.bufnr, { force = true })
        end
      end
    end

    -- Calculate layout dimensions
    local total_height = vim.o.lines
    local total_width = vim.o.columns

    local bottom_height = 12 -- Results window is 12 lines tall
    local middle_height = 1 -- Prompt window is 1 line tall
    local top_height = total_height - bottom_height - middle_height -- Preview window takes remaining height

    local layout = Layout({
      picker = picker,
      mount = function(self)
        vim.notify("sdfsadf")
        -- Create preview window (top)
        self.preview = create_window(false, total_width, top_height, 0, 0, "Preview")

        -- Create prompt window (middle)
        self.prompt = create_window(true, total_width, middle_height, top_height, 0, "Prompt")

        -- Create results window (bottom)
        self.results = create_window(false, total_width, bottom_height, top_height + middle_height, 0, "Results")
      end,
      unmount = function(self)
        destroy_window(self.results)
        destroy_window(self.preview)
        destroy_window(self.prompt)
      end,
      update = function(self) end,
    })

    return layout
  end,
})
