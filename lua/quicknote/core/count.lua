local utils = require("quicknote.utils")

local getNotesCount = function(noteDirPath)
  -- check if note dir exist
  vim.loop.fs_stat(noteDirPath, function(err, _)
    if err then
      print("No notes for current buffer found.")
    else
      -- list all notes
      vim.defer_fn(function()
        local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)
        if noteFilePaths == nil then
          print("No notes found.")
        else
          if #noteFilePaths == 0 then
            print("No notes found.")
            return
          end
          local message = "Notes count for current buffer: " .. #noteFilePaths
          vim.api.nvim_command("echo '" .. message .. "'")
        end
      end, 0)
    end
  end)
end

-- Export
local M = {}

local GetNotesCountForCurrentBuffer = function()
  -- get note dir path
  local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()

  getNotesCount(noteDirPath)
end
M.GetNotesCountForCurrentBuffer = GetNotesCountForCurrentBuffer

local GetNotesCountForCWD = function()
  -- get note dir path
  local noteDirPath = utils.path.getNoteDirPathForCWD()

  getNotesCount(noteDirPath)
end
M.GetNotesCountForCWD = GetNotesCountForCWD

local GetNotesCountForGlobal = function()
  -- get note dir path
  local noteDirPath = utils.path.getNoteDirPathForGlobal()
  print(noteDirPath)

  getNotesCount(noteDirPath)
end
M.GetNotesCountForGlobal = function()
  if utils.config.GetMode() ~= "resident" then
    print("Get global notes count just works in resident mode")
    return
  end
  GetNotesCountForGlobal()
end

return M
