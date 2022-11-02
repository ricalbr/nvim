# nvim
neovim config

### formatting 
install external formatters in the system that hooks into neovim using null-ls. 

for python install `black`
``` bash
conda activate <env_name>
pip install black
```

for cpp install `clangd`
```bash 
sudo pacman -Ss clangd
```

other compatible formatters can be found in [here](https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting).
