 return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = true,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			auto_session_enable_last_session = false, -- Don't automatically restore last session
			cwd_change_handling = {
				restore_upcoming_session = true, -- Restore session when changing to a directory with a session
			},
		})

		-- Auto-save session every 5 minutes (300 seconds)
		local auto_save_timer
		local function start_auto_save_timer()
			if auto_save_timer then
				auto_save_timer:stop()
				auto_save_timer:close()
			end
			auto_save_timer = vim.loop.new_timer()
			auto_save_timer:start(300000, 300000, vim.schedule_wrap(function()
				-- Only save if there are unsaved changes and we're not in a suppressed directory
				local cwd = vim.fn.getcwd()
				local suppressed = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" }
				for _, dir in ipairs(suppressed) do
					if cwd:find(vim.fn.expand(dir)) then
						return
					end
				end
				-- Check if there are any modified buffers
				local has_changes = false
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'modified') then
						has_changes = true
						break
					end
				end
				if has_changes then
					vim.cmd("SessionSave")
				end
			end))
		end

		-- Start the timer when a session is restored
		vim.api.nvim_create_autocmd("SessionLoadPost", {
			callback = start_auto_save_timer
		})

		-- Also start the timer on VimEnter if no session was loaded
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Small delay to ensure auto-session has finished processing
				vim.defer_fn(start_auto_save_timer, 100)
			end
		})

		-- Stop timer on exit
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				if auto_save_timer then
					auto_save_timer:stop()
					auto_save_timer:close()
				end
			end
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>we", "<cmd>AutoSession search<CR>", { desc = "Session search" }) -- search sessions
		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
