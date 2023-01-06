local async = require("plenary.async")

local utils = require("quicknote.utils")
utils.fs = require("quicknote.utils.fs")
local core = require("quicknote.core")

local setup = function(config)
    -- init data folder for quick note
    async.run(function()
        utils.fs.MKDirAsync(utils.fs.GetDataPath())
    end, function() end)
    -- Define sign for quicknote
    core.DefineSign()
end

-- Define API
return {
    -- TODO:
    -- Import note
    -- Clear note in current buffer, cwd, global
    -- (Optional for now) Make notes portable, located in CWD rather than in data folder, and enable temporarily/persistantly swicth between them
    -- (Optional for now) open web browser to show note (list)
    -- (Optional for now) integrate with telescope

    setup = setup,

    NewNoteAtCWD = core.NewNoteAtCWD,
    NewNoteAtLine = core.NewNoteAtLine,
    NewNoteAtCurrentLine = core.NewNoteAtCurrentLine,
    NewNoteAtGlobal = core.NewNoteAtGlobal,

    OpenNoteAtLine = core.OpenNoteAtLine,
    OpenNoteAtCurrentLine = core.OpenNoteAtCurrentLine,
    OpenNoteAtGlobal = core.OpenNoteAtGlobal,
    OpenNoteAtCWD = core.OpenNoteAtCWD,

    DeleteNoteAtLine = core.DeleteNoteAtLine,
    DeleteNoteAtCurrentLine = core.DeleteNoteAtCurrentLine,
    DeleteNoteAtGlobal = core.DeleteNoteAtGlobal,
    DeleteNoteAtCWD = core.DeleteNoteAtCWD,

    ListNotesForCurrentBuffer = core.ListNotesForCurrentBuffer,
    ListNotesForCWD = core.ListNotesForCWD,
    ListNotesForAFileOrWDInCWD = core.ListNotesForAFileOrWDInCWD,
    ListNotesForGlobal = core.ListNotesForGlobal,

    GetNotesCountForCurrentBuffer = core.GetNotesCountForCurrentBuffer,
    GetNotesCountForCWD = core.GetNotesCountForCWD,
    GetNotesCountForGlobal = core.GetNotesCountForGlobal,

    JumpToNextNote = core.JumpToNextNote,
    JumpToPreviousNote = core.JumpToPreviousNote,

    ShowNoteSigns = core.ShowNoteSigns,
    HideNoteSigns = core.HideNoteSigns,
    ToggleNoteSigns = core.ToggleNoteSigns,

    -- TODO:
    -- (Optional) Export note at current line
    -- (Optional) Export note at and under cwd
    ExportNotesForCurrentBuffer = core.ExportNotesForCurrentBuffer,
    ExportNotesForGlobal = core.ExportNotesForGlobal,
    ExportNotesForCWD = core.ExportNotesForCWD,

}
