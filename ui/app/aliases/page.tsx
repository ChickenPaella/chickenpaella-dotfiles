"use client";

import { useEffect, useState, useMemo } from "react";
import SearchBar from "@/components/SearchBar";
import { Save, Pencil, X, Check } from "lucide-react";

interface Alias {
  name: string;
  command: string;
  category: string;
}

export default function AliasesPage() {
  const [aliases, setAliases] = useState<Alias[]>([]);
  const [query, setQuery] = useState("");
  const [editing, setEditing] = useState<{ name: string; value: string } | null>(null);
  const [saving, setSaving] = useState(false);
  const [saveMsg, setSaveMsg] = useState("");

  useEffect(() => {
    fetch("/api/aliases").then((r) => r.json()).then(setAliases);
  }, []);

  const filtered = useMemo(() => {
    if (!query) return aliases;
    const q = query.toLowerCase();
    return aliases.filter(
      (a) => a.name.toLowerCase().includes(q) || a.command.toLowerCase().includes(q) || a.category.toLowerCase().includes(q)
    );
  }, [aliases, query]);

  const grouped = useMemo(() => {
    const map = new Map<string, Alias[]>();
    for (const a of filtered) {
      const list = map.get(a.category) ?? [];
      list.push(a);
      map.set(a.category, list);
    }
    return map;
  }, [filtered]);

  const startEdit = (a: Alias) => setEditing({ name: a.name, value: a.command });

  const confirmEdit = () => {
    if (!editing) return;
    setAliases((prev) =>
      prev.map((a) => (a.name === editing.name ? { ...a, command: editing.value } : a))
    );
    setEditing(null);
  };

  const save = async () => {
    setSaving(true);
    const res = await fetch("/api/aliases", {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ aliases }),
    });
    setSaving(false);
    setSaveMsg(res.ok ? "Saved" : "Error");
    setTimeout(() => setSaveMsg(""), 2000);
  };

  return (
    <div className="p-8 max-w-4xl">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-xl font-semibold text-[#ebdbb2]">Aliases</h1>
          <p className="text-[#928374] text-xs mt-0.5">config/zsh/aliases.zsh</p>
        </div>
        <div className="flex items-center gap-3">
          {saveMsg && (
            <span className={`text-xs ${saveMsg === "Saved" ? "text-[#98971a]" : "text-[#cc241d]"}`}>
              {saveMsg}
            </span>
          )}
          <button
            onClick={save}
            disabled={saving}
            className="flex items-center gap-1.5 px-3 py-1.5 bg-[#458588] text-[#1d2021] rounded text-xs font-medium hover:bg-[#83a598] disabled:opacity-50"
          >
            <Save size={12} />
            {saving ? "Saving…" : "Save"}
          </button>
        </div>
      </div>

      <div className="mb-4">
        <SearchBar value={query} onChange={setQuery} placeholder="Search aliases…" />
      </div>

      <div className="space-y-6">
        {[...grouped.entries()].map(([category, items]) => (
          <div key={category}>
            <h2 className="text-xs font-medium text-[#928374] uppercase tracking-wider mb-2">{category}</h2>
            <div className="border border-[#3c3836] rounded overflow-hidden">
              {items.map((a, i) => (
                <div
                  key={a.name}
                  className={`flex items-center px-3 py-2 gap-3 ${i !== 0 ? "border-t border-[#3c3836]" : ""} ${editing?.name === a.name ? "bg-[#1d2021]" : "hover:bg-[#1d2021]/50"}`}
                >
                  <span className="text-[#d79921] text-sm w-32 shrink-0">{a.name}</span>
                  {editing?.name === a.name ? (
                    <input
                      autoFocus
                      value={editing.value}
                      onChange={(e) => setEditing({ ...editing, value: e.target.value })}
                      onKeyDown={(e) => { if (e.key === "Enter") confirmEdit(); if (e.key === "Escape") setEditing(null); }}
                      className="flex-1 bg-[#282828] border border-[#458588] rounded px-2 py-0.5 text-sm text-[#ebdbb2] focus:outline-none"
                    />
                  ) : (
                    <span className="flex-1 text-[#a89984] text-sm truncate">{a.command}</span>
                  )}
                  <div className="flex gap-1 shrink-0">
                    {editing?.name === a.name ? (
                      <>
                        <button onClick={confirmEdit} className="p-1 text-[#98971a] hover:text-[#b8bb26]"><Check size={13} /></button>
                        <button onClick={() => setEditing(null)} className="p-1 text-[#928374] hover:text-[#ebdbb2]"><X size={13} /></button>
                      </>
                    ) : (
                      <button onClick={() => startEdit(a)} className="p-1 text-[#504945] hover:text-[#a89984]"><Pencil size={13} /></button>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
        {grouped.size === 0 && (
          <p className="text-[#504945] text-sm">No aliases found.</p>
        )}
      </div>
    </div>
  );
}
