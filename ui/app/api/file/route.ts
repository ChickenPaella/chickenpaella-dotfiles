import { NextResponse } from "next/server";
import fs from "fs/promises";
import path from "path";
import { isSafePath, DOTFILES_ROOT } from "@/lib/paths";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const rel = searchParams.get("path");
  if (!rel) return NextResponse.json({ error: "path required" }, { status: 400 });

  const filePath = path.join(DOTFILES_ROOT, rel);
  if (!isSafePath(filePath)) {
    return NextResponse.json({ error: "forbidden" }, { status: 403 });
  }

  try {
    const content = await fs.readFile(filePath, "utf-8");
    return NextResponse.json({ content });
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}

export async function PUT(req: Request) {
  try {
    const { path: rel, content } = (await req.json()) as { path: string; content: string };
    const filePath = path.join(DOTFILES_ROOT, rel);
    if (!isSafePath(filePath)) {
      return NextResponse.json({ error: "forbidden" }, { status: 403 });
    }
    await fs.writeFile(filePath, content, "utf-8");
    return NextResponse.json({ ok: true });
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}
