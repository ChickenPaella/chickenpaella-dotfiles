-- nvim-pets 플러그인 스펙.
--   * 개발 머신(로컬에 ~/nvim-pets 체크아웃이 있는 곳): 그 디렉터리를 직접
--     써서 편집한 내용이 바로 반영되게 한다(dir).
--   * 그 외 머신(회사 PC, 다른 팀원 등): GitHub 에서 lazy 가 자동으로 clone
--     한다. 저장소는 public 이라 인증이 필요 없다.
-- 이렇게 해서 같은 dotfiles 를 어느 머신에 올려도 동작한다.
local local_dir = vim.fn.expand("~/nvim-pets")

local spec = {
  dependencies = { "3rd/image.nvim" },
  -- keys 로만 lazy 로딩하면 <leader>pp 를 누르기 전까지 setup() 이 실행되지
  -- 않아 :Pets* 명령이 등록되지 않는다. cmd 트리거를 더해 명령으로도 로드되게.
  cmd = {
    "Pets", "PetsHelp", "PetsState", "PetsResize", "PetsArea", "PetsMove",
    "PetsType", "PetsCount", "PetsPeek", "PetsWiggle", "PetsSwipe",
    "PetsObject", "PetsFollow", "PetsThrow", "PetsFeed", "PetsStatus",
    "PetsPomodoro", "PetsSleep", "PetsWake",
  },
  keys = {
    { "<leader>pp", "<cmd>Pets<cr>", desc = "Pets: toggle" },
    { "<leader>pb", "<cmd>PetsThrow<cr>", desc = "Pets: throw a ball" },
    { "<leader>pf", "<cmd>PetsFeed<cr>", desc = "Pets: feed" },
  },
  config = function()
    require("pets").setup()
  end,
}

if vim.fn.isdirectory(local_dir) == 1 then
  spec.dir = local_dir                  -- 로컬 체크아웃으로 개발
else
  spec[1] = "ChickenPaella/nvim-pets"   -- GitHub 에서 자동 설치
end

return spec
