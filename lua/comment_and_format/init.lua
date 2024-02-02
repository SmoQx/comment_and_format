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

function M.setupNeovimForFileType(config)
    local filetype = vim.bo.filetype or vim.api.nvim_eval('&filetype')
    local comment_symbol = '#'

    if filetype == "py" then
        print("py works??")
        comment_symbol = '#'
    elseif filetype == "lua" then
        print("lua works??")
        comment_symbol = '--'
    elseif filetype == "cs" then
        comment_symbol = " //"
    elseif filetype == 'c' then
        comment_symbol = ' //'
    end

    if filetype == config.filetype and config.formatter then
        print("formatter works??")
        vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'..config.formatter..' <CR>')
    end
    vim.keymap.set('x', '<leader>c', ':s/^/'..comment_symbol..'<CR>:noh<CR>')
end

function M.setup(user_opts)
--    for _, config in ipairs(user_opts) do
    M.config = vim.tbl_extend("force", default_config, config or {})
--    end
    M.setupNeovimForFileType(M.config)
--    print(M.config.filetype..M.config.formatter)

end

M.setup({ filetype = "py", comment_symbol = "#", formatter = "autopep8" })

return M
