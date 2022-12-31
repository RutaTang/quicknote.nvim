local path = require("plenary.path")
local utils_fs = require("quicknote.utils.fs")
local sha = require("quicknote.utils.sha")

local M = {}

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
M.getNoteDirPathForCurrentBuffer = getNoteDirPathForCurrentBuffer

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
M.getNoteDirPathForCurrentCWD = getNoteDirPathForCurrentCWD

-- same as getNoteDirPath*, but for a global note
local getNoteDirPathForGlobal = function()
    local dataPath = utils_fs.GetDataPath()
    local noteDirName = "global"
    local noteDirPath = path:new(dataPath, noteDirName).filename

    return noteDirPath
end
M.getNoteDirPathForGlobal = getNoteDirPathForGlobal

return M
