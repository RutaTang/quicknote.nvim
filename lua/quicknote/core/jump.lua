local utils_path = require("quicknote.utils.path")
local path = require("plenary.path")

-- helper function to jump to next or previous note in the current buffer
-- @param direction: "next" or "prev"
local jumpToNextOrPreviousNote = function(direction)
    -- get note dir path
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()

    -- scan note dir and get notes
    local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)

    -- extract note names without extension
    local lines = {}
    for _, noteFilePath in ipairs(noteFilePaths) do
        local dirNameList = path._split(path:new(noteFilePath))
        local filename = dirNameList[#dirNameList]
        -- get filename(which is the line number) without extension
        local line = string.match(filename, "(.*)%.")
        line = tonumber(line)
        if line then
            table.insert(lines, line)
        end
    end

    -- if no note found, return
    if #lines == 0 then
        print("No note found.")
        return
    end

    -- sort lines
    table.sort(lines)

    -- exlcude note out of range
    local lineCount = vim.fn.line("$")
    local filteredLines = {}
    for _, line in ipairs(lines) do
        if line <= lineCount then
            table.insert(filteredLines, line)
        end
    end
    lines = filteredLines

    -- get current line number
    local currentLine = vim.api.nvim_win_get_cursor(0)[1]

    -- get next line number
    -- TODO (OPTIMIZE): use binary search
    local nextLine = nil
    if direction == "next" then
        for i = 1, #lines, 1 do
            if lines[i] > currentLine then
                nextLine = lines[i]
                break
            end
        end
    elseif direction == "prev" then
        for i = #lines, 1, -1 do
            if lines[i] < currentLine then
                nextLine = lines[i]
                break
            end
        end
    else
        error("Invalid direction.")
        return
    end

    -- cycle if next line is nil
    if nextLine == nil then
        if direction == "next" then
            nextLine = lines[1]
        else
            nextLine = lines[#lines]
        end
    end

    -- jump to next line
    vim.api.nvim_win_set_cursor(0, { nextLine, 0 })
end

local M = {}

local JumpToNextNote = function()
    jumpToNextOrPreviousNote("next")
end
M.JumpToNextNote = JumpToNextNote

local JumpToPreviousNote = function()
    jumpToNextOrPreviousNote("prev")
end
M.JumpToPreviousNote = JumpToPreviousNote

return M
