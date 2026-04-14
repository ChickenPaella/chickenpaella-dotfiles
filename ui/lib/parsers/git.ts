import fs from "fs/promises";
import { PATHS } from "../paths";

export interface GitAlias {
  name: string;
  command: string;
}

export async function parseGitAliases(): Promise<GitAlias[]> {
  const content = await fs.readFile(PATHS.gitConfig, "utf-8");
  const lines = content.split("\n");
  const aliases: GitAlias[] = [];
  let inAliasSection = false;

  for (const line of lines) {
    const trimmed = line.trim();
    if (trimmed === "[alias]") { inAliasSection = true; continue; }
    if (trimmed.startsWith("[")) { inAliasSection = false; continue; }
    if (!inAliasSection || !trimmed || trimmed.startsWith("#")) continue;

    const match = trimmed.match(/^(\S+)\s*=\s*(.+)$/);
    if (match) {
      aliases.push({ name: match[1], command: match[2].trim() });
    }
  }

  return aliases;
}
