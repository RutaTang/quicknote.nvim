local util = require('quicknote.utils')
local todo = util.todo

-- Define API
return {
    NewNoteAtCWD = todo("NewNoteAtCWD"),
    NewNoteAtLine = todo("NewNoteAtLine"),
    NewNoteAtCurrentLine = todo("NewNoteAtCurrentLine"),
    NewNoteAtGlobal = todo("NewNoteAtGlobal"),

    GetNoteAtLine = todo("GetNoetAtLine"),
    GetNoteAtCurrentLine = todo("GetNoteAtCurrentLine"),
    GetNoteAtGlobal = todo("GetNoteAtGlobal"),
    GetNoteAtCWD = todo("GetNoteAtCWD"),

    DeleteNoteAtLine = todo("DeleteNoteAtLine"),
    DeleteNoteAtCurrentLine = todo("DeleteNoteAtCurrentLine"),
    DeleteNoteAtGlobal = todo("DeleteNoteAtGlobal"),
    DeleteNoteAtCWD = todo("DeleteNoteAtCWD"),

    ShowNoteSign = todo("ShowNoteSign"),
    HideNoteSign = todo("HideNoteSign"),
    ToggleNoteSign = todo("ToggleNoteSign"),
}
