local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local utils = require("quicknote.utils")
local path = require("plenary.path")

local listNotes = function(noteDirPath)
    local notes = {}
    if not vim.loop.fs_stat(noteDirPath) then
        return notes
    end
    local noteFilePaths = vim.fn.glob(noteDirPath .. "/*." .. utils.config.GetFileType(), true, true)
    if noteFilePaths and #noteFilePaths ~= 0 then
        for _, noteFilePath in ipairs(noteFilePaths) do
            local dirNameList = path._split(path:new(noteFilePath))
            local fileName = dirNameList[#dirNameList]
            table.insert(notes, {
                name = fileName,
                path = noteFilePath,
            })
        end
    end
    return notes
end

local finder = function(scope)
    if utils.config.GetMode() ~= "resident" and scope == "Global" then
        error("Global scope is only available in resident mode")
    end
    local func = "getNoteDirPathFor" .. scope
    local noteDirPath = utils.path[func]()
    local notes = listNotes(noteDirPath)
    if not notes or #notes == 0 then
        error("No notes found")
    end
    return finders.new_table({
        results = notes,
        entry_maker = function(entry)
            local name = entry.name
            return {
                value = entry.path,
                display = name,
                ordinal = name,
            }
        end,
    })
end

local options = {
    defaultScope = "CWD",
}

return require("telescope").register_extension({
    setup = function(opts)
        options = vim.tbl_extend("force", options, opts)
    end,
    exports = {
        quicknote = function(opts)
            opts = opts or {}
            local scope = opts.scope or options.defaultScope
            pickers
                .new(opts, {
                    prompt_title = "Quick Notes for " .. scope,
                    finder = finder(scope),
                    previewer = conf.file_previewer(opts),
                    sorter = conf.generic_sorter(opts),
                })
                :find()
        end,
    },
})
