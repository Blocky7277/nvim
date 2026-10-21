return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")

            -- defaults for every server 
            mason_lspconfig.setup({
                ensure_installed = {},
                automatic_installation = false,
                automatic_enable = true,
                handlers = {
                    -- Default handler: applies to all servers unless a specific handler is defined below.
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
            })

            vim.lsp.config("ocamllsp", {
                capabilities = capabilities, 
            })

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--query-driver=/usr/bin/arm-none-eabi-*",
                    "--compile-commands-dir=build/Debug",
                    "--background-index",
                },
                capabilities = capabilities, 
            })

            vim.lsp.enable("ocamllsp")
            vim.lsp.enable("clangd")

            -- autocomplete upon attatch
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
                    local opts = { 
                        buffer = event.buf,
                        silent = true,
                        noremap = true
                    }
                    if client:supports_method('textDocument/completion') then
                        vim.lsp.completion.enable(true, client.id, event.buf, {autotrigger = true})
                        vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
                    end
                    -- stylua: ignore start
                    local keymaps = {
                        { "n", "gC",         vim.lsp.buf.outgoing_calls,  "Outgoing Calls" },
                        { "n", "gD",         vim.lsp.buf.declaration,     "Goto Declaration" },
                        { "n", "gI",         vim.lsp.buf.incoming_calls,  "Incoming Calls" },
                        { "n", "gd",         vim.lsp.buf.definition,      "Goto Definition" },
                        { "n", "gl",         vim.diagnostic.open_float,   "Floating Diagnostic" },
                        { "n", "go",         vim.lsp.buf.type_definition, "Goto Type Definition" },
                        { "n", "<leader>ca", vim.lsp.buf.code_action,     "Code Action" },
                        { "n", "<leader>cr", vim.lsp.buf.rename,          "Rename Symbol" },
                        { "n", "<leader>q",  vim.diagnostic.setloclist,   "Diagnostics List" },
                        { "i", "<C-r>",  function() return "<Tab>" end,   "Insert Suggestion" },
                    }
                    -- stylua: ignore end
                    for _, map in ipairs(keymaps) do
                        local expr = map[5] or {}
                        vim.keymap.set(map[1], map[2], map[3], vim.tbl_extend("force", opts, { desc = map[4] }))
                    end
                end,
            })
            local diagnostic_opts = {
                signs = true,
                underline = {
                    severity = vim.diagnostic.severity.WARN,
                },
                virtual_text = false,
                virtual_lines = {
                    current_line = true,
                    format = function(diagnostic)
                        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
                    end,
                },
                float = false,
                update_in_insert = false,
                severity_sort = true,
            }
            vim.diagnostic.config(diagnostic_opts)
        end,
    },
}
