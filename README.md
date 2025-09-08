# <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" alt="nvim" width="24"/> neovim config
configuration for neovim text editor.

## installation
install the latest version from and the required packages.
   ```bash
   sudo pacman -Syu
   sudo pacman -Sy neovim python3 python-pip python-virtualenv fzf ripgrep bat inotify nodejs npm python-virtualenv
   sudo npm update -g
   ```

create the python 3 environment and install the required libraries
   ```bash
   virtualenv $HOME/.venvs/nvim
   source $HOME/.venvs/nvim/bin/activate
   pip3 install neovim pynvim black==22.10.0 isort flake8 
   ```
clone this repository into the neovim configuration directory:
```bash
mkdir -p $HOME/.config/nvim
git clone https://www.github.com/ricalbr/nvim $HOME/.config/nvim
```

---

## useful commands
- **update plugins**: `:lua vim.pack.update()`
- **check LSP info**: `:LspInfo`
- **debug config**: `:checkhealth`
---

## see also
[neovim github release page](https://github.com/neovim/neovim/releases) 

---
