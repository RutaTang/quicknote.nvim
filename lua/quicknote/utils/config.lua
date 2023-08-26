-- default config
local config = {
    mode = "portable", -- "resident" or "portable"
    sign = "N",
    filetype = "md",
    git_branch_recognizable = true, -- if true, quicknote will separate notes by git branch, but it should only be used with resident mode
}

-- Export
local M = {}

local setup = function(userConfig)
    -- join user config to default config
    config = vim.tbl_deep_extend("force", config, userConfig or {})
end
M.setup = setup

local SetMode = function(newMode)
    if newMode == "resident" or newMode == "portable" then
        config.mode = newMode
        print("Switched to " .. config.mode .. " mode")
    else
        error("Invalid mode: " .. newMode .. ". Valid modes are: resident, portable")
    end
end
M.SetMode = SetMode

local GetMode = function()
    return config.mode
end
M.GetMode = GetMode

local GetSign = function()
    return config.sign
end
M.GetSign = GetSign

local GetFileType = function()
    return config.filetype
end
M.GetFileType = GetFileType

local GetGitBranchRecognizable = function()
    return config.git_branch_recognizable
end
M.IsGitBranchRecognizable = GetGitBranchRecognizable

return M
