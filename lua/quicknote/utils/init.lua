-- Todo Helper
-- @content string: the content of the todo
local function todo(content)
    return function()
        error("TODO: " .. content)
    end
end

return {
    todo = todo
}
