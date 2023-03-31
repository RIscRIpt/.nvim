vim.keymap.set("", "<F25>", function()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
end)
