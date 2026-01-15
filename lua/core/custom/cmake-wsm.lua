-- ~/.config/nvim/lua/cmake-workspace/init.lua
-- CMake workspace generator for C / C++ projects
-- Fully async-safe and compatible with:
--   - vanilla Neovim
--   - snacks.nvim
--   - noice.nvim
--   - telescope-ui-select
--   GUIDED AI GENERATED: CHAT GPT, PROMPTER: NE4580(Eric Nsama)

local M = {}

-----------------------------------------------------------------------
-- Configuration
-----------------------------------------------------------------------
M.config = {
  default_cpp_standard = 17,
  default_c_standard = 11,
  default_build_dir = "build",
  default_source_dir = "src",
  default_include_dir = "include",
}

-----------------------------------------------------------------------
-- Runtime state (reset every run)
-----------------------------------------------------------------------
M.state = {}

-----------------------------------------------------------------------
-- Notifications
-----------------------------------------------------------------------
local level_map = {
  info = vim.log.levels.INFO,
  warn = vim.log.levels.WARN,
  error = vim.log.levels.ERROR,
  success = vim.log.levels.INFO,
}

local function notify(msg, level, opts)
  opts = opts or {}
  level = level or "info"

  if pcall(require, "noice") then
    require("noice").notify(msg, level, {
      title = opts.title or "CMake Workspace",
      timeout = opts.timeout or 2000,
    })
  else
    vim.notify(
      msg,
      level_map[level] or vim.log.levels.INFO,
      { title = opts.title or "CMake Workspace" }
    )
  end
end

local function error_msg(msg)
  notify(msg, "error", { title = "CMake Setup Error", timeout = 3000 })
  return false
end

local function success_msg(msg)
  notify(msg, "success", { title = "CMake Setup Complete", timeout = 4000 })
end

-----------------------------------------------------------------------
-- UI compatibility layer
-----------------------------------------------------------------------
local function ui_uses_opts_callback()
  local info = debug.getinfo(vim.ui.select, "u")
  return info and info.nparams == 2 -- snacks.nvim style
end

local USE_OPTS_CALLBACK = ui_uses_opts_callback()

local function await_select(items, opts)
  local co = coroutine.running()
  if not co then error("await_select must be called in a coroutine") end

  opts = opts or {}

  if USE_OPTS_CALLBACK then
    opts.on_choice = function(choice)
      coroutine.resume(co, choice)
    end
    vim.ui.select(items, opts)
  else
    vim.ui.select(items, opts, function(choice)
      coroutine.resume(co, choice)
    end)
  end

  return coroutine.yield()
end

local function await_input(opts)
  local co = coroutine.running()
  if not co then error("await_input must be called in a coroutine") end

  opts = opts or {}

  if USE_OPTS_CALLBACK then
    opts.on_confirm = function(input)
      coroutine.resume(co, input)
    end
    vim.ui.input(opts)
  else
    vim.ui.input(opts, function(input)
      coroutine.resume(co, input)
    end)
  end

  return coroutine.yield()
end

-----------------------------------------------------------------------
-- Validation
-----------------------------------------------------------------------
local function validate_cwd()
  local cwd = vim.fn.getcwd()
  if not cwd or cwd == "" then
    return error_msg("Cannot determine current directory")
  end
  if not vim.loop.fs_stat(cwd) then
    return error_msg("Current directory does not exist: " .. cwd)
  end
  return true, cwd
end

-----------------------------------------------------------------------
-- Project root detection
-- Finds nearest directory containing CMakeLists.txt
-- Works with:
--   - open buffer
--   - empty buffer
--   - anywhere inside project tree
-----------------------------------------------------------------------
local function find_project_root()
  -- 1. Try from current buffer
  local buf = vim.api.nvim_buf_get_name(0)
  if buf ~= "" then
    local dir = vim.fn.fnamemodify(buf, ":p:h")
    while dir and dir ~= "/" do
      if vim.fn.filereadable(dir .. "/CMakeLists.txt") == 1 then
        return dir
      end
      dir = vim.fn.fnamemodify(dir, ":h")
    end
  end

  -- 2. Fallback: walk upward from cwd
  local dir = vim.fn.getcwd()
  while dir and dir ~= "/" do
    if vim.fn.filereadable(dir .. "/CMakeLists.txt") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

-----------------------------------------------------------------------
-- Prompts
-----------------------------------------------------------------------
local function prompt_project_type()
  local items = {
    { label = "C++", value = "cpp", desc = "C++ Project (CMake CXX)" },
    { label = "C",   value = "c",   desc = "C Project (CMake C)" },
  }

  local choice = await_select(items, {
    prompt = "Select Project Language:",
    format_item = function(item)
      return string.format("%-3s — %s", item.label, item.desc)
    end,
  })

  if not choice then
    return error_msg("Project type selection cancelled")
  end

  M.state.project_type = choice.value
  notify("Selected: " .. choice.label, "info")
  return true
end

local function prompt_project_name(default)
  local input = await_input({
    prompt = "Project Name:",
    default = default,
  })

  if not input or input:gsub("%s+", "") == "" then
    return error_msg("Project name is required")
  end

  if not input:match("^[%w_%-]+$") then
    return error_msg("Project name may contain only letters, numbers, _ and -")
  end

  M.state.project_name = input
  return true
end

local function prompt_binary_name(default)
  local input = await_input({
    prompt = "Output Binary Name:",
    default = default,
  })

  if not input or input:gsub("%s+", "") == "" then
    return error_msg("Binary name is required")
  end

  if not input:match("^[%w_%-%.]+$") then
    return error_msg("Binary name contains invalid characters")
  end

  M.state.binary_name = input
  return true
end

-----------------------------------------------------------------------
-- Directory creation
-----------------------------------------------------------------------
local function create_directories()
  for _, dir in ipairs({
    M.config.default_source_dir,
    M.config.default_include_dir,
    M.config.default_build_dir,
  }) do
    local path = M.state.cwd .. "/" .. dir
    local stat = vim.loop.fs_stat(path)

    if not stat then
      local ok, err = pcall(vim.fn.mkdir, path, "p")
      if not ok then
        return error_msg("Failed to create directory " .. dir .. ": " .. (err or ""))
      end
      notify("Created directory: " .. dir, "info")
    elseif stat.type ~= "directory" then
      return error_msg(dir .. " exists but is not a directory")
    end
  end
  return true
end

-----------------------------------------------------------------------
-- Initial source file (src/main.c or src/main.cpp)
-----------------------------------------------------------------------
local function create_initial_source()
  local ext = M.state.project_type == "cpp" and ".cpp" or ".c"
  local filename = "main" .. ext
  local path = string.format(
    "%s/%s/%s",
    M.state.cwd,
    M.config.default_source_dir,
    filename
  )

  if vim.loop.fs_stat(path) then
    notify("Source file already exists: " .. filename, "info")
    return true
  end

  local content = M.state.project_type == "cpp"
    and ([[#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Hello from %s!" << std::endl;
    return 0;
}
]]):format(M.state.project_name)
    or ([[#include <stdio.h>

int main(int argc, char* argv[]) {
    printf("Hello from %s!\n");
    return 0;
}
]]):format(M.state.project_name)

  local f, err = io.open(path, "w")
  if not f then
    return error_msg("Failed to create source file: " .. (err or ""))
  end

  f:write(content)
  f:close()

  notify("Created sample source file: " .. filename, "info")
  return true
end

-----------------------------------------------------------------------
-- Detect reusable units
-----------------------------------------------------------------------
local function detect_reusable_units()
    local src_dir = M.state.cwd .. "/" .. M.config.default_source_dir
    local include_dir = M.state.cwd .. "/" .. M.config.default_include_dir

    local sources = {}
    local headers = {}

    local extensions = M.state.project_type == "cpp"
        and {".cpp", ".c", ".cxx", ".cc", ".c++"} -- C++ base detects C too
        or {".c"}

    local header_exts = M.state.project_type == "cpp"
        and {".hpp", ".h"}
        or {".h"}

    -- Scan src dir
    for _, ext in ipairs(extensions) do
        for _, file in ipairs(vim.fn.globpath(src_dir, "*" .. ext, true, true)) do
            table.insert(sources, file)
        end
    end

    -- Scan include dir
    for _, ext in ipairs(header_exts) do
        for _, file in ipairs(vim.fn.globpath(include_dir, "*" .. ext, true, true)) do
            table.insert(headers, file)
        end
    end

    return sources, headers
end

-----------------------------------------------------------------------
-- CMakeLists.txt generation
-----------------------------------------------------------------------
local function generate_cmakelists()
    local sources, _ = detect_reusable_units()
    local sources_list = table.concat(sources, " ")

    local lang = M.state.project_type == "cpp" and "CXX" or "C"
    local std = M.state.project_type == "cpp" and M.config.default_cpp_standard or M.config.default_c_standard

    return string.format([[
# CMakeLists.txt for %s
cmake_minimum_required(VERSION 3.10)

project(%s LANGUAGES %s)

set(CMAKE_%s_STANDARD %d)
set(CMAKE_%s_STANDARD_REQUIRED ON)

include_directories(%s)

add_executable(%s %s)
]],
        M.state.project_name,
        M.state.project_name,
        lang,
        lang,
        std,
        lang,
        M.config.default_include_dir,
        M.state.binary_name,
        sources_list
    )
end

local function write_cmakelists()
  local path = M.state.cwd .. "/CMakeLists.txt"

  if vim.loop.fs_stat(path) then
    os.remove(path)
  end

  local f, err = io.open(path, "w")
  if not f then
    return error_msg("Failed to write CMakeLists.txt: " .. (err or ""))
  end

  f:write(generate_cmakelists())
  f:close()

  notify("Created CMakeLists.txt", "info")
  return true
end

-----------------------------------------------------------------------
-- Run CMake inside build directory + compile_commands.json symlink
-----------------------------------------------------------------------
local function run_cmake()
  local build_dir = M.state.cwd .. "/" .. M.config.default_build_dir

  notify("Running CMake configuration...", "info")

  vim.fn.system(
    string.format(
      "cd %s && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..",
      vim.fn.shellescape(build_dir)
    )
  )

  if vim.v.shell_error ~= 0 then
    return error_msg("CMake configuration failed. Check build directory.")
  end

  -- Symlink compile_commands.json to project root
  local src = build_dir .. "/compile_commands.json"
  local dst = M.state.cwd .. "/compile_commands.json"

  if vim.loop.fs_stat(src) then
    os.remove(dst)
    vim.fn.system(string.format(
      "ln -sf %s %s",
      vim.fn.shellescape(src),
      vim.fn.shellescape(dst)
    ))
    notify("Created compile_commands.json symlink", "info")
  end

  return true
end

-----------------------------------------------------------------------
-- Public entry point: setup project
-----------------------------------------------------------------------
function M.setup_cmake_project()
  coroutine.wrap(function()
    M.state = {}

		local root = find_project_root() or vim.fn.getcwd()
		M.state.cwd = root

    local default = vim.fn.fnamemodify(root, ":t")

    if not prompt_project_type() then return end
    if not prompt_project_name(default) then return end
    if not prompt_binary_name(default) then return end
    if not create_directories() then return end
    if not create_initial_source() then return end
    if not write_cmakelists() then return end
    if not run_cmake() then return end

    -- Open main file automatically
    local main_file = M.state.cwd .. "/" .. M.config.default_source_dir .. "/main" .. (M.state.project_type == "cpp" and ".cpp" or ".c")
    if vim.loop.fs_stat(main_file) then
        vim.cmd("edit " .. main_file)
    end

    success_msg(
      string.format(
        "Project: %s (%s)\nBinary: %s\nBuild dir: %s",
        M.state.project_name,
        M.state.project_type == "cpp" and "C++" or "C",
        M.state.binary_name,
        M.config.default_build_dir
      )
    )
  end)()
end

-----------------------------------------------------------------------
-- Regenerate CMake build (re-run CMake after changes)
-----------------------------------------------------------------------
function M.regen_build()
  coroutine.wrap(function()
    local root = find_project_root()
    if not root then
      return error_msg("No existing CMake project found. Run setup first.")
    end

    M.state = {}
    M.state.cwd = root

    notify("Regenerating CMake build...", "info")

    if not run_cmake() then return end

    success_msg("CMake build regenerated")
  end)()
end

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------
function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

return M

