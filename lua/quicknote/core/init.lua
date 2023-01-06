local new = require("quicknote.core.new")
local open = require("quicknote.core.open")
local delete = require("quicknote.core.delete")
local list = require("quicknote.core.list")
local sign = require("quicknote.core.sign")
local jump = require("quicknote.core.jump")
local data = require("quicknote.core.data")
local count = require("quicknote.core.count")
local mode = require("quicknote.core.mode")

return {
    SwitchToResidentMode = mode.SwitchToResidentMode,
    SwitchToPortableMode = mode.SwitchToPortableMode,
    ToggleMode = mode.ToggleMode,

    NewNoteAtGlobal = new.NewNoteAtGlobal,
    NewNoteAtCWD = new.NewNoteAtCWD,
    NewNoteAtLine = new.NewNoteAtLine,
    NewNoteAtCurrentLine = new.NewNoteAtCurrentLine,

    OpenNoteAtGlobal = open.OpenNoteAtGlobal,
    OpenNoteAtCWD = open.OpenNoteAtCWD,
    OpenNoteAtLine = open.OpenNoteAtLine,
    OpenNoteAtCurrentLine = open.OpenNoteAtCurrentLine,

    DeleteNoteAtGlobal = delete.DeleteNoteAtGlobal,
    DeleteNoteAtCWD = delete.DeleteNoteAtCWD,
    DeleteNoteAtLine = delete.DeleteNoteAtLine,
    DeleteNoteAtCurrentLine = delete.DeleteNoteAtCurrentLine,

    ListNotesForGlobal = list.ListNotesForGlobal,
    ListNotesForCWD = list.ListNotesForCWD,
    ListNotesForAFileOrWDInCWD = list.ListNotesForAFileOrWDInCWD,
    ListNotesForCurrentBuffer = list.ListNotesForCurrentBuffer,

    GetNotesCountForCurrentBuffer = count.GetNotesCountForCurrentBuffer,
    GetNotesCountForCWD = count.GetNotesCountForCWD,
    GetNotesCountForGlobal = count.GetNotesCountForGlobal,

    JumpToNextNote = jump.JumpToNextNote,
    JumpToPreviousNote = jump.JumpToPreviousNote,

    ShowNoteSigns = sign.ShowNoteSigns,
    HideNoteSigns = sign.HideNoteSigns,
    DefineSign = sign.DefineSign,
    ToggleNoteSigns = sign.ToggleNoteSigns,

    ExportNotesForCurrentBuffer = data.ExportNotesForCurrentBuffer,
    ExportNotesForGlobal = data.ExportNotesForGlobal,
    ExportNotesForCWD = data.ExportNotesForCWD,


}
