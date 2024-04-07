return {
  {
    "echasnovski/mini.move",
    keys = {
      -- { "<M-k>", mode = "n", desc = "Move line up" },
      -- { "<M-j>", mode = "n", desc = "Move line down" },
      { "<M-k>", mode = "x", desc = "Move selection up" },
      { "<M-j>", mode = "x", desc = "Move selection down" }
    },
    opts = {
      mappings = {
        down = "<M-j>",
        up = "<M-k>",
        left = '',
        right = '',
        line_down = "<M-j>",
        line_up = "<M-k>",
        line_left = '',
        line_right = ''
      }
    }
  }
}

