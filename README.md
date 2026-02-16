# Dependencies
This project requires Neovim. Install via your preferred package manager.

***Arch Linux***
```md
sudo pacman -S --noconfirm wl-clipboard neovim deno lazygit sox cargo ripgrep noto-fonts-emoji imagemagick curl shfmt luarocks lua51 npm jdk-openjdk python tree-sitter-cli sshfs hyperfine
```

***macOS***

```md
brew install neovim curl sox
```

My configuration also comes with some languages that are installed via Mason, some of which require Npm. If you wish to use any of the languages I use, download Npm, otherwise remove the LSPs listed in the lspconfig.lua file after installation.

Install Npm via your preferred package manager.

***Arch Linux***

```md
sudo npm install -g neovim prettier
sudo pacman -S --noconfirm rustup
rustup update stable
cargo install stylua
```

***macOS***

```md
brew install npm 
npm install -g neovim tree-sitter-cli prettier
tree-sitter generate regex rust
cargo install stylua 
```

# Installation
1. Clone Repository:

In order to install, clone the repository.

```md
git clone https://github.com/HiFiveJazz/Neovim-Configuration
```

2. Move into the Neovim .config directory:

```md
mv Neovim-Configuration/* ~/.config/nvim/
```

You're all done!

