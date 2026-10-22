# TODO

## Language system

- Consider making Common a language that a new player character must select when joining (character creation), instead of being the implicit default speech of every PC. Today Common is the fallback in the `.lang` window (`dmfi_lang_nui.nss`) and talk mode is off by default (`lang_talk` unset). Open questions: whether a PC could then forget or lack Common, and how NPC dialog and `LangFluency` should treat it (currently Common is not a language id).
