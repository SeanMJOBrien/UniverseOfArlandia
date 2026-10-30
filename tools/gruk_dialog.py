#!/usr/bin/env python3
"""Generate Gruk's language test dialog: src/dlg/lang_demo.dlg.json.

Gruk (blueprint lang_goblin) greets the player and offers a menu with every
language the system supports. Picking one runs act_lang_npc, which sets the
NPC's npc_language, and Gruk then says a sample line in that language through
cond_lang_line, so the player sees what their own fluency makes of it. Gruk
keeps the chosen language until another is picked. Drow is a sign language,
so Gruk's line appears as a description of signing.
Run from the repo root; safe to re-run.
"""
import json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
TOKEN_GREET, TOKEN_SAY, TOKEN_ALL = 60000, 60001, 60002

LANGS = [("Elven", "Elven"), ("Gnome", "Gnome"), ("Halfling", "Halfling"), ("Dwarven", "Dwarf"),
         ("Orc", "Orc"), ("Goblin", "Goblin"), ("Draconic", "Draconic"), ("Animal", "Animal"),
         ("Thieves' Cant", "Thieves Cant"), ("Celestial", "Celestial"), ("Abyssal", "Abyssal"),
         ("Infernal", "Infernal"), ("Drow (sign)", "Drow"), ("Common", "common")]

GREET = "Gruk is Gruk! Gruk talk any tongue you like. Pick one and Gruk say something, <race> friend."
SAMPLE = ("*The <race> says,* the road to the hills is long, the water is cold, and a <race> should never "
          "trust a goblin with the last of the bread. Danger is near. *The <race> glances over a shoulder.*")

# One sentence per language for the "every language" line: (label, language id, sentence).
ALL_SENTENCES = [
    ("Elven", 1, "Starlight lingers long upon the silver leaves."),
    ("Gnome", 2, "The little gears turn slowly, but they turn true."),
    ("Halfling", 3, "A warm hearth and a full pot beat any treasure."),
    ("Dwarven", 4, "Good stone never forgets a steady hand."),
    ("Orc", 5, "Strong arms break the gate before the sun is high."),
    ("Goblin", 6, "Shiny things go in the pocket and the pocket goes away."),
    ("Draconic", 7, "Fire remembers every name that was spoken to it."),
    ("Animal", 8, "The wind carries fear and the grass carries blood."),
    ("Thieves' Cant", 9, "The mark is soft, the lock is old, and the watch sleeps."),
    ("Celestial", 10, "Light finds the road for those who ask it kindly."),
    ("Abyssal", 11, "Every chain is a promise waiting to be broken."),
    ("Infernal", 12, "A bargain well made is a debt that never ends."),
    ("Drow (sign)", 13, "Two shadows follow you. Do not turn."),
]
ALL = "".join("*%s%s: *{%d}%s" % ("" if i == 0 else "\n", label, lang, text)
              for i, (label, lang, text) in enumerate(ALL_SENTENCES))

def s(k, v): return {"type": k, "value": v}
def loc(t): return s("cexolocstring", {"0": t})
def kv(k, v): return {"__struct_id": 0, "Key": s("cexostring", k), "Value": s("cexostring", str(v))}

def link(index, script="", params=None):
    d = {"__struct_id": 0, "Active": s("resref", script), "Index": s("dword", index), "IsChild": s("byte", 0)}
    if params: d["ConditionParams"] = s("list", [kv(k, v) for k, v in params.items()])
    return d

def node(text, links, key, script="", params=None, comment=""):
    d = {"__struct_id": 0, "Animation": s("dword", 0), "AnimLoop": s("byte", 1), "Comment": s("cexostring", comment),
         "Delay": s("dword", 4294967295), key: s("list", links), "Quest": s("cexostring", ""),
         "Script": s("resref", script), "Sound": s("resref", ""), "Text": loc(text)}
    if params: d["ActionParams"] = s("list", [kv(k, v) for k, v in params.items()])
    return d

# Entries: 0 greeting, 1 sample line, 2 every-language line. Replies: 0..13 languages,
# 14 every language, 15 goodbye.
menu_links = lambda: [link(i) for i in range(len(LANGS) + 2)]
entries = [
    node("<CUSTOM%d>" % TOKEN_GREET, menu_links(), "RepliesList", comment=GREET),
    node("<CUSTOM%d>" % TOKEN_SAY, menu_links(), "RepliesList", comment=SAMPLE),
    node("<CUSTOM%d>" % TOKEN_ALL, menu_links(), "RepliesList", comment=ALL),
]
replies = []
for label, arg in LANGS:
    replies.append(node("[%s] Say something in %s." % (label, label.split(" (")[0]),
                        [link(1, "cond_lang_line", {"token": TOKEN_SAY, "text": SAMPLE})], "EntriesList",
                        "act_lang_npc", {"language": arg}))
replies.append(node("[All] Say one sentence in every language.",
                    [link(2, "cond_lang_line", {"token": TOKEN_ALL, "text": ALL})], "EntriesList"))
replies.append(node("Farewell, Gruk.", [], "EntriesList"))

dlg = {"__data_type": "DLG ", "DelayEntry": s("dword", 0), "DelayReply": s("dword", 0),
       "EndConverAbort": s("resref", ""), "EndConversation": s("resref", ""),
       "EntryList": s("list", entries), "NumWords": s("dword", 0), "PreventZoomIn": s("byte", 0),
       "ReplyList": s("list", replies),
       "StartingList": s("list", [link(0, "cond_lang_line", {"token": TOKEN_GREET, "text": GREET})])}
for i, e in enumerate(dlg["EntryList"]["value"]): e["__struct_id"] = i
for i, r in enumerate(dlg["ReplyList"]["value"]): r["__struct_id"] = i
(ROOT / "src/dlg/lang_demo.dlg.json").write_text(json.dumps(dlg, indent=2) + "\n")
print(len(entries), "entries", len(replies), "replies")
