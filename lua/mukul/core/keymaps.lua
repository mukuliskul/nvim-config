-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- escape terminal mode
keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- insert newline without entering insert mode
keymap.set("n", "<leader>nn", "i<cr><Esc>", { desc = "Insert newline at cursor" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Buffer Management
keymap.set("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Move to the previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Move to the next buffer" })
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "Close all buffers" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Key mappings
keymap.set("n", "]c", "/#<CR>", { desc = "Go to next comment" })
keymap.set("n", "[c", "?#<CR>", { desc = "Go to previous comment" })
