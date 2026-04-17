return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    picker = {
      sources = {
        explorer = {
          watch = false,         -- 대형 레포 파일시스템 감시 비활성화
          git_untracked = false, -- untracked 파일 표시 안 함 (스캔 범위 축소)
          git_status_open = false,
        },
      },
    },
  },
}
