local utils_path = require("quicknote.utils.path")
local path = require("plenary.path")

local M = {}

local JumpToNextNote = function()
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

    -- get current line number
    local currentLine = vim.api.nvim_win_get_cursor(0)[1]

    -- get next line number
    local nextLine = nil
    for _, line in ipairs(lines) do
        if line > currentLine then
            nextLine = line
            break
        end
    end
    if nextLine == nil then
        nextLine = lines[1]
    end

    -- jump to next line
    vim.api.nvim_win_set_cursor(0, { nextLine, 0 })
end
M.JumpToNextNote = JumpToNextNote

local JumpToPreviousNote = function()
    --TODO
end
M.JumpToPreviousNote = JumpToPreviousNote

return M
