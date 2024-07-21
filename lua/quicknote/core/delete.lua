local path = require("plenary.path")
local utils = require("quicknote.utils")
local sign = require("quicknote.core.sign")

-- check if note file exist, if exists, delete it
local checkAndDeleteNoteFile = function(noteFilePath)
  vim.loop.fs_stat(noteFilePath, function(err, _)
    if err then
      print("Note not found.")
    else
      -- delete note file
      local success, err = os.remove(noteFilePath)
      if success then
        print("Note deleted.")
      else
        print("Note delete failed: " .. err)
      end
    end
  end)
end

local M = {}
-- Delete an already existed note at a given line for the current buffer
-- @param line: line number
local DeleteNoteAtLine = function(line)
  local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()
  -- get note file path
  local noteFilePath = path:new(noteDirPath, line .. "." .. utils.config.GetFileType()).filename

  -- check if note file exist
  checkAndDeleteNoteFile(noteFilePath)

  -- if the show sign is enabled, show the sign
  vim.defer_fn(sign.ReShowSignsForCurrentBuffer, 10)
end
M.DeleteNoteAtLine = DeleteNoteAtLine

-- Delete an already existed note at current cursor line for current buffer
local DeleteNoteAtCurrentLine = function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  DeleteNoteAtLine(line)
end
M.DeleteNoteAtCurrentLine = DeleteNoteAtCurrentLine

-- Delete an already existed note at global
local DeleteNoteAtGlobal = function()
  -- get file name from user input
  local fileName = vim.fn.input("Enter note name: ")

  -- get note dir path
  local noteDirPath = utils.path.getNoteDirPathForGlobal()

  -- get note file path
  local noteFilePath = path:new(noteDirPath, fileName .. "." .. utils.config.GetFileType()).filename

  -- check if note file exist
  checkAndDeleteNoteFile(noteFilePath)
end
M.DeleteNoteAtGlobal = function()
  if utils.config.GetMode() ~= "resident" then
    print("Delete note globally just works in resident mode")
    return
  end
  DeleteNoteAtGlobal()
end

-- Delete an already existed note at CWD
local DeleteNoteAtCWD = function()
  -- get file name from user input
  local fileName = vim.fn.input("Enter note name: ")

  -- get note dir path
  local noteDirPath = utils.path.getNoteDirPathForCWD()

  -- get note file path
  local noteFilePath = path:new(noteDirPath, fileName .. "." .. utils.config.GetFileType()).filename

  -- check if note file exist
  checkAndDeleteNoteFile(noteFilePath)
end
M.DeleteNoteAtCWD = DeleteNoteAtCWD

return M
