# Quick Note

<p align="center">
<a href="./i18n/zh.md">[简体中文]</a>
<a href="./i18n/fr.md">[Français]</a>
</p>

<p align="center">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/RutaTang/quicknote.nvim">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/RutaTang/quicknote.nvim">
<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/RutaTang/quicknote.nvim">
<img alt="GitHub issues" src="https://img.shields.io/github/issues-raw/RutaTang/quicknote.nvim">
<img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/RutaTang/quicknote.nvim">
</p>


This is a note taking plugin for Neovim, aiming to help you quickly create, delete, read, and edit notes.

A note can be associated with current cursor line, or current working directory, or be put in global. Thus, for example, a typical use case is that when you are reading source code, you can quickly create note associated with the cursor line where the source code may confuse you, then write down some notes and continue reading. A while later, when you want to read the note you have created at that cursor line, just go back to that cursor line and open the note associated with it.

![Showcase](./asset/showcase.gif)

## Features

🎉 **All main features have already been implemented**. New features may probabily be introduced after fixing potential bugs, optimizing, and writing instruction/tutorial.

- [x] In-place notes: no worrying about jumpping out of current workflow to take notes or managing the notes tediously. Just take notes in-place and make the notes associate with current cursor line, working directory or global directory.  
- [x] Jump between notes: easily jump between notes in current buffer.
- [x] List notes: list the notes you have writen.
- [x] Delete notes: delete notes you do not need quickly and in-place
- [x] Export notes: export all notes in current buffer, working directory, or global directory to your destination folder.
- [x] Import notes: import all notes for current buffer, working directory, or global directory from your external note folder.
- [x] Signs: signs show you which line is associated with a note.
- [x] Portable: notes can be portable, stored at `.quicknote` folder at your CWD.

## Installation
Use any plugin manager you like.

*Note: This plugin uses [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim), thus please make sure it is in the dependencies or in your plugin list.*

For lazy.nvim (a modern plugin manager for Neovim): 

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={}, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

For packer.nvim:

```lua
require('packer').startup(function(use)
    use { "RutaTang/quicknote.nvim", requires={"nvim-lua/plenary.nvim"}, config = function() require('quicknote').setup{} end }
end)
```

## Config

Currently, there is only one config option, but more options might be coming.

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={
    mode = "portable" -- "portable" | "resident", default to "portable"
  }, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## Tutorial

### Quick Start / Basic Usage

1. Open a file.
2. At a certain line, in Command-line mode, run `:lua require('quicknote').NewNoteAtCurrentLine()`. Now, a note has been created and associated with current cursor line. But you do not see any signs on the left side now.
3. At the same line, in Command-line mode, run `:lua require('quicknote').ShowNoteSigns()`. Now you can say a sign just on the left side at the current cursor line, which shows you that the note you have created is at this line.
4. At the same line, when you want to reread or edit the note you just created, run `:lua require('quicknote').OpenNoteAtCurrentLine()`. Now, the note will be opened and you can edit it. It is just a markdown file.

### Advanced Usage

#### 1. How quicknote.nvim works ?

Whenever you create a note associated to the current cursor line, CWD or global, a folder named by the hashed path of current buffer or CWD will be created and I call it "Note Directory" which will store all your notes associated with a certain buffer, CWD or global (Global note directory is not hashed and just named as "global").

For example, when you create a note at line 2 in a file named `hello_world.lua`, you will have a "Note Directory" created at "Data Path" (in "resident" mode, it is `vim.fn.stdpath("state") .. "/quicknote"`; in "portable" mode, it is ".quicknote" at root of your CWD). In the "Data Path", you will see a folder with hashed name, and if you open it, you will see "2.md" which is the note you have just created for this file and "2" means it is associated with line 2.

#### 2. Resident mode vs Protable mode

There are two modes in quicknote.nvim, "resident" mode and "protable" mode. They are almost similar. The big differences are:

1. **`Global` API**: in resident mode, you can use API ended with `Global` and notes stored globally can be accessed whenever you use Neovim, even if you are not in the working directory where you created your notes.  In portable note, you can not use API ended with `Global`.
2. **Pollution or not**:In resident mode, all notes, regardless of whether they are associated with files, CWD or global, will be put in `$XDG_STATE_PATH` and will never pollute your project. But in portable mode, since notes will be located in the `.quicknote` folder in your CWD, it may pollute your project if you consider it as a "pollution".
2. **Portable or not**: In resident mode, the notes you have created will be hard to transfer to another computer. And if you move project which have notes associated with it to another computer or even another directory, all notes associated with it will be lost. But in protable note, you can transfer your project from one path to another or from one computer to another without worrying about lossing notes. You can even share the project with notes to your colleagues or friends who use Neovim and this plugin. They will be able to see the notes you have created.

## API

I do not want to break any APIs when you are using this plugin, but it is still possible if some APIs are not rational or potential bugs force them to be changed. I may use semantic versioning later to avoid breaking APIs in the major version.

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



