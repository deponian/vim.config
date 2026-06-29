-- Conflict resolution actions for merge tool
-- Handles accept current/incoming/both/none actions
local M = {}

-- Import submodules
local tracking = require("codediff.ui.conflict.tracking")
local signs = require("codediff.ui.conflict.signs")
local actions = require("codediff.ui.conflict.actions")
local diffget = require("codediff.ui.conflict.diffget")
local navigation = require("codediff.ui.conflict.navigation")
local keymaps = require("codediff.ui.conflict.keymaps")

-- Delegate to tracking module
M.run_repeatable_action = tracking.run_repeatable_action
M.initialize_tracking = tracking.initialize_tracking

-- Delegate to signs module
M.refresh_all_conflict_signs = signs.refresh_all_conflict_signs
M.setup_sign_refresh_autocmd = signs.setup_sign_refresh_autocmd

-- Delegate to actions module
M.accept_incoming = actions.accept_incoming
M.accept_current = actions.accept_current
M.accept_both = actions.accept_both
M.discard = actions.discard
M.accept_all_incoming = actions.accept_all_incoming
M.accept_all_current = actions.accept_all_current
M.accept_all_both = actions.accept_all_both
M.discard_all = actions.discard_all

-- Delegate to diffget module
M.diffget_incoming = diffget.diffget_incoming
M.diffget_current = diffget.diffget_current

-- Delegate to navigation module
M.navigate_next_conflict = navigation.navigate_next_conflict
M.navigate_prev_conflict = navigation.navigate_prev_conflict

-- Delegate to keymaps module
M.setup_keymaps = keymaps.setup_keymaps

return M
