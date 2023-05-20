local async = require("plenary.async")

-- Export
local M = {}

-- Make new folder
-- Explain: if the folder is not exist, then create it, else do nothing
-- @param {string} path
M.MKDirAsync = function(path)
    local err, stat = async.uv.fs_stat(path)
    if err or stat == nil then
        local err, success = async.uv.fs_mkdir(path, tonumber("666", 8))
        if err or not success then
            error("Error: " .. err)
        end
    end
end

M.CreateFileAsync = function(path)
    local err, stat = async.uv.fs_stat(path)
    if err or stat == nil then
        -- create note file for current line
        local err, fd = async.uv.fs_open(path, "w", tonumber("666", 8))
        if err or fd == nil then
            error("Error: " .. err)
        end
        async.uv.fs_close(fd)
    end
end

return M
