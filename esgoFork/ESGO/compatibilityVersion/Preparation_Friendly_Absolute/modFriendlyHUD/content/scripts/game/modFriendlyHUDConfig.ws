//---=== modFriendlyHUD ===---
class CModFriendlyHUDConfig
{
	//--- Configurable section begin ---
	
	//---=== HUD Modules ===---
	
	//You can disable all hold-to-see hard-coded bindings with this trigger (if they conflict with your custom bindings, for example)
	const var disableHoldToSeeDefaultBindings : bool; default disableHoldToSeeDefaultBindings = false;
	//A threshold to display Wolf Module on vitality increase:
	//use 0 if you want to see healthbar for every vitality increase, including natural regeneration;
	//use 12 (bigger than normal + Sun and Stars) to exclude natural vitality regen;
	//use 999999 (any number big enough) to never see Wolf Module on vitality increase.
	const var vitalityRiseThreshold: float; default vitalityRiseThreshold = 12;
	
	//These are modules, which appear while you're holding Enter, M, J and K hotkeys
	const var essentialModulesStr : string; default
		essentialModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule; Minimap2Module; QuestsModule";
	const var minimapModulesStr : string; default
		minimapModulesStr = "Minimap2Module";
	const var questsModulesStr : string; default
		questsModulesStr = "QuestsModule";
	const var characterModulesStr : string; default
		characterModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule";
	//These are modules, which appear under certain conditions if enabled (see triggers above)
	const var combatModulesStr : string; default
		combatModulesStr = "WolfHeadModule; BuffsModule; ItemInfoModule; DamagedItemsModule; CompanionModule";
	const var witcherSensesModulesStr : string; default
		witcherSensesModulesStr = "Minimap2Module; QuestsModule";
	const var meditationModulesStr : string; default
		meditationModulesStr = "Minimap2Module";
	//Radial module flash script auto-hides top-left and top-right modules (WolfHeadModule, Minimap2Module), impossible to fix now
	const var radialMenuModulesStr : string; default
		radialMenuModulesStr = "ItemInfoModule";
	
	//---=== 3D Quest Markers Settings ===---
	
	//Min distance for displaying a marker
	const var markerMinDistance : float; default markerMinDistance = 4.0;
	//Font parameters for displaying quest markers (html)
	const var userMarkerTextFont : string; default userMarkerTextFont = "<font face=\"$BoldFont\" size=\"25\" color=\"#3CB371\">";
	const var currentMarkerTextFont : string; default currentMarkerTextFont = "<font face=\"$BoldFont\" size=\"25\" color=\"#FFD700\">";
	const var otherMarkerTextFont : string; default otherMarkerTextFont = "<font face=\"$NormalFont\" size=\"25\" color=\"#EEE8AA\">";
	const var upIndicator : string; default upIndicator = "<font face=\"$NormalFont\">^</font>";
	const var downIndicator : string; default downIndicator = "<font face=\"$NormalFont\">v</font>";
	
	//---=== Compass Markers Settings ===---
	
	//compass text settings (html tags)
	const var compassMarkerTextFont : string; default compassMarkerTextFont = "<font face=\"$BoldFont\" size=\"25\" color=\"#FFFF00\">";
	
	//---=== Quick Items In Radial Menu Settings ===---
	
	//Potions order in this list equals to hotkey order: 1-9, 0, -, = (buffs module flash can handle up to 12 items max!)
	const var potionsOrderStr : string; default
		potionsOrderStr = "Tawny_Owl; Thunderbolt; Blizzard; Swallow; White_Raffards_Decoction; Black_Blood; Full_Moon; Maribor_Forest; Petri_Philtre; Golden_Oriole; Cat; White_Honey";
	//Bombs order in this list equals to hotkey order: 1-8
	const var bombsOrderStr : string; default
		bombsOrderStr = "Dancing_Star; Devils_Puffball; Dragons_Dream; Grapeshot; Samum; White_Frost; Silver_Dust_Bomb; Dwimeritium_Bomb";
	//Oils order in this list equals to hotkey order: 1-9, 0, -, =
	const var oilsOrderStr : string; default
		oilsOrderStr = "Cursed_Oil; Draconide_Oil; Insectoid_Oil; Hybrid_Oil; Magicals_Oil; Necrophage_Oil; Ogre_Oil; Relic_Oil; Specter_Oil; Vampire_Oil; Beast_Oil; Hanged_Man_Venom";
	//Key strings (just text, doesn't affect actual bindings). Key bindings are displayed as pictures in-game and buffs module can't handle additional pictures.
	//This list is the best I can do for displaying your custom binds properly without going into much trouble.
	const var keysOrderStr : string; default
		keysOrderStr = "1; 2; 3; 4; 5; 6; 7; 8; 9; 0; -; =";
	//Since localized names have different length in different languages, you can use these settings to fine-tune quick items display to best fit the screen.
	//You can move <key> and <name> placeholders around and add separators. If you have hotkeys memorized, you can remove <key> indicator altogether.
	//And if using something like Better Icons mod that adds names directly to icons, you can remove <name> and leave only <key> for hotkey help.
	const var itemNamePattern : string; default itemNamePattern = "<key>:<name>";
	//Text color (html) for potions with zero quantity left
	const var zeroQuantityTextFont : string; default zeroQuantityTextFont = "<font color=\"#FF0000\">";
	//Controller related: current selection with zero quantity and current selection colors
	const var zeroQuantCurTextFont : string; default zeroQuantCurTextFont = "<font color=\"#FFFF00\">";
	const var currentTextFont : string; default currentTextFont = "<font color=\"#00FF00\">";
	
	//---=== Real Time Meditation ===---
	
	//you can disable RT meditation hard-coded binding with this if it conflicts with your custom bindings
	const var disableRTMeditationDefaultBinding : bool; default disableRTMeditationDefaultBinding = false;
	//When using real time meditation, all stats and buffs are updated in real time adjusted by current acceleration factor
	const var REFILL_INTERVAL_SECONDS : float; default REFILL_INTERVAL_SECONDS = 3600;
	const var MAX_HOURS_PER_MINUTE : float;	default MAX_HOURS_PER_MINUTE = 60;
	const var HOURS_PER_MINUTE_PER_SECOND : float; default HOURS_PER_MINUTE_PER_SECOND = 10;
	
	//---=== Inventory Menu ===---
	
	//Inventory tabs to reset new items flags for. Valid tabs names: Weapons, Alchemy, Quest, Default, Ingredients, Books.
	const var resetNewItemsInTabsStr : string; default
		resetNewItemsInTabsStr = "Alchemy; Default; Ingredients";
	
	//---=== Quen Indicator Settings ===---
	
	//If you're using a mod that changes quen max duration in non-standard way, change
	//maxQuenDurationOverride value to fit the one from the mod
	const var maxQuenDurationOverride : float; default maxQuenDurationOverride = -1;
	
	//--- End of configurable section ---
	
	//============================================================================================
	
	//--- moved to config menu ---
	public var fadeOutTimeSeconds : float;
	public var enableCombatModules : bool;
	public var enableCombatModulesOnUnsheathe : bool;
	public var enableWolfModuleOnVitalityChanged: bool;
	public var enableWitcherSensesModules : bool;
	public var enableMeditationModules : bool;
	public var enableRadialMenuModules : bool;
	public var directionMarkersAlwaysVisible : bool;
	public var questMarkersEnabled : bool;
	public var doNotShowDistance : bool;
	public var immersive3DMarker : bool;
	public var compassMarkersEnabled : bool;
	public var project3DMarkersOnCompass : bool;
	public var compassMarkersTop : bool;
	public var enableItemsInRadialMenu : bool;
	public var defaultDisplayMode : EBuffsDisplayMode;
	public var cycleThroughBuffs : bool;
	public var enableWASD : bool;
	public var applyOilToDrawnSword : bool;
	public var allowOilsInCombat : bool;
	public var radialMenuTimescale : float;
	public var fullHealthRegenAnyDifficulty : bool;
	public var refillPotionsWhileMeditating : bool;
	public var resetRefillSettingToDefaultAfterMeditation : bool;
	public var showTrackedQuest : bool;
	public var blockInventoryInCombat : bool;
	public var potionsTabOpensByDefault : bool;
	public var newPotionsTabSorting : bool;
	public var enableResetNewItems : bool;
	public var showTalkBubble : bool;
	public var showTalkBubbleText : bool;
	public var showTalkButton : bool;
	public var showTalkButtonText : bool;
	public var disableAllInteractionPrompts : bool;
	public var doNotShowDamage : bool;
	public var doNotShowLevels : bool;
	public var enableNPCQuestMarkers : bool;
	public var dontTouchMySwords : bool;
	public var showQuenDuration : bool;
	public var potionsRefillOnMessage : string;
	public var potionsRefillOffMessage : string;
	public var mapUnlimitedZoom : bool;
	public var mapZoomMinCoef : float;
	public var mapZoomMaxCoef : float;
	public var minimapZoomExterior : float;
	public var minimapZoomInterior : float;
	public var minimapZoomBoat : float;

	//--- other vars ---
	public var directionMarkersAlwaysVisibleToggle	: bool;
	public var refillPotionsWhileMeditatingToggle	: bool;
	private var potionsOrder						: array< string >;
	private var bombsOrder							: array< string >;
	private var oilsOrder							: array< string >;
	private var keysOrder							: array< string >;
	public var essentialModules						: array< string >;
	public var minimapModules						: array< string >;
	public var questsModules						: array< string >;
	public var characterModules						: array< string >;
	public var combatModules						: array< string >;
	public var witcherSensesModules					: array< string >;
	public var meditationModules					: array< string >;
	public var radialMenuModules					: array< string >;
	private var resetNewItemsInTabs					: array< string >;
	
	//--- functions ---
	public function Init()
	{
		UpdateUserSettings();
		InitArrays();
		//localized messages
		potionsRefillOnMessage = GetLocStringByKeyExt("fhud_potionsRefillOnMessage");
		potionsRefillOffMessage = GetLocStringByKeyExt("fhud_potionsRefillOffMessage");
	}
	
	public function InitToggleableValues()
	{
		directionMarkersAlwaysVisibleToggle = directionMarkersAlwaysVisible;
		refillPotionsWhileMeditatingToggle = refillPotionsWhileMeditating;
	}

	public function ToggleQuestMarkers()
	{
		directionMarkersAlwaysVisibleToggle = ( !directionMarkersAlwaysVisibleToggle );
	}
	
	public function ResetRefillPotionsWhileMeditating()
	{
		refillPotionsWhileMeditatingToggle = refillPotionsWhileMeditating;
	}
	
	public function ToggleRefillPotionsWhileMeditating()
	{
		refillPotionsWhileMeditatingToggle = ( !refillPotionsWhileMeditatingToggle );
		if ( refillPotionsWhileMeditatingToggle )
		{
			thePlayer.DisplayHudMessage( potionsRefillOnMessage );
		}
		else
		{
			thePlayer.DisplayHudMessage( potionsRefillOffMessage );
		}
	}
	
	public function ShowNewItmesInTab( tabName : string ) : bool
	{
		if ( enableResetNewItems && resetNewItemsInTabs.Contains( tabName ) )
		{
			return false;
		}
		return true;
	}

	public function FillPotionNames( out potionNames : array< string > )
	{
		potionNames = potionsOrder;
	}
	
	public function FillBombNames( out bombNames : array< string > )
	{
		bombNames = bombsOrder;
	}
	
	public function FillOilNames( out oilNames : array< string > )
	{
		oilNames = oilsOrder;
	}
	
	public function FillKeyNames( out keyNames : array< string > )
	{
		keyNames = keysOrder;
	}
	
	function InitArrays()
	{
		potionsOrder = StrToArrStr( potionsOrderStr, ";" );
		bombsOrder = StrToArrStr( bombsOrderStr, ";" );
		oilsOrder = StrToArrStr( oilsOrderStr, ";" );
		keysOrder = StrToArrStr( keysOrderStr, ";" );
		essentialModules = StrToArrStr( essentialModulesStr, ";" );
		minimapModules = StrToArrStr( minimapModulesStr, ";" );
		questsModules = StrToArrStr( questsModulesStr, ";" );
		characterModules = StrToArrStr( characterModulesStr, ";" );
		combatModules = StrToArrStr( combatModulesStr, ";" );
		witcherSensesModules = StrToArrStr( witcherSensesModulesStr, ";" );
		meditationModules = StrToArrStr( meditationModulesStr, ";" );
		radialMenuModules = StrToArrStr( radialMenuModulesStr, ";" );
		resetNewItemsInTabs = StrToArrStr( resetNewItemsInTabsStr, ";" );
	}
	
	//Update user settings
	public function UpdateUserSettings()
	{
		//modules
		enableCombatModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableCombatModules');
		enableCombatModulesOnUnsheathe = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableCombatModulesOnUnsheathe');
		enableWolfModuleOnVitalityChanged = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableWolfModuleOnVitalityChanged');
		enableWitcherSensesModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableWitcherSensesModules');
		enableMeditationModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableMeditationModules');
		enableRadialMenuModules = theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudEnableRadialMenuModules');
		fadeOutTimeSeconds = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudHUD', 'fhudFadeOutTimeSeconds'));
		CheckModules();
		//3D markers
		questMarkersEnabled = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudQuestMarkersEnabled');
		compassMarkersEnabled = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudCompassMarkersEnabled');
		directionMarkersAlwaysVisible = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudDirectionMarkersAlwaysVisible');
		project3DMarkersOnCompass = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudProject3DMarkersOnCompass');
		compassMarkersTop = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudCompassMarkersTop');
		doNotShowDistance = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudDoNotShowDistance');
		immersive3DMarker = theGame.GetInGameConfigWrapper().GetVarValue('fhudMarkers', 'fhudImmersive3DMarker');
		enableItemsInRadialMenu = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudEnableItemsInRadialMenu');
		defaultDisplayMode = GetBuffsDisplayMode();
		cycleThroughBuffs = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudCycleThroughBuffs');
		enableWASD = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudEnableWASD');
		applyOilToDrawnSword = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudApplyOilToDrawnSword');
		allowOilsInCombat = theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudAllowOilsInCombat');
		radialMenuTimescale = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'fhudRadialMenuTimescale'));
		fullHealthRegenAnyDifficulty = theGame.GetInGameConfigWrapper().GetVarValue('fhudMeditation', 'fhudFullHealthRegenAnyDifficulty');
		refillPotionsWhileMeditating = theGame.GetInGameConfigWrapper().GetVarValue('fhudMeditation', 'fhudRefillPotionsWhileMeditating');
		resetRefillSettingToDefaultAfterMeditation = theGame.GetInGameConfigWrapper().GetVarValue('fhudMeditation', 'fhudResetRefillSettingToDefaultAfterMeditation');
		showTrackedQuest = theGame.GetInGameConfigWrapper().GetVarValue('fhudMenus', 'fhudShowTrackedQuest');
		blockInventoryInCombat = theGame.GetInGameConfigWrapper().GetVarValue('fhudMenus', 'fhudBlockInventoryInCombat');
		potionsTabOpensByDefault = theGame.GetInGameConfigWrapper().GetVarValue('fhudMenus', 'fhudPotionsTabOpensByDefault');
		newPotionsTabSorting = theGame.GetInGameConfigWrapper().GetVarValue('fhudMenus', 'fhudNewPotionsTabSorting');
		enableResetNewItems = theGame.GetInGameConfigWrapper().GetVarValue('fhudMenus', 'fhudEnableResetNewItems');
		showTalkBubble = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudShowTalkBubble');
		showTalkBubbleText = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudShowTalkBubbleText');
		showTalkButton = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudShowTalkButton');
		showTalkButtonText = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudShowTalkButtonText');
		disableAllInteractionPrompts = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudDisableAllInteractionPrompts');
		enableNPCQuestMarkers = theGame.GetInGameConfigWrapper().GetVarValue('fhudInteractions', 'fhudEnableNPCQuestMarkers');
		doNotShowDamage = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudDoNotShowDamage');
		doNotShowLevels = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudDoNotShowLevels');
		dontTouchMySwords = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudDontTouchMySwords');
		showQuenDuration = theGame.GetInGameConfigWrapper().GetVarValue('fhudMisc', 'fhudShowQuenDuration');
		//zooms
		mapUnlimitedZoom = theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapUnlimitedZoom');
		mapZoomMinCoef = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapZoomMinCoef'));
		mapZoomMaxCoef = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMapZoomMaxCoef'));
		minimapZoomExterior = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomExterior'));
		minimapZoomInterior = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomInterior'));
		minimapZoomBoat = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('fhudMap', 'fhudMinimapZoomBoat'));
		VerifyZoomCoefs();
		UpdateMinimapZoom();
		//update toggleable values
		InitToggleableValues();
	}
	private function CheckModules()
	{
		if ( !enableCombatModules && IsHUDGroupEnabledForReason( combatModules, "InCombat" ) )
		{
			ToggleCombatModules( false, "InCombat" );
		}
		if ( !enableCombatModulesOnUnsheathe && IsHUDGroupEnabledForReason( combatModules, "OnUnsheathe" ) )
		{
			ToggleCombatModules( false, "OnUnsheathe" );
		}
		if ( !enableWitcherSensesModules && IsHUDGroupEnabledForReason( witcherSensesModules, "WitcherSensesActive" ) )
		{
			ToggleWSModules( false, "WitcherSensesActive" );
		}
		if ( !enableMeditationModules && IsHUDGroupEnabledForReason( meditationModules, "RealTimeMeditation" ) )
		{
			ToggleMeditModules( false, "RealTimeMeditation" );
		}
		if ( !enableRadialMenuModules && IsHUDGroupEnabledForReason( radialMenuModules, "InRadialMenu" ) )
		{
			ToggleModulesToShowInRadialMenu( false, "InRadialMenu" );
		}
	}
	private function VerifyZoomCoefs()
	{
		if( mapZoomMinCoef <= 0 ) mapZoomMinCoef = 1;
		if( mapZoomMaxCoef <= 0 ) mapZoomMaxCoef = 1;
		if( minimapZoomExterior <= 0 ) minimapZoomExterior = 1;
		if( minimapZoomInterior <= 0 ) minimapZoomInterior = 2;
		if( minimapZoomBoat <= 0 ) minimapZoomBoat = 0.5;
	}
	private function UpdateMinimapZoom()
	{
		var hud : CR4ScriptedHud;
		var minimapModule : CR4HudModuleMinimap2;
		hud = (CR4ScriptedHud)theGame.GetHud();
		if( hud )
		{
			minimapModule = (CR4HudModuleMinimap2)hud.GetHudModule( "Minimap2Module" );
			if( minimapModule )
			{
				minimapModule.UpdateZoomForced();
			}
		}
	}
	public function GetBuffsDisplayMode() : EBuffsDisplayMode
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('fhudQuickItems', 'Virtual_fhudDefaultDisplayMode'));
		switch( cfgVal )
		{
			case 0:
				return BDM_ShowPotions;
			case 1:
				return BDM_ShowBombs;
			case 2:
				return BDM_ShowOils;
			case 3:
				return BDM_ShowBuffs;
		}
		return BDM_ShowBuffs;
	}
}

function GetFHUDConfig() : CModFriendlyHUDConfig
{
	return thePlayer.fHUDConfig;
}

function EatWhite( str : string ) : string
{
	var res : string;
	res = StrReplaceAll( str, " ", "" );
	res = StrReplaceAll( res, "\t", "" );
	res = StrReplaceAll( res, "\n", "" );
	res = StrReplaceAll( res, "\r", "" );
	res = StrReplaceAll( res, "\v", "" );
	res = StrReplaceAll( res, "\f", "" );
	return res;
}

function RestoreSpaces( str : string ) : string
{
	return StrReplaceAll( str, "_", " " );
}

function StrToArrStr( str, div : string ) : array< string >
{
	var ret : array< string >;
	var item, res, left, right : string;
	var spl : bool;
	spl = true;
	res = str;
	while( spl )
	{
		spl = StrSplitFirst( res, div, left, right );
		if ( spl )
		{
			item = RestoreSpaces( EatWhite( left ) );
			res = right;
		}
		else
		{
			item = RestoreSpaces( EatWhite( res ) );
		}
		ret.PushBack( item );
	}
	return ret;
}
//---=== modFriendlyHUD ===---
