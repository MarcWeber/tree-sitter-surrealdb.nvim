local M = {}

function M.setup()
    local parsers = require("nvim-treesitter.parsers")
    local parser_config = parsers.get_parser_configs and parsers.get_parser_configs() or parsers.list

    parser_config.surrealdb = {
        install_info = {
            url = "https://github.com/DariusCorvus/tree-sitter-surrealdb",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "surql",
    }

    vim.filetype.add({
        extension = {
            surql = "surql",
            surrealdb = "surql",
        },
    })

    -- Define the highlight queries
    local highlights_scm = [[
(keyword) @keyword
(string) @string
(number) @number
(punctuation) @punctuation
(operator) @operator
(variable) @variable
(constant) @constant.builtin
(function) @function
(bool) @boolean
(comment) @comment
(type) @type
    ]]

    -- Create the query file in the nvim config directory
    local query_path = vim.fn.stdpath("config") .. "/queries/surrealdb"
    if vim.fn.isdirectory(query_path) == 0 then
        vim.fn.mkdir(query_path, "p")
    end

    local f = io.open(query_path .. "/highlights.scm", "w")
    if f then
        f:write(highlights_scm)
        f:close()
    end
end

return M
