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
    model = "gpt-3.5-turbo",
    max_tokens = 1000,
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

-- :AIChat
-- - options: openai config (see https://platform.openai.com/docs/api-reference/chat)
-- - options.initial_prompt: prompt prepended to every chat request
-- - options.request_timeout: request timeout in seconds
-- - options.selection_boundary: seleciton prompt wrapper
-- - ui.populate_options: put [chat-options] to the chat header
-- - ui.open_chat_command: preset (preset_below, preset_tab, preset_right) or a custom command
-- - ui.scratch_buffer_keep_open: re-use scratch buffer within the vim session
-- - ui.paste_mode: use paste mode (see more info in the Notes below)
vim.g.vim_ai_chat = {
  options = {
    model = "gpt-3.5-turbo",
    max_tokens = 1000,
    temperature = 1,
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

-- Notes:
-- ui.paste_mode
-- - if disabled code indentation will work but AI doesn't always respond with a code block
--   therefore it could be messed up
-- - find out more in vim's help `:help paste`
