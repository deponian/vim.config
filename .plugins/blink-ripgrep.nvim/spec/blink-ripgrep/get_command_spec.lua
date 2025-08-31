local assert = require("luassert")
local stub = require("luassert.stub")
local blink_ripgrep = require("blink-ripgrep")
local RipgrepCommand = require("blink-ripgrep.backends.ripgrep.ripgrep_command")

describe("get_command", function()
  local snapshot
  stub(vim, "cmd")

  local default_config = vim.tbl_deep_extend("error", {}, blink_ripgrep.config)

  before_each(function()
    blink_ripgrep.config = default_config
    snapshot = assert:snapshot()

    -- notify_once is used to alert the user that the config needs to be
    -- migrated manually. It logs to the console in the tests, which is not
    -- useful, so we stub it out.
    stub(vim, "notify_once")
  end)

  after_each(function()
    snapshot:revert()
  end)

  it("allows passing additional_rg_options", function()
    local plugin = blink_ripgrep.new({
      backend = {
        ripgrep = {
          additional_rg_options = { "--foo", "--bar" },
        },
      },
    })
    ---@diagnostic disable-next-line: missing-fields
    local cmd = RipgrepCommand.get_command("hello", plugin.config)
    assert(cmd)

    -- don't compare the last item (the directory) as that changes depending on
    -- the test environment (such as individual developers' machines or ci)
    table.remove(cmd.command)
    assert.are_same(cmd.command, {
      "rg",
      "--no-config",
      "--json",
      "--word-regexp",
      "--max-filesize=1M",
      "--ignore-case",
      "--foo",
      "--bar",
      "--",
      "hello[\\w_-]+",
    })
  end)

  it("allows configuring the context size", function()
    local plugin = blink_ripgrep.new({ context_size = 9 })
    ---@diagnostic disable-next-line: missing-fields
    local cmd = RipgrepCommand.get_command("hello", plugin.config)
    assert(cmd)

    table.remove(cmd.command)
    assert.are_same(cmd.command, {
      "rg",
      "--no-config",
      "--json",
      "--word-regexp",
      "--max-filesize=1M",
      "--ignore-case",
      "--",
      "hello[\\w_-]+",
    })
  end)

  it("allows configuring the max_filesize", function()
    local plugin = blink_ripgrep.new({
      backend = {
        ripgrep = { max_filesize = "2M" },
      },
    })
    ---@diagnostic disable-next-line: missing-fields
    local cmd = RipgrepCommand.get_command("hello", plugin.config)
    assert(cmd)

    table.remove(cmd.command)
    assert.are_same(cmd.command, {
      "rg",
      "--no-config",
      "--json",
      "--word-regexp",
      "--max-filesize=2M",
      "--ignore-case",
      "--",
      "hello[\\w_-]+",
    })
  end)

  it("allows configuring the casing", function()
    local plugin = blink_ripgrep.new({
      backend = {
        ripgrep = {
          search_casing = "--smart-case",
        },
      },
    })
    ---@diagnostic disable-next-line: missing-fields
    local cmd = RipgrepCommand.get_command("hello", plugin.config)
    assert(cmd)

    table.remove(cmd.command)
    assert.are_same(cmd.command, {
      "rg",
      "--no-config",
      "--json",
      "--word-regexp",
      "--max-filesize=1M",
      "--smart-case",
      "--",
      "hello[\\w_-]+",
    })
  end)

  it(
    "allows disabling completion when project_root_fallback is disabled",
    function()
      local plugin = blink_ripgrep.new({
        project_root_fallback = false,
        project_root_marker = { ".notfound" },
      })
      ---@diagnostic disable-next-line: missing-fields
      local cmd, error_message =
        RipgrepCommand.get_command("hello", plugin.config)
      assert.are_same(cmd, nil)
      assert.are_same(
        error_message,
        "Could not find project root, and project_root_fallback is disabled."
      )
    end
  )
end)
