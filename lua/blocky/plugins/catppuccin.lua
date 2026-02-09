return { 
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function () 
        require("catppuccin").setup({
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        LineNr = { fg = mocha.red },
                    }
                end,
            }
        })
    end
}
