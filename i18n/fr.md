# Quick Note

*Remarque : le français n'est pas ma langue indigène et je ne suis pas encore très expérimenté avec le français. Ainsi, si vous rencontrez des problèmes de faute de frappe ou de grammaire, s'il vous plaît, faites-moi savoir.*

Ceci est un plugiciel de prise de note pour « Neovim », visant à vous aider à créer, supprimer, lire et modifier rapidement des notes.

Une note peut être associée avec la ligne du curseur courant, répertoire du travail courant, ou peut être globale. Par exemple, un cas d’utilisation typique est quand vous lisez du code source, vous pouvez rapidement créer des notes associées avec la ligne du curseur courant où du code source vous confond possiblement et alors noter les quelques notes. Continuez à lire. Un peu plus tard, quand vous voulez de voir les notes que vous avez créées, retourner à la ligne et ouvrir le note.


![Showcase](../asset/showcase.gif)

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
  { "RutaTang/quicknote.nvim", config={}, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

Pour packer.nvim

```lua
require('packer').startup(function(use)
    use { "RutaTang/quicknote.nvim", requires={"nvim-lua/plenary.nvim"}, config = function() require('quicknote').setup{} end }
end)
```

## Configuration

Actuellement, il y a qu’une seule option de configuration. Mais d’autres options pourraient arriver.

```lua
require("lazy").setup({
  { "RutaTang/quicknote.nvim", config={
    mode = "portable" -- "portable" | "resident", default to "portable"
  }, dependencies = { "nvim-lua/plenary.nvim"} },
})
```

## Tutoriel

### Démarrage rapide / Utilisation de base

1. Ouvrir un fichier.
2. À une certaine ligne, en mode ligne de commande, exécutez :lua require('quicknote').NewNoteAtCurrentLine(). Maintenant, une note a été créée et associée à la ligne du curseur actuel. Mais vous ne voyez pas encore de signes sur le côté gauche.
3. À la même ligne, en mode ligne de commande, exécutez :lua require('quicknote').ShowNoteSigns(). Maintenant, vous pouvez voir un signe juste sur le côté gauche de la ligne du curseur actuel, qui indique que la note que vous avez créée est à cette ligne.
4. À la même ligne, lorsque vous voulez relire ou modifier la note que vous venez de créer, exécutez :lua require('quicknote').OpenNoteAtCurrentLine(). Maintenant, la note sera ouverte et vous pourrez la modifier. C'est simplement un fichier markdown.
