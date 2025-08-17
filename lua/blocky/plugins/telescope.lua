return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    config=function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>sf', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end,
        dependencies = { 'nvim-lua/plenary.nvim' }
}
