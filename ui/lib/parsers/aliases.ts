import fs from "fs/promises";
import { PATHS } from "../paths";

export interface Alias {
  name: string;
  command: string;
  category: string;
}

export async function parseAliases(): Promise<Alias[]> {
  const content = await fs.readFile(PATHS.aliases, "utf-8");
  const lines = content.split("\n");
  const aliases: Alias[] = [];
  let currentCategory = "General";

  for (const line of lines) {
    const trimmed = line.trim();

    // Category header: lines like "# ── Git ──────"
    const categoryMatch = trimmed.match(/^#\s*[─━\-]+\s*(.+?)\s*[─━\-]*$/);
    if (categoryMatch) {
      currentCategory = categoryMatch[1].trim();
      continue;
    }

    // Skip blank lines and plain comments
    if (!trimmed || trimmed.startsWith("#")) continue;

    // alias name='command' or alias name="command" or alias name=command
    const aliasMatch = trimmed.match(/^alias\s+([^=]+)=(.+)$/);
    if (aliasMatch) {
      const name = aliasMatch[1].trim();
      let command = aliasMatch[2].trim();
      // Strip surrounding quotes
      command = command.replace(/^['"]|['"]$/g, "");
      aliases.push({ name, command, category: currentCategory });
    }
  }

  return aliases;
}

export function serializeAliases(aliases: Alias[], originalContent: string): string {
  // Replace each alias line in the original content to preserve comments/structure
  let result = originalContent;
  for (const alias of aliases) {
    const regex = new RegExp(`^(alias\\s+${escapeRegex(alias.name)}=).*$`, "m");
    const replacement = `alias ${alias.name}='${alias.command}'`;
    result = result.replace(regex, replacement);
  }
  return result;
}

function escapeRegex(str: string): string {
  return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
