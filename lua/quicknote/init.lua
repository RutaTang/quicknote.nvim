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

    JumpToNextNote = core.JumpToNextNote,
    JumpToPreviousNote = core.JumpToPreviousNote,

    -- TODO:
    -- Get count of notes
    -- Import note
    -- Clear note in current buffer, cwd, global
    -- (Optional for now) Make notes portable, located in CWD rather than in data folder
    -- (Optional for now) open web browser to show note (list)
    -- (Optional for now) integrate with telescope

    ShowNoteSigns = core.ShowNoteSigns,
    HideNoteSigns = core.HideNoteSigns,
    ToggleNoteSigns = core.ToggleNoteSigns,

    -- TODO:
    -- Export note at current line
    -- Export note at and under cwd
    ExportNotesForCurrentBuffer = core.ExportNotesForCurrentBuffer,
    ExportNotesForCWD = core.ExportNotesForCWD,
    ExportNotesForGlobal = core.ExportNotesForGlobal,
}
