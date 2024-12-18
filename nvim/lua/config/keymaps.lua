-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymaps = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Close nvim tab with `,q`
keymaps("n", "<leader>q", ":q<cr>", opts)

-- Find files with telescope using <leader>ff
keymaps("n", "<leader>ff", ":Telescope find_files<cr>", opts)

-- Select all and copy with <leader>yy
keymaps("n", "<leader>yy", ":%y+<cr>", opts)

-- Navigate to the previous buffer
keymaps("n", "<leader>bp", ":bprevious<cr>", opts)

-- Navigate to the next buffer
keymaps("n", "<leader>bn", ":bnext<cr>", opts)

-- Change to NeoTree
keymaps("n", "<leader>nt", ":Neotree<cr>", opts)

-- Find a word in the current project
keymaps("n", "<leader>ff", ":Telescope current_buffer_fuzzy_find<cr>", opts)

-- Find word in current buffer using telescope
keymaps("n", "<leader>fb", ":Telescope live_grep<cr>", opts)

-- Comment code
keymaps("n", "<leader>cn", ":CommentCode<cr>", opts)

-- Toggle LazyGit
keymaps("n", "<leader>gg", ":LazyGit<cr>", opts)

-- Select all and paste with <leader>pp
keymaps("n", "<leader>pp", "ggVGp", opts)
