#!/usr/bin/env python3
"""Render docs/LANGUAGE_PACKAGE.md and docs/LANGUAGE_SYSTEM.md as one HTML manual.
Usage: make_manual.py <output.html>"""
import html, pathlib, re, sys

HERE = pathlib.Path(__file__).resolve().parent
DOCS = HERE.parent.parent / "docs"

def inline(t):
    t = html.escape(t, quote=False)
    return re.sub(r"`([^`]+)`", r"<code>\1</code>", t)

def slug(t): return re.sub(r"[^a-z0-9]+", "-", t.lower()).strip("-")

def render(lines, toc, out):
    i = 0
    while i < len(lines):
        l = lines[i]
        if l.startswith("# "):
            out.append(f'<h1 class="part">{inline(l[2:])}</h1>'); i += 1; continue
        m = re.match(r"(#{2,3}) (.*)", l)
        if m:
            n, t = len(m.group(1)), m.group(2)
            if n == 2: toc.append((slug(t), t))
            out.append(f'<h{n} id="{slug(t)}">{inline(t)}</h{n}>'); i += 1; continue
        if l.startswith("|"):
            rows = []
            while i < len(lines) and lines[i].startswith("|"):
                rows.append([c.strip() for c in lines[i].strip().strip("|").split("|")]); i += 1
            h = "".join(f"<th>{inline(c)}</th>" for c in rows[0])
            b = "".join("<tr>" + "".join(f"<td>{inline(c)}</td>" for c in r) + "</tr>" for r in rows[2:])
            out.append(f'<div class="tbl"><table><thead><tr>{h}</tr></thead><tbody>{b}</tbody></table></div>'); continue
        if re.match(r"(- |\d+\. )", l):
            ordered = l[0].isdigit()
            items = []
            while i < len(lines) and re.match(r"(- |\d+\. )", lines[i]):
                items.append(inline(re.sub(r"^(- |\d+\. )", "", lines[i]))); i += 1
            tag = "ol" if ordered else "ul"
            out.append(f"<{tag}>" + "".join(f"<li>{x}</li>" for x in items) + f"</{tag}>"); continue
        if not l.strip(): i += 1; continue
        para = [l]; i += 1
        while i < len(lines) and lines[i].strip() and not re.match(r"(#|\||- |\d+\. )", lines[i]):
            para.append(lines[i]); i += 1
        out.append("<p>" + inline(" ".join(para)) + "</p>")

toc, out = [], []
for name in ("LANGUAGE_PACKAGE.md", "LANGUAGE_SYSTEM.md"):
    render((DOCS / name).read_text().split("\n"), toc, out)
nav = "".join(f'<a href="#{s}">{html.escape(t)}</a>' for s, t in toc)
page = (HERE / "manual_tpl.html").read_text().replace("@@NAV@@", nav).replace("@@BODY@@", "\n".join(out))
pathlib.Path(sys.argv[1]).write_text(page)
print(len(toc), "sections")
