/****************************************************************************/
/** Copyright © CD Projekt RED 2015
/** Author : Reaperrz
/****************************************************************************/
/** Included explanation on how the mod works. If you do not know
/** *ANY* programming basics, then it is advised to look them up.
/** Basics include things such as what is a variable, an array, a class,
/** a function and some of the basics of Object Oriented Programming (OOP).
/** Make sure to read up on these to understand what is written, although
/** it is not strictly required if you can figure these thigns out yourself.
/****************************************************************************/

// class which handles the reading of all the in-game options
class ESGOOptionHandler extends CNewNPC
{	
	// ---- General Begin ---- //
	
	public function DurabilityDamage() : int
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionGen', 'DDamage') );
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
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'CLockon');
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
	
	public function AutoSheathe() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCM', 'ASheathe');
	}
	
	public function SpeedCap() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASC');
	}	
	
	public function SpeedCapLow() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASCL');
	}

	public function SkillDependant() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'ASSD');
	}

	public function StamCostFast() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'FASC'));
	}

	public function StamCostHeavy() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'SASC'));
	}

	public function StamCostEvade() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'EVSC'));
	}
	
	public function StamRegenDelay() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'RDSC'));
	}
	
	public function StamRegenDelayHeavy() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'RDSCH'));
	}
	
	public function StamRegenDelayDode() : float
	{
		return StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'RDSCD'));
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
		
	public function LightPerc() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'LightIn') );
	}
		
	public function HeavyPerc() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCW', 'HeavyDe') );
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

	public function StaminaDamageDuration() : float
	{
		return StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCP', 'StamDur') );
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
	
	public function FocusLossLightHits() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegH') );
	}	
	
	public function FocusLossHeavyHits() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegHH') );
	}	
	
	public function FocusLossSuperHeavyHits() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegHSH') );
	}	
	
	public function FocusLossTime() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDeg') );
	}	
	
	public function FocusLossTimeCombat() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegC') );
	}	
	
	public function FocusLossTimeMV() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegMV') );
	}	
		
	public function FocusLossTimeMVC() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCA', 'ADRDegMVC') );
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

	///////////////////////////////////////////////////////////////////////////////////////////////////
	
	public function SignOvActive() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionSO', 'SOT');
	}	

	public function StaminaCostN() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionSO', 'SCost') );
	}

	public function StaminaCostS() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionSO', 'SCostS') );
	}

	public function IntensityPenalty() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionSO', 'SPen') );
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
	
	public function EnemyDodgeNegateDamage() : bool
	{
		return theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'EDND');
	}
	
	public function EnemyDodgeDamageNegation() : float
	{
		return StringToFloat( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionCE', 'EDDN') );
	}

	// ---- Enemies End ---- //
	
}

// class which handles everything that is associated with the crime system in the mod
class ESGOCrimeSystemHandler extends ESGOOptionHandler
{
/*
	// function which signals murder to nearby guards and makes them hostile towards you and attack you
	public final function SignalMurder( Guard : CNewNPC )
	{
		// WARNING: This part (and mostly every other part of the mod and the game too) is based off of Object Oriented Programming (OOP)
		// if you do not know the basics, look up the basics of object oriented programming so you will be able to understand everything that is written here.
	
		// an array of actors, in which NPCs in a 30 foot radius are individually stored
		var entity : array <CActor>;
		var i : int;
		
		// here we fill the array with NPCs residing in a 30 foot radius from the player
		entity = Guard.GetNPCsAndPlayersInRange(30.f);
		// here we use a loop to go through each entity in the array of actors, with i being the indicator of which actor is currently selected
		// as in the first, second, third, etc and is increased in increments of 1 until it reaches the last entity in the array
		// (if there are 5 NPCs in the area, the array will have a length of 5 and i will stop when it reaches 4, because we started it from 0)
		for(i=0; i<entity.Size(); i+=1)
			// if the entity (which we converted from the CActor object into a CNewNPC object) is a guard
			if( ((CNewNPC)entity[i]).GetNPCType() == ENGT_Guard )
				// set the entity's attitude to hostile, so it attacks us
				entity[i].SetAttitude( thePlayer, AIA_Hostile );
	}
	
	// function to force every NPC to be killable and also attackable
	public final function ForceKillable( NPC : CNewNPC )
	{
		// if the NPC is a commoner
		if( NPC.GetNPCType() == ENGT_Commoner )
			// set its attitude to neutral so it can be attacked
			NPC.SetAttitude( thePlayer, AIA_Neutral );
		// force the NPC (converted into a CActor object from a CNewNPC object) to be vulnerable and thus, killable
		((CActor)NPC).ForceVulnerable();
	}
	
	// function to initialize the death event of an NPC, be it a commoner or a guard
	public final function InitDeathEvent( NPC : CNewNPC )
	{
		// if the NPC is a common or a guard
		if( NPC.GetNPCType() == ENGT_Commoner || NPC.GetNPCType() == ENGT_Guard ) 
		{
			// turn on the ragdoll of the NPC, because most NPCs don't have as flexible models as regular enemies
			((CActor)NPC).TurnOnRagdoll();
			// call the function which signals the murder of an enemy to notify other nearby NPCs
			SignalMurder(NPC);
		}
	}
*/
}

class ESGOExperienceHandler extends ESGOOptionHandler
{
	private final function XPScalingModifier() : float
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
	
	public final function AwardKnowledge( NPC : CNewNPC, damageAction : W3DamageAction )
	{
		var ciriEntity  : W3ReplacerCiri;
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		
		if( BestiaryFix() )
			if ( !NPC.IsHuman() && VecDistance(thePlayer.GetWorldPosition(), NPC.GetWorldPosition()) <= 20 && !ciriEntity && !NPC.HasTag('NoBestiaryEntry') ) AddBestiaryKnowledge();	
		else 
			if ( !NPC.IsHuman() && damageAction.attacker == thePlayer && !ciriEntity && !NPC.HasTag('NoBestiaryEntry') ) AddBestiaryKnowledge();
	}
	
	public final function AwardExperience( NPC : CNewNPC, bonusExp : SAbilityAttributeValue )
	{
		var XP : int;
		
		XP = NPC.CalculateExperiencePoints();
		
		if ( XPScalingCheck() )
			XP = RoundMath( XP * (1 + CalculateAttributeValue(bonusExp) ) * XPScalingModifier() * ExperienceModifier() );
		else
			XP = RoundMath( XP * (1 + CalculateAttributeValue(bonusExp) ) * ExperienceModifier() );
		
		GetWitcherPlayer().AddPoints(EExperiencePoint, RoundF( XP * theGame.expGlobalMod_kills ), false );
	}

	public final function AwardQuestExperience( rewards : SReward, globalXPMod : float,  expModifier : float )
	{
		var expMod : float;
		var lvlDiff : int;
		lvlDiff = rewards.level - thePlayer.GetLevel();

		if(FactsQuerySum("NewGamePlus") > 0)
			lvlDiff += theGame.params.GetNewGamePlusLevel();
	
		if ( lvlDiff <= -theGame.params.LEVEL_DIFF_HIGH && QuestXPScaling() )
			expMod = 2.f; 		
		else 
			if ( lvlDiff <= -theGame.params.LEVEL_DIFF_HIGH && !QuestXPScaling() )
				expMod = 1.f;
			
		if(expModifier > 0.f)
			GetWitcherPlayer().AddPoints( EExperiencePoint, RoundF( rewards.experience * globalXPMod * expModifier * expMod * QuestXPMult()), true);
		else if ( expModifier == 0.f && rewards.experience > 0 )
		{
			if ( QuestXPScaling() )
				expMod = 1.5f;
			else expMod = 1.f;
			GetWitcherPlayer().AddPoints( EExperiencePoint, RoundF( rewards.experience * globalXPMod * expModifier * expMod * QuestXPMult()), true);
		}
	}	
	
	public final function DisplayScaledLevel( NPC : CNewNPC, Level : int, out strLevel : string ) : string
	{
		if( NPC.GetAttitude( thePlayer ) != AIA_Hostile || NPC.GetNPCType() == ENGT_Commoner )
			{
				if( ( NPC.GetAttitudeGroup() != 'npc_charmed' ) )
				{
					strLevel = "";
					return "none";
				}
			}
			else
			{
				strLevel = "<font color=\"#66FF66\">" + Level + "</font>"; // #B green
				return "normalLevel";
			}
		return "none";
	}
}

class ESGOScalingHandler extends ESGOOptionHandler
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
	
	private final function ReadValues()
	{
	
		//The level caps for the different level tiers are set here.
		//You fall into different tiers based on what level your character is,
		//so a level 15 Geralt will fall into tier two.
										TierOneHighestLevel   = 10;
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

	public final function GetIsContractTypeMonster( Enemy : CNewNPC ) : bool
	{
		if ( Enemy.HasAbility('mh302_Leshy') || Enemy.HasAbility('mh202_nekker') || Enemy.HasAbility('mh106_HAG') || Enemy.HasAbility('mh306_dao') || Enemy.HasAbility('qMH208_Noonwraith') || Enemy.HasAbility('mh305_doppler') || Enemy.HasAbility('mh305_doppler_geralt') || Enemy.HasAbility('mh301_Gryphon') || Enemy.HasAbility('mh307_Minion') || Enemy.HasAbility('mh207_wraith') || Enemy.HasAbility('mh207_wraith_boss') || Enemy.HasAbility('qMH101_cockatrice') || Enemy.HasAbility('mon_wraith_mh') || Enemy.HasAbility('mon_nightwraith_mh') || Enemy.HasAbility('mon_noonwraith_mh') || Enemy.HasAbility('mon_wild_hunt_minionMH') || Enemy.HasAbility('mon_forktail_mh') || Enemy.HasAbility('mon_fogling_mh') || Enemy.HasAbility('q302_mh104') || Enemy.HasAbility('qmh303_suc') || Enemy.HasAbility('qmh210_lamia') || Enemy.HasAbility('qmh208_forktail') || Enemy.HasAbility('qmh108_fogling') || Enemy.HasAbility('qmh304_ekima') || Enemy.HasAbility('qmh206_bies') )
			return true;
		else return false;
	}
	
	public final function GetIsBoss( Enemy : CNewNPC ) : bool
	{
		if ( Enemy.HasAbility('WildHunt_Eredin') || Enemy.HasAbility('WildHunt_Imlerith') || Enemy.HasAbility('WildHunt_Caranthir') || Enemy.HasAbility('WildHunt_Caranthir_NGPlus') || Enemy.HasAbility('WildHunt_Imlerith_NGPlus') || Enemy.HasAbility('WildHunt_Eredin_NGPlus') || Enemy.HasAbility('mon_witch1') || Enemy.HasAbility('mon_witch2') || Enemy.HasAbility('mon_witch3') || Enemy.HasAbility('q104_whboss') || Enemy.HasAbility('q202_IceGiantDOOM') || Enemy.HasAbility('mon_nightwraith_iris') || Enemy.HasAbility('mon_toad_base') || Enemy.HasAbility('q604_caretaker') || Enemy.HasAbility('mon_djinn') )
			return true;
		else return false;
	}
	
	public final function GetIsGroupTypeMonster( Enemy : CNewNPC ) : bool
	{
		if ( Enemy.HasAbility('mon_boar_base') || Enemy.HasAbility('mon_black_spider_base') || Enemy.GetSfxTag() == 'sfx_alghoul' || Enemy.GetSfxTag() == 'sfx_endriaga' || Enemy.GetSfxTag() == 'sfx_ghoul' || Enemy.GetSfxTag() == 'sfx_wraith' || Enemy.GetSfxTag() == 'sfx_wild_dog' || Enemy.GetSfxTag() == 'sfx_drowner' || Enemy.GetSfxTag() == 'sfx_fogling' || Enemy.HasAbility('mon_erynia') || Enemy.GetSfxTag() == 'sfx_harpy'  || Enemy.GetSfxTag() == 'sfx_nekker' ||  Enemy.GetSfxTag() == 'sfx_siren' || Enemy.GetSfxTag() == 'sfx_wildhunt_minion' || Enemy.HasAbility('mon_rotfiend') || Enemy.HasAbility('mon_rotfiend_large') )
			return true;
		else return false;
	}
	
	public final function CalculateLevel ( NPC : CNewNPC ) : int
	{
		var level_ : int;
		var ciriEntity  : W3ReplacerCiri;
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		
		ReadValues();
		
		if ( Scale() ) 
		{
			if ( !ScalingCheck() )
			{
				if ( ( GetWitcherPlayer().GetLevel() >= 1 ) && ( GetWitcherPlayer().GetLevel() < TierOneHighestLevel ) && ( MaximumLevelCap > TierOneLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierOneGroupMinimumAdded, TierOneGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierOneHumanMin, TierOneHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}			
					else 
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierOneMaximumAdded, TierOneMinimumAdded );
					}
				}
				else if ( ( GetWitcherPlayer().GetLevel() >= TierTwoLowestLevel ) && ( GetWitcherPlayer().GetLevel() < TierTwoHighestLevel ) && ( MaximumLevelCap > TierTwoLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierTwoGroupMinimumAdded, TierTwoGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierTwoHumanMin, TierTwoHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierTwoMaximumAdded, TierTwoMinimumAdded );
					}
				}
				else if ( ( GetWitcherPlayer().GetLevel() >= TierThreeLowestLevel ) && ( GetWitcherPlayer().GetLevel() < TierThreeHighestLevel ) && ( MaximumLevelCap > TierThreeLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierThreeGroupMinimumAdded, TierThreeGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierThreeHumanMin, TierThreeHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierThreeMaximumAdded, TierThreeMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= TierFourLowestLevel ) && ( GetWitcherPlayer().GetLevel() < TierFourHighestLevel ) && ( MaximumLevelCap > TierFourLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFourGroupMinimumAdded, TierFourGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFourHumanMin, TierFourHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFourMaximumAdded, TierFourMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= TierFiveLowestLevel ) && ( GetWitcherPlayer().GetLevel() < MaximumLevelCap ) && ( MaximumLevelCap > TierFiveLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFiveGroupMinimumAdded, TierFiveGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFiveHumanMin, TierFiveHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFiveMaximumAdded, TierFiveMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= MaximumLevelCap ) )
				{	
					if ( GetIsGroupTypeMonster(NPC) )
					{
						level_ = MaximumLevelCap + RandRange( TierFiveGroupMinimumAdded, TierFiveGroupMaximumAdded );
					}
					else if ( NPC.GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( NPC.IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( TierFiveHumanMin, TierFiveHumanMax );
					}
					else if ( NPC.HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( NPC.HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = MaximumLevelCap + RandRange( TierFiveMaximumAdded, TierFiveMinimumAdded );
					}
				}
			}
			else if ( ScalingCheck() )
			{
				if ( NPC.GetLevel()-5 < GetWitcherPlayer().GetLevel() && NPC.GetLevel()+5 > GetWitcherPlayer().GetLevel() ) // normal enemy
					level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSN1') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSN2') ) );
				else // if not normal enemy
				{
					if ( NPC.GetLevel()-5 >= GetWitcherPlayer().GetLevel() ) // if harder or hardcore enemy 
					{
						if ( NPC.GetLevel()-11 > GetWitcherPlayer().GetLevel() ) // if hardcore enemy
						{
							if ( HDCM() ) // if regular hardcore mode is on
								level_ = level;
							else // if regular hardcore mode is off
								level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH4') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH3') ) );
						}
						else  // if harder enemy
							level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH2') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH1') ) );
					} // end harder or hardcore enemy
					else // if weaker or pushover enemy
					if ( NPC.GetLevel()+5 <= GetWitcherPlayer().GetLevel() )
					{
						if ( NPC.GetLevel()+11 <= GetWitcherPlayer().GetLevel() && Pushover() ) // if pushover enemy and pushover category is on
							level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL4') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL3') ) );
						else // if weaker enemy or (pushover and pushover category is off)
							level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL2') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL1') ) );				
					} // end weaker or pushover enemy
				}	
				
				if ( NPC.GetSfxTag() == 'sfx_rat' )
					level_ = 1;
				else
				if ( NPC.HasAbility( 'fistfight_minigame' ) )
					level_ = 1;
				
				if ( level_ > MaximumLevelCap || NPC.level > MaximumLevelCap )
					level_ = MaximumLevelCap + RandRange(-1, 2);
			}
		}
		else level_ = NPC.level;
		
		if ( NPC.GetSfxTag() == 'sfx_rat' )
			level_ = 1;
		
		if ( ciriEntity )
			level_ = NPC.level;	

		if ( level_ <= 0 )
			level_ = 1;
		
		return level_;
	}	
	
	public final function GenerateLevel( NPC : CNewNPC, Level : int )
	{
		var ciriEntity : W3ReplacerCiri;
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		
		if( Level + (int)CalculateAttributeValue( NPC.GetAttributeValue('level',,true)) < 2 || NPC.HasAbility('NPCDoNotGainBoost') ) return;
		
		if ( NPC.HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) NPC.RemoveAbility(theGame.params.ENEMY_BONUS_DEADLY); else
		if ( NPC.HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) NPC.RemoveAbility(theGame.params.ENEMY_BONUS_HIGH); else
		if ( NPC.HasAbility(theGame.params.ENEMY_BONUS_LOW) ) NPC.RemoveAbility(theGame.params.ENEMY_BONUS_LOW); else
		if ( NPC.HasAbility(theGame.params.MONSTER_BONUS_DEADLY) ) NPC.RemoveAbility(theGame.params.MONSTER_BONUS_DEADLY); else
		if ( NPC.HasAbility(theGame.params.MONSTER_BONUS_HIGH) ) NPC.RemoveAbility(theGame.params.MONSTER_BONUS_HIGH); else
		if ( NPC.HasAbility(theGame.params.MONSTER_BONUS_LOW) ) NPC.RemoveAbility(theGame.params.MONSTER_BONUS_LOW);
		
		if ( NPC.IsHuman() && NPC.GetStat( BCS_Essence, true ) < 0 )
		{
			if ( NPC.GetNPCType() != ENGT_Guard )
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level);
			} 
			else
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level);
			}
			
			if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !NPC.HasAbility('CiriHardcoreDebuffHuman') ) NPC.AddAbility('CiriHardcoreDebuffHuman');
		} 
		else
		{
			if ( NPC.GetStat( BCS_Vitality, true ) > 0 && !NPC.HasTag('mon_bear') )
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL_GROUP) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL_GROUP, Level);
			}
			else
			if ( NPC.GetStat( BCS_Vitality, true ) > 0 && NPC.HasAbility('mon_bear') )
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level);				
			}
			else
			{
				if ( (int)CalculateAttributeValue( NPC.GetAttributeValue('armor') ) > 0 )
				{
					if ( NPC.GetIsMonsterTypeGroup() )
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED, Level);
					}
					else
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED, Level);
					}
				}
				else
				{
					if ( NPC.GetIsMonsterTypeGroup() )
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP, Level);
					}
					else
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL, Level);
					}
				}
				
				if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !NPC.HasAbility('CiriHardcoreDebuffMonster') ) NPC.AddAbility('CiriHardcoreDebuffMonster');
			}	 
		}
	}
	
	public final function GenerateOriginalLevel( NPC : CNewNPC, Level : int )
	{
		var lvlDiff : int;
		
		var ciriEntity : W3ReplacerCiri;
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		
		if ( NPC.IsHuman() && NPC.GetStat( BCS_Essence, true ) < 0 )
		{
			if ( NPC.GetNPCType() != ENGT_Guard )
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level-1);
			} 
			else
			{
				if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, 1 + GetWitcherPlayer().GetLevel() + RandRange( 11, 13 ) );
			}
			
			if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !NPC.HasAbility('CiriHardcoreDebuffHuman') ) NPC.AddAbility('CiriHardcoreDebuffHuman');
				
			if ( !ciriEntity ) 
			{
				if ( LevelBonuses() )
				{
					lvlDiff = (int)CalculateAttributeValue(NPC.GetAttributeValue('level',,true)) - thePlayer.GetLevel();
					if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) { NPC.AddAbility(theGame.params.ENEMY_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
					else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) NPC.AddAbility(theGame.params.ENEMY_BONUS_HIGH, true);}
					else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
					else 					  { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_LOW) ) NPC.AddAbility(theGame.params.ENEMY_BONUS_LOW, true); }	
				}	
			}	 
		} 
		else
		{
			if ( NPC.GetStat( BCS_Vitality, true ) > 0 )
			{
				if ( !ciriEntity ) 
				{
					if ( LevelBonuses() )
					{					
						lvlDiff = (int)CalculateAttributeValue(NPC.GetAttributeValue('level',,true)) - thePlayer.GetLevel();
						if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) { NPC.AddAbility(theGame.params.ENEMY_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
						else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) NPC.AddAbility(theGame.params.ENEMY_BONUS_HIGH, true);}
						else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
						else 					  { if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_LOW) ) NPC.AddAbility(theGame.params.ENEMY_BONUS_LOW, true); }		
					}
					if ( !NPC.HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level-1);
				}
			} 
			else
			{
				if ( (int)CalculateAttributeValue( NPC.GetAttributeValue('armor') ) > 0 )
				{
					if ( NPC.GetIsMonsterTypeGroup() )
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED, Level-1);
					} 
					else
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED, Level-1);
					}
				}
				else
				{
					if ( NPC.GetIsMonsterTypeGroup() )
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP, Level-1);
					} 
					else
					{
						if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL) ) NPC.AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL, Level-1);
					}
				}
				
				
				if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !NPC.HasAbility('CiriHardcoreDebuffMonster') ) NPC.AddAbility('CiriHardcoreDebuffMonster');
					
				if ( !ciriEntity ) 
				{
					if ( LevelBonuses() )
					{
						lvlDiff = (int)CalculateAttributeValue(NPC.GetAttributeValue('level',,true)) - thePlayer.GetLevel();
						if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_DEADLY) ) { NPC.AddAbility(theGame.params.MONSTER_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
						else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_HIGH) ) NPC.AddAbility(theGame.params.MONSTER_BONUS_HIGH, true); }
						else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
						else 					  { if ( !NPC.HasAbility(theGame.params.MONSTER_BONUS_LOW) ) NPC.AddAbility(theGame.params.MONSTER_BONUS_LOW, true); }		
					}
				}
			}	 
		}		
	}
	
	public final function ScalingModule( NPC : CNewNPC, Level : int )
	{
		if ( Scale() )
			GenerateLevel(NPC, Level);
		else
			GenerateOriginalLevel(NPC, Level);
	}
}

class ESGOEnemyHandler extends ESGOScalingHandler
{
	public final function AggressionModule( NPC : CNewNPC )
	{
		var maxstam : float;
		
		maxstam = NPC.abilityManager.GetStatMax(BCS_Stamina);

		switch( Aggression() )
		{
			case 0: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.25); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 1: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.50); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 2: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.75); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 3:
			break;
			case 4: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*1.25); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 5: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*1.5); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 6: NPC.abilityManager.SetStatPointMax(BCS_Stamina, maxstam*2); NPC.ForceSetStat(BCS_Stamina, NPC.abilityManager.GetStatMax(BCS_Stamina));
			break;
		}
	}
	
	public final function IsContractMonster( NPC : CActor ) : bool
	{
		if ( NPC.HasAbility('mh302_Leshy') || NPC.HasAbility('mh202_nekker') || NPC.HasAbility('mh106_HAG') || NPC.HasAbility('mh306_dao') || NPC.HasAbility('qMH208_Noonwraith') || NPC.HasAbility('mh305_doppler') || NPC.HasAbility('mh305_doppler_geralt') || NPC.HasAbility('mh301_Gryphon') || NPC.HasAbility('mh307_Minion') || NPC.HasAbility('mh207_wraith') || NPC.HasAbility('mh207_wraith_boss') || NPC.HasAbility('qMH101_cockatrice') || NPC.HasAbility('mon_wraith_mh') || NPC.HasAbility('mon_nightwraith_mh') || NPC.HasAbility('mon_noonwraith_mh') || NPC.HasAbility('mon_wild_hunt_minionMH') || NPC.HasAbility('mon_forktail_mh') || NPC.HasAbility('mon_fogling_mh') || NPC.HasAbility('q302_mh104') || NPC.HasAbility('qmh303_suc') || NPC.HasAbility('qmh210_lamia') || NPC.HasAbility('qmh208_forktail') || NPC.HasAbility('qmh108_fogling') || NPC.HasAbility('qmh304_ekima') || NPC.HasAbility('qmh206_bies') )
			return true;
		else return false;
	}
	
	public final function IsBoss( NPC : CActor ) : bool
	{
		if ( NPC.HasAbility('WildHunt_Eredin') || NPC.HasAbility('WildHunt_Imlerith') || NPC.HasAbility('WildHunt_Caranthir') || NPC.HasAbility('WildHunt_Caranthir_NGPlus') || NPC.HasAbility('WildHunt_Imlerith_NGPlus') || NPC.HasAbility('WildHunt_Eredin_NGPlus') || NPC.HasAbility('mon_witch1') || NPC.HasAbility('mon_witch2') || NPC.HasAbility('mon_witch3') || NPC.HasAbility('q104_whboss') || NPC.HasAbility('q202_IceGiantDOOM') || NPC.HasAbility('mon_nightwraith_iris') || NPC.HasAbility('mon_toad_base') || NPC.HasAbility('q604_caretaker') || NPC.HasAbility('mon_djinn') )
			return true;
		else return false;
	}
	
	public final function IsGroupMonster( NPC : CActor ) : bool
	{
		if ( NPC.HasAbility('mon_boar_base') || NPC.HasAbility('mon_black_spider_base') || ((CNewNPC)NPC).GetSfxTag() == 'sfx_alghoul' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_endriaga' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_ghoul' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_wraith' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_wild_dog' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_drowner' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_fogling' || NPC.HasAbility('mon_erynia') || ((CNewNPC)NPC).GetSfxTag() == 'sfx_harpy'  || ((CNewNPC)NPC).GetSfxTag() == 'sfx_nekker' ||  ((CNewNPC)NPC).GetSfxTag() == 'sfx_siren' || ((CNewNPC)NPC).GetSfxTag() == 'sfx_wildhunt_minion' || NPC.HasAbility('mon_rotfiend') || NPC.HasAbility('mon_rotfiend_large') )
			return true;
		else return false;
	}
	
	public final function SetSkillValues( Skill : CBTTaskPerformParry, out counterChance : float, out hitsToCounter : int )
	{
		counterChance = MaxF(0, 100*(CounterCh() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('counter_chance'))));
		hitsToCounter = (int)MaxF(0, CeilF(CounterHitNumberMult() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('hits_to_roll_counter'))));
		
		if ( hitsToCounter < 0 )
			hitsToCounter = 65536;
	}
	
	public final function SetAltSkillValues( Skill : CBTTaskGuardChange, out raiseGuardChance : int, out lowerGuardChance : int )
	{
		raiseGuardChance = (int)(100*(GuardRaiseCh() * CalculateAttributeValue(Skill.GetNPC().GetAttributeValue('raise_guard_chance'))));
		lowerGuardChance = (int)(100*(GuardLowerCh() * CalculateAttributeValue(Skill.GetNPC().GetAttributeValue('lower_guard_chance'))));
	}
	
	public final function SetAlt2SkillValues( Skill : CBTTaskHitReactionDecorator, out hitsToRaiseGuard : int, out raiseGuardChance : int, out hitsToCounter : int, out counterChance : int, out counterStaminaCost : float )
	{
		var raiseGuardMultiplier : int;
		var counterMultiplier : int;
		
		hitsToRaiseGuard = CeilF(GuardHitNumberMult()*(int)CalculateAttributeValue(Skill.GetActor().GetAttributeValue('hits_to_raise_guard')));
		raiseGuardChance = (int)MaxF(0, 100*(GuardRaiseCh() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('raise_guard_chance'))));
		raiseGuardMultiplier = (int)MaxF(0, 100*(GuardMultPH() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('raise_guard_chance_mult_per_hit'))));
		
		hitsToCounter = CeilF(CounterHitNumberMult()*(int)CalculateAttributeValue(Skill.GetActor().GetAttributeValue('hits_to_roll_counter')));
		counterChance = (int)MaxF(0, 100*(CounterCh() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('counter_chance'))));
		counterMultiplier = (int)MaxF(0, 100*(CounterMultPH() * CalculateAttributeValue(Skill.GetActor().GetAttributeValue('counter_chance_per_hit'))));
		
		counterStaminaCost = CalculateAttributeValue(Skill.GetNPC().GetAttributeValue( 'counter_stamina_cost' ));
		
		raiseGuardChance += Max( 0, Skill.GetNPC().GetHitCounter() - 1 ) * raiseGuardMultiplier;
		counterChance += Max( 0, Skill.GetNPC().GetHitCounter() - 1 ) * counterMultiplier;
		
		if ( hitsToRaiseGuard < 0 )
		{
			hitsToRaiseGuard = 65536;
		}		
	}
	
}

class ESGODamageHandler extends ESGOEnemyHandler
{
	public final function HealthModule( out damageData : W3DamageAction, actor : CActor )
	{
		var thisNPC	: CNewNPC;

		thisNPC = (CNewNPC)actor;
		
		if ( thisNPC.IsHuman() && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage /= SetNormalHealthMultHuman();
			damageData.processedDmg.essenceDamage /= SetNormalHealthMultHuman();
		}		
		else
		if ( GetIsGroupTypeMonster(thisNPC) && !GetIsBoss(thisNPC) && !GetIsContractTypeMonster(thisNPC) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage /= SetGroupHealthMult();
			damageData.processedDmg.essenceDamage /= SetGroupHealthMult();
		}		
		else
		if ( !GetIsGroupTypeMonster(thisNPC) && !GetIsBoss(thisNPC) && !GetIsContractTypeMonster(thisNPC) && !thisNPC.IsHuman() && !((CPlayer)damageData.victim) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage /= SetNormalHealthMultMonster();
			damageData.processedDmg.essenceDamage /= SetNormalHealthMultMonster();
		}
		else
		if ( GetIsContractTypeMonster(thisNPC) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage /= SetMonsterHuntHealthMult();
			damageData.processedDmg.essenceDamage /= SetMonsterHuntHealthMult();
		}	
		else
		if ( GetIsBoss(thisNPC) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage /= SetBossHealthMult();
			damageData.processedDmg.essenceDamage /= SetBossHealthMult();
		}
		else
		if ( thePlayer.IsCiri() ) {}
	}

	public final function DamageModule( out damageData : W3DamageAction, actor : CActor )
	{
		var actorAttacker : CActor;

		actorAttacker = (CActor)damageData.attacker;

		if( (CPlayer)actorAttacker && !((CPlayer)damageData.victim) && !damageData.IsDoTDamage() )
		{
			if( damageData.IsActionRanged() && (W3BoltProjectile)(damageData.causer) )
			{
				damageData.processedDmg.vitalityDamage *= PlayerDamageCross();
				damageData.processedDmg.essenceDamage *= PlayerDamageCross();		
			}
			else
			if( damageData.IsActionRanged() && (W3Petard)(damageData.causer) )
			{
				damageData.processedDmg.vitalityDamage *= PlayerDamageBomb();
				damageData.processedDmg.essenceDamage *= PlayerDamageBomb();		
			}
			else
			if( damageData.IsActionWitcherSign() && (W3SignProjectile)(damageData.causer) )
			{
				damageData.processedDmg.vitalityDamage *= PlayerDamageSign();
				damageData.processedDmg.essenceDamage *= PlayerDamageSign();					
			}
			else
			{
				damageData.processedDmg.vitalityDamage *= PlayerDamage();
				damageData.processedDmg.essenceDamage *= PlayerDamage();
			}
		}
		else		
		if( actorAttacker.IsHuman() && actorAttacker != thePlayer && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage *= HumanDamage();
			damageData.processedDmg.essenceDamage *= HumanDamage();
		}	
		else
		if( !actorAttacker.IsHuman() && actorAttacker != thePlayer && !IsBoss(actorAttacker) && !IsContractMonster(actorAttacker) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage *= MonsterDamage();
			damageData.processedDmg.essenceDamage *= MonsterDamage();
		}
		else
		if( IsBoss(actorAttacker) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage *= BossDamage();
			damageData.processedDmg.essenceDamage *= BossDamage();
		}
		else
		if( IsContractMonster(actorAttacker) && !damageData.IsDoTDamage() )
		{
			damageData.processedDmg.vitalityDamage *= ContractDamage();
			damageData.processedDmg.essenceDamage *= ContractDamage();
		}
		else
		if ( thePlayer.IsCiri() ) {}
	}

	public final function DoTDamageModule( out dmgInfos : array< SRawDamage >, actorAttacker : CActor, action : W3DamageAction )
	{
		var i : int;
		if(actorAttacker == thePlayer && action.IsDoTDamage())
		{
			for(i=0; i<dmgInfos.Size(); i+=1)
			{
				dmgInfos[i].dmgVal = dmgInfos[i].dmgVal * PlayerDOTDamage();
			}
		}
		else
		if(actorAttacker != thePlayer && action.IsDoTDamage())
		{
			for(i=0; i<dmgInfos.Size(); i+=1)
			{
				dmgInfos[i].dmgVal = dmgInfos[i].dmgVal * EnemyDOTDamage();
			}
		}
	}

	public final function WhirlDamageModule( out dmgInfos : array< SRawDamage >, playerAttacker : CR4Player, attackAction : W3Action_Attack	)
	{
		var i : int;
		if( playerAttacker && attackAction && ( thePlayer.IsDoingSpecialAttack(false) || SkillNameToEnum(attackAction.GetAttackTypeName()) == S_Sword_s01 ) )
		{
			for(i=0; i<dmgInfos.Size(); i+=1)
			{
				dmgInfos[i].dmgVal *= WhirlDamage();
			}		
		}
	}

	public final function RendDamageModule( out dmgInfos : array< SRawDamage >, playerAttacker : CR4Player, attackAction : W3Action_Attack	)
	{
		var i : int;
		var rendBonusPerPoint, staminaRendBonus : SAbilityAttributeValue;
		var witcherAttacker : W3PlayerWitcher;
		var rendLoad, rendBonus, rendRatio : float;

		if(playerAttacker && attackAction && SkillNameToEnum(attackAction.GetAttackTypeName()) == S_Sword_s02)
		{
			witcherAttacker = (W3PlayerWitcher)playerAttacker;
			
			rendRatio = witcherAttacker.GetSpecialAttackTimeRatio();
			
			rendLoad = MinF(rendRatio * playerAttacker.GetStatMax(BCS_Focus), playerAttacker.GetStat(BCS_Focus));
			
			if(rendLoad >= 1)
			{
				rendBonusPerPoint = witcherAttacker.GetSkillAttributeValue(S_Sword_s02, 'adrenaline_final_damage_bonus', false, true);
				rendBonus = FloorF(rendLoad) * rendBonusPerPoint.valueMultiplicative;
				
				for(i=0; i<dmgInfos.Size(); i+=1)
				{
					dmgInfos[i].dmgVal *= (1 + ( rendBonus * RendDamageAdr() ));
				}
			}

			staminaRendBonus = witcherAttacker.GetSkillAttributeValue(S_Sword_s02, 'stamina_max_dmg_bonus', false, true);
			
			for(i=0; i<dmgInfos.Size(); i+=1)
			{
				dmgInfos[i].dmgVal *= (1 + ( rendRatio * staminaRendBonus.valueMultiplicative * RendDamageStam() ));
			}			
			
			for(i=0; i<dmgInfos.Size(); i+=1)
			{
				dmgInfos[i].dmgVal *= RendDamage();
			}			
		}	
	}

	public final function FistfightDamage( out damageData : W3DamageAction )
	{
		var actorVictim	: CActor;
		var actorAttacker : CActor;
		
		actorVictim = (CActor)damageData.victim;
		actorAttacker = (CActor)damageData.attacker;
		
		if ( Scale() )
			if ( actorAttacker.HasAbility( 'fistfight_minigame' ) )
				damageData.processedDmg.vitalityDamage *= 0.12;
			else
			if ( actorVictim.HasAbility( 'fistfight_minigame' ) )
				damageData.processedDmg.vitalityDamage *= 4.5;
	}
}


// class which handles anything even slight combat related, like the abilities
class ESGOCombatHandler extends ESGOOptionHandler
{	
	// returns the damage multiplier for enemy dodges
	public final function DamagePercentageTaken() : float
	{
		return (EnemyDodgeDamageNegation() / 100);
	}

	// returns if the heavy stagger option is to be taken into consideration or not
	public final function HeavyStaggerCheck() : bool
	{
		return ( HeavyParryStagger() && HeavyParryAllowed() );
	}
	
	// returns if heavy attacks are counterable or not
	public final function IsCounterable() : bool
	{
		return HeavyCounterAllowed();
	}
	
	// returns if it's allowed for adrenaline to be drained over time in combat or not
	public final function AdrenalineDegen() : bool
	{
		return CombatADRDeg();
	}
	
	// return the multiplier for adrenaline drain over time when out of combat
	public final function AdrenalineTimeDrainMult() : float
	{
		return FocusLossTime();
	}

	// returns the maximum amount of adrenaline that can be drained over time when in combat		
	public final function AdrenalineTimeDrainMaxCombat() : float
	{
		return FocusLossTimeMV();
	}
		
	// returns the maximum amount of adrenaline that can be drained over time when out of combat
	public final function AdrenalineTimeDrainMaxNonCombat() : float
	{
		return FocusLossTimeMVC();
	}
	
	// returns the multiplier for combat adrenaline drain over time
	public final function AdrenalineTimeDrainCombatMult() : float
	{
		return FocusLossTimeCombat();
	}
	
	// returns the maximum adrenaline value set in the options
	public final function MaxAdrenaline() : float
	{
		return MaxFocus();
	}

	// function that returns if an attack can be countered or not for the countering script
	public final function CanParry( parryInfo: SParryInfo ) : bool
	{
		// if countering heavy attacks is allowed and the attack can't be parried or the attacker has an ability that states it can't be countered
		if( !HeavyCounterAllowed() && ( !parryInfo.canBeParried || parryInfo.attacker.HasAbility( 'CannotBeCountered' ) ) )
			return false;
		else 
			return true;
	}

	// function that returns if whirl can be used regardless of the skill being unlocked or not
	public final function CanUseWhirl( key : SInputAction ) : bool
	{
		return ( IsPressed(key) && ( thePlayer.CanUseSkill(S_Sword_s01) || !WhirlReq() ) );
	}	

	// function that returns if rend can be used regardless of the skill being unlocked or not
	public final function CanUseRend( key : SInputAction ) : bool
	{
		return ( IsPressed(key) && ( thePlayer.CanUseSkill(S_Sword_s02) || !RendReq() ) );
	}
	
	// custom checks used to see if auto finishers are allowed or not
	public final function CheckAutoFinisher() : bool
	{
		// if reaper's gambit is active and automatic finishers are allowed or reaper's gambit is disabled
		if ( ( RSActive() && RSAutomaticFinisher() ) || !RSActive() )
		// they are allowed and the game reads the original value
			return true;
		else
		// otherwise they are completely disabled
			return false;
		// never happens, here to satisfy the compiler
		return true;
	}
		
	// function that determines if an attack is parriable or not
	public final function IsParriable( parriable : bool ) : bool
	{
		// if parrying heavy attacks is not allowed or heavy stagger option is on
		if ( !HeavyParryAllowed() || HeavyParryStagger() )
		{
			// then it returns the original value, unchanged
			return parriable;
		}
		else
		// otherwise, if parrying heavy attacks is allowed,
		if ( HeavyParryAllowed() && !HeavyParryStagger() )
		{
			// it returns true instead of whatever the original value was
			return true;
		}
		// this never happens, it's just here to satisfy the compiler
		return true;
	}
	
	// function that changes the damage multiplier of attacks received if heavy attack parrying is allowed, but the stagger is set to on
	public final function HeavyAttackParry( out multiplier : float )
	{
		// if stagger is allowed, multiply damage by 0
		if ( HeavyStaggerCheck() ) 
			multiplier = 0;
	}
		
	// function that rewards the player with adrenaline on dismemberments
	public final function DismemberAdrenalineGain()
	{
		// if the reaper's gambit option is active, give the player adrenaline
		if ( RSActive() )
			thePlayer.GainStat(BCS_Focus, DADRGain());
	}
	
	// function that changes the maximum amount of adrenaline points the player has (change is not visual, there will only be 3 adrenaline bars)
	public final function SetMaximumAdrenaline()
	{
		thePlayer.abilityManager.SetStatPointMax( BCS_Focus, MaxFocus() );
	}

	// function that rewards the player with the specified number of adrenaline if the criteria for it are met
	public final function GainSignAdrenaline( player : CR4Player, focus : SAbilityAttributeValue )
	{
		player.GainStat(BCS_Focus, 0.1f * (1 + CalculateAttributeValue(focus)) * FocusGainSigns() );
	}
	
	// function that handles stamina loss
	public final function StaminaLoss( reason : int )
	{
		// switches between the reasons (which I chose myself as numerics) that indicate which stamina drain it should perform (using switch is an alternative to many ifs)
		switch(reason)
		{
			// drain a fixed amount of stamina, which is the second argument and halt the stamina regen for the amount of seconds specified in the third argument
			case 1: thePlayer.DrainStamina( ESAT_FixedValue, StamCostFast(), StamRegenDelay() );
			break;
			case 2: thePlayer.DrainStamina( ESAT_FixedValue, StamCostHeavy(), StamRegenDelayHeavy() );
			break;
			case 3: thePlayer.DrainStamina( ESAT_FixedValue, StamCostEvade(), StamRegenDelayDode() );
			break;
		}
	}
	
	public final function SignCost( caster : W3SignOwner, funct : int )
	{
		switch(funct)
		{
			
			case 1: caster.GetActor().DrainStamina( ESAT_FixedValue, StaminaCostN(), 1);
			break;
			case 2: caster.GetActor().DrainStamina( ESAT_FixedValue, StaminaCostS(), 1);
			break;
		}
	}
	
	public final function ReturnSignCost( funct : int ) : float
	{
		switch(funct)
		{
			case 1: return StaminaCostN();
			break;
			case 2: return StaminaCostS();
			break;
		}
		
		return 0;
	}
	
	// function that gets called when the player does a dodge, handles hit animation
	public final function WitcherDodge( out damageData : W3DamageAction, actor : CActor )
	{
		// if it's the player, the player is in a dodge, no fleet footed stagger option is active, player can use the fleet footed skill and the skill level of fleet footed is bigger than the one specified in-game
		if ( actor == thePlayer && actor.IsCurrentlyDodging() && FFNoStagger() && thePlayer.CanUseSkill(S_Sword_s09) && thePlayer.GetSkillLevel(S_Sword_s09) >= FFLevel() )
			damageData.SetHitAnimationPlayType(EAHA_ForceNo);
	}
	
	// function that gets called when an enemy performs a dodge, handles the damage they take
	public final function EnemyDodge( out damageData : W3DamageAction, actor : CActor )
	{
		// if it's not the player, the actor is dodging, the attack can be dodged, is within a specified distance of the attacker and they are allowed to negate any amount of damage
		if(actor != thePlayer && actor.IsCurrentlyDodging() && damageData.CanBeDodged() && VecDistanceSquared(actor.GetWorldPosition(),damageData.attacker.GetWorldPosition()) > 1.7 && EnemyDodgeNegateDamage() )
		{
			// multiply the essence damage taken by the enemy by DamagePercentageTaken
			damageData.processedDmg.essenceDamage *= DamagePercentageTaken();
			// multiply the vitality damage taken by DamagePercentageTaken
			damageData.processedDmg.vitalityDamage *= DamagePercentageTaken();
			return;
		}
	}

	// play hit sound and visual effects when commoners or any other sort of NPCs that should not be able to get hit take one
	public final function PlayCommonHitEffect( action : W3DamageAction, actorVictim : CActor, hitAnim : bool )
	{
		// if the NPC is one that is usually not hit and there is an attack causer
		if( ((CNewNPC)action.victim).GetNPCType() == ENGT_Commoner && !((CBaseGameplayEffect)action.causer) ) 
		{
			// play the light hit effects
			actorVictim.PlayEffect(theGame.params.LIGHT_HIT_FX);
			actorVictim.SoundEvent("cmb_play_hit_light");
			actorVictim.ProcessHitSound(action, hitAnim || !actorVictim.IsAlive());
		}
	}
	
	// function to allow the game to perform automatic finishers on enemies or not
	public final function AllowAutoFinisher( actorVictim : CActor )
	{
		// custom check to see if auto finishers are allowed in any way or not
		if( CheckAutoFinisher() )
		{
			// reads the original value (automatic finishers allowed or not) from the gameplay menu of the game and forces the finisher on death
			if ( theGame.GetInGameConfigWrapper().GetVarValue('Gameplay', 'AutomaticFinishersEnabled' ) == "true" )
				actorVictim.AddAbility( 'ForceFinisher', false );
				
			// if the finisher is forced and the player can perform one, it automatically does it	
			if ( actorVictim.HasTag( 'ForceFinisher' ) )
				actorVictim.AddAbility( 'ForceFinisher', false );
		}
		// calls for the finisher animation to start
		actorVictim.SignalGameplayEvent( 'ForceFinisher' );
	}
	
	// function for controller rumble, just makes it so it doesn't vibrate when it shouldn't
	public final function AllowAutoFinisher2( out autofinish : bool )
	{
		if ( RSActive() && RSAutomaticFinisher() )
		{
			autofinish = theGame.GetInGameConfigWrapper().GetVarValue('Gameplay', 'AutomaticFinishersEnabled');
		}
		else autofinish = false;
	}
	
	// function to deteermine amount of adrenaline drained from the player on hits
	public final function AdrenalineDrainHits( actorAttacker : CActor, actorVictim : CActor, attackAction : W3Action_Attack, action : W3DamageAction )
	{
		var focusDrain : float;
		
		// if the victim is the player, the attack dealt damage and it's not a damage over time effect like bleeding, poison, etc
		if( actorVictim == GetWitcherPlayer() && action.DealsAnyDamage() && !action.IsDoTDamage() )
		{
			// if there is an attacker and an attack (so it's not falling damage or anything of the sort)
			if(actorAttacker && attackAction)
			{
				if( actorAttacker.IsHeavyAttack( attackAction.GetAttackName() ) ) 
				// if the attack the attacker did is heavy
					focusDrain = ( CalculateAttributeValue(thePlayer.GetAttributeValue('heavy_attack_focus_drain')) * FocusLossHeavyHits() );
				else  
				// else if the attack is super heavy (as in heavy attacks from fiends, chorts, etc)
					if( actorAttacker.IsSuperHeavyAttack( attackAction.GetAttackName() ) )
						focusDrain = ( CalculateAttributeValue(thePlayer.GetAttributeValue('super_heavy_attack_focus_drain')) * FocusLossSuperHeavyHits() );
				else
				// if it's not heavy or super heavy then it can only be light
					focusDrain = ( CalculateAttributeValue(thePlayer.GetAttributeValue('light_attack_focus_drain')) * FocusLossLightHits() ); 
			}
			else
			// if there is no attacker or the attack is undefined deal light focus damage
			{
				focusDrain = ( CalculateAttributeValue(thePlayer.GetAttributeValue('light_attack_focus_drain')) * FocusLossLightHits() ); 
			}
			// if the player has the skill that reduces adrenaline damage taken
			if ( GetWitcherPlayer().CanUseSkill(S_Sword_s16) )
				focusDrain *= (1 - (CalculateAttributeValue( thePlayer.GetSkillAttributeValue(S_Sword_s16, 'focus_drain_reduction', false, true) ) * thePlayer.GetSkillLevel(S_Sword_s16)));
				
			//drain the actual adrenaline from the player
			thePlayer.DrainFocus(focusDrain);
		}
	}
	
	// function to separate countering from regular parrying so they can be performed on their own
	public final function UnblockableCounter( playerVictim : CR4Player, attackAction : W3Action_Attack, action : W3DamageAction )
	{
		// if the player is the victim, it's an attack, the attack is melee, it can't be parried, countering heavy attacks is allowed and if the attack is countered by the player
		if( playerVictim && attackAction && attackAction.IsActionMelee() && !attackAction.CanBeParried() && HeavyCounterAllowed() && attackAction.IsCountered() )
 		{	
				// force the game to NOT play a hit animation on geralt
				action.SetHitAnimationPlayType(EAHA_ForceNo);
				// don't play hit effects like blood, fire, etc
				action.SetCanPlayHitParticle(false);
				// remove bleeding effect from player if there was one applied
				action.RemoveBuffsByType(EET_Bleeding);
				// do the same with poison effects if there were any
				action.RemoveBuffsByType(EET_Poison);
		}		
	}
	
	// function to break the enemy's block if they have low stamina and the option in-game is active
	public final function BreakEnemyBlock( Skill : CBTTaskGuardChange, npc : CNewNPC )
	{
		// if option is active and has low stamina
		if( HeavyAttackBlockBreak() && !Skill.GetNPC().HasStaminaToParry('attack_heavy') )
		{
			// if the npc is blocking, break his block
			if ( npc.IsGuarded() )
				npc.LowerGuard();
			return;
		}
	}	
	
	// changes the state of the soft-lock based on the option set in the menu
	public final function SetLock( out lock : bool )
	{
		if ( !LockOn() )
			lock = false;
		else 
			lock = true;
	}
	
	// determines if the player should sheathe his sword or not
	public final function SheathSwords( Player : W3PlayerWitcher )
	{
		// if the option in the menu is set to on, it will allow the game to add the timers which make the player sheath his weapon automatically
		if( AutoSheathe() )
		{	
			if ( Player.ShouldSheathSword() )
				Player.AddTimer( 'DelayedSheathSword', 0.5f );
			else
				Player.AddTimer( 'DelayedSheathSword', 2.f );
		}
	}
	
	// returns the basic animation speed for attacking and dodging based on worn armor, stamina and health
	public final function BaseActionSpeed() : float
	{
		var BaseSpeed : float;
		var stamperc, hpperc : float;
		var inv : CInventoryComponent;
		var item : SItemUniqueId;
		var armor : array<SItemUniqueId>;
		var inc, altinc, dec, i : int;
		var type : EArmorType;
		
		// resizes the array to have the length of 2 (it's all we need) and sets the values to 0, just to be sure
		armor.Resize(2); inc = 0; altinc = 0; dec = 0;
		
		// if there is anything equipped in the torso slot, set the first place in the array to that armor's identifier and if not, increase the other value
		if( GetWitcherPlayer().inv.GetItemEquippedOnSlot(EES_Armor, item) )
			armor[0] = item;
		else
			altinc +=1;

		// if there is anything equipped in the glove slot, set the second place in the array to that armor's identifier and if not, increase the other value			
		if( GetWitcherPlayer().inv.GetItemEquippedOnSlot(EES_Gloves, item) )
			armor[1] = item;
		else
			altinc +=1;
			
		// we go through the two slots of armor we specified and we check what type they are
		for(i=0; i<armor.Size(); i+=1)
		{
			// checks the type of the armor in the #i slot
			type = GetWitcherPlayer().inv.GetArmorType(armor[i]);
				
			// determined if it is light or heavy and increases or decreases the values accordingly
			if(type == EAT_Light)
				inc += 1;
			else if(type == EAT_Heavy)
				dec += 1;
		}
		
		stamperc = GetWitcherPlayer().GetStatMax(BCS_Stamina) / 100; // 1% of stamina
		hpperc = GetWitcherPlayer().GetStatMax(BCS_Vitality) / 100; // 1% of health
		
		BaseSpeed = 1; // 100% speed
		
		BaseSpeed -= ((100 - (GetWitcherPlayer().GetStat(BCS_Stamina)/stamperc)) * StamRed()/10000.0); // -StamPerc speed for each percentage of stamina lost
		BaseSpeed -= ((100 - (GetWitcherPlayer().GetStat(BCS_Vitality)/hpperc)) * HPRed()/10000.0); // -HPPerc speed for each percentage of health lost
		BaseSpeed -= (dec * HeavyPerc()); // -HeavyPerc of speed for each piece of heavy torso and glove heavy armor worn 
		
		BaseSpeed += (inc * LightPerc()); // +LightPerc of speed for each piece of light torso and glove light armor worn
		BaseSpeed += (altinc * (LightPerc()+0.03)); // + (LightPerc+0.03) of speed for each free slot of torso and glove armor 
		
		// returns the calculated speed modifier to the variable to where it was called to
		return BaseSpeed;
	}

	// function that modifies the animation speed of fast attacks
	public final function FastAttackSpeedModule( out FastAtkSpdMultID : int )
	{
		// if attack speed is to be calculated based on skills and stats
		if ( SkillDependant() )
		{
			// if the player can use the fast attack damage skill and is not Ciri 
			if(thePlayer.CanUseSkill(S_Sword_s21) && !thePlayer.IsCiri())
			{
				// if the player can't use the razor focus adrenaline skill
				if(!thePlayer.CanUseSkill(S_Sword_s20))  
				{
					// multiply attack speed based on the base action speed and the fast attack damage skill 
					FastAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + thePlayer.GetSkillLevel(S_Sword_s21) * FAI(), FastAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
 					thePlayer.AddTimer( 'RemFastAtkSpdMultID', 0.2 );
				}
				// if the player can use the razor focus skill
				else
				{
					// multiply attack speed based on the base action speed, fast attack damage skill and adrenaline points
					FastAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + (thePlayer.GetSkillLevel(S_Sword_s21) * FAI()) + (thePlayer.GetStat(BCS_Focus)*APIF()) , FastAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemFastAtkSpdMultID', 0.2 );								
				}								
			}
			else 
			// if the player can't use the fast attack damage skill and is not Ciri
			if (!thePlayer.CanUseSkill(S_Sword_s21) && !thePlayer.IsCiri())
			{
				// if the player can't use the razor focus adrenaline skill
				if(!thePlayer.CanUseSkill(S_Sword_s20))  
				{
					// multiply attack speed based on the base action speed
					FastAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed(), FastAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemFastAtkSpdMultID', 0.2 );
				}
				// if the player can use the razor focus skill
				else
				{
					// multiply attack speed based on the base action speed and adrenaline points
					FastAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + (thePlayer.GetStat(BCS_Focus)*APIF()) , FastAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemFastAtkSpdMultID', 0.2 );								
				}								
			}
		}
		// if attack speed is to be set manually instead of calculated based on different values
		else
		{
			// multiply attack speed by the slider set in-game instead of skills and stats
			FastAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier( FAIN(), FastAtkSpdMultID);
			// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
			thePlayer.AddTimer( 'RemFastAtkSpdMultID', 0.2 );						
		}
	}

	// function that modifies the animation speed of strong attacks
	public final function HeavyAttackSpeedModule( out HeavyAtkSpdMultID : int )
	{	
		// if attack speed is to be calculated based on skills and stats
		if ( SkillDependant() )
		{
			// if the player can use the strong attack damage skill and is not Ciri 
			if(thePlayer.CanUseSkill(S_Sword_s04) && !thePlayer.IsCiri())
			{
				// if the player can't use the razor focus adrenaline skill
				if(!thePlayer.CanUseSkill(S_Sword_s20))  
				{
					// multiply attack speed based on the base action speed and the strong attack damage skill 
					HeavyAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + thePlayer.GetSkillLevel(S_Sword_s04) * HAI(), HeavyAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemHeavyAtkSpdMultID', 0.2 );
				}
				else
				{
					// multiply attack speed based on the base action speed, strong attack damage skill and adrenaline points
					HeavyAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + (thePlayer.GetSkillLevel(S_Sword_s04) * HAI()) + (thePlayer.GetStat(BCS_Focus)*APIH()) , HeavyAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemHeavyAtkSpdMultID', 0.2 );								
				}								
			}
			else
			// if the player can't use the strong attack damage skill and is not Ciri 
			if(!thePlayer.CanUseSkill(S_Sword_s04) && !thePlayer.IsCiri())
			{
				// if the player can't use the razor focus adrenaline skill
				if(!thePlayer.CanUseSkill(S_Sword_s20))  
				{
					// multiply attack speed based on the base action speed
					HeavyAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed(), HeavyAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemHeavyAtkSpdMultID', 0.2 );
				}
				// if the player can use the razor focus skill
				else
				{
					// multiply attack speed based on the base action speed and adrenaline points
					HeavyAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + (thePlayer.GetStat(BCS_Focus)*APIH()) , HeavyAtkSpdMultID);
					// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
					thePlayer.AddTimer( 'RemHeavyAtkSpdMultID', 0.2 );								
				}								
			}
		}
		// if attack speed is to be set manually instead of calculated based on different values
		else
		{
			// multiply attack speed by the slider set in-game instead of skills and stats
			HeavyAtkSpdMultID = thePlayer.SetAnimationSpeedMultiplier( HAIN(), HeavyAtkSpdMultID);
			// timer to reset the animation speed to the original one so they don't end up stacking and becoming insanely slow or fast
			thePlayer.AddTimer( 'RemHeavyAtkSpdMultID', 0.2 );						
		}
	}
	
	// function that modifies the animation speed of dodges
	public final function EvadeSpeedModule( out EvadeSpdMultID : int )
	{
		// if animation speed is to be calculated based on skills and stats or set manually
		if ( SkillDependant() )
		{
			// if the player can use the fleet footed skill and is not Ciri
			if(thePlayer.CanUseSkill(S_Sword_s09) && !thePlayer.IsCiri())
			{
				// multiply dodge speed based on base action speed and fleet footed skill level
				EvadeSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed() + thePlayer.GetSkillLevel(S_Sword_s09) * DAI(), EvadeSpdMultID);
				// reset the animation speed to the original so the multipliers don't stack and mess everything up
				thePlayer.AddTimer( 'RemEvadeSpdMultID', 0.3 );
			}
			// if the player can't use the fleet footed skill
			else
			{
				// multiply dodge speed based on the base action speed calculation
				EvadeSpdMultID = thePlayer.SetAnimationSpeedMultiplier(BaseActionSpeed(), EvadeSpdMultID);
				// reset the animation speed to the original so the multipliers don't stack and mess everything up
				thePlayer.AddTimer( 'RemEvadeSpdMultID', 0.3 );
			}
		}
		// if animation speed is to be set manually instead
		else
		{
			// multiply dodge speed based on the in-game slider set in the mod menu
			EvadeSpdMultID = thePlayer.SetAnimationSpeedMultiplier( DAIN(), EvadeSpdMultID);
			// reset the animation speed to the original so the multipliers don't stack and mess everything up
			thePlayer.AddTimer( 'RemEvadeSpdMultID', 0.2 );						
		}
	}
	
	// function that rewards the player with adrenaline and sets invulnerability mode based on settings
	public final function ReaperFinisher()
	{
		// if reaper's gambit is active in-game
		if ( RSActive() )
		{
			// give the player a specified amount of adrenaline, based on in-game settings
			thePlayer.GainStat( BCS_Focus, FADRGain() );
		}	

		// if finisher vulnerability is turned off and reaper's gambit is active or if reaper's gambit is not active
		if ( (!RSFinishVulnerability() && RSActive()) || !RSActive() )
		{
			// make the player immortal for the length of the finisher animation
			thePlayer.SetImmortalityMode( AIM_Invulnerable, AIC_SyncedAnim );
		}
	}
	
	// separate function from the PerformCounter() function that applies the effects of the sword counter so that it gets applied at the correct time instead of instantly
	public final function SwordCounterEffect( action : W3DamageAction, attackAction : W3Action_Attack, actorVictim : CActor, playerAttacker : CR4Player )
	{
		// variable that is a struct (record) which holds multiple variables inside
		var bleeding : SCustomEffectParams;
		
		// if the player is the attacker, the damage action is not a damage over time one like burning, bleeding, etc and the enemy got sword countered (custom flag set by me)
		if( playerAttacker && !action.IsDoTDamage() && playerAttacker.GetCountered() )
		{
			// if the player can use the Counterattack talent
			if( thePlayer.CanUseSkill(S_Sword_s11) )
			{
				// if the attack deals damage (as in, it's not blocked or completely absorbed somehow
				if( action.DealsAnyDamage() )
				{
					// set the effect type of the variable to the bleeding effect
					bleeding.effectType = EET_Bleeding;
					// set the creator of the bleeding effect as the attacker, which is the player
					bleeding.creator = playerAttacker;
					// set the source of the bleeding effect as the Counterattack talent
					bleeding.sourceName = SkillEnumToName(S_Sword_s11);
					// set the duration of the effect based on the in-game slider setting multiplied by the counterattack skill level
					bleeding.duration = BleedDuration() * thePlayer.GetSkillLevel(S_Sword_s11);
					// set the damage of the effect based on the in-game slider and the counterattack skill
					bleeding.effectValue.valueAdditive = BleedDamage() * thePlayer.GetSkillLevel(S_Sword_s11);
					// add the custom effect to the victim, which is the enemy which got countered ( or multiple enemies if you countered one and more got hit )
					actorVictim.AddEffectCustom(bleeding);
				}
				// regardless if the attack dealt damage or not (it shouldn't, because the enemy has to be blocking actively which means no damage was sustained)
				// and the option to disarm on counterattacks is active in the menu
				if( ((CNewNPC)actorVictim).IsShielded( playerAttacker ) && DisarmShield() )
					// destroy the enemy's shield and make their left hand unarmed, same way the igni stream of fire does it
					((CNewNPC)actorVictim).ProcessShieldDestruction();
			}
		}
	}
	
	// the function that almost handles everything in the defender's resolve option menu, it controls what happens when an enemy gets countered
	public final function PerformCounter( causer : CR4Player, counterCollisionGroupNames : array<name>, parryInfo: SParryInfo, weaponTags : array<name>, hitNormal : Vector, out repelType : EPlayerRepelType, out ragdollTarget : CActor )
	{
		var thisPos, attackerPos, tracePosStart, tracePosEnd, playerToAttackerVector, hitPos : Vector;
		var bleeding : SCustomEffectParams;
		var playerToTargetRot : EulerAngles;
		var useKnockdown : bool;
		var zDifference : float;
		
		// if it's a grave hag, use the custom counter animation for them (doesn't work on regular enemies, hitbox doesn't match) to cut their tongue off
		if ( parryInfo.attacker.HasAbility('mon_gravehag') )
		{
			repelType = PRT_Slash;
			parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, 'ReflexParryPerformed');
		}
		// if there is an attack and that attacker is not human, so it's a monster
		else if ( (CNewNPC)parryInfo.attacker && !((CNewNPC)parryInfo.attacker).IsHuman() )
		{
			// set the knockdown flag to false, since we will use it to indicate if the counter should produce a knockdown or not
			useKnockdown = false;
			
			// if the player can use the Counterattack talent, his current adrenaline points are higher or equal to the amount specified in the menu, his stamina points are higher than the amount specified and the enemy's health is lower than the amount specified
			if( thePlayer.CanUseSkill(S_Sword_s11) && (thePlayer.GetStat(BCS_Focus) >= KnockAT()) && (thePlayer.GetStat(BCS_Stamina) > (thePlayer.GetStatMax(BCS_Stamina)*KnockST()/100)) && ( (((CNewNPC)parryInfo.attacker).GetStat(BCS_Essence) < (((CNewNPC)parryInfo.attacker).GetStatMax(BCS_Essence)*KnockHT()/100))) )
				// if all the above checks off, set the knockdown flag to true
				useKnockdown = true;
			
			// if the knockdown flag is set to true and the enemy is not immune to knockdowns
			if(useKnockdown && (!parryInfo.attacker.IsImmuneToBuff(EET_HeavyKnockdown) || !parryInfo.attacker.IsImmuneToBuff(EET_Knockdown)))
			{	
				// if the countered attack wasn't a heavy attack
				if( parryInfo.attackActionName != 'attack_heavy' )
				{
					// check which counter method is specified for normal monster attacks
					switch ( MCT() )
					{
						// the first one on the slider is the sword slash, set the animation to the sidestep slash and set the countered flag for the bleeding effect to true
						case 0: repelType = PRT_SideStepSlash; causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
						break;
						// the second one on the slider is the kick, set the animation to the kick and add a timer to make the enemy ragdoll after the kick is performed and drain their stamina
						case 1: repelType = PRT_Kick; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 ); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
						break;
						// the third one on the slider is the bash, set the animation to the shoulder bash and add a timer to make the enemy ragdoll after the bash is performed
						case 2: repelType = PRT_Bash; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
						break;
					}
				}
				// if it was a heavy attack
				else
				{
					// check which counter method is specified for heavy monster attacks
					switch ( HMCT() )
					{
						case 0: repelType = PRT_SideStepSlash; causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
						break;
						case 1: repelType = PRT_Kick; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 ); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
						break;
						case 2: repelType = PRT_Bash; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
						break;
					}
				}
			}
			// if the enemy is immune to knockdowns, only stagger them
			else
			{
				// if the countered attack wasn't a heavy attack
				if( parryInfo.attackActionName != 'attack_heavy' )
				{
					// check which counter method is specified for light monster attacks
					switch ( MCT() )
					{
						// set the bleeding flag for counters
						case 0: causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
						break;
						// add the countered effect to enemies which makes them stagger and drain stamina
						case 1: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed"); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
						break;
						// add the countered effect to enemies to stagger them
						case 2: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed");
						break;
					}							
				}
				else
				{
					// check which counter method is specified for heavy monster attacks
					switch ( HMCT() )
					{
						// set the bleeding flag
						case 0: causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
						break;
						// *HACK*
						// here I'm using ragdolls to make the enemies stagger, they don't get knocked down, but only stagger while they don't do anything with the counter hit effect
						case 1: ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 ); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
						break;
						// same hack is applied here
						case 2: ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
						break;
					}									
				}
			}
		}
		// enemy type exclusion, here we check for wielded weapon type
		
		// if the countered enemy is using a spear
		else if ( weaponTags.Contains('spear2h') )
		{
			// auomatically set the repel type to side slash since the rest look horrible with this
			repelType = PRT_SideStepSlash;
			// drain the enemy's stamina based on the Counterattack talent
			((CNewNPC)parryInfo.attacker).DrainStamina(StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11));
			// break the enemy's spear, doesn't seem to be working though
			parryInfo.attacker.SignalGameplayEvent( 'SpearDestruction');
		}
		// if the weapon wielded is a hammer, axe, halberd or two handed sword
		else if ( weaponTags.Contains('hammer2h') || weaponTags.Contains('axe2h') || weaponTags.Contains('halberd2h') || weaponTags.Contains('sword2h') ) 
		{
			// check the counter type for super heavy human attacks
			switch ( SHHCT() )
			{
				// set the counter animation and activate the counter flag
				case 0: repelType = PRT_SideStepSlash; causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
				break;
				// *HACK*
				// here we ragdoll the enemies again, this time they DO fall over and can be insta-killed, this is required because they don't have a proper stun animation for getting countered and they hit even faster after getting countered
				case 1: repelType = PRT_Kick; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
				break;
				// same hack is applied here
				case 2: repelType = PRT_Bash; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
				break;
			}
		}
		// if the enemy is not a monster and is not wielding any of the above weapons
		else
		{
			// save the player's position to a variable
			thisPos = causer.GetWorldPosition();
			// set the countered enemy's position to a variable
			attackerPos = parryInfo.attacker.GetWorldPosition();
			// save the 3d space locational differences between the player and the attacker into a structure
			playerToTargetRot = VecToRotation( thisPos - attackerPos );
			// check the height difference between the player and the countered enemy
			zDifference = thisPos.Z - attackerPos.Z;
			
			// if the pitch is lower (as in the player is looking down on the enemy) and the height difference is above a certain point
			if ( playerToTargetRot.Pitch < -5.f && zDifference > 0.35 )
			{
				// automatically set the repel type to the kick so it looks like it actually connects
				repelType = PRT_Kick;
				// make the enemy ragdoll from getting kicked in the face :)
				ragdollTarget = parryInfo.attacker;
				AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
			}
			// if the pitch and height check is normal (as in the enemy isn't below the player or such)
			else
			{
				// set knockdown flag to false
				useKnockdown = false;
					
				// check if the knockdown should be performed or not
				if( thePlayer.CanUseSkill(S_Sword_s11) && (GetWitcherPlayer().GetStat(BCS_Focus) >= KnockAT()) && (thePlayer.GetStat(BCS_Stamina) > (thePlayer.GetStatMax(BCS_Stamina)*KnockST()/100)) && ((((CNewNPC)parryInfo.attacker).GetStat(BCS_Vitality) < (((CNewNPC)parryInfo.attacker).GetStatMax(BCS_Vitality)*KnockHT()/100) ))) 							
					useKnockdown = true;
					
				// GOOOOD LEEFT MEEE UNFIIIIINIIIIISHEED
				if ( parryInfo.attacker.IsHuman() )
				{ 
					tracePosStart = parryInfo.attacker.GetWorldPosition();
					tracePosStart.Z += 1.f;
					playerToAttackerVector = VecNormalize( parryInfo.attacker.GetWorldPosition() -  parryInfo.target.GetWorldPosition() );
					tracePosEnd = ( playerToAttackerVector * 0.75f ) + ( playerToAttackerVector * parryInfo.attacker.GetRadius() ) + parryInfo.attacker.GetWorldPosition();
					tracePosEnd.Z += 1.f;
					
					if ( !theGame.GetWorld().StaticTrace( tracePosStart, tracePosEnd, hitPos, hitNormal, counterCollisionGroupNames ) )
					{
						tracePosStart = tracePosEnd;
						tracePosEnd -= 3.f;
						
						if ( !theGame.GetWorld().StaticTrace( tracePosStart, tracePosEnd, hitPos, hitNormal, counterCollisionGroupNames ) )
							useKnockdown = true;
					}
				}
				
				// if the knockdown flag is active and the enemy is not immune to some type of knockdown
				if(useKnockdown && (!parryInfo.attacker.IsImmuneToBuff(EET_HeavyKnockdown) || !parryInfo.attacker.IsImmuneToBuff(EET_Knockdown))) // if not immune to knockdowns, knockdown
				{	
				// BLA BLA BLA, coutner checks, you know already
					if( parryInfo.attackActionName == 'attack_heavy' )
					{
						switch ( HHCT() )
						{
							case 0: repelType = PRT_SideStepSlash; causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
							break;
							case 1: repelType = PRT_Kick; parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed"); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
							break;
							case 2: repelType = PRT_Bash; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
							break;
						}
					}
					else
					{
						switch ( HCT() )
						{
							case 0: repelType = PRT_SideStepSlash; causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
							break;
							case 1: repelType = PRT_Kick; parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed");  ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
							break;
							case 2: repelType = PRT_Bash; ragdollTarget = parryInfo.attacker; causer.AddTimer( 'ApplyCounterRagdollTimer', 0.3 );
							break;
						}
					}
				}
				else
				{
					if( parryInfo.attackActionName == 'attack_heavy' )
					{
						switch ( HHCT() )
						{
							case 0: causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
							break;
							case 1: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed"); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
							break;
							case 2: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed");
							break;
						}								
					}
					else
					{ 
						switch ( HCT() )
						{
							case 0: causer.SetCountered(); causer.AddTimer('RemoveCounterFlag',1.0f, false);
							break;
							case 1: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed"); ((CActor)parryInfo.attacker).DrainStamina(ESAT_FixedValue, StaminaDamage()*GetWitcherPlayer().GetSkillLevel(S_Sword_s11), StaminaDamageDuration() );
							break;
							case 2: parryInfo.attacker.AddEffectDefault(EET_CounterStrikeHit, causer, "ReflexParryPerformed");
							break;
						}									
					}
				}
			}
		}
	}
	
	// set the counter animation type if it was not already somehow specified 
	public final function SetCounterType( parryInfo: SParryInfo, out repelType : EPlayerRepelType )
	{
		// if the counter animation is set to random (as in, none of the above was true because the random one is the default animation type)
		if ( repelType == PRT_Random )
			// BLA BLA BLA, check for enemy type and counter options in the menu, usual stuff
			if ( parryInfo.attacker.IsHuman() )
			{
				if( parryInfo.attackActionName == 'attack_heavy' )
				{
					switch ( HHCT() )
					{
						case 0: repelType = PRT_SideStepSlash; 
						break;
						case 1: repelType = PRT_Kick;
						break;
						case 2: repelType = PRT_Bash;
						break;
					}
				}
				else
				{
					switch ( HCT() )
					{
						case 0: repelType = PRT_SideStepSlash; 
						break;
						case 1: repelType = PRT_Kick;
						break;
						case 2: repelType = PRT_Bash;
						break;
					}
				}
			}
			else
			{
				if( parryInfo.attackActionName != 'attack_heavy' )
				{
					switch ( MCT() )
					{
						case 0: repelType = PRT_SideStepSlash; 
						break;
						case 1: repelType = PRT_Kick; 
						break;
						case 2: repelType = PRT_Bash; 
						break;
					}
				}
				else
				{
					switch ( HMCT() )
					{
						case 0: repelType = PRT_SideStepSlash; 
						break;
						case 1: repelType = PRT_Kick;
						break;
						case 2: repelType = PRT_Bash;
						break;
					}
				}						
			}
	}
}

// class which handles any and all equipment effects and just general things related to how equipment is used or found
class ESGOEquipmentHandler extends ESGOOptionHandler
{
	// function that handles durability changes
	public final function Durability( out chance : int )
	{
		switch( DurabilityDamage() )
		{
			case 0: chance /= 2;
			break;
			case 1:
			break;
			case 2: chance = 0;
			break;
		}
	}
	
	// first function which sets the color of the item level indicator in certain circumstances
	public final function LevelRequirementIndicator( out colour : string, itemId : SItemUniqueId, Inv : CInventoryComponent )
	{
		if ( LevelRequirement() )
		{
			if (Inv.GetItemLevel(itemId) <= thePlayer.GetLevel())
				colour = "<font color = '#66FF66'>"; // green		
			else
				colour = "<font color = '#9F1919'>"; // red
		}
		else 
		if( !LevelRequirement() && ( ( LevelDifference() > 0 && ( Inv.GetItemLevel(itemId) <= ( thePlayer.GetLevel() + LevelDifference() ) ) ) || LevelDifference() == 0 ) )			
			colour = "<font color = '#66FF66'>"; // green
		else
			colour = "<font color = '#9F1919'>"; // red
	}
	
	// second function which sets the color of the item level indicator in certain circumstances
	public final function LevelRequirementIndicator2( out colour : string, lvl_item : int, Inv : CInventoryComponent )
	{
		if ( LevelRequirement() )
		{
			if ( lvl_item > thePlayer.GetLevel() ) 
				colour = "<font color = '#9F1919'>"; // red	
			else
				colour = "<font color = '#66FF66'>"; // green
		}
		else
		if( !LevelRequirement() && ( ( LevelDifference() > 0 && ( lvl_item <= ( thePlayer.GetLevel() + LevelDifference() ) ) ) || LevelDifference() == 0 ) )
			colour = "<font color = '#66FF66'>"; // green
		else
			colour = "<font color = '#9F1919'>"; // red
	}
	
	// function that handles when the player should be allowed to equip certain items
	public final function LevelRequirements( item : SItemUniqueId, inv : CInventoryComponent ) : bool
	{
		// if level requirements are turned on in the menu
		if( LevelRequirement() )
		{
			// if the player has the Wolven Hour potion active, make all level requirements 2 levels lower
			if(thePlayer.HasBuff(EET_WolfHour))
			{
				if((inv.GetItemLevel(item) - 2) > thePlayer.GetLevel() )
					return false;
			}
			// if the potion is not active, proceed as usual with how the level requirements work in vanilla
			else
				if(inv.GetItemLevel(item) > thePlayer.GetLevel() )	
					return false;
		}
		// if the option is not active in the menu
		else
		// if the option is not active and the player's level + the level difference slider is higher than the item's level or the slider is on 0
		if( !LevelRequirement() && ( ( LevelDifference() > 0 && ( inv.GetItemLevel(item) <= ( thePlayer.GetLevel() + LevelDifference() ) ) ) || LevelDifference() == 0 ) )
			// allow the item to be equipped
			return true;
		// if the option is not active, the slider is not on 0 and the player still doesn't meet the level requirement and of course to satisfy the compiler
		return false;
	}
	
	// function that makes the little red cross visible on item equipment icons in the inventory if they can not be worn
	public final function UnableToEquip( out flashObject : CScriptedFlashObject, _inv : CInventoryComponent, item : SItemUniqueId ) 
	{
		var check : bool;
		
		// main level requirement option and level slider check
		if( LevelRequirement() || ( !LevelRequirement() && ( LevelDifference() > 0 && ( _inv.GetItemLevel(item) > ( thePlayer.GetLevel() + LevelDifference() ) ) ) ) )
		{
			check = _inv.GetItemLevel(item) > thePlayer.GetLevel();
			// add the red cross via the graphical user interface framework
			flashObject.SetMemberFlashBool( "cantEquip", check );
		}
	}
	
	/*
	public final function ApplySetBonuses( player : CR4Player )
	{
		if( player.HasAllItemsFromSet(theGame.params.ITEM_SET_TAG_BEAR) && !player.HasAbility(theGame.params.MONSTER_BONUS_LOW) )
			player.AddAbility(theGame.params.MONSTER_BONUS_LOW, true);
			
		if( player.HasAllItemsFromSet(theGame.params.ITEM_SET_TAG_GRYPHON) && !player.HasAbility(theGame.params.MONSTER_BONUS_LOW) )
			player.AddAbility(theGame.params.MONSTER_BONUS_LOW, true);
			
		if( player.HasAllItemsFromSet(theGame.params.ITEM_SET_TAG_LYNX) && !player.HasAbility(theGame.params.MONSTER_BONUS_LOW) )
			player.AddAbility(theGame.params.MONSTER_BONUS_LOW, true);
			
		if( player.HasAllItemsFromSet(theGame.params.ITEM_SET_TAG_WOLF) && !player.HasAbility(theGame.params.MONSTER_BONUS_LOW) )
			player.AddAbility(theGame.params.MONSTER_BONUS_LOW, true);
	}
	*/
}
