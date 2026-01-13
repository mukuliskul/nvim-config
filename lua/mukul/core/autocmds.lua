-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	command = "checktime",
})

-- Optional: Notify when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	command = "echohl WarningMsg | echo '🔁 File changed on disk. Reloaded.' | echohl None",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[%s/\s\+$//e]],
})

-- Restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})
