-- ~/.config/nvim/lua/cmake-workspace/init.lua
local M = {}

-- Configuration
M.config = {
  default_cpp_standard = 17,
  default_c_standard = 11,
  default_build_dir = "build",
  default_source_dir = "src",
  default_include_dir = "include",
}

-- State tracking
M.state = {
  project_type = nil,
  project_name = nil,
  binary_name = nil,
  cwd = nil
}

-- Utility: Show notifications with noice
local function notify(msg, level, opts)
  opts = opts or {}
  local title = opts.title or "CMake Workspace"
  local timeout = opts.timeout or 2000

  if pcall(require, "noice") then
    require("noice").notify(msg, level, {
      title = title,
      timeout = timeout
    })
  else
    vim.notify(msg, vim.log.levels[level:upper()] or vim.log.levels.INFO, {
      title = title,
    })
  end
end

-- Utility: Show error and return false
local function error_msg(msg)
  notify(msg, "error", { title = "CMake Setup Error", timeout = 3000 })
  return false
end

-- Utility: Show success message
local function success_msg(msg)
  notify(msg, "success", { title = "CMake Setup Complete" })
end

-- Validate current working directory
local function validate_cwd()
  local cwd = vim.fn.getcwd()
  if cwd == "" or cwd == nil then
    return error_msg("Cannot determine current directory")
  end

  -- Check if we're in a valid directory
  local stat = vim.loop.fs_stat(cwd)
  if not stat then
    return error_msg("Current directory doesn't exist: " .. cwd)
  end

  return true, cwd
end

-- Prompt for project type (C/C++)
local function prompt_project_type()
  local choices = {
    { value = "cpp", label = "C++", desc = "C++ Project (CMake CXX)" },
    { value = "c", label = "C", desc = "C Project (CMake C)" }
  }

  local items = {}
  for _, choice in ipairs(choices) do
    table.insert(items, {
      text = choice.label,
      desc = choice.desc,
      value = choice.value
    })
  end

  vim.ui.select(items, {
    prompt = "Select Project Language:",
    format_item = function(item)
      return string.format("%-5s - %s", item.text, item.desc)
    end
  }, function(selected)
    if selected then
      M.state.project_type = selected.value
      notify(string.format("Selected: %s project", selected.text), "info")
    end
  end)

  -- Wait for selection (simplified - in real use you'd use async/callbacks)
  vim.wait(100, function() return M.state.project_type ~= nil end)

  if not M.state.project_type then
    return error_msg("Project type selection cancelled")
  end

  return true
end

-- Prompt for project name
local function prompt_project_name(default_name)
  vim.ui.input({
    prompt = "Project Name: ",
    default = default_name,
    completion = "file",
  }, function(input)
    if input and input:gsub("%s+", "") ~= "" then
      M.state.project_name = input
    end
  end)

  vim.wait(100, function() return M.state.project_name ~= nil end)

  if not M.state.project_name then
    return error_msg("Project name required")
  end

  -- Validate project name (no special chars)
  if not M.state.project_name:match("^[%w_%-]+$") then
    return error_msg("Project name can only contain letters, numbers, underscores, and hyphens")
  end

  return true
end

-- Prompt for binary name
local function prompt_binary_name(default_name)
  vim.ui.input({
    prompt = "Output Binary Name: ",
    default = default_name,
    completion = "file",
  }, function(input)
    if input and input:gsub("%s+", "") ~= "" then
      M.state.binary_name = input
    end
  end)

  vim.wait(100, function() return M.state.binary_name ~= nil end)

  if not M.state.binary_name then
    return error_msg("Binary name required")
  end

  -- Validate binary name
  if not M.state.binary_name:match("^[%w_%-%.]+$") then
    return error_msg("Binary name contains invalid characters")
  end

  return true
end

-- Create directory structure
local function create_directories()
  local dirs = {
    M.config.default_source_dir,
    M.config.default_include_dir,
    M.config.default_build_dir
  }

  for _, dir in ipairs(dirs) do
    local path = M.state.cwd .. "/" .. dir
    local stat = vim.loop.fs_stat(path)

    if not stat then
      -- Directory doesn't exist, create it
      local success, err = pcall(vim.fn.mkdir, path, "p")
      if not success then
        return error_msg("Failed to create directory '" .. dir .. "': " .. (err or "unknown error"))
      end
      notify("Created directory: " .. dir, "info")
    elseif stat.type ~= "directory" then
      return error_msg("Path exists but is not a directory: " .. dir)
    else
      notify("Directory already exists: " .. dir, "info")
    end
  end

  return true
end
-- Generate CMakeLists.txt content
local function generate_cmakelists_content()
  local is_cpp = M.state.project_type == "cpp"
  local project_type_upper = is_cpp and "CXX" or "C"
  local standard = is_cpp and M.config.default_cpp_standard or M.config.default_c_standard
  local extension_pattern = is_cpp and '"src/*.cpp" "src/*.cc" "src/*.cxx" "src/*.c++"' or '"src/*.c"'

  local content = string.format([[
# CMakeLists.txt for %s
cmake_minimum_required(VERSION 3.10)
project(%s %s)

# Set C/C++ standard
set(CMAKE_%s_STANDARD %d)
set(CMAKE_%s_STANDARD_REQUIRED ON)

# Include directories
include_directories(%s)

# Collect source files
file(GLOB_RECURSE SOURCES %s)

# Create executable
add_executable(%s ${SOURCES})

# Installation (optional)
# install(TARGETS %s DESTINATION bin)
]],
    M.state.project_name,
    M.state.project_name,
    is_cpp and "LANGUAGES CXX" or "LANGUAGES C",
    project_type_upper,
    standard,
    project_type_upper,
    M.config.default_include_dir,
    extension_pattern,
    M.state.binary_name,
    M.state.binary_name
  )

  return content
end

-- Write CMakeLists.txt
local function write_cmakelists()
  local cmake_path = M.state.cwd .. "/CMakeLists.txt"

  -- Check if CMakeLists.txt already exists
  local stat = vim.loop.fs_stat(cmake_path)
  if stat then
    vim.ui.input({
      prompt = "CMakeLists.txt already exists. Overwrite? (y/n): ",
      default = "n"
    }, function(input)
      if not input or input:lower() ~= "y" then
        notify("CMake setup cancelled - CMakeLists.txt already exists", "warn")
        return false
      end
    end)
    vim.wait(50)
  end

  -- Generate and write content
  local content = generate_cmakelists_content()
  local file, err = io.open(cmake_path, "w")
  if not file then
    return error_msg("Failed to create CMakeLists.txt: " .. (err or "unknown error"))
  end

  file:write(content)
  file:close()

  notify("Created CMakeLists.txt", "info")
  return true
end

-- Create initial source file
local function create_initial_source()
  local extension = M.state.project_type == "cpp" and ".cpp" or ".c"
  local filename = "main" .. extension
  local source_path = M.state.cwd .. "/" .. M.config.default_source_dir .. "/" .. filename

  -- Check if source file already exists
  local stat = vim.loop.fs_stat(source_path)
  if stat then
    notify("Source file already exists: " .. filename, "info")
    return true
  end

  -- Create sample source content
  local content
  if M.state.project_type == "cpp" then
    content = string.format([[
#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Hello from %s!" << std::endl;
    return 0;
}
]], M.state.project_name)
  else
    content = string.format([[
#include <stdio.h>

int main(int argc, char* argv[]) {
    printf("Hello from %s!\n");
    return 0;
}
]], M.state.project_name)
  end

  -- Write the file
  local file, err = io.open(source_path, "w")
  if not file then
    return error_msg("Failed to create source file: " .. (err or "unknown error"))
  end

  file:write(content)
  file:close()

  notify("Created sample source file: " .. filename, "info")
  return true
end

-- Run CMake command
local function run_cmake()
  local build_dir = M.state.cwd .. "/" .. M.config.default_build_dir

  notify("Running CMake configuration...", "info")

  -- Run cmake command
  local cmd = string.format("cd %s && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..",
    vim.fn.shellescape(build_dir))

  vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    return error_msg("CMake configuration failed. Check build directory.")
  end

  -- Create symlink for compile_commands.json
  local compile_commands_src = build_dir .. "/compile_commands.json"
  local compile_commands_dst = M.state.cwd .. "/compile_commands.json"

  local stat = vim.loop.fs_stat(compile_commands_src)
  if stat then
    -- Remove existing symlink if it exists
    local dst_stat = vim.loop.fs_stat(compile_commands_dst)
    if dst_stat then
      os.remove(compile_commands_dst)
    end

    -- Create symlink
    vim.fn.system(string.format("ln -sf %s %s",
      vim.fn.shellescape(compile_commands_src),
      vim.fn.shellescape(compile_commands_dst)))

    notify("Created compile_commands.json symlink", "info")
  end

  return true
end

-- Main setup function
function M.setup_cmake_project()
  -- Reset state
  M.state = {
    project_type = nil,
    project_name = nil,
    binary_name = nil,
    cwd = nil
  }

  -- Step 1: Validate CWD
  local valid, cwd = validate_cwd()
  if not valid then return end
  M.state.cwd = cwd

  notify("Setting up CMake workspace in: " .. cwd, "info")

  -- Step 2: Get default names
  local default_project_name = vim.fn.fnamemodify(cwd, ":t")
  local default_binary_name = default_project_name

  -- Step 3: Prompt for project type
  if not prompt_project_type() then return end

  -- Step 4: Prompt for project name
  if not prompt_project_name(default_project_name) then return end

  -- Step 5: Prompt for binary name
  if not prompt_binary_name(default_binary_name) then return end

  -- Step 6: Create directories
  if not create_directories() then return end

  -- Step 7: Create initial source file
  if not create_initial_source() then return end

  -- Step 8: Write CMakeLists.txt
  if not write_cmakelists() then return end

  -- Step 9: Run CMake
  if not run_cmake() then return end

  -- Final success message
  local summary = string.format([[
CMake Workspace Setup Complete!

Project: %s (%s)
Binary: %s
Directories: %s, %s, %s

Build commands:
  cd %s
  cmake --build .
]],
    M.state.project_name,
    M.state.project_type == "cpp" and "C++" or "C",
    M.state.binary_name,
    M.config.default_source_dir,
    M.config.default_include_dir,
    M.config.default_build_dir,
    M.config.default_build_dir
  )
  success_msg(summary)
  -- Optional: Open the CMakeLists.txt for review
  --vim.cmd("edit CMakeLists.txt")
end

-- Setup function for configuration
function M.setup(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

	--notify("CMake Workspace Manager Loaded", "info")
end

return M
