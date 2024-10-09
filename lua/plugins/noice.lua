return {
    "folke/noice.nvim",
    config = function()
        require("noice").setup({
            views = {
                hover = {
                    border = {
                        style = "rounded",
                        text = {
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = "Normal:HoverNormalColor,FloatBorder:CmpBorderColor",
                        wrap = true,
                        linebreak = true,
                    },
                    position = {
                        row = 2,
                        col = 0
                    },
                },
            },
            cmdline = {
                enabled = false, -- enables the Noice cmdline UI
                view = "cmdline_popup",
                format = {
                    cmdline = { pattern = "^:", icon = "󰄛 ", lang = "vim" },
                }
            },
            messages = {
                enabled = false, -- enables the Noice messages UI
            },
            popupmenu = {
                enabled = false, -- enables the Noice popupmenu UI
            },
            redirect = {
                view = "popup",
                filter = { event = "msg_show" },
            },
            notify = {
                enabled = true,
                view = "notify",
            },
            lsp = {
                hover = {
                    enabled = true,
                    view = "hover",
                    opts = {
                        border = {
                            text = {
                                top = "   Hover ",
                            }
                        },
                        focusable = true,
                    }
                },
                override = {
                    -- override the default lsp markdown formatter with Noice
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    -- override the lsp markdown formatter with Noice
                        ["vim.lsp.util.stylize_markdown"] = true,
                },
                signature = {
                    enabled = true,
                    view = "hover",
                    opts = {
                        position = {
                            col = 5,
                            row = 0
                        },
                        size = {
                            width = "auto",
                            height = 1,
                            max_height = 20,
                        },
                    }
                },
                message = {
                    enabled = false,
                },
                documentation = {
                    --view = "hover",
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                    },
                },
            },
        })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
    }
}
