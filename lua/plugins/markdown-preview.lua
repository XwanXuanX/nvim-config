return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreview<cr>",
        ft = "markdown",
        desc = "Markdown Preview",
      },
      {
        "<leader>ms",
        "<cmd>MarkdownPreviewStop<cr>",
        ft = "markdown",
        desc = "Markdown Preview Stop",
      },
      {
        "<leader>mt",
        "<cmd>MarkdownPreviewToggle<cr>",
        ft = "markdown",
        desc = "Markdown Preview Toggle",
      },
    },
  },
}
