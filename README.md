# <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" alt="nvim" width="24"/> Neovim config
Configuration for Neovim text editor.

## Installation

### Requirements and Dependencies

Make sure the following are installed on your system:

1. **Neovim** (version >= 0.9.0):
   Install the latest version from [Neovim's GitHub releases](https://github.com/neovim/neovim/releases).
   
   #### Ubuntu/Debian:
   ```bash
   sudo apt update
   sudo apt install neovim
   ```
   
   #### Arch:
   ```bash
   sudo pacman -Syu
   sudo pacman -Sy neovim
   ```

3. **Python** (for `pynvim`):
   Install Python 3 and the required library.
   
   #### Ubuntu/Debian:
   ```bash
   sudo apt install python3 python3-pip python3-virtualenv
   virtualenv $HOME/.venvs/nvim
   source $HOME/.venvs/nvim/bin/activate
   pip3 install --user pynvim
   ```
   
   #### Arch:
   ```bash
   sudo pacman -Sy python3 python-pip python-virtualenv
   virtualenv $HOME/.venvs/nvim
   source $HOME/.venvs/nvim/bin/activate
   pip3 install pynvim
   ```

5. **Node.js and npm**:
   Required for plugins and the Language Server Protocol (LSP). Install it via a package manager or [nvm](https://github.com/nvm-sh/nvm).

   #### Ubuntu/Debian:
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
   nvm install --lts
   nvm reinstall-packages system
   npm install -g npm-check-updates
   ncu -ug
   npm update -g
   ```

   #### Arch:
   ```bash
   sudo pacman -Sy npm
   sudo npm update -g
   ```

7. **Optional utilities**:
   - `ripgrep` (for better search), `bat` (for better highlight), `fzf` (fuzzy finder).
     #### Ubuntu/Debian:
     ```bash
     sudo apt install fzf ripgrep bat
     ```
     #### Arch:
     ```bash
     sudo pacman -Sy fzf ripgrep bat stylua
     ```
   - `python` setup:
      ```bash
      pip install neovim pynvim black==22.10.0 isort flake8
      ```

### Clone the Repository

Clone this repository into your Neovim configuration directory:

```bash
mkdir -p ~/.config/nvim
git clone https://www.github.com/ricalbr/nvim ~/.config/nvim
```

---

## Useful Commands

- **Install Plugins**: `:Lazy sync`
- **Update Plugins**: `:Lazy update`
- **Check LSP Info**: `:LspInfo`
- **Debug Config**: `:checkhealth`

---
