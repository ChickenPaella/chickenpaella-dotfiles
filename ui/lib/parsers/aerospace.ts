import fs from "fs/promises";
import { parse } from "smol-toml";
import { PATHS } from "../paths";

export interface AerospaceBinding {
  key: string;
  action: string;
  mode: string;
}

export async function parseAerospaceBindings(): Promise<AerospaceBinding[]> {
  const content = await fs.readFile(PATHS.aerospace, "utf-8");
  const toml = parse(content) as Record<string, unknown>;
  const bindings: AerospaceBinding[] = [];

  const mode = toml["mode"] as Record<string, unknown> | undefined;
  if (!mode) return bindings;

  for (const [modeName, modeConfig] of Object.entries(mode)) {
    const cfg = modeConfig as Record<string, unknown>;
    const binding = cfg["binding"] as Record<string, unknown> | undefined;
    if (!binding) continue;

    for (const [key, action] of Object.entries(binding)) {
      bindings.push({
        key,
        action: Array.isArray(action) ? action.join(", ") : String(action),
        mode: modeName,
      });
    }
  }

  return bindings;
}
