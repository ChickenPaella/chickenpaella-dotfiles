"use client";

import { useEffect, useState, useMemo } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import SearchBar from "@/components/SearchBar";
import { Suspense } from "react";

interface TmuxBinding { key: string; command: string; prefix: boolean; repeat: boolean; }
interface AerospaceBinding { key: string; action: string; mode: string; }
interface GitAlias { name: string; command: string; }
interface NvimKeymap { file: string; mode: string; key: string; action: string; desc: string; }
interface ZshBinding { key: string; action: string; source: string; }

interface AllBindings {
  tmux: TmuxBinding[];
  aerospace: AerospaceBinding[];
  git: GitAlias[];
  nvim: NvimKeymap[];
  zsh: ZshBinding[];
}

const TABS = ["zsh", "tmux", "aerospace", "nvim", "git"] as const;
type Tab = typeof TABS[number];

function KeybindingsContent() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const [data, setData] = useState<AllBindings | null>(null);
  const [query, setQuery] = useState("");
  const activeTab = (searchParams.get("tab") as Tab) ?? "zsh";

  useEffect(() => {
    fetch("/api/keybindings").then((r) => r.json()).then(setData);
  }, []);

  const setTab = (tab: Tab) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("tab", tab);
    router.replace(`?${params.toString()}`);
  };

  const filtered = useMemo(() => {
    if (!data) return [];
    const q = query.toLowerCase();
    if (activeTab === "zsh") return data.zsh.filter((b) => !q || b.key.toLowerCase().includes(q) || b.action.toLowerCase().includes(q));
    if (activeTab === "tmux") return data.tmux.filter((b) => !q || b.key.toLowerCase().includes(q) || b.command.toLowerCase().includes(q));
    if (activeTab === "aerospace") return data.aerospace.filter((b) => !q || b.key.toLowerCase().includes(q) || b.action.toLowerCase().includes(q));
    if (activeTab === "nvim") return data.nvim.filter((b) => !q || b.key.toLowerCase().includes(q) || b.action.toLowerCase().includes(q) || b.desc.toLowerCase().includes(q) || b.file.toLowerCase().includes(q));
    if (activeTab === "git") return data.git.filter((b) => !q || b.name.toLowerCase().includes(q) || b.command.toLowerCase().includes(q));
    return [];
  }, [data, activeTab, query]);

  const counts = data
    ? { zsh: data.zsh.length, tmux: data.tmux.length, aerospace: data.aerospace.length, nvim: data.nvim.length, git: data.git.length }
    : { zsh: 0, tmux: 0, aerospace: 0, nvim: 0, git: 0 };

  return (
    <div className="p-8 max-w-5xl">
      <div className="mb-6">
        <h1 className="text-xl font-semibold text-[#ebdbb2]">Keybindings</h1>
        <p className="text-[#928374] text-xs mt-0.5">All tool keybindings in one place</p>
      </div>

      {/* Tabs */}
      <div className="flex gap-0.5 mb-4 bg-[#1d2021] rounded p-1 w-fit border border-[#3c3836]">
        {TABS.map((tab) => (
          <button
            key={tab}
            onClick={() => setTab(tab)}
            className={`px-3 py-1 rounded text-xs transition-colors ${
              activeTab === tab
                ? "bg-[#458588] text-[#1d2021] font-medium"
                : "text-[#928374] hover:text-[#ebdbb2]"
            }`}
          >
            {tab}
            <span className={`ml-1.5 ${activeTab === tab ? "text-[#1d2021]/70" : "text-[#504945]"}`}>
              {counts[tab]}
            </span>
          </button>
        ))}
      </div>

      <div className="mb-4">
        <SearchBar value={query} onChange={setQuery} placeholder="Search keybindings…" />
      </div>

      {!data ? (
        <p className="text-[#504945] text-sm">Loading…</p>
      ) : (
        <div className="border border-[#3c3836] rounded overflow-hidden">
          {/* zsh */}
          {activeTab === "zsh" && (
            <table className="w-full text-sm">
              <thead><tr className="border-b border-[#3c3836] bg-[#1d2021]">
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-40">Key</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium">Action</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-24">Source</th>
              </tr></thead>
              <tbody>{(filtered as ZshBinding[]).map((b, i) => (
                <tr key={`${b.source}-${b.key}-${b.action}`} className={`${i % 2 === 0 ? "" : "bg-[#1d2021]/30"} border-t border-[#3c3836]`}>
                  <td className="px-3 py-2 text-[#d79921] font-mono">{b.key}</td>
                  <td className="px-3 py-2 text-[#a89984]">{b.action}</td>
                  <td className="px-3 py-2 text-[#504945] text-xs">{b.source}</td>
                </tr>
              ))}</tbody>
            </table>
          )}

          {/* tmux */}
          {activeTab === "tmux" && (
            <table className="w-full text-sm">
              <thead><tr className="border-b border-[#3c3836] bg-[#1d2021]">
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-32">Key</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium">Command</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-20">Prefix</th>
              </tr></thead>
              <tbody>{(filtered as TmuxBinding[]).map((b, i) => (
                <tr key={`${b.key}-${b.command}`} className={`${i % 2 === 0 ? "" : "bg-[#1d2021]/30"} border-t border-[#3c3836]`}>
                  <td className="px-3 py-2 text-[#d79921] font-mono">{b.key}</td>
                  <td className="px-3 py-2 text-[#a89984]">{b.command}</td>
                  <td className="px-3 py-2 text-xs">{b.prefix ? <span className="text-[#458588]">Ctrl+S</span> : <span className="text-[#928374]">none</span>}</td>
                </tr>
              ))}</tbody>
            </table>
          )}

          {/* aerospace */}
          {activeTab === "aerospace" && (
            <table className="w-full text-sm">
              <thead><tr className="border-b border-[#3c3836] bg-[#1d2021]">
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-40">Key</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium">Action</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-24">Mode</th>
              </tr></thead>
              <tbody>{(filtered as AerospaceBinding[]).map((b, i) => (
                <tr key={`${b.mode}-${b.key}`} className={`${i % 2 === 0 ? "" : "bg-[#1d2021]/30"} border-t border-[#3c3836]`}>
                  <td className="px-3 py-2 text-[#d79921] font-mono">{b.key}</td>
                  <td className="px-3 py-2 text-[#a89984]">{b.action}</td>
                  <td className="px-3 py-2 text-[#504945] text-xs">{b.mode}</td>
                </tr>
              ))}</tbody>
            </table>
          )}

          {/* nvim */}
          {activeTab === "nvim" && (
            <table className="w-full text-sm">
              <thead><tr className="border-b border-[#3c3836] bg-[#1d2021]">
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-8">Mode</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-32">Key</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium">Description</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-28">File</th>
              </tr></thead>
              <tbody>{(filtered as NvimKeymap[]).map((b, i) => (
                <tr key={`${b.file}-${b.mode}-${b.key}`} className={`${i % 2 === 0 ? "" : "bg-[#1d2021]/30"} border-t border-[#3c3836]`}>
                  <td className="px-3 py-2 text-[#b16286] text-xs font-mono">{b.mode}</td>
                  <td className="px-3 py-2 text-[#d79921] font-mono text-xs">{b.key}</td>
                  <td className="px-3 py-2 text-[#a89984] text-xs">{b.desc || b.action}</td>
                  <td className="px-3 py-2 text-[#504945] text-xs">{b.file}</td>
                </tr>
              ))}</tbody>
            </table>
          )}

          {/* git */}
          {activeTab === "git" && (
            <table className="w-full text-sm">
              <thead><tr className="border-b border-[#3c3836] bg-[#1d2021]">
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium w-32">Alias</th>
                <th className="text-left px-3 py-2 text-[#928374] text-xs font-medium">Command</th>
              </tr></thead>
              <tbody>{(filtered as GitAlias[]).map((b, i) => (
                <tr key={b.name} className={`${i % 2 === 0 ? "" : "bg-[#1d2021]/30"} border-t border-[#3c3836]`}>
                  <td className="px-3 py-2 text-[#d79921] font-mono">g {b.name}</td>
                  <td className="px-3 py-2 text-[#a89984]">{b.command}</td>
                </tr>
              ))}</tbody>
            </table>
          )}

          {filtered.length === 0 && (
            <p className="text-[#504945] text-sm p-4">No results.</p>
          )}
        </div>
      )}
    </div>
  );
}

export default function KeybindingsPage() {
  return (
    <Suspense fallback={<div className="p-8 text-[#504945] text-sm">Loading…</div>}>
      <KeybindingsContent />
    </Suspense>
  );
}
