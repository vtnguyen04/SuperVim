#!/usr/bin/env nvim -l

-- Comprehensive test suite for SuperVim
local function run_all_tests()
  print("🧪 SuperVim Comprehensive Test Suite")
  print("====================================")

  local tests_passed = 0
  local tests_total = 0

  -- Test 1: Basic file syntax
  print("\n1️⃣  Testing Lua file syntax...")
  tests_total = tests_total + 1

  local lua_files = {
    "init.lua",
    "lua/config/options.lua",
    "lua/config/keymaps.lua",
    "lua/config/autocmds.lua",
    "lua/config/lazy.lua",
    "lua/utils/init.lua",
    "lua/health.lua",
  }

  local syntax_ok = true
  for _, file in ipairs(lua_files) do
    local ok, err = pcall(dofile, file)
    if not ok and not err:match("Re%-sourcing your config") then
      print("    ❌ " .. file .. ": " .. err)
      syntax_ok = false
    else
      print("    ✅ " .. file)
    end
  end

  if syntax_ok then
    tests_passed = tests_passed + 1
    print("  ✅ All Lua files passed syntax check")
  else
    print("  ❌ Some Lua files have syntax errors")
  end

  -- Test 2: Plugin files
  print("\n2️⃣  Testing plugin configurations...")
  tests_total = tests_total + 1

  local plugin_files = vim.fn.glob("lua/plugins/*.lua", false, true)
  local plugin_ok = true

  for _, file in ipairs(plugin_files) do
    local ok, result = pcall(dofile, file)
    if ok and type(result) == "table" then
      print("    ✅ " .. file:match("([^/]+)%.lua$"))
    else
      print("    ❌ " .. file:match("([^/]+)%.lua$") .. ": Invalid plugin config")
      plugin_ok = false
    end
  end

  if plugin_ok then
    tests_passed = tests_passed + 1
    print("  ✅ All plugin configurations are valid")
  else
    print("  ❌ Some plugin configurations have issues")
  end

  -- Test 3: System requirements
  print("\n3️⃣  Testing system requirements...")
  tests_total = tests_total + 1

  local requirements = {
    { name = "Neovim", cmd = "nvim --version" },
    { name = "Git", cmd = "git --version" },
    { name = "Python", cmd = "python3 --version" },
  }

  local req_met = 0
  for _, req in ipairs(requirements) do
    local handle = io.popen(req.cmd .. " 2>/dev/null")
    if handle then
      local output = handle:read("*a")
      handle:close()
      if output and output:match("%S") then
        print("    ✅ " .. req.name .. " available")
        req_met = req_met + 1
      else
        print("    ❌ " .. req.name .. " not found")
      end
    end
  end

  if req_met >= 2 then -- At least Neovim and Git
    tests_passed = tests_passed + 1
    print("  ✅ Essential system requirements met")
  else
    print("  ❌ Missing critical system requirements")
  end

  -- Test 4: Performance check
  print("\n4️⃣  Testing startup performance...")
  tests_total = tests_total + 1

  local start_time = vim.fn.reltime()

  -- Load core modules
  pcall(dofile, "lua/config/options.lua")
  pcall(dofile, "lua/config/keymaps.lua")
  pcall(dofile, "lua/utils/init.lua")

  local load_time = vim.fn.reltimefloat(vim.fn.reltime(start_time))

  if load_time < 0.1 then
    tests_passed = tests_passed + 1
    print(string.format("  ✅ Excellent performance: %.2fms", load_time * 1000))
  elseif load_time < 0.2 then
    tests_passed = tests_passed + 1
    print(string.format("  ⚠️  Good performance: %.2fms", load_time * 1000))
  else
    print(string.format("  ❌ Slow performance: %.2fms", load_time * 1000))
  end

  -- Test 5: Demo file
  print("\n5️⃣  Testing demo file...")
  tests_total = tests_total + 1

  if vim.fn.filereadable("demo.py") == 1 then
    local demo_content = vim.fn.readfile("demo.py")
    if #demo_content > 50 then -- Should have substantial content
      tests_passed = tests_passed + 1
      print("  ✅ Demo file exists and has content")
    else
      print("  ❌ Demo file too short")
    end
  else
    print("  ❌ Demo file not found")
  end

  -- Final results
  print("\n📊 Test Results")
  print("===============")
  print(string.format("Passed: %d/%d tests", tests_passed, tests_total))

  local success_rate = (tests_passed / tests_total) * 100

  if success_rate == 100 then
    print("🎉 Perfect! All tests passed!")
    print("SuperVim is ready for production use!")
  elseif success_rate >= 80 then
    print("✅ Great! Most tests passed.")
    print("SuperVim should work well with minor issues.")
  elseif success_rate >= 60 then
    print("⚠️  Good, but some issues detected.")
    print("Consider fixing the failing tests.")
  else
    print("❌ Several tests failed.")
    print("Please fix the issues before using SuperVim.")
  end

  return success_rate >= 80
end

-- Run tests
return run_all_tests()