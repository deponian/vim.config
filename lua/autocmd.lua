local autocmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
  fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Restore your cursor shape after exiting neovim
-- if you don't use standard block shape cursor
augroup("CursorShape", function(group)
  autocmd("VimLeave", {
    group = group,
    pattern = "*",
    command = [[set guicursor=a:ver25-blinkon1000-blinkoff1000]]
  })
end)

-- Go to last loc when opening a buffer
augroup("LastLocation", function(group)
  autocmd("BufReadPost", {
    group = group,
    pattern = "*",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })
end)

-- Resize splits if window got resized
augroup("ResizeWindows", function(group)
  autocmd("VimResized", {
    group = group,
    pattern = "*",
    command = "tabdo wincmd ="
    })
end)

-- Highlight current line only on focused window
augroup("ActiveWinCursorLine", function(g)
  autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
    group = g,
    pattern = "*",
    command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif"
  })
  autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
    group = g,
    pattern = "*",
    command = "if &cursorline && ! &pvw | setlocal nocursorline | endif"
  })
end)

-- Auto create dir when saving a file, in case some intermediate directory does not exist
augroup("AutoCreateDir", function(group)
  autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    })
end)

-- Open nvim-tree at the start
augroup("AutoOpenNvimTree", function(group)
  autocmd("VimEnter", {
    group = group,
    pattern = "*",
    callback = function(data)
      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1

      if not no_name and not directory then
        return
      end

      -- change to the directory
      if directory then
        vim.cmd.cd(data.file)
      end

      -- open the tree
      require("nvim-tree.api").tree.open()
    end,
  })
end)

-- Copy all plugins from lazy directory and
-- clean up unnecessary files
augroup("CopyPlugins", function(group)
  autocmd("User", {
    group = group,
    pattern = { "LazyInstall", "LazyUpdate", "LazySync" },
    callback = function()
      local plugins_data_path = vim.fn.stdpath("data") .. "/lazy"
      local plugins_local_path = vim.fn.stdpath("config") .. "/.plugins"

      -- genetate help tags for all plugins
      local plugins = vim.fn.systemlist({
        "fd", "--hidden", "--no-ignore",
        "-td", "-d1", ".",
        plugins_data_path,
        "-x", "echo", "{/}"
      })
      for _, plugin in pairs(plugins) do
        if not plugin == "gitsigns.nvim" then
          vim.cmd("helptags " .. plugins_data_path .. "/" .. plugin)
        end
      end

      -- copy all plugins to repository
      vim.fn.system({
        "rsync", "--quiet", "--delete", "-r",
        plugins_data_path .. "/",
        plugins_local_path
      })

      -- clean up unnecessary files
      local items = {
        [".git"] = "d",
        [".github"] = "d",
        ["scripts"] = "d",
        ["tests"] = "d",
        ["test"] = "d",
        ["etc"] = "d",
        ["README.md"] = "f",
        [".gitignore"] = "f",
        ["Makefile"] = "f",
        [".luacheckrc"] = "f",
        [".stylua.toml"] = "f",
        [".editorconfig"] = "f",
        ["stylua.toml"] = "f",
        ["CONTRIBUTING.md"] = "f",
        ["CONTRIBUTING.markdown"] = "f",
        ["README.markdown"] = "f",
        ["CHANGELOG.md"] = "f",
        ["selene.toml"] = "f",
        [".styluaignore"] = "f",
      }
      for pattern, type in pairs(items) do
        vim.fn.system({
          "fd", "--hidden", "--no-ignore",
          "-t" .. type,
          "^" .. pattern .. "$",
          plugins_local_path,
          "-x", "rm", "-rf", "{}" })
      end
    end,
  })
end)
