-- Define sign for quicknote
vim.fn.sign_define("QuickNote", {text = "N", texthl = "QuickNote", linehl = "", numhl = ""})

local M = {}
-- Show note sign 
function M.ShowNoteSign()
end

-- Hide note sign
function M.HideNoteSign()
end

-- Toggle note sign
function M.ToggleNoteSign()
end

return M
