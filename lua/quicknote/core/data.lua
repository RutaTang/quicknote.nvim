-- This module consist of import and export functions for the note data
local utils_path = require("quicknote.utils.path")
local path = require("plenary.path")

local M = {}

local ExportNotesForCurrentBuffer = function()
    -- get user input destination dir path
    local destinationDir = vim.fn.input("Enter destination dir path: ")
    vim.cmd([[:redraw]])
    if destinationDir == "" then
        print("No destination dir path provided")
        return
    end

    -- make path absolute
    destinationDir = path.new(destinationDir):absolute()

    -- check if destination dir exists, if exists, do nothing and return
    local stat = vim.loop.fs_stat(destinationDir)
    if stat ~= nil then
        print("Destination dir has already existed")
        return
    end

    -- create destination dir, recursively
    destinationDir = path.new(destinationDir)
    local ok, err = destinationDir:mkdir({ parents = true })
    if not ok then
        print("Failed to create destination dir: " .. err)
        return
    end

    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()

    -- get note file paths
    local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)

    -- copy note files to the destination dir
    for _, noteFilePath in ipairs(noteFilePaths) do
        --get note file name with extention
        local noteFileName = path.new(noteFilePath):_split()
        noteFileName = noteFileName[#noteFileName]

        local destinationFilePath = destinationDir:joinpath(noteFileName)

        path.new(noteFilePath):copy({ destination = destinationFilePath })
    end

    print("Exported successfully.")
end
M.ExportNotesForCurrentBuffer = ExportNotesForCurrentBuffer

return M