import { parseAliases } from "@/lib/parsers/aliases";
import { parseTmuxBindings } from "@/lib/parsers/tmux";
import { parseAerospaceBindings } from "@/lib/parsers/aerospace";
import { parseGitAliases } from "@/lib/parsers/git";
import { parseNvimKeymaps } from "@/lib/parsers/nvim";
import { parseZshBindings } from "@/lib/parsers/zsh";
import { BookMarked, Keyboard, FunctionSquare, Terminal, Wind, GitBranch, Cpu } from "lucide-react";
import Link from "next/link";

async function getStats() {
  const [aliases, tmux, aerospace, git, nvim, zsh] = await Promise.allSettled([
    parseAliases(),
    parseTmuxBindings(),
    parseAerospaceBindings(),
    parseGitAliases(),
    parseNvimKeymaps(),
    parseZshBindings(),
  ]);
  return {
    aliases: aliases.status === "fulfilled" ? aliases.value.length : 0,
    tmux: tmux.status === "fulfilled" ? tmux.value.length : 0,
    aerospace: aerospace.status === "fulfilled" ? aerospace.value.length : 0,
    git: git.status === "fulfilled" ? git.value.length : 0,
    nvim: nvim.status === "fulfilled" ? nvim.value.length : 0,
    zsh: zsh.status === "fulfilled" ? zsh.value.length : 0,
  };
}

export default async function DashboardPage() {
  const stats = await getStats();
  const totalKeybindings = stats.tmux + stats.aerospace + stats.nvim + stats.zsh;

  const cards = [
    {
      href: "/aliases",
      icon: BookMarked,
      label: "Aliases",
      count: stats.aliases,
      unit: "aliases",
      color: "text-[#d79921]",
      bg: "bg-[#d79921]/10",
      sub: null,
    },
    {
      href: "/keybindings",
      icon: Keyboard,
      label: "Keybindings",
      count: totalKeybindings,
      unit: "total bindings",
      color: "text-[#458588]",
      bg: "bg-[#458588]/10",
      sub: [
        { label: "zsh", count: stats.zsh },
        { label: "tmux", count: stats.tmux },
        { label: "aerospace", count: stats.aerospace },
        { label: "nvim", count: stats.nvim },
      ],
    },
    {
      href: "/keybindings?tab=git",
      icon: GitBranch,
      label: "Git Aliases",
      count: stats.git,
      unit: "aliases",
      color: "text-[#b16286]",
      bg: "bg-[#b16286]/10",
      sub: null,
    },
  ];

  const tools = [
    { icon: Terminal, label: "zsh", desc: "aliases · vi-mode · functions", color: "text-[#98971a]" },
    { icon: Cpu, label: "tmux", desc: `Prefix Ctrl+S · ${stats.tmux} bindings`, color: "text-[#689d6a]" },
    { icon: Wind, label: "AeroSpace", desc: `Alt+hjkl · workspaces 1–10`, color: "text-[#458588]" },
    { icon: FunctionSquare, label: "Neovim", desc: `LazyVim · Space leader · ${stats.nvim} keymaps`, color: "text-[#d65d0e]" },
    { icon: GitBranch, label: "git", desc: `${stats.git} aliases · fsmonitor`, color: "text-[#b16286]" },
  ];

  return (
    <div className="p-8 max-w-4xl">
      <div className="mb-8">
        <h1 className="text-2xl font-semibold text-[#ebdbb2]">dotfiles</h1>
        <p className="text-[#928374] text-sm mt-1">~/dotfiles config manager</p>
      </div>

      <div className="grid grid-cols-3 gap-4 mb-8">
        {cards.map(({ href, icon: Icon, label, count, unit, color, bg, sub }) => (
          <Link
            key={href}
            href={href}
            className="bg-[#1d2021] border border-[#3c3836] rounded-lg p-4 hover:border-[#504945] transition-colors"
          >
            <div className="flex items-center gap-2 mb-2">
              <div className={`p-1.5 rounded ${bg}`}>
                <Icon size={14} className={color} />
              </div>
              <span className="text-[#a89984] text-xs">{label}</span>
            </div>
            <div className={`text-2xl font-bold ${color}`}>{count}</div>
            <div className="text-[#504945] text-xs mt-0.5">{unit}</div>
            {sub && (
              <div className="flex gap-3 mt-2 flex-wrap">
                {sub.map((s) => (
                  <span key={s.label} className="text-[#504945] text-xs">
                    {s.label} <span className="text-[#665c54]">{s.count}</span>
                  </span>
                ))}
              </div>
            )}
          </Link>
        ))}
      </div>

      <h2 className="text-xs font-medium text-[#928374] uppercase tracking-wider mb-3">Tools</h2>
      <div className="space-y-1">
        {tools.map(({ icon: Icon, label, desc, color }) => (
          <div
            key={label}
            className="flex items-center gap-3 px-3 py-2.5 bg-[#1d2021] border border-[#3c3836] rounded"
          >
            <Icon size={14} className={color} />
            <span className="text-[#ebdbb2] text-sm w-24">{label}</span>
            <span className="text-[#665c54] text-xs">{desc}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
