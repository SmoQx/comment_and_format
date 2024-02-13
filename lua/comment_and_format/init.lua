-- Function to setup Neovim based on file type
local M = {}

-- Default configuration values
local default_config = {
    filetype = vim.bo.filetype or vim.api.nvim_eval('&filetype'),
    comment_symbol = "#",
    formatter = "",
}

M.config = {}

function M.setupNeovimForFileType()
    local formatted_config = default_config
    local filetp = vim.bo.filetype or vim.api.nvim_eval('&filetype')
    print(filetp)
    for _, value in pairs(M.config) do
        if value.filetype == filetp then
            formatted_config = value
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
