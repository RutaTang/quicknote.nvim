local async = require("plenary.async")
local path = require("plenary.path")

local dataPath = path.joinpath(vim.fn.stdpath("state"), "quicknote")

-- Make new folder
-- Explain: if the folder is not exist, then create it, else do nothing
-- @param {string} path
local mkdir = function(path)
    local err, stat = async.uv.fs_stat(path)
    if err or stat == nil then
        local err, success = async.uv.fs_mkdir(path, 511)
        if err or not success then
            error("Error: " .. err)
        end
    end
end

-- Export
local M = {}

M.MKDir = function(path)
    async.run(function()
        print(1)
    end)
end

M.GetDataPath = function()
    return dataPath
end

return M
