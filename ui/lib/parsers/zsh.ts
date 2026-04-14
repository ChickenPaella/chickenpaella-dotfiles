import fs from "fs/promises";
import { PATHS } from "../paths";

export interface ZshBinding {
  key: string;
  action: string;
  source: string;
}

export async function parseZshBindings(): Promise<ZshBinding[]> {
  const bindings: ZshBinding[] = [];

  for (const [label, filePath] of [["zshrc", PATHS.zshrc], ["functions", PATHS.functions]] as const) {
    let content: string;
    try {
      content = await fs.readFile(filePath, "utf-8");
    } catch {
      continue;
    }

    const lines = content.split("\n");
    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith("#")) continue;

      // bindkey "key" action  or  bindkey 'key' action
      const match = trimmed.match(/^bindkey\s+["']([^"']+)["']\s+(.+)$/);
      if (match) {
        bindings.push({
          key: match[1],
          action: match[2].trim(),
          source: label,
        });
      }
    }
  }

  return bindings;
}
