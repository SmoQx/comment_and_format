-- Function to setup Neovim based on file type
local M = {}

-- Default configuration values
local default_config = {
    filetype = vim.bo.filetype or vim.api.nvim_eval('&filetype'),
    comment_symbol = "#",
    formatter = "",
}

M.config = {}
--{ filetype = "py", comment_symbol = "#", formatter = "autopep8" },
--{ filetype = "cs", comment_symbol = "//", formatter = "csharpier" },

-- Setup autocmd to detect file type on BufRead and BufNewFile events
vim.api.nvim_exec([[
    augroup FileTypeDetection
        autocmd!
        autocmd BufRead,BufNewFile,BufEnter * lua require'comment_and_format'.setupNeovimForFileType()
    augroup END
]], false)

function M.setupNeovimForFileType()
    local formatted_config = default_config
    local filetp = vim.bo.filetype or vim.api.nvim_eval('&filetype')
    print(filetp)
    for _, value in pairs(M.config) do
        for conf_k, conf_v in pairs(value) do
            if value[conf_k] == filetp then
                print(conf_v)
                formatted_config = value
                break
            end
        end
    end
    for k, v in pairs(formatted_config) do
        print(k.." "..v)
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

--M.setup({{ filetype = "python", comment_symbol = "#", formatter = "autopep8 -i %"},
--{ filetype = "cs", comment_symbol = "\\/\\/", formatter = "dotnet csharpier %"},
--{ filetype = "lua", comment_symbol = "--", formatter = ""},})
--M.setupNeovimForFileType()
return M
