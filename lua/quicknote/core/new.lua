local async = require("plenary.async")
local path = require("plenary.path")
local utils_fs = require("quicknote.utils.fs")
local sha = require("quicknote.utils.sha")

-- Export
local M = {}

local NewNoteAtCurrentLineAsync = function()
    -- get current
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- get current buffer file path
    local currentBufferPath = vim.api.nvim_buf_get_name(0)

    -- get note dir path
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = sha.sha1(currentBufferPath) -- hash current buffer path
    local noteDirPath = path:new(dataPath, noteDirName).filename

    -- create note dir
    utils_fs.MKDirAsync(noteDirPath)

    -- create note file (if not exist)
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename
    utils_fs.CreateFileAsync(noteFilePath)

    return noteFilePath
end
M.NewNoteAtCurrentLine = function()
    async.run(NewNoteAtCurrentLineAsync, function() end)
end




return M
