#!/usr/bin/env python3
import os
import re
import sys
import shutil
from pathlib import Path


def find_lazy_path():
    localappdata = os.environ.get("LOCALAPPDATA", "")
    candidates = [
        os.path.join(localappdata, "nvim-data", "lazy"),
        os.path.join(os.environ.get("APPDATA", ""), "nvim", "data", "lazy"),
        os.path.expanduser("~/.local/share/nvim/lazy"),
    ]
    for c in candidates:
        if os.path.isdir(c):
            return c
    return None


def find_plugin_dir(lazy_path, module_name):
    for entry in os.listdir(lazy_path):
        entry_path = os.path.join(lazy_path, entry)
        if not os.path.isdir(entry_path):
            continue
        lua_dir = os.path.join(entry_path, "lua")
        if not os.path.isdir(lua_dir):
            continue
        if os.path.isdir(os.path.join(lua_dir, module_name)):
            return entry_path
        init_file = os.path.join(lua_dir, module_name + ".lua")
        if os.path.isfile(init_file):
            return entry_path
    return None


def scan_module_files(plugin_dir, module_name):
    lua_dir = os.path.join(plugin_dir, "lua")
    module_root = os.path.join(lua_dir, module_name)
    result = []

    def read_content(path):
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return f.read()

    if os.path.isdir(module_root):
        init_lua = os.path.join(module_root, "init.lua")
        if os.path.isfile(init_lua):
            result.append((module_name, init_lua, read_content(init_lua)))
        for fname in sorted(os.listdir(module_root)):
            fpath = os.path.join(module_root, fname)
            if not os.path.isfile(fpath) or not fname.endswith(".lua"):
                continue
            if fname == "init.lua":
                continue
            sub_mod = module_name + "." + fname[:-4]
            result.append((sub_mod, fpath, read_content(fpath)))
    else:
        single_file = os.path.join(lua_dir, module_name + ".lua")
        if os.path.isfile(single_file):
            result.append((module_name, single_file, read_content(single_file)))

    return result


def sanitize_var_name(s):
    return re.sub(r"[^a-zA-Z0-9_]", "_", s)


def build_module_inline(modules, module_name, plugin_dir=""):
    lines = []
    lines.append(f"    -- [EXPANDED START] plugin module: {module_name}")
    lines.append(f"    do")

    mod_vars = {}
    for mod_name, mod_path, mod_content in modules:
        var = f"___mod_{sanitize_var_name(mod_name)}"
        mod_vars[mod_name] = var
        if plugin_dir:
            try:
                rel = os.path.relpath(mod_path, plugin_dir).replace("\\", "/")
            except ValueError:
                rel = mod_path.replace("\\", "/")
        else:
            rel = mod_path.replace("\\", "/")
        lines.append(f"        -- source: {rel}")
        lines.append(f"        local {var} = (function()")
        for cline in mod_content.splitlines():
            if cline.strip() == "":
                lines.append("")
            else:
                lines.append("            " + cline)
        lines.append(f"        end)()")
        lines.append(f"        package.loaded[\"{mod_name}\"] = {var}")
        lines.append("")

    main_var = mod_vars.get(module_name, "nil")
    lines.append(f"        if {main_var} and type({main_var}.setup) == \"function\" then")
    lines.append(f"            {main_var}.setup()")
    lines.append(f"        end")
    lines.append(f"    end")
    lines.append(f"    -- [EXPANDED END] plugin module: {module_name}")
    return "\n".join(lines)


RE_REQUIRE_SETUP_INDENTED = re.compile(
    r"""^(\s*)require\s*\(\s*["']([a-zA-Z_][a-zA-Z0-9_\.]*)["']\s*\)\s*\.setup\s*\(\s*\)""",
    re.MULTILINE,
)


def indent_block(text, indent_str):
    if not indent_str:
        return text
    lines = text.splitlines()
    result = []
    for line in lines:
        if line == "":
            result.append("")
        else:
            result.append(indent_str + line)
    return "\n".join(result)


def expand_config_function(content, module_name, inline_code):
    pattern = re.compile(
        r"""^(\s*)require\s*\(\s*["']""" + re.escape(module_name) + r"""["']\s*\)\s*\.setup\s*\(\s*\)""",
        re.MULTILINE,
    )
    match = pattern.search(content)
    if not match:
        return content, 0
    indent_str = match.group(1)

    def replacer(m):
        ind = m.group(1)
        return indent_block(inline_code, ind)

    new_content, count = pattern.subn(replacer, content, count=1)
    return new_content, count


def process_init_lua(init_lua_path, lazy_path, output_path=None):
    with open(init_lua_path, "r", encoding="utf-8") as f:
        content = f.read()

    original_content = content

    matches = RE_REQUIRE_SETUP_INDENTED.findall(content)
    seen = set()
    unique_modules = []
    for _, mod_full in matches:
        top = mod_full.split(".")[0]
        if top not in seen:
            seen.add(top)
            unique_modules.append(top)

    print(f"[INFO] Found {len(unique_modules)} unique plugin modules to expand:")
    for m in unique_modules:
        print(f"       - {m}")

    expanded_count = 0
    skipped = []

    for module_name in unique_modules:
        plugin_dir = find_plugin_dir(lazy_path, module_name)
        if not plugin_dir:
            print(f"[SKIP] Plugin directory not found for module: {module_name}")
            skipped.append(module_name)
            continue

        mod_files = scan_module_files(plugin_dir, module_name)
        if not mod_files:
            print(f"[SKIP] No lua module files found for: {module_name} in {plugin_dir}")
            skipped.append(module_name)
            continue

        print(f"[EXPAND] {module_name}: {len(mod_files)} submodule(s) from {os.path.basename(plugin_dir)}")
        for mn, mp, _ in mod_files:
            rel = os.path.relpath(mp, plugin_dir).replace("\\", "/")
            print(f"         -> {mn} ({rel})")

        inline_code = build_module_inline(mod_files, module_name, plugin_dir)
        content, count = expand_config_function(content, module_name, inline_code)
        if count > 0:
            expanded_count += count
        else:
            print(f"[WARN] Pattern replacement failed for {module_name}, trying multi-line setup()")
            args_pat = re.compile(
                r"""require\s*\(\s*["']""" + re.escape(module_name) + r"""["']\s*\)\s*\.setup\s*\(""",
                re.MULTILINE,
            )
            if args_pat.search(content):
                print(f"[WARN] Module {module_name} has setup() with arguments, skipping expansion")
            skipped.append(module_name)

    if output_path is None:
        backup_path = init_lua_path + ".bak"
        shutil.copy2(init_lua_path, backup_path)
        print(f"[BACKUP] Original saved to: {backup_path}")
        output_path = init_lua_path

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"\n[RESULT] Expanded {expanded_count} plugin setup call(s) into {os.path.basename(output_path)}")
    if skipped:
        print(f"         Skipped ({len(skipped)}): {', '.join(skipped)}")
    changed = content != original_content
    print(f"         Content changed: {'YES' if changed else 'NO'}")
    return changed


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    init_lua = os.path.join(script_dir, "init.lua")

    if not os.path.isfile(init_lua):
        print(f"[ERROR] init.lua not found at: {init_lua}")
        sys.exit(1)

    lazy_path = find_lazy_path()
    if not lazy_path:
        print("[ERROR] lazy.nvim plugin directory not found.")
        print("        Please ensure plugins are installed first (run nvim once).")
        sys.exit(2)
    print(f"[INFO] lazy.nvim data dir: {lazy_path}")

    output_arg = None
    if len(sys.argv) > 1:
        if sys.argv[1] in ("-h", "--help"):
            print("Usage: python expand_plugins.py [output_init.lua]")
            print("")
            print("Expands all plugin `require(\"mod\").setup()` calls in init.lua into inline")
            print("code, reading module sources from the lazy.nvim installation directory.")
            print("")
            print("If output path is not given, init.lua is overwritten (with .bak backup).")
            sys.exit(0)
        output_arg = sys.argv[1]
        if not os.path.isabs(output_arg):
            output_arg = os.path.join(script_dir, output_arg)

    ok = process_init_lua(init_lua, lazy_path, output_arg)
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
