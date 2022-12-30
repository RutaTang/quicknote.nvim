local async = require("plenary.async")

local utils = require("quicknote.utils")
utils.fs = require("quicknote.utils.fs")
local core = require("quicknote.core")
core.new = require("quicknote.core.new")

-- init data folder for quick note
async.run(function()
    utils.fs.MKDirAsync(utils.fs.GetDataPath())
end, function() end)

-- Define API
return {
    NewNoteAtCWD = utils.todo("NewNoteAtCWD"),
    NewNoteAtLine = utils.todo("NewNoteAtLine"),
    NewNoteAtCurrentLine = core.new.NewNoteAtCurrentLine,
    NewNoteAtGlobal = utils.todo("NewNoteAtGlobal"),

    OpenNoteAtLine = utils.todo("GetNoetAtLine"),
    OpenNoteAtCurrentLine = core.new.OpenNoteAtCurrentLine,
    OpenNoteAtGlobal = utils.todo("GetNoteAtGlobal"),
    OpenNoteAtCWD = utils.todo("GetNoteAtCWD"),

    DeleteNoteAtLine = utils.todo("DeleteNoteAtLine"),
    DeleteNoteAtCurrentLine = core.new.DeleteNoteAtCurrentLine,
    DeleteNoteAtGlobal = utils.todo("DeleteNoteAtGlobal"),
    DeleteNoteAtCWD = utils.todo("DeleteNoteAtCWD"),

    ShowNoteSign = utils.todo("ShowNoteSign"),
    HideNoteSign = utils.todo("HideNoteSign"),
    ToggleNoteSign = utils.todo("ToggleNoteSign"),
}
