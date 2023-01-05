local path = require("plenary.path")
local utils_path = require("quicknote.utils.path")

local M = {}

-- check if note file exist, if exists, open it
local checkAndOpenNoteFile = function(noteFilePath)
    vim.loop.fs_stat(noteFilePath, function(err, _)
        if err then
            print("Note not found.")
        else
            -- open note file
            -- use vim.defer_fn to avoid "can not call nvim exec in vim loop event"
            vim.defer_fn(function()
                vim.cmd("split " .. noteFilePath)
            end, 0)
        end
    end)
end

-- Open an already existed note at a given line for the current buffer
-- @param line: line number
local OpenNoteAtLine = function(line)
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()
    -- get note file path
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename
    -- check if note file exist
    checkAndOpenNoteFile(noteFilePath)
end
M.OpenNoteAtLine = OpenNoteAtLine

-- Open an already existed note at current cursor line for current buffer
local OpenNoteAtCurrentLine = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    OpenNoteAtLine(line)
end
M.OpenNoteAtCurrentLine = OpenNoteAtCurrentLine

-- Open an already existed note at global
local OpenNoteAtGlobal = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForGlobal()

    -- get note file path
    local noteFilePath = path:new(noteDirPath, fileName .. ".md").filename

    -- check if note file exist
    checkAndOpenNoteFile(noteFilePath)
end
M.OpenNoteAtGlobal = OpenNoteAtGlobal

-- Open an already existed note at CWD
local OpenNoteAtCWD = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCWD()

    -- get note file path
    local noteFilePath = path:new(noteDirPath, fileName .. ".md").filename

    -- check if note file exist
    checkAndOpenNoteFile(noteFilePath)
end
M.OpenNoteAtCWD = OpenNoteAtCWD

return M
