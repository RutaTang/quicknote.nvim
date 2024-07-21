local async = require("plenary.async")
local Path = require("plenary.path")

-- Export
local M = {}

-- Make new folder
-- Explain: if the folder does not exist, then create it, else do nothing
-- @param {string} path
M.MKDirAsync = function(dir_path)
	local success = Path:new(dir_path):mkdir({ parents = true })
	if not success then
		error("Unable to create directory: " .. dir_path)
	end
end

M.CreateFileAsync = function(file_path)
	local err, stat = async.uv.fs_stat(file_path)
	if err or stat == nil then
		-- create note file for current line
		local file_err, fd = async.uv.fs_open(file_path, "w", tonumber("666", 8))
		if file_err or fd == nil then
			error("Error: " .. file_err)
		end
		async.uv.fs_close(fd)
	end
end

return M
