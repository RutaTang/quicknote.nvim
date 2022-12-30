local async = require("plenary.async")
local path = require("plenary.path")
local utils_fs = require("quicknote.utils.fs")


local newNoteAtCurrentLine = function()
    -- get current
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- get current buffer file path
    local currentBufferPath = vim.api.nvim_buf_get_name(0)
    -- form note dir path for current buffer
    local noteDirPath = utils_fs.GetDataPath .. "/" .. "[" .. currentBufferPath .. "]" .. ".quicknote"

    -- create note dir
    utils_fs.MKDir(noteDirPath)
end

-- Export
local M = {}

M.NewNoteAtCurrentLine = newNoteAtCurrentLine

return M
