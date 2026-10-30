# Plan: the language system on NWNX, with translated speech in the normal bubbles

Status: Phases 1 to 3 are written and compile (`dmfi_lang_nwnx.nss`, `lang_nwnx_say.nss`, `LangNpcSay`, `lang_nwnx_on`, `lang_nwnx_log`). Phase 0, the checks with two clients, has not been run, and `NWNX_CHAT_SKIP=no` is not set on the server. The NWScript behavior stays in use whenever the plugin is not loaded or `lang_nwnx_on` is off.

## Goal

Each creature within hearing distance sees the speaker's line in the normal speech bubble and chat log, already translated to what that listener understands. The `.lang` window is not needed to read translations.

## How the bubbles work

The Chat plugin lets a script cancel a chat message (`NWNX_Chat_SkipMessage`) and send a chat line of its own to a single recipient from a chosen sender (`NWNX_Chat_SendMessage(channel, text, oSender, oRecipient)`). The client draws a bubble above the sender for a talk line, and puts the line in the chat log. So the plugin sends one line per listener, each with that listener's text:

| Listener | Line they receive |
|---|---|
| The speaker | the line as it will be heard (known words, `...` for unknown) |
| Fluent (6) | the speaker's words as the speaker can say them |
| Partial (1-5) | the garbled version, fixed per word |
| Level 0 | the scrambled language |

This is the rule set already in `LangSpeak`; only the delivery changes. In the no-NWNX path the bubble can show one text only (`SpeakString`), which is why the readable version arrives as a separate system message and the `.lang` window log exists. With NWNX the log is unnecessary. It can stay as an optional history; the "Show translations" check box then only controls that history.

## What changes with NWNX

| Area | Without NWNX | With NWNX Chat |
|---|---|---|
| Typed text in talk mode | speaker's chat line replaced by scrambled text; translation as a system message | one chat line and bubble per listener |
| `.lang` Speak button, typed `[text]` | `SpeakString` scrambled bubble plus system messages | the same per-listener lines through one shared function |
| Whisper | same, 3 m | same lines on the whisper channel |
| NPC speech | not handled in chat | `LangNpcSay` (below) |
| NPC dialog windows | custom token (`cond_lang_line`) | unchanged; dialog windows are not chat |
| Drow sign language | description lines, no bubble | unchanged; no bubble is the point |
| Thieves' Cant | one gesture | unchanged |

Settings, exposure sources, PC-only mode, trainers, slots and tutoring need no change. They are plain NWScript and apply to both paths, because the NWNX path already calls `LangGainExposure` with the speaker as the source.

## Plan

### Phase 0: switch on and verify the assumptions

1. Set `NWNX_CHAT_SKIP=no` in `config/nwserver.env` on a test server. Check the log for "Language system: NWNX Chat active."
2. With two clients, check each assumption before building on it. Any failure changes the design:
   - a skipped message disappears for everyone, and the speaker still sees something;
   - `NWNX_Chat_SendMessage` with the speaker as sender draws a bubble over the speaker for the recipient only;
   - the same works for the whisper channel and the 20 m and 3 m ranges;
   - a sender that is an NPC works;
   - shouts, party and DM channels are untouched;
   - a DM client sees the original text.
3. Record the results in this file.

### Phase 1: one delivery function for players

1. Move the per-listener loop out of `dmfi_lang_nwnx.nss` into one function, `LangDeliver(oSpeaker, iLang, sSaid, iChannel, fRange)`, used by:
   - the chat hook (`lang_nwnx_chat`) for talk mode,
   - the `.lang` Speak button,
   - typed `[text]` (`dmfi_voice_exe`).
2. `LangSpeak` picks the path: `LangNwnxActive()` uses `LangDeliver`; otherwise the current code runs. The two paths share the masking functions, so a word is masked the same way in both.
3. Keep the line-of-sight rule for players and the "hears everything" rule for DMs.
4. The `.lang` Speak button sends a talk-channel line even when the chat hook is not involved. With the plugin it needs no scrambled `SpeakString`.
5. Add the module setting `lang_nwnx_on` (on/off, in `dmfi_lang_cfg`) so the plugin path can be turned off without removing the plugin.

### Phase 2: NPC speech

The plugin sees player chat. NPC lines come from scripts, so NPC speech needs a wrapper.

1. Add `LangNpcSay(oNPC, sText, iLang = 0)`: finds the listeners in range exactly as `LangDeliver` does and sends each their version with the NPC as sender. If the plugin is off it falls back to `SpeakString` of the scrambled text.
2. Replace `SpeakString` in NPC scripts that should speak a language (Gruk's actions, any shout or ambient line) with `LangNpcSay`. The NPC's language is `npc_language`, or its racial language.
3. Exposure from NPC lines goes through the same rules: with PC-only mode on, only trainer NPCs (`lang_trainer` = 1) give points.
4. Check whether the plugin reports NPC `SpeakString` calls to the chat script. If it does, a generic hook can cover NPC speech; otherwise the wrapper stays.

### Phase 3: remove the dependency on the window

1. Treat the window as optional input: it still lets a player pick a language, type, and set talk mode, but it no longer shows translations by default. `lang_nui_off` defaults to hiding the log when the plugin is active.
2. The log stays available as history for players who want it.
3. Tutoring and `.lang` windows are independent of the plugin.

### Phase 4: optional NWNX storage (separate decision)

The campaign database works without NWNX and is deployed. NWNX offers alternatives: the SQL plugin (already enabled, same sqlite engine), or the dedicated item in `docs/TODO.md`. Neither is needed for translated bubbles. Do this only if the item-storage TODO is taken up.

## Risks

- The Chat plugin has never run on this server; Phase 0 is the gate.
- A skipped message that fails to resend leaves the speaker silent. The chat hook has to fall through to the original message on any error.
- Two scripts that modify chat (`mod_chat` with `SetPCChatMessage`, and the plugin hook) must not both act on one line. The plugin path skips the `LangHandleTalk` replacement when `LangNwnxActive()`.
- Cost: one loop per spoken line over creatures in 20 m. Same as the existing `LangSpeak`; acceptable.
- Per-listener lines in a busy area produce many messages; test with ten clients.
- A plugin or client update can change bubble behavior for sent messages; keep the NWScript path as the fallback.

## Tests

Repeat the main cases of `docs/LANGUAGE_TEST_SPEC.md` (F and I) with two or more clients and the plugin on:

1. A fluent and a level-0 client both see the bubble above the same speaker with different text.
2. A partial client sees the same masked words on repeat.
3. The speaker's own bubble shows `...` for unknown words.
4. Walking out of 20 m, or behind a wall, removes the line.
5. A DM sees the original.
6. Turning `lang_nwnx_on` off returns to the NWScript behavior.
7. NPC speech through `LangNpcSay`, with PC-only mode on and off, with and without `lang_trainer`.

## Order and size

Phase 0 is an hour of testing. Phase 1 is a refactor of about 150 lines. Phase 2 is a small wrapper plus script edits. Phase 3 is a default change. Do not start Phase 1 before Phase 0 passes.
