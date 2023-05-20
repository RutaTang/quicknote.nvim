# Quick Note

*Remarque : le français n'est pas ma langue indigène et je ne suis pas encore très expérimenté avec le français. Ainsi, si vous rencontrez des problèmes de faute de frappe ou de grammaire, s'il vous plaît, faites-moi savoir.*

Ceci est un plugiciel de prise de note pour « Neovim », visant à vous aider à créer, supprimer, lire et modifier rapidement des notes.

Une note peut être associée avec la ligne du curseur courant, répertoire du travail courant, ou peut être globale. Par exemple, un cas d’utilisation typique est quand vous lisez du code source, vous pouvez rapidement créer des notes associées avec la ligne du curseur courant où du code source vous confond possiblement et alors noter les quelques notes. Continuez à lire. Un peu plus tard, quand vous voulez de voir les notes que vous avez créées, retourner à la ligne et ouvrir le note.

<p align="center">
  <img src="../asset/showcase.gif">
</p>


## Les fonctionnalités

🎉 **Toutes les fonctionnalités principales ont déjà été mises en œuvre.** De nouvelles fonctionnalités peuvent probablement être introduites après la correction de bogues potentiels, l’ optimisation et la rédaction d’instructions/didacticiels.

- [x] Le prenant des notes en place: ne vous inquiétez pas de sortir du flux de travail actuel pour prendre des notes ou de gérer les notes fastidieusement. Prenez simplement des notes en place et associez-les à la ligne de curseur actuelle, au répertoire de travail ou au répertoire global.
- [x] Sautez entre des notes: sautez facilement entre des notes dans le tampon actuel.
- [x] Listez des notes: listez des notes que vous avez écrites.
- [x] Supprimez des notes: supprimez des notes dont vous n’avez pas besoin vite et en place.
- [x] Exportez des notes: exportez facilement toute note que vous avez créée.
- [x] Importez des notes: importez facilement toute note à partir de sources externes.
- [x] Signes: les signes vous montrent quelle ligne est associée à une note.
- [x] Portatif: des notes peuvent être portables, stockées dans le dossier appelé «.quicknote» dans votre répertoire de travail courant.

## Installation

Utilisez n’importe quel gestionnaire de plugins que vous aimez.

*Remarque: Ce plugin utilise le [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim), alors assurez qu’il est dans les dépendances ou dans votre liste de plugin.*

Pour lazy.nvim (le plugin gestionnaire moderne pour Neovim):

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config=function()
        -- you must call setup to let quicknote.nvim works correctly
        require("quicknote").setup({})
  end
  , dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## Configuration

Actuellement, il y a qu’une seule option de configuration. Mais d’autres options pourraient arriver.

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config=function()
        require("quicknote").setup({
            mode = "portable" -- "portable" | "resident", default to "portable"
        })
  end
  , dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## Tutoriel

### Démarrage rapide / Utilisation de base

1. Ouvrir un fichier.
2. À une certaine ligne, en mode ligne de commande, exécutez :lua require('quicknote').NewNoteAtCurrentLine(). Maintenant, une note a été créée et associée à la ligne du curseur actuel. Mais vous ne voyez pas encore de signes sur le côté gauche.
3. À la même ligne, en mode ligne de commande, exécutez :lua require('quicknote').ShowNoteSigns(). Maintenant, vous pouvez voir un signe juste sur le côté gauche de la ligne du curseur actuel, qui indique que la note que vous avez créée est à cette ligne.
4. À la même ligne, lorsque vous voulez relire ou modifier la note que vous venez de créer, exécutez :lua require('quicknote').OpenNoteAtCurrentLine(). Maintenant, la note sera ouverte et vous pourrez la modifier. C'est simplement un fichier markdown.

### Utilisation avancée

#### 1. Comment fonctionne quicknote.nvim ?

Chaque fois que vous créez une note associée à la ligne de curseur actuelle, au CWD (répertoire de travail courant) ou globale, un dossier nommé d'après le chemin haché du tampon actuel ou du CWD sera créé et je l'appelle "Répertoire de notes" qui stockera toutes vos notes associées à un certain tampon, CWD ou global (Le répertoire de notes global n'est pas haché et est simplement nommé "global").

Par exemple, lorsque vous créez une note à la ligne 2 dans un fichier nommé `hello_world.lua`, vous aurez un "Répertoire de notes" créé au "Chemin des données" (en mode "résident", il s'agit de `vim.fn.stdpath("state") .. "/quicknote"` ; en mode "portable", il s'agit de ".quicknote" à la racine de votre CWD). Dans le "Chemin des données", vous verrez un dossier au nom haché, et si vous l'ouvrez, vous verrez "2.md" qui est la note que vous venez de créer pour ce fichier et "2" signifie qu'elle est associée à la ligne 2.

#### 2. Mode résident vs Mode portable

Il y a deux modes dans quicknote.nvim, le mode "résident" et le mode "portable". Ils sont presque similaires. Les grandes différences sont :

1. **`API Global`** : en mode résident, vous pouvez utiliser l'API se terminant par `Global` et les notes stockées globalement peuvent être accessibles chaque fois que vous utilisez Neovim, même si vous n'êtes pas dans le répertoire de travail où vous avez créé vos notes. Dans le mode portable, vous ne pouvez pas utiliser l'API se terminant par `Global`.
2. **Pollution ou non** : En mode résident, toutes les notes, qu'elles soient associées à des fichiers, CWD ou globales, seront placées dans `$XDG_STATE_PATH et ne pollueront jamais votre projet. Mais en mode portable, puisque les notes seront situées dans le dossier `.quicknote` de votre CWD, cela peut polluer votre projet si vous considérez cela comme une "pollution".
3. **Portable ou non** : En mode résident, les notes que vous avez créées seront difficiles à transférer vers un autre ordinateur. Et si vous déplacez un projet qui a des notes associées vers un autre ordinateur ou même un autre répertoire, toutes les notes associées seront perdues. Mais en mode portable, vous pouvez transférer votre projet d'un chemin à un autre ou d'un ordinateur à un autre sans vous soucier de perdre des notes. Vous pouvez même partager le projet avec des notes à vos collègues ou amis qui utilisent Neovim et ce plugin. Ils pourront voir les notes que vous avez créées.


## API

Je ne veux pas casser les APIs lorsque vous utilisez ce plugin, mais cela reste possible si certaines APIs ne sont pas rationnelles ou si des bogues potentiels les obligent à être modifiées. Je pourrais utiliser la version sémantique plus tard pour éviter de casser les APIs dans la version majeure.

1. Nouvelle note

| Fonction | Description |
| --- | ---|
| `NewNoteAtCWD()` | créer une note dans le répertoire de travail actuel |
| `NewNoteAtLine(line)`| créer une note à une ligne donnée |
| `NewNoteAtCurrentLine()`| créer une note à la ligne du curseur actuel |
| `NewNoteAtGlobal` | créer une note accessible globalement |

2. Ouvrir une note

| Fonction | Description |
| --- | ---|
| `OpenNoteAtCWD()` | ouvrir une note dans le répertoire de travail actuel, vous saisirez le nom de la note |
| `OpenNoteAtLine(line)` | ouvrir une note associée à une ligne donnée |
| `OpenNoteAtCurrentLine(line)` | ouvrir une note associée à la ligne du curseur actuel |
| `OpenNoteAtGlobal()` | ouvrir une note globalement, vous saisirez le nom de la note |

3. Supprimer une note

| Fonction | Description |
| --- | ---|
| `DeleteNoteAtCWD()` | supprimer une note dans le répertoire de travail actuel, vous saisirez le nom de la note |
| `DeleteNoteAtLine(line)` | supprimer une note associée à une ligne donnée |
| `DeleteNoteAtCurrentLine(line)` | supprimer une note associée à la ligne du curseur actuel |
| `DeleteNoteAtGlobal()` | supprimer une note globalement, vous saisirez le nom de la note |

4. Note de liste

| Fonction | Description |
| --- | --- |
| `ListNotesForCurrentBuffer()` | liste toutes les notes associées au tampon actuel |
| `ListNotesForCWD()` | liste toutes les notes créées dans le CWD |
| `ListNotesForGlobal()`| liste toutes les notes globales |
| `ListNotesForAFileOrWDInCWD()` | liste toutes les notes pour un certain fichier ou répertoire sous CWD |

5. Aller à la note

| Fonction | Description |
| --- | --- |
| `JumpToNextNote()` | aller à la note suivante disponible dans le tampon actuel |
| `JumpToPreviousNote()` | aller à la note précédente disponible dans le tampon actuel |

6. Comptage des notes

| Fonction | Description |
| --- | ---|
| `GetNotesCountForCurrentBuffer()` | obtenir le nombre de notes pour le tampon actuel |
| `GetNotesCountForCWD()` |  obtenir le nombre de notes pour le répertoire de travail actuel |
| `GetNotesCountForGlobal()`| obtenir le nombre de notes pour le global|

7. Signes

| Fonction | Description |
| --- | --- |
| `ShowNoteSigns()` | afficher les signes pour le tampon actuel |
| `HideNoteSigns()` | masquer les signes pour le tampon actuel |
| `ToggleNoteSigns()` | basculer les signes |

8. Exporter les notes

| Fonction | Description |
| --- | --- |
| `ExportNotesForCurrentBuffer()` | exporter toutes les notes associées au tampon actuel vers un répertoire de destination |
| `ExportNotesForCWD()` | exporter toutes les notes associées au CWD, mais les notes associées aux fichiers sous CWD ne sont pas exportées |
| `ExportNotesForGlobal()` | exporter toutes les notes qui ont été mises en global |

9. Importer des notes

| Fonction | Description |
| --- | --- |
| `ImportNotesForCurrentBuffer()` | importer des notes depuis un dossier de notes externe vers le tampon actuel |
| `ImportNotesForCWD()` | importer des notes depuis un dossier de notes externe vers le répertoire de travail actuel |
| `ImportNotesForGlobal()` | importer des notes depuis un dossier de notes externe vers le global |

10. Changer de mode

| Fonction | Description |
| --- | --- |
| `SwitchToResidentMode()` | passer en mode résident |
| `SwitchToPortableMode()` | passer en mode portable |
| `ToggleMode()` | basculer entre les modes |





Par example, vous pouvez utiliser le code ci-dessous pour associer une touche à l'une des fonctions ci-dessus :
```lua
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>",{})
```

