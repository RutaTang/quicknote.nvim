local utils_path = require("quicknote.utils.path")

local getNotesCount = function(noteDirPath)
    -- check if note dir exist
    vim.loop.fs_stat(noteDirPath, function(err, _)
        if err then
            print("No notes for current buffer found.")
        else
            -- list all notes
            vim.defer_fn(function()
                local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)
                if noteFilePaths == nil then
                    print("No notes found.")
                else
                    if #noteFilePaths == 0 then
                        print("No notes found.")
                        return
                    end
                    local message = "Notes count for current buffer: " .. #noteFilePaths
                    vim.api.nvim_command("echo '" .. message .. "'")
                end
            end, 0)
        end
    end)
end

-- Export
local M = {}

local GetNotesCountForCurrentBuffer = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()

    getNotesCount(noteDirPath)
end
M.GetNotesCountForCurrentBuffer = GetNotesCountForCurrentBuffer

local GetNotesCountForCWD = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCWD()

    getNotesCount(noteDirPath)
end
M.GetNotesCountForCWD = GetNotesCountForCWD

local getNotesCountForGlobal = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForGlobal()

    getNotesCount(noteDirPath)
end
M.GetNotesCountForGlobal = getNotesCountForGlobal

return M
