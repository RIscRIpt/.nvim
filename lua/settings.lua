function toggle_background()
    vim.o.background = vim.o.background == "dark" and "light" or "dark"
end

vim.keymap.set("", "<F25>", toggle_background)
vim.keymap.set("", "<C-F1>", toggle_background)
