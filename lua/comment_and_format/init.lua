-- ~/.config/nvim/lua/my_plugin/init.lua

-- Function to setup Neovim based on file type
local M = {}

function M.setupNeovimForFileType()
    local filetype = vim.fn.expand('%:e') -- Get file extension
    local comment_symbol = '#'
    local formatter = 'echo %'

    if filetype == "py" then
        comment_symbol = '#'
        formatter = 'autopep8 --in-place --aggressive --aggressive %'
    elseif filetype == "lua" then
        comment_symbol = '--'
    elseif filetype == "cs" then
        comment_symbol = '//'
        formatter = 'dotnet csharpier .'
    elseif filetype == 'c' then
        comment_symbol = '//'
    end

    vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'..formatter..' <CR>')
    vim.keymap.set('x', '<leader>c', ':s/^/'..comment_symbol..'<CR>:noh<CR>')
end

-- Setup autocmd to detect file type on BufRead and BufNewFile events
vim.api.nvim_exec([[
    augroup FileTypeDetection
        autocmd!
        autocmd BufRead,BufNewFile * lua require'my_plugin'.setupNeovimForFileType()
    augroup END
]], false)

function M.showTest()
    print("First plugin test")
end

return M
