import fs from "fs/promises";
import { PATHS } from "../paths";

export interface TmuxBinding {
  key: string;
  command: string;
  prefix: boolean; // false = -n (no prefix needed)
  repeat: boolean; // -r flag
  note?: string;
}

export async function parseTmuxBindings(): Promise<TmuxBinding[]> {
  const content = await fs.readFile(PATHS.tmux, "utf-8");
  const lines = content.split("\n");
  const bindings: TmuxBinding[] = [];

  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;

    // bind[-key] [-n] [-r] key command
    const match = trimmed.match(/^bind(?:-key)?\s+(.*)/);
    if (!match) continue;

    let rest = match[1].trim();
    let prefix = true;
    let repeat = false;

    // Parse flags
    while (rest.startsWith("-")) {
      if (rest.startsWith("-n ")) { prefix = false; rest = rest.slice(3).trim(); }
      else if (rest.startsWith("-r ")) { repeat = true; rest = rest.slice(3).trim(); }
      else if (rest.startsWith("-T ")) { rest = rest.slice(rest.indexOf(" ", 3)).trim(); } // skip table
      else break;
    }

    const parts = rest.match(/^(\S+)\s+(.+)$/);
    if (!parts) continue;

    bindings.push({
      key: parts[1],
      command: parts[2].trim(),
      prefix,
      repeat,
    });
  }

  return bindings;
}
