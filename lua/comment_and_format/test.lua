local m = require("init")

m.setup({{ filetype = "python", comment_symbol = "#", formatter = "autopep8 -i %"},
{ filetype = "cs", comment_symbol = "\\/\\/", formatter = "dotnet csharpier %"},
{ filetype = "lua", comment_symbol = "--", formatter = ""},})
m.setupNeovimForFileType()
