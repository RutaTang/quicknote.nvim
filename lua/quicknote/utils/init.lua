local fs = require("quicknote.utils.fs")
local config = require("quicknote.utils.config")
local path = require("quicknote.utils.path")
local sha = require("quicknote.utils.sha")

-- Todo Helper
-- @content string: the content of the todo
local function todo(content)
    return function()
        error("TODO: " .. content)
    end
end

return {
    todo = todo,
    fs = fs,
    config = config,
    path = path,
    sha = sha
}
