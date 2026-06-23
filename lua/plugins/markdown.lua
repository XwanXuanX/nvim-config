return {
  -- Treesitter Markdown support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
      })
    end,
  },

  -- Mason: ensure the Markdown-related language servers are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        "marksman",
        "ltex-ls",
      })
    end,
  },

  -- LSP: Marksman + LTeX
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      local util = require("lspconfig.util")

      local function read_spell_words()
        local words = {}
        local spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

        local file = io.open(spellfile, "r")
        if file then
          for word in file:lines() do
            if word ~= "" and not word:match("^%s*$") then
              table.insert(words, word)
            end
          end
          file:close()
        end

        return words
      end

      -- Marksman gives Markdown LSP features:
      -- links, document symbols, go-to-definition, references, etc.
      opts.servers.marksman = {
        filetypes = { "markdown" },
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)

          if fname == "" then
            on_dir(vim.fn.getcwd())
            return
          end

          local root = util.root_pattern(".marksman.toml", ".git")(fname)
          on_dir(root or vim.fs.dirname(fname))
        end,
        single_file_support = true,
      }

      -- LTeX gives grammar/style diagnostics through LanguageTool.
      -- The article feeds Vim spellfile words into ltex.dictionary.
      opts.servers.ltex = {
        filetypes = { "markdown", "text" },
        settings = {
          ltex = {
            language = "en-US",
            enabled = { "markdown", "text" },
            dictionary = {
              ["en-US"] = read_spell_words(),
            },
          },
        },
      }
    end,
  },

  -- LuaSnip for article-style Markdown snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      -- Keep LazyVim/friendly-snippets behavior.
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load the article-style SnipMate snippets from ~/.config/nvim/snippets/*.snippets
      require("luasnip.loaders.from_snipmate").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })
    end,
  },

  -- Tell LazyVim's default completion engine, blink.cmp, to use LuaSnip.
  -- Current LazyVim uses blink.cmp by default, not nvim-cmp.
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      snippets = {
        preset = "luasnip",
      },
    },
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
}
