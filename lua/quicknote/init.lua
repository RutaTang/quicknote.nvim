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
    NewNoteAtCWD = core.new.NewNoteAtCWD,
    NewNoteAtLine = core.new.NewNoteAtLine,
    NewNoteAtCurrentLine = core.new.NewNoteAtCurrentLine,
    NewNoteAtGlobal = core.new.NewNoteAtGlobal,

    OpenNoteAtLine = core.new.OpenNoteAtLine,
    OpenNoteAtCurrentLine = core.new.OpenNoteAtCurrentLine,
    OpenNoteAtGlobal = core.new.OpenNoteAtGlobal,
    OpenNoteAtCWD = core.new.OpenNoteAtCWD,

    DeleteNoteAtLine = core.new.DeleteNoteAtLine,
    DeleteNoteAtCurrentLine = core.new.DeleteNoteAtCurrentLine,
    DeleteNoteAtGlobal = core.new.DeleteNoteAtGlobal,
    DeleteNoteAtCWD = core.new.DeleteNoteAtCWD,

    ListNotesForCurrentBuffer = core.new.ListNotesForCurrentBuffer,
    ListNotesForCWD = core.new.ListNotesForCWD,
    ListNotesForGlobal = core.new.ListNotesForGlobal,

    ShowNoteSign = utils.todo("ShowNoteSign"),
    HideNoteSign = utils.todo("HideNoteSign"),
    ToggleNoteSign = utils.todo("ToggleNoteSign"),
}
