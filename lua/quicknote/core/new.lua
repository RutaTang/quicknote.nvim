local async = require("plenary.async")
local path = require("plenary.path")
local utils_fs = require("quicknote.utils.fs")
local sha = require("quicknote.utils.sha")

-- Export
local M = {}

-- Create a new note at current cursor line for current buffer
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

local OpenNoteAtCurrentLine = function()
    -- get current
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- get current buffer file path
    local currentBufferPath = vim.api.nvim_buf_get_name(0)

    -- get note dir path
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = sha.sha1(currentBufferPath) -- hash current buffer path
    local noteDirPath = path:new(dataPath, noteDirName).filename

    -- get note file path
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename

    -- check if note file exist
    vim.loop.fs_stat(noteFilePath, function(err, _)
        if err then
            print("Note not found and please use NewNoteAtCurrentLine to create one before you open it.")
        else
            -- open note file
            -- use vim.defer_fn to avoid "can not call nvim exec in vim loop event"
            vim.defer_fn(function()
                vim.cmd("split " .. noteFilePath)
            end, 0)
        end
    end)
end
M.OpenNoteAtCurrentLine = OpenNoteAtCurrentLine

local DeleteNoteAtCurrentLine = function()
    -- get current
    local line = vim.api.nvim_win_get_cursor(0)[1]
    -- get current buffer file path
    local currentBufferPath = vim.api.nvim_buf_get_name(0)

    -- get note dir path
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = sha.sha1(currentBufferPath) -- hash current buffer path
    local noteDirPath = path:new(dataPath, noteDirName).filename

    -- get note file path
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename

    -- check if note file exist
    vim.loop.fs_stat(noteFilePath, function(err, _)
        if err then
            print("Note not found.")
        else
            -- delete note file
            local success,err = os.remove(noteFilePath)
            if success then
                print("Note deleted.")
            else
                print("Note delete failed: " .. err)
            end
        end
    end)
end
M.DeleteNoteAtCurrentLine = DeleteNoteAtCurrentLine

return M
