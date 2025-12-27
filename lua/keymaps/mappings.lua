---------------------------------------------------------------------------------
-- 1. FILE OPERATIONS
vim.keymap.set('n', '<leader>wf', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>we', ':wq<CR>', { desc = 'Write & Exit' })
---------------------------------------------------------------------------------
-- 2. BUFFER NAVIGATION
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous Buffer' })
---------------------------------------------------------------------------------
-- 3. INDENTATION
vim.keymap.set("n", "<leader>ff", function()
  vim.cmd [[normal! gg=G]]
  vim.api.nvim_win_call(0, function()
    vim.cmd [[normal! ``]]
  end)
end, { desc = "Indent file" })
---------------------------------------------------------------------------------
-- 4. TERMINAL
vim.keymap.set('n', '<F5>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true, desc = "Toggle terminal" })
vim.keymap.set('t', '<F5>', '<cmd>ToggleTerm i<CR>', { noremap = true, silent = true })
---------------------------------------------------------------------------------
-- 5. PROTODEF
vim.keymap.set('n', '<leader>,PP', ':Protodef<CR>', { desc = 'Generate prototypes' })
vim.keymap.set('n', '<leader>,PN', ':Protodef!<CR>', { desc = 'Generate prototypes (no namespace)' })
---------------------------------------------------------------------------------
-- 6. TAGBAR
vim.keymap.set('n', '<leader>sl', ':TagbarToggle<CR>', { desc = 'Toggle Tagbar' })
---------------------------------------------------------------------------------
-- 7. AUTO-PAIRS TOGGLE
local autopairs = require("nvim-autopairs")
local toggle_autopairs = function()
  if autopairs.state.disabled then
    autopairs.enable()
    vim.notify("Auto-pairs: ENABLED", vim.log.levels.INFO)
  else
    autopairs.disable()
    vim.notify("Auto-pairs: DISABLED", vim.log.levels.WARN)
  end
end
vim.keymap.set({'i', 'n'}, '<F8>', toggle_autopairs, { desc = 'Toggle auto-pairs' })
---------------------------------------------------------------------------------
-- 8. NERD TREE MAPPINGS
vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', { silent = true, desc = "Toggle file explorer" })
vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>', { silent = true, desc = "Reveal current file" })
vim.keymap.set('n', '<leader>r', ':NERDTreeRefresh<CR>', { silent = true, desc = "Refresh explorer" })
---------------------------------------------------------------------------------
-- 9. FSWITCH MAPPINGS
vim.keymap.set('n', '<leader>ss', ':FSHere<CR>', { silent = true, desc = 'Switch header/source' })
vim.keymap.set('n', '<leader>sh', ':FSSplitBelow<CR>', { silent = true, desc = 'Switch header/source (split)' })
---------------------------------------------------------------------------------
-- 10. TELESCOPE MAPPINGS
vim.keymap.set('n', '<leader>te', ':Telescope file_browser<CR>', { desc = 'File Browser' })
vim.keymap.set('n', '<leader>tn', ':Telescope frecency<CR>', { desc = 'Noice' })
vim.keymap.set('n', '<leader>th', ':Telescope help_tags<CR>', { desc = 'Help tags' })
-- 										finding files
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fl', ':Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fm', ':Telescope media_files<CR>', { desc = 'Browse media files' })
vim.keymap.set('n', '<leader>fs', ':Telescope frecency<CR>', { desc = 'Open Frecency View' })
-- 										buffer navigation
vim.keymap.set('n', '<leader>bb', ':Telescope buffers<CR>', { desc = 'List buffers' })
---------------------------------------------------------------------------------
-- 11. GITHUB EXTENSION
vim.api.nvim_set_keymap('n', '<leader><leader>g', ':Neogit<CR>', { desc = "Github CLI" })
vim.api.nvim_set_keymap('n', '<C-c>', ':q<CR>', { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- 12. Open Diffview
vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { desc = "DiffviewOpen"  })
vim.api.nvim_set_keymap('n', '<leader>dc', ':DiffviewClose<CR>', { desc= "DiffviewClose" })
vim.api.nvim_set_keymap('n', '<leader>dt', ':DiffviewToggleFiles<CR>', { desc= "DiffviewToggleFiles" })
vim.api.nvim_set_keymap('n', '<leader>df', ':DiffviewFocusFiles<CR>', { desc= "DiffviewFocusFiles" })
vim.api.nvim_set_keymap('n', '<leader>dh', ':DiffviewFileHistory<CR>', { desc= "DiffviewFileHistory" })
vim.api.nvim_set_keymap('n', '<C-c>', ':DiffviewClose<CR>', { noremap = true, silent = true })

