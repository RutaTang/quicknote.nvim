local async = require("plenary.async")
local path = require("plenary.path")
local utils = require("quicknote.utils")
local sign = require("quicknote.core.sign")
local open = require("quicknote.core.open")

-- Export
local M = {}

-- create a new note for the global
local NewNoteAtGlobalAsync = function()
    -- get file name for the user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPtha = utils.path.getNoteDirPathForGlobal()

    -- create note dir (if not exist)
    utils.fs.MKDirAsync(noteDirPtha)

    -- create note file
    local noteFilePath = path:new(noteDirPtha, fileName .. "." .. utils.config.GetFileType()).filename
    utils.fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtGlobal = function()
    if utils.config.GetMode() ~= "resident" then
        print("Create note globally just works in resident mode")
        return
    end
    async.run(NewNoteAtGlobalAsync, function() end)
end

-- Create a new note for the current working directory (CWD)
local NewNoteAtCWDAsync = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCWD()

    -- create note dir (if not exist)
    utils.fs.MKDirAsync(noteDirPath)

    -- create note files (if not exist)
    local noteFilePath = path:new(noteDirPath, fileName .. "." .. utils.config.GetFileType()).filename
    utils.fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtCWD = function()
    async.run(NewNoteAtCWDAsync, function() end)
end

-- Create a new note at a given line for the current buffer
-- @param line: line number
local NewNoteAtLineAsync = function(line)
    if line == nil or line <= 0 then
        print("line number should be given and bigger than 0")
        return
    end
    -- get note file path
    local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()

    -- create note dir (if not exist)
    utils.fs.MKDirAsync(noteDirPath)

    -- create note file (if not exist)
    local noteFilePath = path:new(noteDirPath, line .. "." .. utils.config.GetFileType()).filename
    utils.fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtLine = function(line)
    async.run(function()
        NewNoteAtLineAsync(line)
    end, function()
        -- if the show sign is enabled, show the sign
        vim.defer_fn(sign.ReShowSignsForCurrentBuffer, 0)
    end)
end

-- Create a new note at current cursor line for current buffer
local NewNoteAtCurrentLineAsync = function()
    -- get current cursor line
    local line = vim.api.nvim_win_get_cursor(0)[1]
    NewNoteAtLineAsync(line)
end
M.NewNoteAtCurrentLine = function()
    async.run(NewNoteAtCurrentLineAsync, function()
        -- if the show sign is enabled, show the sign
        vim.defer_fn(sign.ReShowSignsForCurrentBuffer, 0)
        vim.defer_fn(open.OpenNoteAtCurrentLine, 0)
    end)
end

return M
