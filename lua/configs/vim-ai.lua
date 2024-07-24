local M = { "madox2/vim-ai" }

M.config = function()
  local initial_prompt = {
    ">>> system",
    "",
    "You are going to play a role of a completion engine with following parameters:",
    "Task: Provide compact code/text completion, generation, transformation or explanation",
    "Topic: general programming and text editing",
    "Style: Plain result without any commentary, unless commentary is necessary",
    "Audience: Users of text editor and programmers that need to transform/generate text"
  }

  local chat_engine_config = {
    engine = "chat",
    options = {
      model = "gpt-4o",
      endpoint_url = "https://api.openai.com/v1/chat/completions",
      max_tokens = 0,
      temperature = 0.1,
      request_timeout = 20,
      selection_boundary = "",
      initial_prompt = initial_prompt
    }
  }

  vim.g.vim_ai_complete = chat_engine_config
  vim.g.vim_ai_edit = chat_engine_config

  -- This prompt instructs model to work with syntax highlighting
  local initial_chat_prompt = {
    ">>> system",
    "",
    "You are a general assistant.",
    "If you attach a code block add syntax type after ``` to enable syntax highlighting."
  }

  vim.g.vim_ai_chat = {
    options = {
      model = "gpt-4o",
      endpoint_url = "https://api.openai.com/v1/chat/completions",
      max_tokens = 0,
      temperature = 0.1,
      request_timeout = 20,
      selection_boundary = "",
      initial_prompt = initial_chat_prompt,
    },
    ui = {
      code_syntax_enabled = 1,
      populate_options = 0,
      open_chat_command = "preset_below",
      scratch_buffer_keep_open = 0,
      paste_mode = 1,
    }
  }
end

M.keys = {
  -- <Leader>a -- ChatGPT integration

  -- (mnemonic: [a]rtificial intelligence)
  { "<Leader>a", ":AI<Space>" },
  { "<Leader>a", ":AIEdit<Space>", mode = "x" },
}

return M
