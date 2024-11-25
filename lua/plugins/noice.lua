return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      local newOpts = {
        view = "cmdline",
      }
      if opts.cmdline ~= nil then
        newOpts = vim.tbl_extend("force", opts.cmdline, newOpts)
        vim.notify(vim.inspect(newOpts))
        opts.cmdline = newOpts
      else
        opts.cmdline = newOpts
      end
    end,
  },
}
