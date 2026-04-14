"use client";

import { Search } from "lucide-react";

interface Props {
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
}

export default function SearchBar({ value, onChange, placeholder = "Search..." }: Props) {
  return (
    <div className="relative">
      <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2 text-[#504945]" />
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="w-full bg-[#1d2021] border border-[#3c3836] rounded px-3 py-1.5 pl-8 text-sm text-[#ebdbb2] placeholder:text-[#504945] focus:outline-none focus:border-[#458588]"
      />
    </div>
  );
}
