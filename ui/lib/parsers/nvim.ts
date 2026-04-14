import fs from "fs/promises";
import path from "path";
import { PATHS } from "../paths";

export interface NvimKeymap {
  file: string;
  mode: string;
  key: string;
  action: string;
  desc: string;
}

export async function parseNvimKeymaps(): Promise<NvimKeymap[]> {
  const keymaps: NvimKeymap[] = [];

  let files: string[] = [];
  try {
    const entries = await fs.readdir(PATHS.nvimKeymaps);
    files = entries.filter((f) => f.endsWith(".lua")).map((f) => path.join(PATHS.nvimKeymaps, f));
  } catch {
    return keymaps;
  }

  for (const file of files) {
    const content = await fs.readFile(file, "utf-8");
    const fileName = path.basename(file, ".lua");

    // Match: map("mode", "key", ..., { desc = "..." })
    // or vim.keymap.set("mode", "key", ..., { desc = "..." })
    const pattern = /(?:map|vim\.keymap\.set)\(\s*["']([^"']+)["']\s*,\s*["']([^"']+)["']\s*,\s*(.+?)(?:,\s*\{[^}]*desc\s*=\s*["']([^"']+)["'][^}]*\})?\s*\)/gs;

    let match;
    while ((match = pattern.exec(content)) !== null) {
      const mode = match[1];
      const key = match[2];
      const actionRaw = match[3].trim().replace(/\s+/g, " ");
      const desc = match[4] || "";

      // Skip overly long action strings (lambdas) — summarize
      const action = actionRaw.length > 60 ? actionRaw.slice(0, 57) + "..." : actionRaw;

      keymaps.push({ file: fileName, mode, key, action, desc });
    }
  }

  return keymaps;
}
