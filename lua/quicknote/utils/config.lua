-- default config
local config = {
    mode = "portable", -- "resident" or "portable"
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

return M
