local utils_fs = require('quicknote.utils.fs')
local new = require('quicknote.core.new')

-- init data folder for quick note
utils_fs.MKDir(utils_fs.GetDataPath())

-- Define API
return {
    NewNoteAtCWD = utils_fs.todo("NewNoteAtCWD"),
    NewNoteAtLine = utils_fs.todo("NewNoteAtLine"),
    NewNoteAtCurrentLine = new.NewNoteAtCurrentLine,
    NewNoteAtGlobal = utils_fs.todo("NewNoteAtGlobal"),

    GetNoteAtLine = utils_fs.todo("GetNoetAtLine"),
    GetNoteAtCurrentLine = utils_fs.todo("GetNoteAtCurrentLine"),
    GetNoteAtGlobal = utils_fs.todo("GetNoteAtGlobal"),
    GetNoteAtCWD = utils_fs.todo("GetNoteAtCWD"),

    DeleteNoteAtLine = utils_fs.todo("DeleteNoteAtLine"),
    DeleteNoteAtCurrentLine = utils_fs.todo("DeleteNoteAtCurrentLine"),
    DeleteNoteAtGlobal = utils_fs.todo("DeleteNoteAtGlobal"),
    DeleteNoteAtCWD = utils_fs.todo("DeleteNoteAtCWD"),

    ShowNoteSign = utils_fs.todo("ShowNoteSign"),
    HideNoteSign = utils_fs.todo("HideNoteSign"),
    ToggleNoteSign = utils_fs.todo("ToggleNoteSign"),
}
