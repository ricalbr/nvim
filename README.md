# <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" alt="nvim" width="24"/> neovim config
configuration for neovim text editor.

### install
clone the repo
``` bash
mkdir ~/.config/nvim
git clone https://github.com/ricalbr/nvim ~/.config/nvim
```

install the required packages:

###### ubuntu

```bash
xargs sudo apt-get install < pkglist.txt
```

###### arch-based

```bash
pacman -S - < pkglist.txt
```

### setup environments

Install `npm` via `nvm`
```bash 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
nvm install node -s --latest-npm --default
nvm reinstall-packages system
npm install -g npm-check-updates
ncu -ug
npm update -g
```
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

### check nvim status

Check the editor and plugins status using `:checkhealth`
