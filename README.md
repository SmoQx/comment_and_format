
---

# Neovim Comment and Format Plugin

The Neovim Comment and Format plugin is designed to assist you in commenting and formatting code based on file types. It allows you to customize comment symbols and formatters according to your preferences.

## Installation

Use your preferred package manager to install the plugin. For example, using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'SmoQx/comment_and_format'
```

Then run `:PlugInstall` to install the plugin.

## Configuration

The plugin provides a `setup` function to customize its behavior. It accepts a table of options, where each option is a nested table specifying the configuration for a specific file type. The available options are:

- `filetype`: File type for which the configuration should apply.
- `comment_symbol`: Comment symbol specific to the file type.
- `formatter`: Code formatter command for the file type.

### Example Configuration

```lua
local comment = require("comment_and_format")
comment.setup({{ filetype = "lua", comment_symbol = "--", formatter = ""},
              { filetype = "python", comment_symbol = "#", formatter = "autopep8 -i %"},
              { filetype = "cs", comment_symbol = "\\/\\/", formatter = "dotnet csharpier %"}})

function setKeyBind()
    vim.keymap.set('x', '<leader>c', ':s/^/'..comment.setupNeovimForFileType().comment_symbol..'<CR>:noh<CR>')
    vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'..comment.setupNeovimForFileType().formatter..'<CR><CR>')
    vim.keymap.set('x', '<leader>uc', ':s/^'..comment.setupNeovimForFileType().comment_symbol..'/<CR>:noh<CR>')
end

vim.api.nvim_exec([[
    augroup FileTypeDetection
        autocmd!
        autocmd BufRead,BufNewFile,BufEnter * lua setKeyBind()
    augroup END
]], false)
```

## Usage

The plugin sets up autocmd to detect file types on `BufRead` and `BufNewFile` events. It adjusts the comment symbol and formatter accordingly. Additionally, you can use the provided keymap to comment and format your code.

### Keymaps

- `<leader>c`: Comment selected lines.
- `<C-f><C-s>`: Format code using the specified formatter.

## Contributing

Contributions are welcome! Feel free to submit issues, pull requests, or suggestions on [GitHub](https://github.com/SmoQx/neovim-comment-and-format).

---
