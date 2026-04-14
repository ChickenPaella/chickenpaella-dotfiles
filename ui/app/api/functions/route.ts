import { NextResponse } from "next/server";
import fs from "fs/promises";
import { PATHS } from "@/lib/paths";

export interface ZshFunction {
  name: string;
  summary: string;
  body: string;
  startLine: number;
}

export async function GET() {
  try {
    const content = await fs.readFile(PATHS.functions, "utf-8");
    const lines = content.split("\n");
    const functions: ZshFunction[] = [];
    let i = 0;

    while (i < lines.length) {
      const line = lines[i];
      // Match: function name() { or name() {
      const match = line.match(/^(?:function\s+)?(\w+)\s*\(\s*\)\s*\{?\s*$/);
      if (match) {
        const name = match[1];
        // Look for a preceding comment as summary
        let summary = "";
        if (i > 0) {
          const prev = lines[i - 1].trim();
          if (prev.startsWith("#")) summary = prev.replace(/^#+\s*/, "");
        }

        // Collect body until closing }
        const startLine = i + 1;
        const bodyLines: string[] = [line];
        let depth = (line.match(/\{/g) || []).length - (line.match(/\}/g) || []).length;
        i++;
        while (i < lines.length && depth > 0) {
          const l = lines[i];
          depth += (l.match(/\{/g) || []).length;
          depth -= (l.match(/\}/g) || []).length;
          bodyLines.push(l);
          i++;
        }
        functions.push({ name, summary, body: bodyLines.join("\n"), startLine });
        continue;
      }
      i++;
    }

    return NextResponse.json(functions);
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}
