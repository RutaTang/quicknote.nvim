local async = require("plenary.async")
local Path = require("plenary.path")

local create_dir_if_not_exist = function(file_path)
	local dir_path = Path:new(file_path):absolute()
	local err, stat = async.uv.fs_stat(dir_path)
	if err or stat == nil then
		local create_err, create_success = async.uv.fs_mkdir(dir_path, tonumber("777", 8))
		if create_err or not create_success then
			return create_err, false
		end
	end

	return nil, true
end

-- Export
local M = {}

-- Make new folder
-- Explain: if the folder is not exist, then create it, else do nothing
-- @param {string} path
-- HACK: Assuming there are only 2 directories that may be missing
-- TODO: There should be some way to send in the path and do this recursively. Attempt should be made
M.MKDirAsync = function(file_path)
	local err, success = create_dir_if_not_exist(Path:new(file_path):parent():absolute())
	if err then
		error("Unable to create directory: " .. err)
	end

	if success then
		local file_err, _ = create_dir_if_not_exist(file_path)
		if file_err then
			error("Unable to create serial directory: " .. err)
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
