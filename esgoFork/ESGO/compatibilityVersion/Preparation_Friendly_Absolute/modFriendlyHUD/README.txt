modFriendlyHUD
==============

This mod is for 1.12 version of the game. English and Russian languages in options menu are fully supported, other languages should display mod options in English.

Installation:
=============

If you have vanilla version of the game, backup your "[Path To The Witcher 3]\bin\config" folder as some of the mods (including this one) make changes to configuration files and it won't hurt to have vanilla version in case you will need to quickly clean up all your mods.

1. Unpack the mod and copy an entire "modFriendlyHUD" folder to "[Path To The Witcher 3]\Mods" folder. If "Mods" folder doesn't exist, create it first. You can use NMM to install the mod, but you'll still need to configure menu and key bindings part manually.

2. Navigate to "[Path To The Witcher 3]\Mods\modFriendlyHUD" folder and copy an entire "bin" folder into your "[Path To The Witcher 3]" folder, replacing files when prompted. Note: this action will replace your input.xml file, so if you have other mods installed that instruct you to replace/modify this file, don't replace it, but open your "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\input.xml" file and modded "[Path To The Witcher 3]\Mods\modFriendlyHUD\bin\config\r4game\user_config_matrix\pc\input.xml" file and manually copy modFriendlyHUD changes (they are marked with "modFriendlyHUD begin" and "modFriendlyHUD end" comments).

3. Open both "C:\Users\[Your Username]\Documents\The Witcher 3\input.settings" and "[Path To The Witcher 3]\Mods\modFriendlyHUD\input.settings.part.txt" file from the mod. Select everything inside "input.settings.part.txt", copy and paste it at the beginning of "input.settings" file.

4. Open both "C:\Users\[Your Username]\Documents\The Witcher 3\user.settings" and "[Path To The Witcher 3]\Mods\modFriendlyHUD\user.settings.part.txt" file from the mod. Select everything inside "user.settings.part.txt", copy and paste it at the beginning of "user.settings" file.

5. If you have other mods installed, use Script Merger to find and resolve conflicts. Note that some of the mods on Nexus might not support the latest patch and thus are incompatible nor with this mod not with the current game version in general.

6. If you're playing with gamepad remapped through Antimicro and have conflicting bindings or just want to change default hold-to-see bindings to something else, see README_additonal_actions.txt file.

7. IMPORTANT! The mod doesn't hide HUD modules, it shows them. So if you want to use condition-based modules behavior mod offers, you need to turn them OFF using in-game vanilla video options menu. You don't have to turn off every module, just the ones you don't want to see all the time. Modules that are ON in game video options are not affected by the mod and retain their vanilla behavior.

Default key bindings:
=====================

"F2" - quest markers display mode (always show/ witcher senses only);
"F3" - HUD on/off;
"F4" - potions refill on/off;
"F11" - pause/unpause the game;
"~" - switch between crossbow and selected bomb;
"Esc (press controller Select button)" - menu in dialogs/scenes;
"Hold Right Shift" - pin module modifier (hold RShift and press M to pin map module, for example).
"Hold controller Right Thumb" - real time meditation;
"Hold controller Left Thumb" - potions refill on/off;
"1-9, 0, -, =" - drink potions/equip bombs/apply oils in radial menu;
"F1" - show potions in radial menu;
"F2" - show bombs in radial menu;
"F3" - show oils in radial menu;
"F4" - show currently active buffs in radial menu;
"Q (controller Y button)" - cycle through potions/bombs/oils/buffs in radial menu;
"Controller D-Pad arrows" (or WASD if corresponding option is enabled) - navigate quick items list in radial menu;
"Controller Right Thumb" (or "C" if corresponding option is enabled) - drink selected potion/equip selected bomb/apply selected oil in radial menu;
"Hold N (or your reassigned meditation menu key)" - real-time meditation;
"Hold M (or your reassigned map key)" - show minimap temporarily;
"Hold J (or your reassigned journal key)" - show tracked quest objectives temporarily;
"Hold K (or your reassigned character skills key)" - show character modules temporarily;
"Hold Enter (or your reassigned quick menu key)" - show essential modules temporarily.

Configuration:
==============

Most of the options are now configurable directly from in-game menu - look for "Mods" and "Friendly HUD" entries.

For conditional modules to show up after you turn them on in menu you sometimes need to re-enter the state. For example, if you're in combat state with no combat modules enabled and you go to menu and enable them, they won't show up immediately. But after you finish current combat and start the next one, they will show up properly. Disabling of modules works immediately.

Dropping zoom factors to zero results in vanilla zoom values (for those of you who like vanilla zoom).

Combat modules: wolf medallion, buffs, additional items, damaged items, companions.
Witcher senses modules: minimap, tracked quest.
Meditation modules: minimap.
Radial menu modules: additional items.

Lists of modules and quick items, fonts for new features and some other things can be configured inside "[Path To The Witcher 3]\Mods\modFriendlyHUD\content\scripts\game\modFriendlyHUDConfig.ws" file. They require very basic programming knowledge, use them if you want to change some of the mod's inner workings. Configurable section starts with the line "Configurable section begin" and ends with the line "End of configurable section". Don't change anything outside these lines if you don't know exactly what you're doing.

Updating:
=========

It is always safer, both when updating manually and with NMM, to remove previous mod version (and make sure "[Path To The Witcher 3]\Mods\modFriendlyHUD" folder was indeed deleted) and install it anew. No changes to inputs and user configs are needed if you've already applied them and if changelog for the new version has no new bindings mentioned.

If you have other mods installed, un-merge your existing merges in ScriptMerger and re-merge everything again.

De-installation:
================

You can either uninstall the mod with NMM or manually delete "[Path To The Witcher 3]\Mods\modFriendlyHUD" folder. Note that if you have this mod merged with the others, you will need to re-merge remaining mods after uninstalling this one.

You can leave key bindings in place, as they won't do anything without mod installed, but if you don't want unused bindings cluttering your in-game menu, remove everything guarded with "modFriendlyHUD begin" and "modFriendlyHUD end" comments from your "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\input.xml" file. To remove FriendlyHUD menu options delete "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\modFHUDConfig.xml" file.

If you have backup of your vanilla "[Path To The Witcher 3]\bin\config" folder and have no other mods installed that change configuration files, simply delete your "[Path To The Witcher 3]\bin\config" folder and copy backup "config" folder in its place.

Remember that mod doesn't change any of your vanilla HUD settings, so you have to re-enable every module you want to see using in-game video options.

This mod doesn't change your save files, so uninstalling it in the middle of playthrough is safe.
