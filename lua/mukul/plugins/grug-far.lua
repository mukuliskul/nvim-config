return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			-- options, see Configuration section below
			-- there are no required options atm
			-- engine = 'ripgrep' is default, but 'astgrep' can be specified
		})
		vim.api.nvim_set_keymap("n", "<leader>gf", ":GrugFar<CR>", { noremap = true, silent = true })
	end,
}
