import path from "path";
import os from "os";

export const DOTFILES_ROOT = path.join(os.homedir(), "dotfiles");

export const PATHS = {
  aliases: path.join(DOTFILES_ROOT, "config/zsh/aliases.zsh"),
  functions: path.join(DOTFILES_ROOT, "config/zsh/functions.zsh"),
  zshrc: path.join(DOTFILES_ROOT, "config/zsh/.zshrc"),
  tmux: path.join(DOTFILES_ROOT, "config/tmux/tmux.conf"),
  aerospace: path.join(DOTFILES_ROOT, "config/aerospace/aerospace.toml"),
  gitConfig: path.join(DOTFILES_ROOT, "config/git/config"),
  nvimKeymaps: path.join(DOTFILES_ROOT, "config/nvim/lua/config/keymaps"),
} as const;

// Ensure a given absolute path is inside DOTFILES_ROOT (prevent path traversal)
export function isSafePath(filePath: string): boolean {
  const resolved = path.resolve(filePath);
  return resolved.startsWith(DOTFILES_ROOT + path.sep) || resolved === DOTFILES_ROOT;
}
