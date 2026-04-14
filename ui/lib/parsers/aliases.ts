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
      // Skip duplicates (keep first occurrence — from the if-branch, not the else fallback)
      if (!aliases.some((a) => a.name === name)) {
        aliases.push({ name, command, category: currentCategory });
      }
    }
  }

  return aliases;
}

export function serializeAliases(aliases: Alias[], originalContent: string): string {
  let result = originalContent;
  for (const alias of aliases) {
    // Match alias with optional leading whitespace (handles if/else indented blocks)
    // Capture the indent so we can preserve it
    const regex = new RegExp(`^([ \\t]*)(alias\\s+${escapeRegex(alias.name)}=).*$`, "mg");
    result = result.replace(regex, (_, indent) => `${indent}alias ${alias.name}='${alias.command}'`);
  }
  return result;
}

function escapeRegex(str: string): string {
  return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
