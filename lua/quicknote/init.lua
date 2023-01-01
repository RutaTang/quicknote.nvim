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

    ShowNoteSigns = core.ShowNoteSigns,
    HideNoteSigns = core.HideNoteSigns,
    ToggleNoteSigns = core.ToggleNoteSigns,
}
