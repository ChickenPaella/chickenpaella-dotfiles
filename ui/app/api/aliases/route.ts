import { NextResponse } from "next/server";
import fs from "fs/promises";
import { parseAliases, serializeAliases, type Alias } from "@/lib/parsers/aliases";
import { PATHS } from "@/lib/paths";

export async function GET() {
  try {
    const aliases = await parseAliases();
    return NextResponse.json(aliases);
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}

export async function PUT(req: Request) {
  try {
    const { aliases } = (await req.json()) as { aliases: Alias[] };
    const original = await fs.readFile(PATHS.aliases, "utf-8");
    const updated = serializeAliases(aliases, original);
    await fs.writeFile(PATHS.aliases, updated, "utf-8");
    return NextResponse.json({ ok: true });
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}
