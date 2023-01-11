# Quick Note

这是一个为Neovim设计的做笔记的插件，旨在帮助你快速创建，删除，读，改笔记。

一个笔记可以和当前的光标行，当前工作目录相关联，或者被放在全局中。因此，一个典型的使用场景就是，当你在读源码时，你可以快速地创建一个与当前光标行相关联的笔记，来记录你对当前源码感到疑惑的地方，然后继续向下看源码。当之后你想回顾你之前在那行所做的笔记的时候，只需要回到那行，打开与其关联的笔记即可。

![Showcase](../asset/showcase.gif)

## 功能/特点

**所有主要功能已经实现。** 新的功能会在修复潜在的Bugs，优化，和写完教程指引之后再被添加。

- [x] 原地做笔记：无需担心中断或跳出当前工作流程去做笔记或管理笔记。只需原地创建和当前光标行，工程目录，或全局相关联的笔记。
- [x] 在笔记间跳跃：支持快速在当前Buffer跳跃到下一个/上一个笔记。
- [x] 列出笔记：列出你所创建的笔记。
- [x] 删除笔记：原地删除笔记。
- [x] 导入/导出笔记：导入/导出与当前Buffer或工作目录相关联，或被放在全局的笔记。
- [x] Signs: sign将显示在有笔记相关联的行的左侧。
- [x] 可携带：笔记被存放在当前工作目录的 `.quicknote` 目录下。


## 安装

使用任何你喜欢的 plugin manager 。

*注意：本插件使用了 [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim), 所以请确保它在你的插件依赖项中，或在你的插件列表中。*

比如 lazy.nvim:

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={}, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

或 packer.nvim:

```lua
require('packer').startup(function(use)
    use { "RutaTang/quicknote.nvim", requires={"nvim-lua/plenary.nvim"}, config = function() require('quicknote').setup{} end }
end)
```

## 配置

当前只有一个可选配置项，但是在之后的更新中，可能有更多的配置项可选。

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={
    mode = "portable" -- "portable" | "resident", 默认 "portable"
  }, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## 教程

### 快速开始 / 基本使用


### 进阶使用
