### Install Node.js and npm
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

### 2. Buffer Navigation
- **`<leader>bn`**: Next Buffer
- **`<leader>bp`**: Previous Buffer

### 3. Indentation
- **`<leader>ff`**: Indent entire file

### 4. Terminal
- **`<F5>`**: Toggle terminal

### 5. Protodef
- **`<leader>,PP`**: Generate prototypes
- **`<leader>,PN`**: Generate prototypes (no namespace)

### 6. Tagbar
- **`<leader>sl`**: Toggle Tagbar

### 7. Auto-Pairs Toggle
- **`<F8>`**: Toggle auto-pairs

### 8. NERDTree Mappings
- **`<leader>n`**: Toggle file explorer
- **`<leader>N`**: Reveal current file
- **`<leader>R`**: Refresh explorer

### 9. Fswitch Mappings
- **`<leader>ss`**: Switch header/source
- **`<leader>sh`**: Switch header/source (split)

### 10. Telescope Mappings
- **`<leader>te`**: File Browser
- **`<leader>tn`**: Noice
- **`<leader>th`**: Help tags
- **`<leader>ff`**: Find files
- **`<leader>fl`**: Live grep
- **`<leader>fm`**: Browse media files
- **`<leader>fs`**: Open Frecency View
- **`<leader>bb`**: List buffers

### 11. GitHub Extension
- **`<leader><leader>g`**: GitHub CLI

### 12. Open Diffview
- **`<leader>dv`**: Open Diffview
- **`<leader>dc`**: Close Diffview
- **`<leader>dt`**: Toggle Diffview files
- **`<leader>df`**: Focus on Diffview files
- **`<leader>dh`**: Diffview file history

### 13. LSP Mapping
- **`<leader>rn`**: Rename symbol
- **`<leader>gd`**: Jump to definition
- **`<leader>gr`**: Show symbol reference
- **`<leader>ca`**: Code action

### 13. Extra Mapping
- **`<leader>cw`**: CMake custom workspace setup script

## FIXING fzf ERROR message
    $ cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
    $ make

## VIMDOC FIX
 in a neovim cmd
    :TSInstall vimdoc

Since frecency requires SQLite to keep track of usage statistics, you need to install SQLite first. Make sure you have it installed on your system.
You can typically install SQLite using your package manager:

    For Debian/Ubuntu:
        $ sudo apt install sqlite3

## Installation Guide for Debian-based Distros

