return {
  "nvim-cmp",
  keys = {
    { "<Tab>", false },
    { "<S-Tab>", false },
  },
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
    local ls = require("luasnip")
    local cmp = require("cmp")
    opts.snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end,
    }
    local mapping = {
      ["<C-n>"] = {
        i = cmp.mapping.select_next_item({ behavior = require("cmp.types").cmp.SelectBehavior.Insert }),
      },
      ["<C-p>"] = {
        i = cmp.mapping.select_prev_item({ behavior = require("cmp.types").cmp.SelectBehavior.Insert }),
      },

      ["<C-Space>"] = cmp.mapping.complete(),

      ["<C-e>"] = {
        i = cmp.mapping.abort(),
      },
      ["<C-j>"] = cmp.mapping(function(_)
        _ = ls.locally_jumpable() and ls.jump(1)
      end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function(_)
        _ = ls.locally_jumpable() and ls.jump(-1)
      end, { "i", "s" }),

      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { "i", "c" }
      ),
      ["<S-Tab>"] = cmp.mapping(function() end),
    }
    table.insert(opts.sources, { name = "luasnip" })
    opts.mapping = mapping
    local exp = { ghost_text = true }

    opts.experimental = vim.tbl_extend("force", opts.experimental, exp)
  end,
}
