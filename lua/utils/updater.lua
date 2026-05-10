-- ============================================
-- SUPERVIM UPDATER - Tự động cập nhật từ GitHub
-- ============================================

local M = {}

-- Cấu hình
M.repo_url = "https://github.com/vtnguyen04/SuperVim.git"
M.check_interval = 86400 -- Kiểm tra mỗi 24 giờ (tính bằng giây)

function M.check_for_updates(silent)
  local nvim_dir = vim.fn.stdpath("config")
  
  -- Kiểm tra xem có phải là git repo không
  local is_git = vim.fn.isdirectory(nvim_dir .. "/.git") == 1
  if not is_git then
    if not silent then
      vim.notify("⚠️ SuperVim không được cài đặt qua Git, không thể tự động cập nhật.", vim.log.levels.WARN)
    end
    return
  end

  -- Chạy git fetch ngầm
  vim.fn.jobstart("git fetch origin", {
    cwd = nvim_dir,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then return end
      
      -- Kiểm tra số lượng commit mới
      local status = vim.fn.system("git rev-list HEAD..origin/main --count"):gsub("%s+", "")
      local count = tonumber(status) or 0

      if count > 0 then
        vim.notify("🚀 SuperVim có " .. count .. " bản cập nhật mới! Gõ :SuperVimUpdate để nâng cấp.", vim.log.levels.INFO, {
          title = "SuperVim Update",
          timeout = 10000,
        })
      elseif not silent then
        vim.notify("✅ SuperVim đã ở phiên bản mới nhất.", vim.log.levels.INFO)
      end
    end
  })
end

function M.update()
  local nvim_dir = vim.fn.stdpath("config")
  
  print("🔄 Đang cập nhật SuperVim...")
  
  vim.fn.jobstart("git pull origin main", {
    cwd = nvim_dir,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then print(line) end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("✨ SuperVim đã cập nhật thành công! Vui lòng khởi động lại Neovim.", vim.log.levels.INFO)
        -- Kích hoạt sync plugin sau khi update code
        vim.cmd("Lazy sync")
      else
        vim.notify("❌ Cập nhật thất bại. Vui lòng kiểm tra lại Git.", vim.log.levels.ERROR)
      end
    end
  })
end

function M.setup()
  -- Tạo command
  vim.api.nvim_create_user_command("SuperVimUpdate", function()
    M.update()
  end, { desc = "Cập nhật SuperVim lên bản mới nhất" })

  -- Tự động kiểm tra cập nhật khi khởi động (nếu đã quá interval)
  local last_check = vim.fn.stdpath("data") .. "/supervim_last_check"
  local f = io.open(last_check, "r")
  local last_time = f and tonumber(f:read("*all")) or 0
  if f then f:close() end

  local current_time = os.time()
  if current_time - last_time > M.check_interval then
    M.check_for_updates(true)
    local fw = io.open(last_check, "w")
    if fw then
      fw:write(tostring(current_time))
      fw:close()
    end
  end
end

return M
