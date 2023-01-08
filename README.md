# Quick Note

This is a note taking plugin for Neovim, aiming to help you quickly create, delete, read, and edit notes.

A note can be associated with current cursor line, or current working directory, or be put in global. Thus, for example, a typical use case is that when you are reading source code, you can quickly create note associated with the cursor line where the source code may confuse you, then write down some notes and continue reading. A while later, when you want to read the note you have created at that cursor line, just go back to that cursor line and open the note associated with it.

![Showcase](./showcase.gif)

## Installation
Use any plugin manager you like.

Like, for lazy.nvim (a modern plugin manager for Neovim): 

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={}, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## Features
- [x] In-place notes: taking notes in-place and quickly and let the notes associated with current cursor line, working directory or global directory.  
- [x] Jump between notes: easily jump between notes in current buffer.
- [x] List notes: say the notes you have writen.
- [x] Delete notes: delete notes you do not need quickly and in-place
- [x] Export notes: export all notes in current buffer, working directory, or global directory to your destination folder.
- [x] Import notes: import all notes for current buffer, working directory, or global directory from your external note folder.
- [x] Signs: signs show you which line is associated with a note.
- [x] Portable: notes can be portable, stored at `.quicknote` folder at your CWD

## API

Still in active development, some APIs may be broken later.

1. New note

| Function | Description |
| --- | ---|
| `NewNoteAtCWD()` | create a note at current working directory|
| `NewNoteAtLine(line)`| create a note at a give line|
| `NewNoteAtCurrentLine()`| create a note at current cursor line|
| `NewNoteAtGlobal` | create a note which can be accessed globally|

2. Open note 

| Function | Description |
| --- | ---|
| `OpenNoteAtCWD()` | open a note at CWD, you will input the name of the note|
| `OpenNoteAtLine(line)` | open a note associated with a given line |
| `OpenNoteAtCurrentLine(line)` | open a note associated with the current cursor line |
| `OpenNoteAtGlobal()` | open a note in global, you will input the name of the note |

3. Delete note

| Function | Description |
| --- | ---|
| `DeleteNoteAtCWD()` | delete a note at CWD, you will input the name of the note|
| `DeleteNoteAtLine(line)` | delete a note associated with a given line|
| `DeleteNoteAtCurrentLine(line)` | delete a note associated with the current cursor line|
| `DeleteNoteAtGlobal()` | delete a note in global, you will input the name of the note |

4. List note

| Funtion | Description |
| --- | --- |
| `ListNotesForCurrentBuffer()` | list all notes associated with current buffer |
| `ListNotesForCWD()` | list all notes created in CWD |
| `ListNotesForGlobal()`| list all notes in global |
| `ListNotesForAFileOrWDInCWD()` | list all notes for a certain file or directory under CWD |

5. Jump to note

| Function | Description |
| --- | --- |
| `JumpToNextNote()` | jump to next avaiable note in current buffer |
| `JumpToPreviousNote()` | jump to previous avaiable note in current buffer |

6. Notes count

| Function | Description |
| --- | ---|
| `GetNotesCountForCurrentBuffer()` | get notes count for current buffer |
| `GetNotesCountForCWD()` |  get notes count for CWD |
| `GetNotesCountForGlobal()`| get notes count for global|

7. Signs

| Funtion | Description |
| --- | --- |
| `ShowNoteSigns()` | show signs for current buffer |
| `HideNoteSigns()` | hide signs for current buffer |
| `ToggleNoteSigns()` | toggle signs |

8. Export notes

| Funtion | Description |
| --- | --- |
| `ExportNotesForCurrentBuffer()` | export all notes associated with the current buffer to a destination dir |
| `ExportNotesForCWD()` | export all notes associated with CWD, but notes associated with the files under CWD are not exported | 
| `ExportNotesForGlobal()` | export all notes that have been put in global | 

9. Import notes

| Funtion | Description |
| --- | --- |
| `ImportNotesForCurrentBuffer()` | import notes from external note folder to current buffer |
| `ImportNotesForCWD()` | import notes from external note folder to CWD |
| `ImportNotesForGlobal()` | import notes from external note folder to global |

10. Swicth Mode

| Funtion | Description |
| --- | --- |
| `SwitchToResidentMode()` | swicth to resident mode|
| `SwitchToPortableMode()` | switch to portable mode|
| `ToggleMode()` | toggle mode |





For example, you can use the code below to map a key to one of the function above:
```lua
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>",{})
```




