return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    -- 치트시트 전용 가상 플러그인 (plenary 팝업 활용)
    dir = vim.fn.stdpath("config"),
    name = "cheatsheet",
    lazy = true,
    keys = {
      { "<leader>?", desc = "치트시트 열기" },
    },
    config = function()
      vim.keymap.set("n", "<leader>?", function()
        local lines = {
          "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
          "  Vim 치트시트",
          "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
          "",
          "  [검색]",
          "  /word          파일 내 검색 (n=다음, N=이전)",
          "  *              커서 위 단어 즉시 검색",
          "  <leader>fg     프로젝트 전체 grep",
          "  <leader>ff     파일명 검색",
          "",
          "  [치환]",
          "  :%s/old/new/g  전체 치환",
          "  :%s/old/new/gc 하나씩 확인하며 치환 (y/n/q)",
          "  :s/old/new/g   현재 줄만 치환",
          "",
          "  [매크로]",
          "  qa             a 레지스터에 녹화 시작",
          "  q              녹화 종료",
          "  @a             매크로 실행",
          "  3@a            3번 반복 실행",
          "  @@             마지막 매크로 재실행",
          "",
          "  [Visual Block]",
          "  Ctrl+v         Visual Block 시작",
          "  I              각 줄 앞에 삽입",
          "  A              각 줄 끝에 삽입",
          "  d / x          선택 삭제",
          "",
          "  [삽입 모드]",
          "  i/a/I/A        커서앞/커서뒤/줄앞/줄끝 삽입",
          "  Ctrl+o         삽입모드에서 명령 하나 실행",
          "  jk             Normal 모드로",
          "",
          "  [이동]",
          "  H / L          줄 처음 / 줄 끝",
          "  J / K          다음 단락 / 이전 단락",
          "  gg / G         파일 처음 / 파일 끝",
          "  Ctrl+d/u       반 페이지 아래/위",
          "",
          "  [AI 자동완성 (Codeium)]",
          "  Alt+y          제안 수락",
          "  Alt+[          제안 거절",
          "  Alt+n          다음 제안",
          "",
          "  [리팩토링]",
          "  <leader>rv     변수로 추출 (visual)",
          "  <leader>re     함수로 추출 (visual)",
          "  <leader>ri     인라인 변수",
          "",
          "  q              닫기",
          "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
        }

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].modifiable = false
        vim.bo[buf].filetype = "markdown"

        local width = 70
        local height = #lines
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = math.floor((vim.o.lines - height) / 2),
          col = math.floor((vim.o.columns - width) / 2),
          style = "minimal",
          border = "rounded",
          title = " Cheatsheet ",
          title_pos = "center",
        })

        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, nowait = true })
      end, { desc = "치트시트 열기" })
    end,
  },
}
