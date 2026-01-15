return {
	"mrjones2014/smart-splits.nvim",
	init = function()
		-- moving between splits (using Option+hjkl)
		vim.keymap.set("n", "<M-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<M-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<M-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<M-l>", require("smart-splits").move_cursor_right)
		-- resizing splits (using Option+arrows)
		vim.keymap.set("n", "<M-Left>", require("smart-splits").resize_left)
		vim.keymap.set("n", "<M-Down>", require("smart-splits").resize_down)
		vim.keymap.set("n", "<M-Up>", require("smart-splits").resize_up)
		vim.keymap.set("n", "<M-Right>", require("smart-splits").resize_right)
		vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
		-- swapping buffers between windows
		vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
		vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
		vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
		vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
	end,
}
