# nvim

neovim config

### requirements

install the required packages:

##### ubuntu

```bash
xargs sudo apt-get install < pkglist.txt
```

##### arch-based

```bash
pacman -S - < pkglist.txt
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

# check nvim status

Check the editor and plugins status using `:checkhealth`
