-- Function to setup Neovim based on file type
local M = {}

-- Default configuration values
local default_config = {
    filetype = vim.bo.filetype or vim.api.nvim_eval('&filetype'),
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
    local formatted_config = default_config
    for _, value in pairs(M.config) do
        for conf_k, conf_v in pairs(value) do
            if value[conf_k] == default_config.filetype then
                formatted_config = value
            end
        end
    end
    if not formatted_config.formatter then
        vim.keymap.set('x', '<leader>c', ':s/^/'..default_config.comment_symbol..'<CR>:noh<CR>')
        vim.keymap.set({'n', 'x', 'i'}, '<C-f><C-s>' , '<C-c>:!'.."%"..'<CR><CR>')
    end
    return formatted_config
end

function M.setup(user_opts)
    if user_opts then
        for key, value in pairs(user_opts) do
            table.insert(M.config, value)
        end
    end
--    print(M.config.filetype..M.config.formatter)

end

--M.setup()
--M.setupNeovimForFileType()
return M
