local M = require("init")

M.setup({{ filetype = "lua", comment_symbol = "--", formatter = nil},
{ filetype = "py", comment_symbol = "#", formatter = "autopep8"}})
--M.setup({{ filetype = "lua", comment_symbol = "--", formatter = nil}})
M.setup()
