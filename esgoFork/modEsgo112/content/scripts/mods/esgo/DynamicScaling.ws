/*
Copyright © CD Projekt RED 2015
*/

class DynamicScaling
{	
	public var TierOneLowestLevel, TierOneHighestLevel : int;
	public var TierTwoLowestLevel, TierTwoHighestLevel : int;
	public var TierThreeLowestLevel, TierThreeHighestLevel : int;
	public var TierFourLowestLevel, TierFourHighestLevel : int;
	public var TierFiveLowestLevel : int;
	
	public var TierOneMinimumAdded, TierOneMaximumAdded : int;
	public var TierTwoMinimumAdded, TierTwoMaximumAdded : int;
	public var TierThreeMinimumAdded, TierThreeMaximumAdded : int;
	public var TierFourMinimumAdded, TierFourMaximumAdded : int;
	public var TierFiveMinimumAdded, TierFiveMaximumAdded : int;

	public var TierOneGroupMinimumAdded, TierOneGroupMaximumAdded : int;
	public var TierTwoGroupMinimumAdded, TierTwoGroupMaximumAdded : int;
	public var TierThreeGroupMinimumAdded, TierThreeGroupMaximumAdded : int;
	public var TierFourGroupMinimumAdded, TierFourGroupMaximumAdded : int;
	public var TierFiveGroupMinimumAdded, TierFiveGroupMaximumAdded : int;
	
	public var TierOneHumanMin, TierOneHumanMax : int;
	public var TierTwoHumanMin, TierTwoHumanMax : int;
	public var TierThreeHumanMin, TierThreeHumanMax : int;
	public var TierFourHumanMin, TierFourHumanMax : int;
	public var TierFiveHumanMin, TierFiveHumanMax : int;
	
	public var MaximumLevelCap : int;
		
	// ---- General Begin ---- //
	
	public function DurabilityDamage() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'DDamage');
	}

	public function ShowMonsterLevel() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'MonsLVL');
	}
	
	public function Scale() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'Scale');
	}
	
	public function LevelRequirement() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'LVLReq');
	}
	
	public function LevelDifference() : int
	{
		return StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'LVLUse'));
	}
	
	public function AutoRefill() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'ARef');
	}

	public function BestiaryFix() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'BFix');
	}
	
	public function ScalingCheck() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'SCMode');
	}

	public function GMaxLevel() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLMX', 'MaxLVLP') );
	}	
	
	public function LevelBonuses() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLB', 'LVLB');
	}	
		
	public function SkillPointsGained() : int
	{
		return StringToInt (theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLB', 'SPG'));
	}	
	
	// ---- General End ---- //

	// ---- Experience Begin ---- //
	
	public function QuestXPScaling() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionE', 'QXPScaling');
	}
	
	public function XPScalingCheck() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionE', 'XPScaling');
	}
	
	public function ExperienceModifier() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionE', 'XPMult') );
	}	

	public function QuestXPMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionE', 'QXPMult') );
	}	
	
	public function GXPMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionE', 'GXPMult') );
	}	
	
	// ---- Experience End ---- //

	// ---- Health Begin ---- //
	
	public function SetNormalHealthMultHuman() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionH', 'HumanHP') );
	}
	
	public function SetNormalHealthMultMonster() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionH', 'MonsterHP') );
	}
	
	public function SetGroupHealthMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionH', 'GMonsterHP') );
	}

	public function SetMonsterHuntHealthMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionH', 'CMonsterHP') );
	}
		
	public function SetBossHealthMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionH', 'BossHP') );
	}
	
	// ---- Health End ---- //
	
	// ---- Damage Begin ---- //
	
	public function PlayerDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'PDam') );
	}
	
	public function PlayerDamageCross() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'PDamC') );
	}
	
	public function PlayerDamageSign() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'PDamS') );
	}
	
	public function PlayerDamageBomb() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'PDamB') );
	}

	public function PlayerDOTDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'PDOT') );
	}

	public function EnemyDOTDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'EDOT') );
	}
	
	public function HumanDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'HumDam') );
	}
	
	public function MonsterDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'MonDam') );
	}

	public function BossDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'BDam') );
	}	
	
	public function ContractDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionD', 'CMonDam') );
	}	
	
	// ---- Damage End ---- //
	
	// ---- Combat Start ---- //
	
	public function LockOn() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'Lockon');
	}
	
	public function CLockOn() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'Lockon');
	}
	
	public function BLockOn() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'Lockon');
	}
	
	public function LockOnMode() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'LockonM');
	}
	
	public function CombatState() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'Combatstate');
	}
	
	public function SpeedCap() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASC');
	}

	public function SkillDependant() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASSD');
	}
	
	public function StamRed() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASDPS') );
	}
	
	public function HPRed() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASDPH') );
	}
	
	public function FAI() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASFA') );
	}
		
	public function HAI() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASHA') );
	}
		
	public function DAI() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASDR') );
	}
		
	public function FAIN() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASFAN') );
	}
		
	public function HAIN() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASHAN') );
	}
		
	public function DAIN() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASDRN') );
	}

	public function APIF() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASAPF') );
	}
		
	public function APIH() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASAPH') );
	}
			
	public function HeavyParryAllowed() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'PCheck');
	}
				
	public function HeavyParryStagger() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'PCheckS');
	}
					
	public function ParryArrow() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'PCheckA');
	}
					
	public function CounterArrow() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CCheckA');
	}
	
	public function HeavyCounterAllowed() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CCheck');
	}

	public function CounterADRGainAllowed() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CADRG');
	}

	public function CounterADRGainAmount() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CADRGA') );
	}

	public function BleedDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'BleedDam') );
	}

	public function StaminaDamage() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'StamDam') );
	}

	public function BleedDuration() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'BleedDur') );
	}
	
	public function DisarmShield() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'DisarmSH');
	}
	
	public function FFNoStagger() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'FFNS');
	}
	
	public function FFLevel() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'FFL') );
	}
	
	public function HCT() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CTH') );
	}
		
	public function HHCT() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CTHH') );
	}
		
	public function SHHCT() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CTHSH') );
	}

	public function MCT() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CTM') );
	}
		
	public function HMCT() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'CTMH') );
	}
			
	public function RSActive() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSAct');
	}
				
	public function RSFinishVulnerability() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSFV');
	}
				
	public function RSAutomaticFinisher() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSAF');
	}

	public function Dism() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'Dism') );
	}	
	
	public function FinishChance() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'Finish') );
	}	
	
	public function FADRGain() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSAGF') );
	}	
	
	public function DADRGain() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSAGD') );
	}	
	
	public function CombatADRDeg() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'CADRDeg');
	}	
	
	public function MaxFocus() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRP') );
	}	
	
	public function FocusGainHits() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRGenH') );
	}	
	
	public function FocusGainRanged() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRGenR') );
	}	
	
	public function FocusGainBombs() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRGenB') );
	}	
	
	public function FocusGainSigns() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRGenS') );
	}	
	
	public function FocusLossHits() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegH') );
	}	
	
	public function FocusLossTime() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDeg') );
	}	
	
	public function KnockAT() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'KAT') );
	}	
	
	public function KnockST() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'KST') );
	}	
	
	public function KnockHT() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'KHT') );
	}	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	public function WhirlReq() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCWh', 'WhSR');
	}	
	
	public function WhirlCostAdr() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCWh', 'WhAU') );
	}	
	
	public function WhirlCostStam() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCWh', 'WhSU') );
	}	
	
	public function WhirlDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCWh', 'WhDM') );
	}	
	
	public function WhirlRangeExt() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCWh', 'WhER');
	}	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	public function RendReq() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReSR');
	}	
	
	public function RendCostStam() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReSU') );
	}	
	
	public function RendCostAdr() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReAU') );
	}	

	public function RendDamage() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReDM') );
	}	
	
	public function RendDamageAdr() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReDPA') );
	}	

	public function RendDamageStam() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReDPS') );
	}

	public function RendRangeExt() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionRend', 'ReER');
	}

	public function HeavyAttackBlockBreak() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCR', 'RSHABB');
	}

	// ---- Combat End ---- //

	// ---- Levels Start ---- //
	
	public function Pushover() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSPE');
	}

	public function HDCM() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSHDC');
	}	
	
	// ---- Levels End ---- //
	
	// ---- Enemies Start ---- //
	
	public function Aggression() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'EnAgg') );
	}	

	public function GuardLowerCh() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'LGCh') );
	}	
	
	public function GuardRaiseCh() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'RGCh') );
	}	
	
	public function CounterCh() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'CCh') );
	}	
	
	public function CounterMultPH() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'CChPH') );
	}	
	
	public function GuardMultPH() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'GChPH') );
	}	
		
	public function GuardHitNumberMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'HGCh') );
	}	
	
	public function CounterHitNumberMult() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'HCCh') );
	}

	// ---- Enemies End ---- //
	
	// ---- MODIFY FROM HERE ONWARD ---- //
	
	public function XPScalingModifier() : float
	{
		var currlvl : int;
		var mod, scalingvalue : float;

		currlvl = thePlayer.GetLevel();
		
		//You can set the scaling modifier here. The algorhytm is the following: 1.0 - (yourlevel * scaling value)
		//For reference, let's say you are level 40, the formula goes 1.0 - (40 * 0,0115) which yields 0.54 ~ This will be the multiplier for the original experience.
		//Let's say the original experience is 100 (so without this you get 100 xp for slaying a monster) which gets multiplied by 0.54. This yields an XP gain of 54 instead of the normal 100.
		//This stops your from leveling up insanely fast as you gain levels, because the enemies also get higher and yield a lot more experience.
		scalingvalue = 0.0115;

		mod = 1.0 - (currlvl * scalingvalue);
		
		return mod;
	}
	
	public function SetValues()
	{
	
		//The level caps for the different level tiers are set here.
		//You fall into different tiers based on what level your character is,
		//so a level 15 Geralt will fall into tier two.
		TierOneHighestLevel  = 10;
		TierTwoLowestLevel   = 10;		TierTwoHighestLevel   = 20;
		TierThreeLowestLevel = 20;		TierThreeHighestLevel = 30;
		TierFourLowestLevel  = 30;		TierFourHighestLevel  = 40;
		TierFiveLowestLevel  = 40;		MaximumLevelCap = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLMX', 'MaxLVL') );

		TierOneMinimumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T1M1') );		TierOneMaximumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T1M2') );
		TierTwoMinimumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T2M1') );		TierTwoMaximumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T2M2') );
		TierThreeMinimumAdded = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T3M1') );		TierThreeMaximumAdded = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T3M2') );
		TierFourMinimumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T4M1') );		TierFourMaximumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T4M2') );
		TierFiveMinimumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T5M1') );		TierFiveMaximumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLM', 'T5M2') );

		TierOneGroupMinimumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T1GM1') );		TierOneGroupMaximumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T1GM2') );
		TierTwoGroupMinimumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T2GM1') );		TierTwoGroupMaximumAdded   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T2GM2') );
		TierThreeGroupMinimumAdded = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T3GM1') );		TierThreeGroupMaximumAdded = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T3GM2') );
		TierFourGroupMinimumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T4GM1') );		TierFourGroupMaximumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T4GM2') );
		TierFiveGroupMinimumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T5GM1') );		TierFiveGroupMaximumAdded  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLGM', 'T5GM2') );

		TierOneHumanMin   =	StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T1H1') );					TierOneHumanMax   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T1H2') );
		TierTwoHumanMin	  =	StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T2H1') );					TierTwoHumanMax   = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T2H2') );
		TierThreeHumanMin =	StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T3H1') );					TierThreeHumanMax = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T3H2') );
		TierFourHumanMin  =	StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T4H1') );					TierFourHumanMax  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T4H2') );
		TierFiveHumanMin  =	StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T5H1') );					TierFiveHumanMax  = StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLH', 'T5H2') );
		
	}

}