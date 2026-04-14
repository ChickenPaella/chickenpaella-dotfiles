"use client";

import { useEffect, useState, useMemo } from "react";
import SearchBar from "@/components/SearchBar";
import { codeToHtml } from "shiki";

interface ZshFunction {
  name: string;
  summary: string;
  body: string;
  startLine: number;
}

function CodeBlock({ code }: { code: string }) {
  const [html, setHtml] = useState("");

  useEffect(() => {
    codeToHtml(code, {
      lang: "bash",
      theme: "github-dark",
    }).then(setHtml);
  }, [code]);

  if (!html) return <pre className="text-[#a89984] text-xs p-4 overflow-auto">{code}</pre>;
  return (
    <div
      className="text-xs overflow-auto [&>pre]:p-4 [&>pre]:!bg-transparent"
      dangerouslySetInnerHTML={{ __html: html }}
    />
  );
}

export default function FunctionsPage() {
  const [functions, setFunctions] = useState<ZshFunction[]>([]);
  const [query, setQuery] = useState("");
  const [selected, setSelected] = useState<ZshFunction | null>(null);

  useEffect(() => {
    fetch("/api/functions").then((r) => r.json()).then((data) => {
      setFunctions(data);
      if (data.length > 0) setSelected(data[0]);
    });
  }, []);

  const filtered = useMemo(() => {
    if (!query) return functions;
    const q = query.toLowerCase();
    return functions.filter(
      (f) => f.name.toLowerCase().includes(q) || f.summary.toLowerCase().includes(q)
    );
  }, [functions, query]);

  return (
    <div className="flex h-screen">
      {/* Left panel */}
      <div className="w-60 shrink-0 border-r border-[#3c3836] flex flex-col">
        <div className="p-4 border-b border-[#3c3836]">
          <h1 className="text-sm font-semibold text-[#ebdbb2] mb-3">Functions</h1>
          <SearchBar value={query} onChange={setQuery} placeholder="Search…" />
        </div>
        <div className="flex-1 overflow-auto">
          {filtered.map((f) => (
            <button
              key={f.name}
              onClick={() => setSelected(f)}
              className={`w-full text-left px-4 py-2.5 border-b border-[#3c3836] transition-colors ${
                selected?.name === f.name
                  ? "bg-[#458588]/20 text-[#ebdbb2]"
                  : "text-[#a89984] hover:bg-[#1d2021] hover:text-[#ebdbb2]"
              }`}
            >
              <div className="text-sm font-mono">{f.name}</div>
              {f.summary && <div className="text-[#504945] text-xs mt-0.5 truncate">{f.summary}</div>}
            </button>
          ))}
          {filtered.length === 0 && (
            <p className="text-[#504945] text-xs p-4">No functions found.</p>
          )}
        </div>
        <div className="px-4 py-2 border-t border-[#3c3836]">
          <p className="text-[#504945] text-xs">config/zsh/functions.zsh</p>
        </div>
      </div>

      {/* Right panel */}
      <div className="flex-1 overflow-auto">
        {selected ? (
          <div>
            <div className="px-6 py-4 border-b border-[#3c3836] bg-[#1d2021]">
              <span className="text-[#d79921] font-mono text-sm">{selected.name}</span>
              {selected.summary && (
                <span className="text-[#928374] text-xs ml-3">{selected.summary}</span>
              )}
              <span className="text-[#504945] text-xs ml-3">line {selected.startLine}</span>
            </div>
            <CodeBlock code={selected.body} />
          </div>
        ) : (
          <div className="flex items-center justify-center h-full text-[#504945] text-sm">
            Select a function
          </div>
        )}
      </div>
    </div>
  );
}
