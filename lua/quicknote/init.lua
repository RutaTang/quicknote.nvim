local async = require("plenary.async")

local utils = require("quicknote.utils")
local core = require("quicknote.core")

local setup = function(config)
    -- setup config
    utils.config.setup(config)
    -- init data folder for quick note
    async.run(function()
        utils.fs.MKDirAsync(utils.path.GetDataPath())
    end, function() end)
    -- Define sign for quicknote
    core.DefineSign()
end

-- Define API
return {
    -- TODO:
    -- Clear note in current buffer, cwd, global
    -- (Optional for now) open web browser to show note (list)
    -- (Optional for now) integrate with telescope

    setup = setup,

    SwitchToResidentMode = core.SwitchToResidentMode,
    SwitchToPortableMode = core.SwitchToPortableMode,
    ToggleMode = core.ToggleMode,

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
    -- (Optional) Export note at and under cwd
    ExportNotesForCurrentBuffer = core.ExportNotesForCurrentBuffer,
    ExportNotesForGlobal = core.ExportNotesForGlobal,
    ExportNotesForCWD = core.ExportNotesForCWD,

    ImportNotesForCurrentBuffer = core.ImportNotesForCurrentBuffer,
    ImportNotesForGlobal = core.ImportNotesForGlobal,
    ImportNotesForCWD = core.ImportNotesForCWD,
}
