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
    local formatted_config = {}
    for key, value in pairs(M.config) do
        for conf_k, conf_v in pairs(default_config) do
            if value == conf_v then
                formatted_config[conf_k] = conf_v
            else
                formatted_config[conf_k] = value 
            end
        end
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

return M
