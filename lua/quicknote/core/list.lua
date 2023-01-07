local utils= require("quicknote.utils")
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
    local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForCurrentBuffer = ListNotesForCurrentBuffer

-- List all notes for CWD
local ListNotesForCWD = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCWD()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForCWD = ListNotesForCWD

-- List all notes for CWD including files under the current dir and all offspring dirs
local ListNotesForAFileOrWDInCWD = function()
    -- get CWD path
    local cwdPath = vim.fn.getcwd()
    -- get all paths of files under cwd and its offspring dirs
    local filePaths = vim.fn.glob(cwdPath .. "/**/*", true, true)
    table.insert(filePaths, 1, cwdPath)

    -- check if any note dir exist
    local noteDirPaths = {}
    local existedFilePaths = {}
    for _, filePath in ipairs(filePaths) do
        local noteDirPath = utils.path.getHashedNoteDirPath(filePath)
        local stat = vim.loop.fs_stat(noteDirPath)
        if stat then
            -- list notes
            table.insert(noteDirPaths, noteDirPath)
            table.insert(existedFilePaths, filePath)
        end
    end
    if #noteDirPaths == 0 then
        print("No file or dir containing notes in CWD")
        return
    end

    -- list offspring files under CWD for user to choose
    local message = ""
    for idx, filePath in ipairs(existedFilePaths) do
        message = message .. idx .. " " .. "." .. string.sub(filePath, #cwdPath + 1, #filePath) .. "\n"
    end
    message = "Choose a file to list notes for:\n" .. message
    print(message)

    -- get user input for file index
    local choice = vim.fn.input("Enter the index: ")
    choice = tonumber(choice)
    vim.cmd([[:redraw]]) -- redraw messages

    -- check if user input is valid
    if choice == nil then
        print("You should input an index to choose a file or dir to list notes.")
        return
    end
    if choice < 1 or choice > #filePaths then
        print("Index out of range.")
        return
    end

    -- get note dir path
    local noteDirPath = noteDirPaths[choice]

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForAFileOrWDInCWD = ListNotesForAFileOrWDInCWD

-- List all notes for global
local ListNotesForGlobal = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForGlobal()

    -- list notes
    listNotes(noteDirPath)
end
M.ListNotesForGlobal = function()
    if utils.config.GetMode() ~= "resident" then
        print("List notes globally just works in resident mode")
        return
    end
    ListNotesForGlobal()
end

return M
