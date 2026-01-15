local cmake_workspace = require("core.custom.cmake-wsm")

cmake_workspace.setup({
  default_cpp_standard = 17,
  default_c_standard = 11,
})  -- or 20 if you prefer

-- Keymap: Setup CMake workspace
vim.keymap.set("n", "<leader>cw", function()
  cmake_workspace.setup_cmake_project()
end, { desc = "Setup CMake workspace" })

-- Keymap: Regenerate CMake build after updating CMakeLists or adding reusable units
vim.keymap.set("n", "<leader>cr", function()
  cmake_workspace.regen_build()
end, { desc = "Regenerate CMake build" })

-- Optional: Auto-detect CMake projects on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local cwd = vim.fn.getcwd()
    local cmake_path = cwd .. "/CMakeLists.txt"
    local build_dir = cwd .. "/build"

    -- If CMakeLists exists but no build directory, suggest setup
    if vim.fn.filereadable(cmake_path) == 1 and vim.fn.isdirectory(build_dir) == 0 then
      vim.defer_fn(function()
        local response = vim.fn.input("CMake project detected. Run workspace setup? (y/n): ")
        if response:lower() == "y" then
          cmake_workspace.setup_cmake_project()
        end
      end, 100)
    end
  end,
})

