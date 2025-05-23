return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc","cpp","go",
          "typescript","query", "rust", "vue","java","python", "javascript", 
          "html","sql","markdown","llvm","json","cmake" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  }
 }
