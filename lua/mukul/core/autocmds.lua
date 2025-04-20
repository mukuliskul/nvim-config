-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	command = "checktime",
})

-- Optional: Notify when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	command = "echohl WarningMsg | echo '🔁 File changed on disk. Reloaded.' | echohl None",
})
