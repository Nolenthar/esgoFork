Additional key bindings for FriendlyHUD
=======================================

You most probably don't need anything from this file if you don't have conflicting bindings with Map, Journal, Character, Meditation and Quick Menu hotkeys. This file is mostly for controller players having their keys remapped using Antimicro or some other similar utility. Lot of manual editing is needed to make it work, so you need to know your way around input.settings file and be ready to spend some time configuring your keys.

If you have your bindings heavily remapped and default hold-to-see and hold-to-meditate bindings create conflicts for you, then you can disable them inside <Path To The Witcher 3>\Mods\modFriendlyHUD\content\scripts\game\modFriendlyHUDConfig.ws file (search for disableHoldToSeeDefaultBindings and disableRTMeditationDefaultBinding) and manually set new ones using separate actions.

Add these lines to your <Path To The Witcher 3>\bin\config\r4game\user_config_matrix\pc\input.xml file right before
<!-- [BASE_CharacterMovement] --> line:
<Var builder="Input" id="HoldToSeeEssentials" displayName="HoldToSeeEssentials" displayType="INPUTPC" actions="HoldToSeeEssentials" />
<Var builder="Input" id="HoldToSeeCharStats" displayName="HoldToSeeCharStats" displayType="INPUTPC" actions="HoldToSeeCharStats" />
<Var builder="Input" id="HoldToSeeMap" displayName="HoldToSeeMap" displayType="INPUTPC" actions="HoldToSeeMap" />
<Var builder="Input" id="HoldToSeeQuests" displayName="HoldToSeeQuests" displayType="INPUTPC" actions="HoldToSeeQuests" />
<Var builder="Input" id="HoldToMeditate" displayName="HoldToMeditate" displayType="INPUTPC" actions="HoldToMeditate" />

Then open your C:\Users\<Your Username>\Documents\The Witcher 3\input.settings file and add corresponding key bindings to appropriate sections. Example:
[Exploration]
IK_Pad_LeftThumb=(Action=HoldToSeeMap)
