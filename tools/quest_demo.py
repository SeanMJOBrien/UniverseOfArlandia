#!/usr/bin/env python3
"""Generate the quest-dialog example: src/dlg/quest_demo.dlg.json, the
journal categories qd_* in src/jrl/module.jrl.json and the NPC blueprint
src/utc/quest_wren.utc.json.

One hub NPC (Wren) offers four quests that share the scripts cond_qd, act_qd
and cond_lang_know:
  miller    persuasion   Persuade / Intimidate / pay, one try each, fail forward
  envoy     language     the reply depends on Goblin fluency (6 / 3-5 / 1-2 / 0)
  ledger    logic        a who-lied deduction with a hint after two misses
  caravan   umbrella     each quest above adds a lead; any order, resumable
Run from the repo root; safe to re-run.
"""
import copy, json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
RESUME_HUB = "hub"

# --- GFF helpers

def loc(text):
    return {"type": "cexolocstring", "value": {"0": text}}

def kv(key, value):
    return {"__struct_id": 0, "Key": {"type": "cexostring", "value": key},
            "Value": {"type": "cexostring", "value": str(value)}}

def params(d):
    return [kv(k, v) for k, v in d.items()]

def cond(op, quest=None, **kw):
    """(script, params) for cond_qd."""
    p = {"op": op}
    if quest: p["quest"] = quest
    p.update({k: v for k, v in kw.items()})
    return ("cond_qd", p)

def lang(language, level=1):
    return ("cond_lang_know", {"language": language, "level": level})

def act(op, quest=None, **kw):
    p = {"op": op}
    if quest: p["quest"] = quest
    p.update(kw)
    return ("act_qd", p)

# --- the dialog

entries, replies, starts = {}, {}, []
entry_order, reply_order = [], []

def E(name, text, action=None, to=()):
    entries[name] = dict(text=text, action=action, links=list(to)); entry_order.append(name)

def R(name, text, action=None, to=()):
    replies[name] = dict(text=text, action=action, links=list(to)); reply_order.append(name)

def link(target, c=None):
    return (target, c)

HUB = [link("E_HUB_DONE", cond("stage_eq", "caravan", value=9)),
       link("E_HUB3", cond("leads_ge", value=3)),
       link("E_HUB2", cond("leads_eq", value=2)),
       link("E_HUB1", cond("leads_eq", value=1)),
       link("E_HUB0")]

# shared replies
R("R_BACK", "Let's talk about something else.", to=HUB)
R("R_LEAVE", "Farewell.")

# --- greeting and hub
E("E_NEW", "Welcome to the Crossroads Archive. I am Wren. A merchant caravan left here three days ago and has not been seen since. "
           "Three loose ends might lead to it: the miller's debt, a goblin's letter, a stolen ledger. Will you look into it?",
  to=[link("R_TAKE"), link("R_NOT_NOW")])
R("R_TAKE", "I'll find the caravan.", act("stage", "caravan", value=1), to=HUB)
R("R_NOT_NOW", "Not now.")

hub_replies = [link("R_MILL0", cond("stage_eq", "miller", value=0)), link("R_MILL1", cond("stage_eq", "miller", value=1)),
               link("R_ENV0", cond("stage_eq", "envoy", value=0)), link("R_ENV1", cond("stage_eq", "envoy", value=1)),
               link("R_LED0", cond("stage_eq", "ledger", value=0)), link("R_LED1", cond("stage_eq", "ledger", value=1)),
               link("R_FINALE", cond("finale_ready")), link("R_RESET"), link("R_LEAVE")]
E("E_HUB0", "You hold no leads yet. Take the three in any order: the miller's debt calls for a smooth tongue, the goblin letter for the right language, the ledger for a clear head.", to=hub_replies)
E("E_HUB1", "One lead of three. The others wait where you left them; nothing you have done is lost.", to=hub_replies)
E("E_HUB2", "Two leads of three. One more and the caravan's trail is clear.", to=hub_replies)
E("E_HUB3", "Three leads of three. That is enough to ride out after the caravan.", to=hub_replies)
E("E_HUB_DONE", "The caravan is home and the road is open. Thank you. You may rerun any lesson here by resetting your progress.", to=hub_replies)
R("R_RESET", "[Test] Forget all my quest progress.", act("reset"), to=HUB)

# --- quest 1: persuasion (miller)
R("R_MILL0", "[Persuasion] Ask about the miller's debt.", to=[link("E_MILL_INTRO")])
R("R_MILL1", "[Persuasion] Return to the toll gate.", to=[link("E_MILL_APPROACH")])
E("E_MILL_INTRO", "Old Tolliver the miller owes the Guild eighty gold in tolls. Collector Brannoc takes the mill at dawn. "
                  "Tolliver's wagon travelled with the caravan and he saw which road it took, but he will say nothing while his mill is in danger. "
                  "Speak to Brannoc for him.", to=[link("R_MILL_ACCEPT"), link("R_BACK")])
R("R_MILL_ACCEPT", "I'll speak to Brannoc.", act("stage", "miller", value=1), to=[link("E_MILL_APPROACH")])
E("E_MILL_APPROACH", "Brannoc stands at the toll gate with a ledger under his arm. How do you handle him?",
  to=[link("R_PERSUADE", cond("noflag", "miller", name="tried_persuade")),
      link("R_INTIM", cond("noflag", "miller", name="tried_intimidate")),
      link("R_BRIBE", cond("gold", value=80)),
      link("R_BACK")])
R("R_PERSUADE", "[Persuade, DC 15] Appeal to his sense of fairness.", act("roll", "miller", skill="persuade", dc=15, name="persuade"),
  to=[link("E_MILL_OK_PERSUADE", cond("flag", "miller", name="ok_persuade")), link("E_MILL_FAIL")])
R("R_INTIM", "[Intimidate, DC 18] Remind him who the Guild answers to.", act("roll", "miller", skill="intimidate", dc=18, name="intimidate"),
  to=[link("E_MILL_OK_INTIM", cond("flag", "miller", name="ok_intimidate")), link("E_MILL_FAIL")])
R("R_BRIBE", "[80 gold] Pay the debt yourself.", act("pay", "miller", gold=80, name="bribe"), to=[link("E_MILL_OK_BRIBE")])
E("E_MILL_FAIL", "Brannoc shakes his head. 'Rules are rules.' You may try another way.",
  to=[link("R_MILL_RETRY"), link("R_BACK")])
R("R_MILL_RETRY", "Try something else.", to=[link("E_MILL_APPROACH")])
E("E_MILL_OK_PERSUADE", "Brannoc sighs and crosses out the debt. 'Fair enough. Tell Tolliver he has until harvest.' "
                        "Grateful, Tolliver tells you the caravan turned off toward the broken bridge.",
  act("complete", "miller", xp=150, gold=50), to=[link("R_BACK")])
E("E_MILL_OK_INTIM", "Brannoc pales and stamps the debt paid. 'No need for that.' Tolliver tells you, shaking, that the caravan turned toward the broken bridge.",
  act("complete", "miller", xp=150, gold=50), to=[link("R_BACK")])
E("E_MILL_OK_BRIBE", "Brannoc counts the coins twice and lets the mill be. Tolliver, relieved, tells you the caravan turned toward the broken bridge.",
  act("complete", "miller", xp=100, gold=0), to=[link("R_BACK")])

# --- quest 2: language (envoy)
G = "goblin"
R("R_ENV0", "[Language] Ask about the goblin letter.", to=[link("E_ENV_INTRO")])
R("R_ENV1", "[Language] Read the goblin letter again.",
  to=[link("E_ENV_6", lang(G, 6)), link("E_ENV_3", lang(G, 3)), link("E_ENV_1", lang(G, 1)), link("E_ENV_0")])
E("E_ENV_INTRO", "A goblin envoy, Skritt, left a sealed letter on my desk and ran. I cannot read Goblin script. "
                 "Your fluency matters here: the better your Goblin, the more the letter tells you. "
                 "Goblin primers exist in six volumes; volume 6 makes you fluent.", to=[link("R_ENV_ACCEPT"), link("R_BACK")])
R("R_ENV_ACCEPT", "Show me the letter.", act("stage", "envoy", value=1),
  to=[link("E_ENV_6", lang(G, 6)), link("E_ENV_3", lang(G, 3)), link("E_ENV_1", lang(G, 1)), link("E_ENV_0")])
E("E_ENV_6", "You read it as a native. 'To the keepers of the road hall: the Red Hand took your caravan, not us. We trade fairly. "
             "Meet Skritt at dusk by the broken bridge and bring no steel.' Wren nods. 'Then the goblins are witnesses, not thieves.'",
  act("complete", "envoy", xp=200, gold=0), to=[link("R_BACK")])
E("E_ENV_3", "You follow most of it: '...caravan... not us... Red... bridge...' Enough to doubt the goblins, not enough to be sure. "
             "You may piece the rest together, or study more Goblin and read it again.",
  act("setflag", "envoy", name="gist"), to=[link("R_GIST", cond("noflag", "envoy", name="tried_gist")), link("R_BACK")])
R("R_GIST", "[Lore, DC 18] Fill the gaps from what you caught.", act("roll", "envoy", skill="lore", dc=18, name="gist"),
  to=[link("E_ENV_GUESS_OK", cond("flag", "envoy", name="ok_gist")), link("E_ENV_GUESS_FAIL")])
E("E_ENV_1", "Only a few words are clear: 'caravan', 'bridge', 'dusk'. Not enough to act on. Better Goblin, or a lucky guess at the glyphs, would help.",
  to=[link("R_DECIPHER", cond("noflag", "envoy", name="tried_decipher")), link("R_BACK")])
E("E_ENV_0", "The glyphs mean nothing to you. Learn Goblin from a book, or try to match the glyphs against Wren's old ledgers.",
  to=[link("R_DECIPHER", cond("noflag", "envoy", name="tried_decipher")), link("R_BACK")])
R("R_DECIPHER", "[Lore, DC 25] Decipher it by comparing glyphs.", act("roll", "envoy", skill="lore", dc=25, name="decipher"),
  to=[link("E_ENV_GUESS_OK", cond("flag", "envoy", name="ok_decipher")), link("E_ENV_GUESS_FAIL")])
E("E_ENV_GUESS_OK", "It comes together: the Red Hand took the caravan and the goblins want to meet by the broken bridge. You are unsure of every word, but the sense holds.",
  act("complete", "envoy", xp=100, gold=0), to=[link("R_BACK")])
E("E_ENV_GUESS_FAIL", "You tell Wren it reads like a war threat. She frowns. 'That does not sound right.' You are not sure either. A better grasp of Goblin would settle it.",
  act("setflag", "envoy", name="misread"), to=[link("R_BACK")])

# --- quest 3: logic (ledger)
R("R_LED0", "[Logic] Ask about the missing ledger.", to=[link("E_LED_INTRO")])
R("R_LED1", "[Logic] Return to the ledger puzzle.", to=[link("E_LED_Q")])
E("E_LED_INTRO", "The Guild ledger vanished from the locked archive. Only the Cook, the Guard and the Scribe hold keys. "
                 "I questioned them. Each made one statement, and exactly one of the three statements is true. No skill helps here; only reasoning.",
  to=[link("R_LED_ACCEPT"), link("R_BACK")])
R("R_LED_ACCEPT", "Tell me what they said.", act("stage", "ledger", value=1), to=[link("E_LED_Q")])
E("E_LED_Q", "The Cook: 'The Scribe took it.' The Guard: 'I did not take it.' The Scribe: 'The Cook is lying.' "
             "Exactly one statement is true. Who took the ledger?",
  to=[link("R_COOK"), link("R_GUARD"), link("R_SCRIBE"), link("R_LED_HINT", cond("attempts_ge", "ledger", value=2)), link("R_BACK")])
R("R_COOK", "The Cook took it.", to=[link("E_LED_NO_COOK")])
R("R_GUARD", "The Guard took it.", to=[link("E_LED_OK")])
R("R_SCRIBE", "The Scribe took it.", to=[link("E_LED_NO_SCRIBE")])
R("R_LED_HINT", "Give me a hint.", to=[link("E_LED_HINT")])
E("E_LED_NO_COOK", "If the Cook took it, the Scribe's 'The Cook is lying' is true, and so is the Guard's 'I did not take it'. That makes two truths, not one.",
  act("attempt", "ledger"), to=[link("R_LED_AGAIN"), link("R_BACK")])
E("E_LED_NO_SCRIBE", "If the Scribe took it, the Cook's statement is true, and so is the Guard's. Two truths again.",
  act("attempt", "ledger"), to=[link("R_LED_AGAIN"), link("R_BACK")])
E("E_LED_HINT", "Assume each suspect did it and count how many of the three statements come out true. Only one suspect gives exactly one.",
  to=[link("R_LED_AGAIN"), link("R_BACK")])
R("R_LED_AGAIN", "Let me think again.", to=[link("E_LED_Q")])
E("E_LED_OK", "The Guard it is: with the Guard guilty, only the Scribe's 'The Cook is lying' is true. The Guard confesses and returns the ledger, "
              "which records the caravan's secret route.",
  act("complete", "ledger", xp=200, gold=75), to=[link("R_BACK")])

# --- finale: all three leads
R("R_FINALE", "[Report] I hold all three leads.", to=[link("E_FINALE")])
E("E_FINALE", "Tolliver's road, Skritt's letter and the ledger's route all point to the broken bridge. You ride out at dusk, "
              "meet the goblins, and drive off the Red Hand. The caravan returns with its goods intact.",
  act("complete", "caravan", xp=500, gold=250), to=[link("R_BACK")])

STARTS = [link("E_NEW", cond("stage_eq", "caravan", value=0))] + HUB

# --- build the dlg json

def link_struct(index, c, reply_side):
    s = {"__struct_id": 0, "Active": {"type": "resref", "value": c[0] if c else ""},
         "Index": {"type": "dword", "value": index}}
    if reply_side: s["IsChild"] = {"type": "byte", "value": 0}
    if c: s["ConditionParams"] = {"type": "list", "value": params(c[1])}
    return s

def node(d, links, index_of, list_name, reply_side):
    n = {"__struct_id": 0, "Animation": {"type": "dword", "value": 0}, "AnimLoop": {"type": "byte", "value": 1},
         "Comment": {"type": "cexostring", "value": ""}, "Delay": {"type": "dword", "value": 4294967295},
         list_name: {"type": "list", "value": [link_struct(index_of[t], c, True) for t, c in links]},
         "Quest": {"type": "cexostring", "value": ""},
         "Script": {"type": "resref", "value": d["action"][0] if d["action"] else ""},
         "Sound": {"type": "resref", "value": ""}, "Text": loc(d["text"])}
    if d["action"]: n["ActionParams"] = {"type": "list", "value": params(d["action"][1])}
    if list_name == "RepliesList": n["Speaker"] = {"type": "cexostring", "value": ""}
    return n

e_index = {n: i for i, n in enumerate(entry_order)}
r_index = {n: i for i, n in enumerate(reply_order)}
dlg = {"__data_type": "DLG ", "DelayEntry": {"type": "dword", "value": 0}, "DelayReply": {"type": "dword", "value": 0},
       "EndConverAbort": {"type": "resref", "value": ""}, "EndConversation": {"type": "resref", "value": ""},
       "NumWords": {"type": "dword", "value": 0}, "PreventZoomIn": {"type": "byte", "value": 0},
       "EntryList": {"type": "list", "value": [node(entries[n], entries[n]["links"], r_index, "RepliesList", True) for n in entry_order]},
       "ReplyList": {"type": "list", "value": [node(replies[n], replies[n]["links"], e_index, "EntriesList", True) for n in reply_order]},
       "StartingList": {"type": "list", "value": [link_struct(e_index[t], c, False) for t, c in STARTS]}}
for e in dlg["EntryList"]["value"]:  # entry node ids are reply indexes
    pass
(ROOT / "src/dlg/quest_demo.dlg.json").write_text(json.dumps(dlg, indent=2) + "\n")

# --- journal categories

JOURNAL = {
    "miller": ("Quest: The Miller's Debt", "Brannoc will seize the mill at dawn unless the debt is settled. Persuade, intimidate or pay him.",
               "The mill is saved, and Tolliver told you the caravan turned toward the broken bridge."),
    "envoy": ("Quest: The Goblin Envoy's Letter", "A goblin left a sealed letter. How much of it you can read depends on your Goblin.",
              "The letter says the Red Hand took the caravan, and asks for a meeting at the broken bridge."),
    "ledger": ("Quest: The Stolen Ledger", "Exactly one of three statements is true. Work out who took the ledger.",
               "The Guard took the ledger. It records the caravan's route."),
    "caravan": ("Quest: The Lost Caravan", "Gather three leads, in any order: the miller's debt, the goblin letter and the stolen ledger.",
                "The caravan is home safe."),
}
jrl_path = ROOT / "src/jrl/module.jrl.json"
jrl = json.loads(jrl_path.read_text())
cats = [c for c in jrl["Categories"]["value"] if not c["Tag"]["value"].startswith("qd_")]
def jentry(i, text, end):
    return {"__struct_id": 0, "End": {"type": "word", "value": end}, "ID": {"type": "dword", "value": i}, "Text": loc(text)}
for quest, (name, start, done) in JOURNAL.items():
    cats.append({"__struct_id": 0, "Comment": {"type": "cexostring", "value": ""},
                 "EntryList": {"type": "list", "value": [jentry(1, start, 0), jentry(9, done, 1)]},
                 "Name": loc(name), "Picture": {"type": "word", "value": 65535}, "Priority": {"type": "dword", "value": 1},
                 "Tag": {"type": "cexostring", "value": "qd_" + quest}, "XP": {"type": "dword", "value": 0}})
jrl["Categories"]["value"] = cats
jrl_path.write_text(json.dumps(jrl, indent=2) + "\n")

# --- NPC: Wren, cloned from the plot giver
utc = json.loads((ROOT / "src/utc/plotgiver.utc.json").read_text())
utc["Tag"]["value"] = "quest_wren"
utc["TemplateResRef"]["value"] = "quest_wren"
utc["Conversation"]["value"] = "quest_demo"
utc["FirstName"]["value"] = {"0": "Wren"}
utc["LastName"]["value"] = {"0": "the Archivist"}
(ROOT / "src/utc/quest_wren.utc.json").write_text(json.dumps(utc, indent=2) + "\n")
print("entries", len(entry_order), "replies", len(reply_order), "starts", len(STARTS))
