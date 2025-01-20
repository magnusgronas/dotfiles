return {
    "elmcgill/springboot-nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-java/nvim-java"
    },
    config = function()
    local springboot_nvim = require("springboot-nvim")
        springboot_nvim.setup()
    end
}
