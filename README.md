### Install Node.JS and Npm
   ```bash
   sudo apt update 
   sudo apt install nodejs npm 
   sudo apt install nodejs npm 
   sudo apt install cmake

```
## Setup Key Mappings Summary
### 1. File Operations
- **`<leader>wf`**: Save file
- **`<leader>we`**: Write & Exit
- **`<leader>qq`**: quit

### 2. Buffer Navigation
- **`<leader>bn`**: Next Buffer
- **`<leader>bp`**: Previous Buffer

### 3. Indentation
- **`<leader>ff`**: Indent entire file

### 4. `Protodef`
- **`<leader>,PP`**: Generate prototypes
- **`<leader>,PN`**: Generate prototypes (no namespace)

### 5. `Tagbar`
- **`<leader>sl`**: Toggle Tagbar

### 6. Auto-Pairs Toggle
- **`<F8>`**: Toggle auto-pairs

### 7.`NERDTree`Mappings
- **`<leader>n`**: Toggle file explorer
- **`<leader>R`**: Refresh explorer

### 8. `Fswitch`Mappings
- **`<leader>fs`**: Switch header/source
- **`<leader>fh`**: Switch header/source (split)

### 9. Telescope Mappings
- **`<leader>te`**: File Browser
- **`<leader>tn`**: Noice
- **`<leader>tf`**: Frecency
- **`<leader>th`**: Help tags
- **`<leader>ff`**: Find files
- **`<leader>fl`**: Live grep
- **`<leader>fm`**: Browse media files
- **`<leader>fq`**: Open Frecency View
- **`<leader>bb`**: List buffers

### 10. GitHub Extension
- **`<leader><leader>n`**: GitHub CLI

### 11. Open Diffview
- **`<leader><leader>dv`**: Open Diffview
- **`<leader><leader>dc`**: Close Diffview
- **`<leader><leader>dt`**: Toggle Diffview files
- **`<leader><leader>df`**: Focus on Diffview files
- **`<leader><leader>dh`**: Diffview file history

### 12. LSP Mapping
- **`<leader>rs`**: Rename symbol
- **`<leader>gd`**: Jump to definition
- **`<leader>gr`**: Show symbol reference
- **`<leader>ca`**: Code action

### 13. Extra Mapping
- **`<leader>cw`**: CMake custom workspace setup script

## INSTALLATION GUIDE for DEBIAN-BASED DISTROS

## FIXING `Fzf` ERROR Message
    $ cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
    $ make

## `VIMDOC` FIX & Markdown
 in a neovim cmd
    `:TSInstall vimdoc`
    `:TSInstall markdown`
    `:MasonInstall harper-ls`

Since `frecency` requires SQLite to keep track of usage statistics, you `need to` install SQLite first. Make sure you have it installed on your system.
You can typically install SQLite using your package manager:

    For Debian/Ubuntu:
        $ sudo apt install sqlite3
## FZF setup on install
``bash
    cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
    make 

