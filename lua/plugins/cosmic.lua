return {
    'CosmicNvim/cosmic-ui',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
        require('cosmic-ui').setup({
            border_style = 'rounded',
            -- rename popup settings
            rename = {
                border = {
                    highlight = 'CmpBorderColor',
                    style = 'rounded',
                    title = ' 󰼭 Rename ',
                    title_align = 'center',
                    title_hl = 'RenameTitleColor',
                },
                prompt = '',
                prompt_hl = 'RenamePromptColor',
            },
            code_actions = {
                min_width = nil,
                border = {
                    bottom_hl = 'CodeActionBottomColor',
                    highlight = 'CmpBorderColor',
                    style = 'rounded',
                    title = ' 󱓞  Code Actions ',
                    title_align = 'center',
                    title_hl = 'CodeActionTitleColor',
                },
            }
        })
        local function map(mode, lhs, rhs, opts)
            local options = { noremap = true, silent = true }
            if opts then
                options = vim.tbl_extend('force', options, opts)
            end
            vim.api.nvim_set_keymap(mode, lhs, rhs, options)
        end

        map('n', 'gr', '<cmd>lua require("cosmic-ui").rename()<cr>')
        map('n', 'gx', '<cmd>lua require("cosmic-ui").code_actions()<cr>')
        map('v', 'gX', '<cmd>lua require("cosmic-ui").range_code_actions()<cr>')
    end,
}
