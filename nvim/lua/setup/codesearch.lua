-- Made by izaron: https://gist.github.com/Izaron/a65e69f7ba03a64f2c27707ac65aff9e
vim.g.search_link_keymap = '<C-s>'

-- better than "print"
local echo = function(str)
    str = string.gsub(str, '"', '\\"')
    str = string.gsub(str, '\n', '\\n')
    vim.cmd(string.format([[echo "%s"]], str))
end

-- YaCodeSearch
local escape_string = function(str)
    str = string.gsub(str, '%%', '%%2525') -- escape '%', warning: it should be first!
    str = string.gsub(str, ' ', '%%2520') -- escape ' '
    str = string.gsub(str, '"', '%%2522') -- escape '"'
    str = string.gsub(str, '%(', '%%255C%%28') -- escape '('
    str = string.gsub(str, '%)', '%%255C%%29') -- escape ')'
    str = string.gsub(str, '%*', '%%255C%*') -- escape '*'
    str = string.gsub(str, '%.', '%%255C%.') -- escape '.'
    str = string.gsub(str, '%[', '%%255C%%255B') -- escape '['
    str = string.gsub(str, '%]', '%%255C%%255D') -- escape ']'
    str = string.gsub(str, '%{', '%%255C%%257B') -- escape '{'
    str = string.gsub(str, '%}', '%%255C%%257D') -- escape '}'
    str = string.gsub(str, ',', '%%252C') -- escape ','
    str = string.gsub(str, '-', '%%255C-') -- escape '-'
    str = string.gsub(str, ';', '%%253B') -- escape ';'
    str = string.gsub(str, '<', '%%253C') -- escape '<'
    str = string.gsub(str, '>', '%%253E') -- escape '>'
    str = string.gsub(str, '\'', '%%27') -- escape '\''
    str = string.gsub(str, '\\n', '%%255C%%255Cn') -- escape '\n'
    return str
end

local make_search_url = function(query)
    local search_arg = escape_string(query)
    local url = string.format('https://github.com/search?q=%s&type=code', search_arg)
    local result = string.format('Url for Arcadia:\n%s', url)
    return result
end

local make_search_url_for_word = function()
    local query = vim.fn.expand('<cword>') -- get word under cursor
    echo(make_search_url(query))
end

local make_search_url_for_selection = function()
    vim.cmd.execute([["normal! \<Esc>"]])

    line_start, col_start = unpack(vim.fn.getpos("'<"), 2)
    line_end, col_end = unpack(vim.fn.getpos("'>"), 2)

    if line_start == line_end then
        local cur_line = vim.api.nvim_buf_get_lines(0, line_start - 1, line_start, false)[1]
        local line_part = string.sub(cur_line, col_start, col_end)
        echo(make_search_url(line_part))
    else
        echo('Please select text within a single line\n')
    end
end

vim.keymap.set('n', vim.g.search_link_keymap, make_search_url_for_word)

vim.keymap.set('v', vim.g.search_link_keymap, make_search_url_for_selection)

vim.api.nvim_create_user_command('YaCodeSearch', make_search_url_for_word, {})

