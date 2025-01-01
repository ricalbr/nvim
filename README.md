# nvim

neovim config

### requirements

install following requirements:

- python
- npm
- unzip
- python3-pip
- python3-virtualenv
- fzf
- ripgrep
- fd
- clangd
- clang-format
- clang-tools
- julia
- luajit
- clazy

##### ubuntu

```bash
sudo apt install npm unzip python3-pip python3-virtualenv fzf ripgrep clangd clang-format clang-tools julia luajit
```

##### arch-based

```bash
sudo pacman -Sy npm unzip python3-pip python3-virtualenv fzf ripgrep clangd clang-format clang-tools julia luajit
```

# setup environments

```
npm install -g neovim prettier
```

```
virtualenv $HOME/.venvs/nvim
source $HOME/.venvs/nvim/bin/activate
pip install neovim pynvim black isort flake8
```

### formatting

install external formatters in the system that hooks into neovim using null-ls.

other compatible formatters can be found in [here](https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting).
