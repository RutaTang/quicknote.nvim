local utils = require('quicknote.utils')
local core = require('quicknote.core')

-- Define API
return {
    NewNoteAtCWD = utils.todo("NewNoteAtCWD"),
    NewNoteAtLine = utils.todo("NewNoteAtLine"),
    NewNoteAtCurrentLine = core.new.NewNoteAtCurrentLine,
    NewNoteAtGlobal = utils.todo("NewNoteAtGlobal"),

    GetNoteAtLine = utils.todo("GetNoetAtLine"),
    GetNoteAtCurrentLine = utils.todo("GetNoteAtCurrentLine"),
    GetNoteAtGlobal = utils.todo("GetNoteAtGlobal"),
    GetNoteAtCWD = utils.todo("GetNoteAtCWD"),

    DeleteNoteAtLine = utils.todo("DeleteNoteAtLine"),
    DeleteNoteAtCurrentLine = utils.todo("DeleteNoteAtCurrentLine"),
    DeleteNoteAtGlobal = utils.todo("DeleteNoteAtGlobal"),
    DeleteNoteAtCWD = utils.todo("DeleteNoteAtCWD"),

    ShowNoteSign = utils.todo("ShowNoteSign"),
    HideNoteSign = utils.todo("HideNoteSign"),
    ToggleNoteSign = utils.todo("ToggleNoteSign"),
}
