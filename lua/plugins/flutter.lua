return {
    'akinsho/flutter-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require("flutter-tools").setup {
            ui = {
                border = "rounded",
                -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
                -- please note that this option is eventually going to be deprecated and users will need to
                -- depend on plugins like `nvim-notify` instead.
                notification_style = 'native' -- | 'plugin'
            },
            widget_guides = {
                enabled = false,
            },
            closing_tags = {
                highlight = "Comment", -- highlight for the closing tag
                prefix = "// ", -- character to use for close tag e.g. > Widget
                enabled = true -- set to false to disable
            },
            dev_log = {
                enabled = true,
                open_cmd = "tabedit", -- command to use to open the log buffer
            },
            dev_tools = {
                autostart = false, -- autostart devtools server if not detected
                auto_open_browser = false, -- Automatically opens devtools in the browser
            },
            outline = {
                open_cmd = "30vnew", -- command to use to open the outline buffer
                auto_open = false -- if true this will open the outline automatically when it is first populated
            },
            lsp = {
                capabilities = vim.lsp.protocol.make_client_capabilities()
            }
        }
    end
}
