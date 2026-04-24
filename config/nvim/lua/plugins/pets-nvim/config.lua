return {
  "giusgad/pets.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = { "PetsNew", "PetsList", "PetsKill", "PetsKillAll", "PetsPauseToggle", "PetsHideToggle" },
  opts = {
    row = 1,           -- distance from bottom of screen
    col = 0,           -- distance from right of screen
    speed_multiplier = 1,
    default_pet = "dog",
    default_style = "brown",
    random = true,     -- random pet on PetsNew
    debug = false,
    go_home_at_end = false,
    duty = false,
  },
}
