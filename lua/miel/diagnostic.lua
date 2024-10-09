local rightAlignFormatFunction = function(diagnostic)
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format("🐙 %s", diagnostic.message)
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format("🐥 %s", diagnostic.message)
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format("🐬 %s", diagnostic.message)
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format("🐨 %s", diagnostic.message)
    end
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        format = rightAlignFormatFunction
    },
})
