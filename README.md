# Dependencies
This project requires NeoVim. Install via your preferred package manager.

***Arch Linux***
```md
sudo pacman -S neovim
```

***macOS***

```md
brew install neovim
```

My config also comes with some languages that are installed via Mason, some of which require Npm. If you wish to use any of the languages I use, download Npm, otherwise remove the LSPs listed in the lspconfig.lua file after installation.

Install Npm via your preferred package manager.

***Arch Linux***

```md
sudo pacman -S npm
```

***macOS***

```md
brew install npm
```

# Installation
1. Clone Repository:

In order to install, clone the repository.

```md
git clone https://github.com/HiFiveJazz/NeoVim-Config
```

2. Move into the Neovim .config directory:

```md
mv NeoVim-Config/* ~/.config/nvim/
```

You're all done!
