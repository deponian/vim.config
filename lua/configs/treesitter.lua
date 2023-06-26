local M = { "nvim-treesitter/nvim-treesitter" }

M.config = function()
  require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
      "awk", "bash", "comment",
      "css", "diff", "dockerfile", "embedded_template",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      "go", "gomod", "gosum", "gowork", "hcl",
      "html", "htmldjango", "http", "ini", "javascript",
      "jq", "jsdoc", "json", "json5", "jsonc",
      "jsonnet", "lua", "luadoc", "luap", "make",
      "markdown", "markdown_inline", "ninja", "passwd",
      "phpdoc", "proto", "python", "query",
      "regex", "rst", "ruby",
      "sxhkdrc", "teal", "terraform", "toml",
      "vim", "vimdoc", "vue", "yaml",
    },
    -- List of parsers to ignore installing
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 25 * 1024 -- 25 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
      end,
    },
  })

  -- custom highlighting for yaml filetype
  vim.api.nvim_set_hl(0, "@field.yaml", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "@number.yaml", { link = "Function" })
  vim.api.nvim_set_hl(0, "@boolean.yaml", { link = "Conditional" })

  -- custom highlighting for gitcommit filetype
  vim.api.nvim_set_hl(0, "@text.uri.gitcommit", { link = "Constant" })

  -- custom highlighting for url inside text
  vim.api.nvim_set_hl(0, "@text.uri", { link = "Constant" })
end

return M
