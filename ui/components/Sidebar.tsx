"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutDashboard, BookMarked, Keyboard, FunctionSquare, GitBranch } from "lucide-react";

const nav = [
  { href: "/", label: "Dashboard", icon: LayoutDashboard },
  { href: "/aliases", label: "Aliases", icon: BookMarked },
  { href: "/keybindings", label: "Keybindings", icon: Keyboard },
  { href: "/functions", label: "Functions", icon: FunctionSquare },
];

export default function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="w-52 shrink-0 bg-[#1d2021] border-r border-[#3c3836] flex flex-col">
      <div className="px-4 py-5 border-b border-[#3c3836]">
        <div className="flex items-center gap-2">
          <GitBranch size={18} className="text-[#d79921]" />
          <span className="font-semibold text-[#ebdbb2] text-sm">dotfiles</span>
        </div>
        <p className="text-[#928374] text-xs mt-0.5">config manager</p>
      </div>

      <nav className="flex-1 p-3 space-y-0.5">
        {nav.map(({ href, label, icon: Icon }) => {
          const active = pathname === href;
          return (
            <Link
              key={href}
              href={href}
              className={`flex items-center gap-3 px-3 py-2 rounded text-sm transition-colors ${
                active
                  ? "bg-[#458588] text-[#1d2021] font-medium"
                  : "text-[#a89984] hover:text-[#ebdbb2] hover:bg-[#282828]"
              }`}
            >
              <Icon size={15} />
              {label}
            </Link>
          );
        })}
      </nav>

      <div className="px-4 py-3 border-t border-[#3c3836]">
        <p className="text-[#504945] text-xs">~/dotfiles</p>
      </div>
    </aside>
  );
}
