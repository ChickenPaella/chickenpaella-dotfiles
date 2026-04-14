import { NextResponse } from "next/server";
import { parseTmuxBindings } from "@/lib/parsers/tmux";
import { parseAerospaceBindings } from "@/lib/parsers/aerospace";
import { parseGitAliases } from "@/lib/parsers/git";
import { parseNvimKeymaps } from "@/lib/parsers/nvim";
import { parseZshBindings } from "@/lib/parsers/zsh";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const tool = searchParams.get("tool") ?? "all";

  try {
    const [tmux, aerospace, git, nvim, zsh] = await Promise.all([
      tool === "all" || tool === "tmux" ? parseTmuxBindings() : Promise.resolve([]),
      tool === "all" || tool === "aerospace" ? parseAerospaceBindings() : Promise.resolve([]),
      tool === "all" || tool === "git" ? parseGitAliases() : Promise.resolve([]),
      tool === "all" || tool === "nvim" ? parseNvimKeymaps() : Promise.resolve([]),
      tool === "all" || tool === "zsh" ? parseZshBindings() : Promise.resolve([]),
    ]);

    return NextResponse.json({ tmux, aerospace, git, nvim, zsh });
  } catch (e) {
    return NextResponse.json({ error: String(e) }, { status: 500 });
  }
}
