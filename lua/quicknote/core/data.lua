-- This module consist of import and export functions for the note data
local utils = require("quicknote.utils")
local path = require("plenary.path")
local sign = require("quicknote.core.sign")

local exportNotesToDestination = function(noteDirPath)
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

local importNotesFromDestination = function(noteDirPath)
    -- create note dir if not exists
    path.new(noteDirPath):mkdir({ parents = true })

    -- get user input external notes source dir path
    local sourceDir = vim.fn.input("Enter external source dir path: ")
    vim.cmd([[:redraw]])
    if sourceDir == "" then
        print("No external source dir path provided")
        return
    end

    -- make path absolute
    sourceDir = path.new(sourceDir):absolute()

    -- check if source dir exists, if not exist, do nothing and return
    local stat = vim.loop.fs_stat(sourceDir)
    if stat == nil then
        print("Source dir does not exist")
        return
    end

    -- get note file paths from source dir
    local sourceNoteFilePaths = vim.fn.glob(sourceDir .. "/*.md", true, true)
    if sourceNoteFilePaths == nil or #sourceNoteFilePaths == 0 then
        print("Source dir has no notes inside")
        return
    end

    -- copy note files from external source dir to the internal note dir
    for _, sourceNoteFilePath in ipairs(sourceNoteFilePaths) do
        --get note file name with extention
        local sourceNoteFileName = path.new(sourceNoteFilePath):_split()
        sourceNoteFileName = sourceNoteFileName[#sourceNoteFileName]

        local destinationFilePath = path.new(noteDirPath):joinpath(sourceNoteFileName)

        path.new(sourceNoteFilePath):copy({ destination = destinationFilePath })
    end

    print("Imported successfully.")
end

-- Exports

local M = {}

local ExportNotesForCurrentBuffer = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()

    -- export notes to destination
    exportNotesToDestination(noteDirPath)
end
M.ExportNotesForCurrentBuffer = ExportNotesForCurrentBuffer

local ExportNotesForCWD = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCWD()

    -- export notes to destination
    exportNotesToDestination(noteDirPath)
end
M.ExportNotesForCWD = ExportNotesForCWD

local ExportNotesForGlobal = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForGlobal()

    -- export notes to destination
    exportNotesToDestination(noteDirPath)
end
M.ExportNotesForGlobal = function()
    if utils.config.GetMode() ~= "resident" then
        print("Export global notes just works in resident mode")
        return
    end
    ExportNotesForGlobal()
end

local ImportNotesForCurrentBuffer = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()

    -- import notes from external source dir
    importNotesFromDestination(noteDirPath)
end
M.ImportNotesForCurrentBuffer = function()
    ImportNotesForCurrentBuffer()
    -- refresh signs
    sign.ReShowSignsForCurrentBuffer()
end

local ImportNotesForCWD = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForCWD()

    -- import notes from external source dir
    importNotesFromDestination(noteDirPath)
end
M.ImportNotesForCWD = ImportNotesForCWD

local ImportNotesForGlobal = function()
    -- get note dir path
    local noteDirPath = utils.path.getNoteDirPathForGlobal()

    -- import notes from external source dir
    importNotesFromDestination(noteDirPath)
end
M.ImportNotesForGlobal = function()
    if utils.config.GetMode() ~= "resident" then
        print("Import global notes just works in resident mode")
        return
    end
    ImportNotesForGlobal()
end

return M
