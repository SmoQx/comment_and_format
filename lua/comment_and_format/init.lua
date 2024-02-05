-- Function to setup Neovim based on file type
local M = {}

-- Default configuration values
local default_config = {
    filetype = "default",
    comment_symbol = "#",
    formatter = nil,
}

M.config = {{}}
--{ filetype = "py", comment_symbol = "#", formatter = "autopep8" },
--{ filetype = "cs", comment_symbol = "//", formatter = "csharpier" },

-- Setup autocmd to detect file type on BufRead and BufNewFile events
vim.api.nvim_exec([[
    augroup FileTypeDetection
        autocmd!
        autocmd BufRead,BufNewFile * lua require'comment_and_format'.setupNeovimForFileType()
    augroup END
]], false)

function M.setupNeovimForFileType()
    local filetype = vim.bo.filetype or vim.api.nvim_eval('&filetype')
    print(filetype)
    local comment_symbol = "#"
    for key, value in pairs(M.config) do
        if filetype == value.filetype then
            comment_symbol = value.comment_symbol
            print("The filetype is "..filetype.." the comment symbol is "..comment_symbol)
            vim.keymap.set('x', '<leader>c', ':s/^/'..comment_symbol..'<CR>:noh<CR>')
        else
            comment_symbol = default_config.comment_symbol
            print("loaded default_config the comment symbol is "..comment_symbol)
        end

        if filetype == value.filetype and value.formatter then
            print("formatter works??")
            vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'..value.formatter..' <CR>')
        end
    end
end

function M.setup(user_opts)
    if user_opts then
        for key, value in pairs(user_opts) do
            table.insert(M.config, value)
        end
    end
--    print(M.config.filetype..M.config.formatter)

end

return M
