# AGENTS.md - Neovim Configuration Guide for AI Coding Agents

This document provides essential information for AI coding agents working on this Neovim configuration.

## Project Overview

- **Type**: Personal Neovim configuration (dotfiles)
- **Language**: Lua (100%)
- **Plugin Manager**: lazy.nvim
- **Primary User**: mukul
- **Location**: `~/.config/nvim` (`/Users/sharmamu/.config/nvim`)
- **Git Repository**: git@github.com:mukuliskul/nvim-config.git

## Build/Test/Lint Commands

### Testing Configuration
No traditional build system or test suite exists for this project. Testing is done manually:

```bash
# Test configuration by launching Neovim
nvim

# Check for Lua syntax errors
nvim --headless -c "luafile init.lua" -c "qa"

# Check plugin health
nvim +checkhealth

# View lazy.nvim plugin status
nvim +Lazy
```

### Formatting
```bash
# Format Lua files with stylua (configured in conform.nvim)
# Inside Neovim: <leader>mp (format file or visual selection)

# Format single file externally (if stylua is installed via Mason)
~/.local/share/nvim/mason/bin/stylua lua/mukul/core/options.lua

# Format entire codebase
~/.local/share/nvim/mason/bin/stylua .
```

### Linting
No automated linting is configured. LSP diagnostics via `lua_ls` provide error checking.

### Plugin Management
```bash
# Sync plugins (install/update/clean)
nvim +Lazy sync

# Update plugins
nvim +Lazy update

# Clean unused plugins
nvim +Lazy clean
```

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - loads core and lazy
├── lazy-lock.json             # Plugin version lockfile (50 plugins)
└── lua/mukul/                 # Main configuration namespace
    ├── lazy.lua               # Plugin manager bootstrap
    ├── core/                  # Core Neovim settings
    │   ├── init.lua          # Core module loader
    │   ├── options.lua       # Editor options
    │   ├── keymaps.lua       # Global keybindings
    │   └── autocmds.lua      # Auto-commands
    └── plugins/               # Plugin configurations (27 files)
        ├── init.lua          # Base plugins (plenary)
        ├── lsp/              # LSP-specific configs
        │   ├── mason.lua    # LSP server installer
        │   └── lspconfig.lua # LSP settings
        └── [25+ plugin files]
```

## Code Style Guidelines

### File Naming & Organization
- **Convention**: Use lowercase with hyphens for plugin filenames (e.g., `nvim-cmp.lua`, `which-key.lua`)
- **Module Structure**: Each plugin gets its own file in `lua/mukul/plugins/`
- **Namespace**: All custom code must be under `lua/mukul/`
- **LSP Exception**: LSP-related plugins go in `lua/mukul/plugins/lsp/`

### Lua Code Style

#### Indentation & Formatting
- **Tabs**: Use TABS (converted to 2 spaces via `expandtab`)
- **Indent Width**: 2 spaces (configured in options.lua:12)
- **Line Length**: No strict limit, but keep lines readable
- **Formatter**: stylua (configured for Lua files)

#### Variable Naming
- **Local Variables**: Use `snake_case` (e.g., `local mason_lspconfig`)
- **Vim Options**: Use `opt` or `keymap` as shorthand aliases
- **Plugin Requires**: Use descriptive names matching plugin (e.g., `require("mason")`)

#### Imports/Requires
- **Order**: Group requires logically (dependencies first, then utilities)
- **Pattern**: Always use `local` for requires
- **Example**:
```lua
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
```

#### Plugin Configuration Pattern
Every plugin file should follow this structure:
```lua
return {
  "author/plugin-name",
  event = { "BufReadPre", "BufNewFile" }, -- lazy loading
  dependencies = {
    "dependency/plugin",
  },
  config = function()
    local plugin = require("plugin-name")
    
    plugin.setup({
      -- configuration options
    })
    
    -- keymaps (if applicable)
    vim.keymap.set("n", "<leader>xy", "<cmd>Command<cr>", { desc = "Description" })
  end,
}
```

#### Comments
- **Section Headers**: Use uppercase with separator lines
```lua
-- =======================
-- LSP SERVER CONFIGS
-- =======================
```
- **Inline Comments**: Use `--` with space, keep them descriptive
- **Avoid**: Redundant comments that just repeat the code

#### Keymaps
- **Always** include descriptive `desc` field for documentation
- **Leader Key**: Space (` `)
- **Local Leader**: Comma (`,`)
- **Pattern**:
```lua
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
```

#### Options Configuration
- **Use shorthand**: `local opt = vim.opt` at the top
- **Group logically**: Related settings together with section comments
- **Example**:
```lua
-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
```

### Type Safety
- **No type annotations**: This config doesn't use Lua type annotations
- **LSP Settings**: Configure `lua_ls` for diagnostics (see mason.lua:62-74)

### Error Handling
- **Keep it simple**: Most configuration doesn't need explicit error handling
- **Protected calls**: Use `pcall()` only for optional dependencies
- **Let it fail**: Configuration errors should be visible to help debug

### LSP Configuration
- **New Pattern**: Use `vim.lsp.config()` and `vim.lsp.enable()` (Neovim 0.11+)
- **Capabilities**: Always include `cmp_nvim_lsp.default_capabilities()` for completion
- **Pattern**:
```lua
vim.lsp.config("server_name", {
  capabilities = capabilities,
  settings = {
    -- server-specific settings
  },
})
vim.lsp.enable("server_name")
```

## Common Patterns

### Lazy Loading
Prefer event-based lazy loading for better startup performance:
- `event = "VimEnter"` - Load after Neovim starts
- `event = { "BufReadPre", "BufNewFile" }` - Load when opening files
- `event = "InsertEnter"` - Load when entering insert mode
- `cmd = "Command"` - Load when command is invoked
- `keys = "<leader>x"` - Load when keymap is pressed

### Dependencies
Always list dependencies explicitly in plugin spec:
```lua
dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
}
```

## Key Conventions

### Installed LSP Servers
ts_ls, lua_ls, pyright, html, cssls, tailwindcss, emmet_ls, yamlls, marksman

### Formatters
- **Lua**: stylua
- **Python**: ruff (format, fix, organize imports)
- **JS/TS/JSON/YAML/Markdown**: prettier

### Leader Keymaps Prefix Scheme
- `<leader>f` - Find/Telescope (ff=files, fs=string, fb=buffers)
- `<leader>b` - Buffer management (bd=delete, ba=delete all)
- `<leader>s` - Split/window management (sv=vertical, sh=horizontal)
- `<leader>m` - Formatting (mp=format file/range)
- `<leader>q` - Quickfix navigation (qn=next, qp=prev)
- `<leader>n` - Misc utilities (nh=clear search, nn=newline)

## Important Notes for Agents

1. **DO NOT** modify `lazy-lock.json` manually - it's managed by lazy.nvim
2. **DO NOT** add new root-level directories - keep everything in `lua/mukul/`
3. **DO** test changes by restarting Neovim or using `:source %`
4. **DO** keep plugins organized - one plugin per file
5. **DO** use descriptive keymap descriptions for which-key integration
6. **DO** maintain lazy loading for optimal startup performance
7. **DO NOT** enable format-on-save - formatting is manual via `<leader>mp`
8. **DO** preserve the existing namespace structure (`mukul.*`)

## Performance Optimizations
- Bytecode caching enabled via `vim.loader.enable()` in init.lua
- Lazy loading for most plugins (only ~10 load at startup)
- Disabled rocks support in lazy.nvim
- Disabled change detection notifications

## When Making Changes
1. Keep the modular structure - don't consolidate plugin files
2. Follow the existing pattern for plugin configuration
3. Add descriptive comments for non-obvious settings
4. Test changes in a live Neovim instance
5. Ensure lazy loading is preserved for new plugins
