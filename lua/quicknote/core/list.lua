local utils_path = require("quicknote.utils.path")
local path = require("plenary.path")

-- list all notes in a note dir
local listNotes = function(noteDirPath)
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
                    local message = "Notes for current buffer:"
                    for _, noteFilePath in ipairs(noteFilePaths) do
                        local dirNameList = path._split(path:new(noteFilePath))
                        local fileName = dirNameList[#dirNameList]
                        -- get filename without extension
                        fileName = string.match(fileName, "(.*)%.")
                        message = message .. "\n" .. fileName
                    end
                    vim.api.nvim_command("echo '" .. message .. "'")
                end
            end, 0)
        end
    end)
end


local M = {}

-- List all notes for current buffer file
local ListNotesForCurrentBuffer = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForCurrentBuffer = ListNotesForCurrentBuffer

-- List all notes for CWD
local ListNotesForCWD = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentCWD()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForCWD = ListNotesForCWD

-- List all notes for global
local ListNotesForGlobal = function()
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForGlobal()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForGlobal = ListNotesForGlobal

return M
