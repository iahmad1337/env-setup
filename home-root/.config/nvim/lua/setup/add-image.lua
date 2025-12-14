local function add_image()
    local cwd = vim.fn.getcwd()
    local images_dir = cwd .. "/images"

    -- Create images directory if it doesn't exist
    local stat = vim.loop.fs_stat(images_dir)
    if not stat then
        vim.fn.mkdir(images_dir, "p")
    end

    local filepath = images_dir .. "/" .. os.date("%Y-%m-%dT%H-%M-%S") .. ".png"

    local cmd
    if vim.fn.executable("xclip") == 1 then
        cmd = string.format("xclip -selection clipboard -t image/png -o > %s 2>/dev/null", vim.fn.shellescape(filepath))
    else
        vim.notify("Error: No clipboard tool found (only xclip supported)", vim.log.levels.ERROR)
        return
    end

    local result = os.execute(cmd)

    if result == 0 or result == true then
        local line = vim.api.nvim_get_current_line()
        local col = vim.fn.col(".")
        local new_line = line:sub(1, col - 1) .. "[stub](" .. filepath .. ")" .. line:sub(col)
        vim.api.nvim_set_current_line(new_line)

        vim.notify("Image saved to " .. filepath, vim.log.levels.INFO)
    else
        vim.notify("Error: Failed to save image from clipboard", vim.log.levels.ERROR)
    end
end

-- Create the :AddImage command
vim.api.nvim_create_user_command("AddImage", add_image, {})
