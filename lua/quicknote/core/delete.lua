local path = require("plenary.path")
local utils_path = require("quicknote.utils.path")

-- check if note file exist, if exists, delete it
local checkAndDeleteNoteFile = function(noteFilePath)
    vim.loop.fs_stat(noteFilePath, function(err, _)
        if err then
            print("Note not found.")
        else
            -- delete note file
            local success, err = os.remove(noteFilePath)
            if success then
                print("Note deleted.")
            else
                print("Note delete failed: " .. err)
            end
        end
    end)
end

local M = {}
-- Delete an already existed note at a given line for the current buffer
-- @param line: line number
local DeleteNoteAtLine = function(line)
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()
    -- get note file path
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename

    -- check if note file exist
    checkAndDeleteNoteFile(noteFilePath)
end
M.DeleteNoteAtLine = DeleteNoteAtLine

-- Delete an already existed note at current cursor line for current buffer
local DeleteNoteAtCurrentLine = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    DeleteNoteAtLine(line)
end
M.DeleteNoteAtCurrentLine = DeleteNoteAtCurrentLine

-- Delete an already existed note at global
local DeleteNoteAtGlobal = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForGlobal()

    -- get note file path
    local noteFilePath = path:new(noteDirPath, fileName .. ".md").filename

    -- check if note file exist
    checkAndDeleteNoteFile(noteFilePath)
end
M.DeleteNoteAtGlobal = DeleteNoteAtGlobal

-- Delete an already existed note at CWD
local DeleteNoteAtCWD = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentCWD()

    -- get note file path
    local noteFilePath = path:new(noteDirPath, fileName .. ".md").filename

    -- check if note file exist
    checkAndDeleteNoteFile(noteFilePath)
end
M.DeleteNoteAtCWD = DeleteNoteAtCWD

return M
