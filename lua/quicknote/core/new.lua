local async = require("plenary.async")
local dataPath = vim.fn.stdpath("data") .. "/quicknote"

local function mkdir(path)
    local err, stat = async.uv.fs_stat(path)
    if err or stat == nil then
        local err, success = async.uv.fs_mkdir(path, 511)
        if err or not success then
            error("Error: " .. err)
        end
    end
end

local M = {}

local newNoteAtCurrentLine = function()
    mkdir(dataPath)
    -- -- get current
    -- local line = vim.api.nvim_win_get_cursor(0)[1]
    -- -- get current buffer file path
    -- local currentBufferPath = vim.api.nvim_buf_get_name(0)
    -- -- note dir path
    -- local noteDirPath = dataPath .. "/" .. "[" .. currentBufferPath .. "]" .. ".quicknote"
    -- -- check quick note dir for this buffer existance
    -- local err, stat = async.uv.fs_stat(noteDirPath)
    -- if err or stat == nil then
    --     -- create quick note dir for this buffer
    --     local err, success = async.uv.fs_mkdir(noteDirPath, 511)
    --     if err or not success then
    --         error("Error: " .. err)
    --     end
    -- end
end

M.NewNoteAtCurrentLine = function()
    async.run(newNoteAtCurrentLine)
end

return M
