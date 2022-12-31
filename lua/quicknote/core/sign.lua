local utils_path = require("quicknote.utils.path")
local path = require("plenary.path")

local SIGN_NAME = "QuickNote"
local SIGN_GROUP = "QuickNote"
local SIGN_DISPLAY_STATE = {
    HIDE = 0,
    SHOW = 1,
}

-- A table to store sign display state for each buffer
local SignDisplayStateForEachBuffer = {}

local M = {}

-- export constants for other modules
function M.GetConstant_SIGN_NAME()
    return SIGN_NAME
end

function M.GetConstant_SIGN_GROUP()
    return SIGN_GROUP
end

function M.GetConstant_SIGN_DISPLAY_STATE()
    return SIGN_DISPLAY_STATE
end

-- define sign
function M.DefineSign()
    vim.fn.sign_define(SIGN_NAME, { text = "N", texthl = "", linehl = "", numhl = "" })
end

-- get sign display state for a buffer
function M.GetSignDisplayState(bufnr)
    return SignDisplayStateForEachBuffer[bufnr]
end

-- Show note sign, only for current buffer
function M.ShowNoteSigns()
    -- set sign display state
    SignDisplayStateForEachBuffer[vim.api.nvim_get_current_buf()] = SIGN_DISPLAY_STATE.SHOW

    -- get note dir path for current buffer
    local noteDirPath = utils_path.getNoteDirPathForCurrentBuffer()

    -- get all notes under this path
    local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)
    if noteFilePaths == nil or #noteFilePaths <= 0 then
        return
    end
    local lines = {}
    for _, noteFilePath in ipairs(noteFilePaths) do
        local dirNameList = path._split(path:new(noteFilePath))
        local filename = dirNameList[#dirNameList]
        -- get filename(which is the line number) without extension
        local line = string.match(filename, "(.*)%.")
        table.insert(lines, line)
    end

    -- show signs
    for _, line in pairs(lines) do
        vim.fn.sign_place(line, SIGN_GROUP, SIGN_NAME, vim.api.nvim_get_current_buf(), { lnum = line })
    end
end

-- Hide note sign (as ShowNoteSigns, only for current buffer)
function M.HideNoteSigns()
    -- set sign display state
    SignDisplayStateForEachBuffer[vim.api.nvim_get_current_buf()] = SIGN_DISPLAY_STATE.HIDE
    -- hide signs
    vim.fn.sign_unplace(SIGN_GROUP, { buffer = vim.api.nvim_get_current_buf() })
end

-- Toggle note sign
function M.ToggleNoteSigns()
    local bufnr = vim.api.nvim_get_current_buf()
    local current = SignDisplayStateForEachBuffer[bufnr]
    if current == nil or current == SIGN_DISPLAY_STATE.HIDE then
        M.ShowNoteSigns()
    else
        M.HideNoteSigns()
    end
end

-- Re-Show signs for current if the sign display state is SHOW
function M.ReShowSignsForCurrentBuffer()
    local current = M.GetSignDisplayState(vim.api.nvim_get_current_buf())
    if current ~= nil and current == SIGN_DISPLAY_STATE.SHOW then
        -- unplace all signs in this buffer
        M.HideNoteSigns()
        -- re-run this function to scan note dir and show signs
        M.ShowNoteSigns()
    end
end

return M
