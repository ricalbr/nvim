# <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" alt="nvim" width="24"/> neovim config
configuration for neovim text editor.

---

## Requirements

### Tools and Dependencies

Make sure the following are installed on your system:

1. **Neovim** (version >= 0.9.0):
   Install the latest version from [Neovim's GitHub releases](https://github.com/neovim/neovim/releases).
   On Ubuntu/Debian:
   ```bash
   sudo apt update
   sudo apt install neovim
   ```

2. **Python** (for `pynvim`):
   Install Python 3 and the required library:
   ```bash
   sudo apt install python3 python3-pip
   pip3 install --user pynvim
   ```

3. **Node.js and npm**:
   Required for plugins and the Language Server Protocol (LSP). Install it via a package manager or [nvm](https://github.com/nvm-sh/nvm):
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
   nvm install --lts
   nvm reinstall-packages system
   npm install -g npm-check-updates
   ncu -ug
   npm update -g
   ```

4. **Optional utilities**:
   - `ripgrep` (for better search):
     ```bash
     sudo apt install ripgrep
     ```
   - `fzf` (fuzzy finder):
     ```bash
     sudo apt install fzf
     ```

---

## Installation

### Step 1: Clone the Repository

Clone this repository into your Neovim configuration directory:

```bash
mkdir -p ~/.config/nvim
git clone git@github.com:ricalbr/nvim.git ~/.config/nvim
```

### Step 2: Install Plugins

This configuration uses `lazy.nvim` as a plugin manager. To install all plugins:

1. Open Neovim:
   ```bash
   nvim
   ```

2. Run the command:
   ```vim
   :Lazy sync
   ```

Plugins will be installed automatically.

---

## Setup Python Environment

For Python development, ensure that the correct Python interpreter is set up in Neovim:

1. Install `pynvim` globally or in a virtual environment:
   ```bash
   pip3 install pynvim
   ```

2. If using a virtual environment (recommended):
   ```bash
   virtualenv $HOME/.venvs/nvim
   source $HOME/.venvs/nvim/bin/activate
   pip install neovim pynvim black isort flake8
   ```

3. If the environment is created in a different location, modify the following command:
   ```lua
   vim.g.python3_host_prog = '$HOME/.venv/nvim/bin/python'
   ```

---

## Setup Node.js Environment

To enable LSP, ensure `npm` is set up:

1. Install `npm` packages required for Neovim LSP:
   ```bash
   npm install -g neovim prettier
   ```

---

<!-- ## Setup Language Servers -->
<!---->
<!-- This configuration uses Neovim's built-in LSP for code intelligence. To set up additional language servers: -->
<!---->
<!-- 1. Use `npm` for JavaScript/TypeScript: -->
<!--    ```bash -->
<!--    npm install -g typescript-language-server typescript -->
<!--    ``` -->
<!---->
<!-- 2. Use `pip` for Python (e.g., `pylsp`): -->
<!--    ```bash -->
<!--    pip install 'python-lsp-server[all]' -->
<!--    ``` -->
<!---->
<!-- 3. Other language servers can be installed via their package managers or tools like `mason.nvim`. -->

---

## Key Features

- **Plugin Management**: Powered by `lazy.nvim`.
- **LSP Integration**: Pre-configured for multiple languages.
- **Treesitter**: Advanced syntax highlighting and parsing.
- **Fuzzy Finder**: Integrated with `telescope.nvim` and `fzf`.

---

## Customization

1. **Colorscheme**:
   This configuration uses `habamax` by default. To change it, edit the `init.lua`:
   ```lua
   vim.cmd("colorscheme habamax")
   ```

2. **Keybindings**:
   Custom keybindings are defined in `lua/keymaps.lua`. Modify this file to customize shortcuts.

3. **Plugins**:
   Add or remove plugins in `lua/plugins/`.

---

## Troubleshooting

### Common Issues

1. **Plugin Installation Fails**:
   - Ensure `git` is installed and accessible.
   - Run `:Lazy sync` to retry.

2. **Python Not Configured**:
   - Check the output of `:checkhealth` to diagnose Python issues.
   - Verify the `pynvim` installation:
     ```bash
     pip3 show pynvim
     ```

3. **LSP Not Working**:
   - Ensure the required language server is installed.
   - Check Neovim's logs:
     ```bash
     :LspLog
     ```

---

## Useful Commands

- **Install Plugins**: `:Lazy sync`
- **Update Plugins**: `:Lazy update`
- **Check LSP Info**: `:LspInfo`
- **Debug Config**: `:checkhealth`

---
