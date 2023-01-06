local async = require("plenary.async")
local utils = require("quicknote.utils")
local sign = require("quicknote.core.sign")

local refreshAfterSwitchMode = function()
    -- re-run to check if quicknote root folder for this mode is valid
    async.run(function()
        utils.fs.MKDirAsync(utils.path.GetDataPath())
    end, function() end)
    -- re-run to refresh signs
    sign.ReShowSignsForCurrentBuffer()
end

-- Export
local M = {}

local SwitchToResidentMode = function()
    utils.config.SetMode("resident")
    refreshAfterSwitchMode()
end
M.SwitchToResidentMode = SwitchToResidentMode

local SwitchToPortableMode = function()
    utils.config.SetMode("portable")
    refreshAfterSwitchMode()
end
M.SwitchToPortableMode = SwitchToPortableMode

local ToggleMode = function()
    if utils.config.GetMode == "resident" then
        SwitchToPortableMode()
    else
        SwitchToResidentMode()
    end
end
M.ToggleMode = ToggleMode

return M
