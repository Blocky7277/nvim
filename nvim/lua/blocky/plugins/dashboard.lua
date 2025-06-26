return {
    'goolord/alpha-nvim',
    config = function ()
        local alpha = require'alpha'
        local dashboard = require'alpha.themes.dashboard'
        dashboard.section.header.val = {
            [[    _  __________ _   ________  ___ ]],
            [[   / |/ / __/ __ \ | / /  _/  |/  / ]],
            [[  /    / _// /_/ / |/ // // /|_/ /  ]],
            [[ /_/|_/___/\____/|___/___/_/  /_/   ]],
        }
        dashboard.section.header.opts.hl = "error"
        local buttons = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "󰉋  File Explorer", ":Ex<CR>"),
            dashboard.button("q", "󰿅  Quit NVIM", ":qa<CR>"),
        }

        -- Apply custom highlights to each button
        for _, btn in ipairs(buttons) do
            btn.opts.hl = "debug"
            btn.opts.hl_shortcut = "error"
        end
dashboard.section.buttons.val = buttons
        dashboard.section.footer.val = "Good Morning, Blocky!"
        dashboard.section.footer.opts.hl = "error"
        alpha.setup(dashboard.config)
    end
}
