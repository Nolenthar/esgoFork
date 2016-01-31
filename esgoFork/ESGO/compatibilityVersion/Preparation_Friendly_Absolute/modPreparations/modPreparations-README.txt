modPreparations
===============

This mod is for 1.12 version of the game. English and Russian languages in options menu are fully supported, other languages should display mod options in English.

The mod is compatible with existing saves, you can install and uninstall it at any point of the game with no risk of breaking your saves.

You must have modFriendlyHUD mod already installed to install this version of modPreparations!

Installation:
=============

1. Unpack the mod and copy both "modFriendlyHUD" and "modPreparations" folders to "[Path To The Witcher 3]\Mods" folder, replacing files when prompted.

2. Navigate to "[Path To The Witcher 3]\Mods\modPreparations" folder and copy an entire "bin" folder into your "[Path To The Witcher 3]" folder, replacing files when prompted. Note: this action will replace your input.xml file, so if you have other mods installed that instruct you to replace/modify this file, don't replace it, but open your "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\input.xml" file and modded "[Path To The Witcher 3]\Mods\modPreparations\bin\config\r4game\user_config_matrix\pc\input.xml" file and manually copy modPreparations changes (they are marked with "modPreparations begin" and "modPreparations end" comments).

3. Open both "C:\Users\[Your Username]\Documents\The Witcher 3\input.settings" and "[Path To The Witcher 3]\Mods\modPreparations\input.settings.part.txt" file from the mod. Select everything inside "input.settings.part.txt", copy and paste it at the beginning of "input.settings" file.

4. Open both "C:\Users\[Your Username]\Documents\The Witcher 3\user.settings" and "[Path To The Witcher 3]\Mods\modPreparations\user.settings.part.txt" file from the mod. Select everything inside "user.settings.part.txt", copy and paste it at the beginning of "user.settings" file.

5. If you have other mods installed, use Script Merger to find and resolve conflicts. Note that some of the mods on Nexus might not support the latest patch and thus are incompatible nor with this mod not with the current game version in general. If you have previously merged modFriendlyHUD with other mods, un-merge everything and re-merge again.

6. IMPORTANT: for oils amount to initialize properly when loading existing save you need to open your inventory and switch to potions tab!

Default key bindings:
=====================
Press N (hold controller Right Thumb) to enter/exit meditation mode;
Hold spacebar (controller Left Thumb) to advance time.

Configuration:
==============

All mod options are now configurable directly from in-game menu - look for "Mods" and "Preparations" entries.

Updating:
=========

1. Always update you modFriendlyHUD first as instructed in its readme file! If there were no changes to modFriendlyHUD and this is just a modPreparations update, go directly to the next step.

2. Delete "[Path To The Witcher 3]\Mods\modPreparations" folder and copy updated folders over. No changes to inputs and user configs are needed if you've already applied them and if changelog for the new version has no new bindings mentioned.

3. If you have other mods installed, un-merge your existing merges in ScriptMerger and re-merge everything again.

De-installation:
================

To uninstall the mod delete "[Path To The Witcher 3]\Mods\modPreparations" folder. If you want to go back to clean modFriendlyHUD install, delete "[Path To The Witcher 3]\Mods\modFriendlyHUD" folder and repeat steps 1 and 2 of install process described in modFriendlyHUD's readme. Note that if you have this mod merged with the others, you will need to re-merge remaining mods after uninstalling this one.

You can leave key bindings in place, as they won't do anything without mod installed, but if you don't want unused bindings cluttering your in-game menu, remove everything guarded with "modPreparations begin" and "modPreparations end" comments from your "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\input.xml" file. To remove Preparations menu options delete "[Path To The Witcher 3]\bin\config\r4game\user_config_matrix\pc\modPreparationsConfig.xml" file.
