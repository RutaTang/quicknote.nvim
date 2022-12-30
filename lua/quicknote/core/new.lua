local async = require("plenary.async")
local path = require("plenary.path")
local utils_fs = require("quicknote.utils.fs")
local sha = require("quicknote.utils.sha")

-- Get the path to the notes directory corresponding to the current buffer
-- Note: one buffer can have multiple notes; the name of the dir is the hash of the buffer file name
local getNoteDirPathForCurrentBuffer = function()
    -- get current buffer file path
    local currentBufferPath = vim.api.nvim_buf_get_name(0)

    -- get note dir path
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = sha.sha1(currentBufferPath) -- hash current buffer path
    local noteDirPath = path:new(dataPath, noteDirName).filename

    return noteDirPath
end

-- same as getNoteDirPathForCurrentBuffer but for a CWD instead of the current buffer
local getNoteDirPathForCurrentCWD = function()
    -- get CWD path
    local cwdPath = vim.fn.getcwd()

    -- get note dir path
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = sha.sha1(cwdPath)
    local noteDirPath = path:new(dataPath, noteDirName).filename

    return noteDirPath
end

-- same as getNoteDirPath*, but for a global note
local getNoteDirPathForGlobal = function()
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = "global"
    local noteDirPath = path:new(dataPath, noteDirName).filename

    return noteDirPath
end

-- Export
local M = {}

-- create a new note for the global
local NewNoteAtGlobalAsync = function()
    -- get file name for the user input 
    local fileName = vim.fn.input("Enter note name: ")
    
    -- get note dir path
    local noteDirPtha = getNoteDirPathForGlobal()

    -- create note dir (if not exist)
    utils_fs.MKDirAsync(noteDirPtha)


    -- create note file
    local noteFilePath = path:new(noteDirPtha, fileName .. ".md").filename
    utils_fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtGlobal = function()
    async.run(NewNoteAtGlobalAsync, function() end)
end

-- Create a new note for the current working directory (CWD)
local NewNoteAtCWDAsync = function()
    -- get file name from user input
    local fileName = vim.fn.input("Enter note name: ")

    -- get note dir path
    local noteDirPath = getNoteDirPathForCurrentCWD()

    -- create note dir (if not exist)
    utils_fs.MKDirAsync(noteDirPath)


    -- create note files (if not exist)
    local noteFilePath = path:new(noteDirPath, fileName .. ".md").filename
    utils_fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtCWD = function()
    async.run(NewNoteAtCWDAsync, function() end)
end

-- Create a new note at a given line for the current buffer
-- @param line: line number
local NewNoteAtLineAsync = function(line)
    -- get note file path
    local noteDirPath = getNoteDirPathForCurrentBuffer()

    -- create note dir (if not exist)
    utils_fs.MKDirAsync(noteDirPath)

    -- create note file (if not exist)
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename
    utils_fs.CreateFileAsync(noteFilePath)
end
M.NewNoteAtLine = function(line)
    async.run(function ()
       NewNoteAtLineAsync(line)
    end, function() end)
end

-- Create a new note at current cursor line for current buffer
local NewNoteAtCurrentLineAsync = function()
    -- get current cursor line
    local line = vim.api.nvim_win_get_cursor(0)[1]
    NewNoteAtLineAsync(line)
end
M.NewNoteAtCurrentLine = function()
    async.run(NewNoteAtCurrentLineAsync, function() end)
end

-- Open an already existed note at current cursor line for current buffer
local OpenNoteAtCurrentLine = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local noteDirPath = getNoteDirPathForCurrentBuffer()
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

-- Delete an already existed note at current cursor line for current buffer
local DeleteNoteAtCurrentLine = function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local noteDirPath = getNoteDirPathForCurrentBuffer()
    -- get note file path
    local noteFilePath = path:new(noteDirPath, line .. ".md").filename

    -- check if note file exist
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
M.DeleteNoteAtCurrentLine = DeleteNoteAtCurrentLine

return M
