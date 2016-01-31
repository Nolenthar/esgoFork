//---=== modPreparations ===---
class CModPreparationsConfig
{
	//---- User configurable section begin ----

	//real time meditation acceleration parameters
	const var MAX_HOURS_PER_MINUTE : float;			default MAX_HOURS_PER_MINUTE = 60;
	const var HOURS_PER_MINUTE_PER_SECOND : float;	default HOURS_PER_MINUTE_PER_SECOND = 10;
	
	//---- User configurable section end ----

	//moved to menu
	//allow meditation near existing campfires
	public var allowCampFire : bool;
	//allow meditation near fire sources (campfires are not fire sources)
	public var allowFireSource : bool;
	//allow meditation near any light source (campfires and fire sources are also light sources)
	public var allowLightSource : bool;
	//disallows meditating in interior
	public var disallowInterior : bool;
	//disallows meditating in settlements (can still meditate in interior if disallowInterior = false)
	public var disallowSettlement : bool;
	//disallows meditating near non-allied NPCs
	public var disallowNPCs : bool;
	//min distance to NPC
	public var npcDistance : float;
	//allow spawning campfire in interiors
	public var allowCampFireInInterior : bool;
	//amount of timber needed to spawn campfire
	public var timberAmount : int;
	//amount of hardened timber needed to spawn campfire (if player has no timber)
	public var hardTimberAmount : int;
	//disallow player-spawned campfires
	public var disallowCampFire : bool;

	//disallows creating alchemy items while not meditating
	public var disallowAlchemy : bool;
	//disallows repairing items while not meditating
	public var disallowRepair : bool;
	//disallows upgrading items (runes, glyphs) while not meditating
	public var disallowUpgrade : bool;
	//disallows buying new skills while not meditating
	public var disallowBuySkill : bool;
	//disallows equipping/unequipping/swapping skills while not meditating
	public var disallowEquipSkill : bool;
	//disallows equipping/unequipping mutagens while not meditating
	public var disallowEquipMutagen : bool;
	
	//time in seconds to create alchemy item
	public var timeToCreateItemSec : int;
	//time in seconds to repair an item
	public var timeToRepairItemSec : int;
	//time in seconds to upgrade an item
	public var timeToUpgradeItemSec : int;
	//time in seconds to buy skill
	public var timeToBuySkillSec : int;
	//time in seconds to equip skill (unequip/swap takes no time)
	public var timeToEquipSkillSec : int;
	//time in seconds to equip mutagen (unequipping takes no time)
	public var timeToEquipMutagenSec : int;

	//max oil charges
	public var maxOilCharges : int;
	
	//use one common base for all item levels when refilling
	public var oneBaseForRefill : bool;
	public var bombsRefillBase : name;
	public var oilsRefillBase : name;
	public var mutagensRefillBase : name;
	public var potionsRefillBase : name;
	//require full set of ingredients when refilling
	public var fullRecipeForRefill : bool;
	
	//configs
	public function Init()
	{
		UpdateUserSettings();
	}
	
	public function UpdateUserSettings()
	{
		allowCampFire = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepAllowCampFire');
		allowFireSource = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepAllowFireSource');
		allowLightSource = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepAllowLightSource');
		disallowInterior = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepDisallowInterior');
		disallowSettlement = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepDisallowSettlement');
		disallowNPCs = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepDisallowNPCs');
		npcDistance = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepNpcDistance'));
		allowCampFireInInterior = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepAllowCampFireInInterior');
		timberAmount = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepTimberAmount'));
		hardTimberAmount = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepHardTimberAmount'));
		disallowCampFire = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMeditation', 'prepDisallowCampFire');
		disallowAlchemy = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowAlchemy');
		disallowRepair = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowRepair');
		disallowUpgrade = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowUpgrade');
		disallowBuySkill = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowBuySkill');
		disallowEquipSkill = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowEquipSkill');
		disallowEquipMutagen = theGame.GetInGameConfigWrapper().GetVarValue('preparationsActions', 'prepDisallowEquipMutagen');
		timeToCreateItemSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToCreateItemMins'));
		timeToRepairItemSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToRepairItemMins'));
		timeToUpgradeItemSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToUpgradeItemMins'));
		timeToBuySkillSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToBuySkillMins'));
		timeToEquipSkillSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToEquipSkillMins'));
		timeToEquipMutagenSec = 60 * StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsTime', 'prepTimeToEquipMutagenMins'));
		maxOilCharges = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'prepMaxOilCharges'));
		oneBaseForRefill = theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'prepOneBaseForRefill');
		bombsRefillBase = GetBombsRefillBase();
		oilsRefillBase = GetOilsRefillBase();
		mutagensRefillBase = GetMutagensRefillBase();
		potionsRefillBase = GetPotionsRefillBase();
		fullRecipeForRefill =  theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'prepFullRecipeForRefill');
	}
	
	public function GetBombsRefillBase() : name
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'Virtual_prepBombsRefillBase'));
		switch( cfgVal )
		{
			case 0:
				return 'Saltpetre';
			case 1:
				return 'Stammelfords dust';
			case 2:
				return 'Alchemists powder';
		}
		return 'Saltpetre';
	}
	
	public function GetOilsRefillBase() : name
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'Virtual_prepOilsRefillBase'));
		switch( cfgVal )
		{
			case 0:
				return 'Dog tallow';
			case 1:
				return 'Bear fat';
			case 2:
				return 'Alchemical paste';
		}
		return 'Dog tallow';
	}

	public function GetMutagensRefillBase() : name
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'Virtual_prepMutagensRefillBase'));
		switch( cfgVal )
		{
			case 0:
				return 'Dwarven spirit';
			case 1:
				return 'Alcohest';
			case 2:
				return 'White Gull 1';
		}
		return 'Dwarven spirit';
	}

	public function GetPotionsRefillBase() : name
	{
		var cfgVal : int;
		cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('preparationsMisc', 'Virtual_prepPotionsRefillBase'));
		switch( cfgVal )
		{
			case 0:
				return 'Dwarven spirit';
			case 1:
				return 'Alcohest';
			case 2:
				return 'White Gull 1';
		}
		return 'Dwarven spirit';
	}
}

function GetPreparationsConfig() : CModPreparationsConfig
{
	return GetWitcherPlayer().prepConfig;
}
//---=== modPreparations ===---