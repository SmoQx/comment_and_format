-- Function to setup Neovim based on file type
local M = {}

-- Default configuration values
local default_config = {
    filetype = "default",
    comment_symbol = "#",
    formatter = nil,
}

M.config = { filetype = "", comment_symbol = "", formatter = "" }
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
    local comment_symbol = "#"
    if filetype == M.config.filetype then
        comment_symbol = M.config.comment_symbol
        print("The filetype is "..filetype.." the comment symbol is "..comment_symbol)
    else
        comment_symbol = default_config.comment_symbol
        print("loaded default_config the comment symbol is "..comment_symbol)
    end

    if filetype == M.config.filetype and M.config.formatter then
        print("formatter works??")
        vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'..config.formatter..' <CR>')
    end
    vim.keymap.set('x', '<leader>c', ':s/^/'..comment_symbol..'<CR>:noh<CR>')
end



function M.setup(user_opts)
    for _, config in pairs(user_opts) do
        print(config)
        M.config = vim.tbl_extend("force", default_config, config or {})
    end
    M.setupNeovimForFileType()
--    print(M.config.filetype..M.config.formatter)

end

M.setup({ filetype = "lua", comment_symbol = "--", formatter = "None"})
--,
--{ filetype = "py", comment_symbol = "#", formatter = "autopep8"}})

return M
