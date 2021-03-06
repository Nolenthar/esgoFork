/***********************************************************************/
/** Ability Manager handles all NPC/Player's:
/**  - character stats (vitality, stamina etc.),
/**  - abilities,
/**  - skills.
/**
/** NPC/Player should use their own classes with custom code handling.
/**
/** In general - player skills have their own structures while the monsters' skills are just abilities.
/** 
/** Stats and resists are cached so we wouldn't have to recalculate them all the time. It also simplifies
/** the process of getting stats since tags don't give us too much options (e.g. if you would like to get
/** base stat + all passive skill and item bonuses then this is harder to do if the values are not cached).
/** 
/** Ability Manager is also used to get attribute values of the actor. It has to be encapsulated since
/** some of the stats are cached - we must ensure that the cached values are read, not the partial not calculated
/** values (e.g. getting character's health from XML definition would lose the information about other 
/** passive bonuses like skills and you wouldn't know about it).
/**
/** The 'forbidden attributes' are the attributes which cannot be got using GetAttribute* functions.
/** They have their own functions that must be used, e.g. GetStat, which have a custom handling.
/***********************************************************************/
/** Copyright © 2012-2014
/** Author : Tomek Kozera
/***********************************************************************/

import abstract class W3AbilityManager extends IScriptable
{
	// moved to c++
	// protected saved var statPoints : array<SBaseStat>;						//cached stats
	// protected saved var resistStats : array<SResistanceValue>;				//cached resist stats

	import var owner : CActor;												//actor whose AbilityManager this is
	import var charStats : CCharacterStats;									//cached owner CharacterStats object
	import saved var usedDifficultyMode : EDifficultyMode;					//difficulty mode used to calculate stats of this actor
	import var difficultyAbilities : array< array< name > >;				//cached names of abilities for specific difficulty modes
	import var ignoresDifficultySettings : bool;							//if set then actor ignores difficulty settings
	private var overhealBonus : float;

	import final function CacheStaticScriptData();
	import final function SetInitialStats( diff : EDifficultyMode ) : bool;
	
	import final function HasStat( stat : EBaseCharacterStats ) : bool;
	import final function StatAddNew( stat : EBaseCharacterStats, optional max : float );
	import final function RestoreStat( stat : EBaseCharacterStats );
	import final function RestoreStats();
	import  	 function GetStat( stat : EBaseCharacterStats, optional skipLock : bool ) : float;
	public final function GetStatMax( stat : EBaseCharacterStats ) : float;
	public final function GetStatPercents( stat : EBaseCharacterStats ) : float;
	import final function GetStats( stat : EBaseCharacterStats, out current : float, out max : float ) : bool;
	import final function SetStatPointCurrent( stat : EBaseCharacterStats, val : float );
	import final function SetStatPointMax( stat : EBaseCharacterStats, val : float );
	import final function UpdateStatMax( stat : EBaseCharacterStats );
	
	import final function HasResistStat( stat : ECharacterDefenseStats ) : bool;
	import final function GetResistStat( stat : ECharacterDefenseStats, out resistStat: SResistanceValue ) : bool;
	import final function SetResistStat( stat : ECharacterDefenseStats, out resistStat: SResistanceValue );
	import final function ResistStatAddNew( stat : ECharacterDefenseStats );
	import  	 function RecalcResistStat( stat : ECharacterDefenseStats );
	
	import  	 function GetAttributeValueInternal( attributeName : name, optional tags : array< name > ) : SAbilityAttributeValue;
	
	import final function CacheDifficultyAbilities();
	import final function UpdateStatsForDifficultyLevel( diff : EDifficultyMode );
	import final function UpdateDifficultyAbilities( diff : EDifficultyMode );
	
	// the following methods don't work on final build (return empty array / false)
	import final function GetAllStats_Debug( out stats : array< SBaseStat > ) : bool;
	import final function GetAllResistStats_Debug( out stats : array< SResistanceValue > ) : bool;

	protected var isInitialized : bool;										//set to true once all initialization code is one, before that you should not use ability manager!
	protected saved var blockedAbilities : array<SBlockedAbility>;			//list of abilities that are currently blocked (e.g. as a result of focus mode)
		default isInitialized = false;										//must be called in child class after all the Init code is done		
	
	//called after Init after other actor managers are initialized		
	public function PostInit();
		
	//returns true if properly initialized
	public function Init(ownr : CActor, cStats : CCharacterStats, isFromLoad : bool, diff : EDifficultyMode) : bool
	{
		var abs : array<name>;
		var i : int;
		var dm : CDefinitionsManagerAccessor;

		isInitialized = false;		
		difficultyAbilities.Clear();
		ignoresDifficultySettings = false;
		
		CacheStaticScriptData();
		
		owner = ownr;
		charStats = cStats;
		dm = theGame.GetDefinitionsManager();
				
		//check for difficulty modes ignoring
		charStats.GetAbilities(abs);
		for(i=0; i<abs.Size(); i+=1)
		{
			if(dm.AbilityHasTag(abs[i], theGame.params.DIFFICULTY_TAG_IGNORE))
			{
				ignoresDifficultySettings = true;
				break;
			}
		}
		
		//setup difficulty levels data
		if(!ignoresDifficultySettings)
			difficultyAbilities.Resize(EnumGetMax('EDifficultyMode')+1);
		
		//set stats
		if(!isFromLoad)
		{
			usedDifficultyMode = EDM_NotSet;
			
			if(!SetInitialStats(diff))
				return false;
		}
		else if(!ignoresDifficultySettings)
		{
			CacheDifficultyAbilities();
		}
		
		//if used diff mode is different than the one with which we're spawning we need to update
		//this can be caused due to streaming in when difficulty has been changed while the NPC was
		//streamed out
		if(!ignoresDifficultySettings && usedDifficultyMode != diff)
		{
			UpdateStatsForDifficultyLevel(diff);
		}
		
		return true;
	}
	
	public final function IsInitialized() : bool 		{return isInitialized;}
	
	/* moved to c++
	public final function RestoreStats()
	{
		var i : int;
		
		for(i=0; i<statPoints.Size(); i+=1)
			RestoreStat(i);
	}
	*/
	
	public function OnOwnerRevived()
	{
		var i : int;
		
		RestoreStats();
		
		for(i=blockedAbilities.Size()-1; i>=0; i-=1)
		{
			if(blockedAbilities[i].timeWhenEnabledd > 0)
				blockedAbilities.EraseFast(i);
		}
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////    ---===  @ATTRIBUTES  ===---    ////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Returns true if attribute is forbidden (cannot be used in GetAttribute* functions)
	protected function CheckForbiddenAttribute(attName : name) : bool
	{
		if( theGame.params.IsForbiddenAttribute(attName) )
		{
			LogAssert(false, "W3AbilityManager.CheckForbiddenAttribute: you are trying to get attribute <<" + attName + ">> in a wrong way - use propper custom function instead!");
			return true;
		}
		
		return false;
	}
	
	/*
		Gets attribute value. Makes a check for Forbidden Attributes.
		If tags contains tag names then gets only attribute values from abilities having given tag.
	*/
	public function GetAttributeValue(attributeName : name, optional tags : array<name>) : SAbilityAttributeValue
	{
		var val : SAbilityAttributeValue;
	
		if(CheckForbiddenAttribute(attributeName))
		{
			val.valueBase = -9999;
			val.valueAdditive = -9999;
			val.valueMultiplicative = 100;
			return val;
		}
		
		return GetAttributeValueInternal(attributeName, tags);
	}
	
	public function GetAbilityAttributeValue(abilityName : name, attributeName : name) : SAbilityAttributeValue
	{
		var val : SAbilityAttributeValue;
	
		if(CheckForbiddenAttribute(attributeName))
		{
			val.valueBase = -9999;
			val.valueAdditive = -9999;
			val.valueMultiplicative = 100;
			return val;
		}
		
		return charStats.GetAbilityAttributeValue(attributeName, abilityName);
	}
	
	/*
		Gets attribute value. Makes NO check for Forbidden Attributes.
		If tags contains tag names then also gets attribute values from skill abilities having given tag.
	*/
	/* moved to c++
	protected function GetAttributeValueInternal(attributeName : name, optional tags : array<name>) : SAbilityAttributeValue	
	{
		var val, min, max : SAbilityAttributeValue;
		var abs : array<name>;
	
		//get from base character stats
		val = charStats.GetAttributeValue(attributeName, tags);
				
		abs = GetNonBlockedSkillAbilitiesList(tags);
		if(abs.Size() > 0)
		{
			theGame.GetDefinitionsManager().GetAbilitiesAttributeValue(abs, attributeName, min, max);		
			val += GetAttributeRandomizedValue(min, max);
		}		
		return val;
	}
	*/
		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////    ---===  @ABILITIES  ===---    ////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	protected function GetNonBlockedSkillAbilitiesList(tags : array<name>) : array<name>
	{
		var null : array<name>;
		return null;
	}
	
	// Runs through all abilities and checks their cooldowns, removes the ones that are no longer blocked
	// returns time till next call
	public function CheckBlockedAbilities(dt : float) : float
	{
		var i : int;
		var min : float;
		
		min = 1000000;
		for(i = blockedAbilities.Size()-1; i>=0; i-=1)
		{
			if(blockedAbilities[i].timeWhenEnabledd != -1)
			{
				blockedAbilities[i].timeWhenEnabledd = MaxF(blockedAbilities[i].timeWhenEnabledd - dt, 0);
				
				if(blockedAbilities[i].timeWhenEnabledd == 0)		//if cooldown set and ended then unblock
				{
					BlockAbility(blockedAbilities[i].abilityName, false);	//this removes object from array
				}
				else
				{
					min = MinF(min, blockedAbilities[i].timeWhenEnabledd);
				}
			}
		}
		
		if(min == 1000000)
			min = -1;
			
		return min;
	}
	
	//returns index in array
	protected final function FindBlockedAbility(abName : name) : int
	{
		var i : int;
		
		for(i=0; i<blockedAbilities.Size(); i+=1)
			if(blockedAbilities[i].abilityName == abName)
				return i;
				
		return -1;
	}
	
	/*
		Blocks or unblocks an ability from being used.
	
		@params
		abilityName - name of the ability
		block - if set then ability will be blocked, otherwise unblocked
		cooldown - if 'block' is set as well then the ability will be blocked only for this time. Otherwise it's blocked until unblocked
		
		@returns
		true if action was carried out successfully
	*/
	public function BlockAbility(abilityName : name, block : bool, optional cooldown : float) : bool
	{		
		var i : int;
		var ab : SBlockedAbility;
		var min, cnt : float;
		var ret : bool;
				
		if(!IsNameValid(abilityName))
			return false;
				
		for(i=0; i<blockedAbilities.Size(); i+=1)
		{
			if(blockedAbilities[i].abilityName == abilityName)
			{
				if(!block)
				{	
					cnt = blockedAbilities[i].count;
					blockedAbilities.Erase(i);					//unblock ability - remove from blocked list
					if(cnt > 0)									//cnt might be 0 when ability was blocked and later completely removed from actor
						charStats.AddAbility(abilityName, cnt);					
					
					return true;
				}
				else
				{
					return false;
				}
			}
		}
		
		if(block)
		{
			ab.abilityName = abilityName;
			//set the 'timer' to current time + cooldown time
			if(cooldown > 0)				
			{
				ab.timeWhenEnabledd = cooldown;
				
				//find next call time
				min = cooldown;
				for(i=0; i<blockedAbilities.Size(); i+=1)
				{
					if(blockedAbilities[i].timeWhenEnabledd > 0)
					{
						min = MinF(min, blockedAbilities[i].timeWhenEnabledd);
					}
				}
				
				//schedule next update
				owner.AddTimer('CheckBlockedAbilities', min, , , , true);
			}
			else
			{
				ab.timeWhenEnabledd = -1;
			}
			
			//count
			ab.count = owner.GetAbilityCount(abilityName);
	
			//lock ability			
			ret = charStats.RemoveAbility(abilityName);
			blockedAbilities.PushBack(ab);
			return ret;
		}
		else
		{
			return false;
		}
	}
	
	public final function IsAbilityBlocked(abilityName : name) : bool
	{
		return FindBlockedAbility(abilityName) >= 0;
	}
		
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////    ---===  @STATS  ===---    /////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/* use HasResistStat/GetResistStat instead
	protected function GetResistStatIndex( out arr : array<SResistanceValue>, stat : ECharacterDefenseStats ) : int
	{
		var i : int;
		
		for(i=0; i<arr.Size(); i+=1)
			if(arr[i].type == stat)
				return i;
				
		return -1;
	}
	*/
	
	// Gets power stat value. If ability tag is set gets only the value for given ability.
	public function GetPowerStatValue(stat : ECharacterPowerStats, optional abilityTag : name) : SAbilityAttributeValue
	{
		var tags : array<name>;
		
		if(IsNameValid(abilityTag))
			tags.PushBack(abilityTag);
		return GetAttributeValueInternal(PowerStatEnumToName(stat), tags);
	}
	
	// Multiplies current stat value by a given value
	protected function MutliplyStatBy(stat : EBaseCharacterStats, val : float)
	{
		if(val > 0)
			SetStatPointCurrent(stat, MinF(val * GetStat(stat, true), GetStatMax(stat) ) );
	}
	
	/*
		Returns actor's resistance stat value. Maxcap is at 1.0, there is no Min cap (resist can be negative)
	*/
	public function GetResistValue(stat : ECharacterDefenseStats, out points : float, out percents : float)
	{
		var pts, prc, charPts, charPerc : SAbilityAttributeValue;
		var buff : W3Mutagen20_Effect;
		var resistStat : SResistanceValue; 
		
		if ( GetResistStat( stat, resistStat ) )
		{
			charPts = resistStat.points;
			charPerc = resistStat.percents;		
		}
		
		//add bonus from mutagen 20 for DoT damages
		if(stat == CDS_DoTBurningDamageRes || stat == CDS_DoTPoisonDamageRes || stat == CDS_DoTBleedingDamageRes)
		{
			if(owner.HasBuff(EET_Mutagen20))
			{
				buff = (W3Mutagen20_Effect)owner.GetBuff(EET_Mutagen20);
				buff.GetResistBonus(stat, pts, prc);
				
				charPts = charPts + pts;
				charPerc = charPerc + prc;
			}
		}
		
		points = CalculateAttributeValue(charPts);
		percents = MinF(1, CalculateAttributeValue(charPerc));		//max cap
		return;
	}
	
	//returns false if stats are not properly initialized
	/* moved to c++
	private function SetInitialStats(diff : EDifficultyMode) : bool
	{		
		var i : int;	
		var res : SResistanceValue;
		var emptyRes : SAbilityAttributeValue;
		var max : float;
		var statsCount : int;
	
		if(!owner.HasDefaultAbilitySet())			
		{
			LogAssert(false, "W3AbilityManager.SetInitialStats: actor <<" + owner + ">> has no default ability defined - don't know what to set, actor WILL NOT HAVE ANY STATS, aborting!!!");
			return false;
		}
		
		if(!ignoresDifficultySettings)
		{
			CacheDifficultyAbilities();
			
			//if diff has been initialized
			if(diff != EDM_NotSet)
				UpdateStatsForDifficultyLevel(diff);
		}
		
		//character stats
		statsCount = EnumGetMax( 'EBaseCharacterStats' ) + 1;
		for ( i = 0; i < statsCount; i+=1 )
		{
			max = CalculateAttributeValue(GetAttributeValueInternal(StatEnumToName(i)));
			if(max > 0)
			{
				if(!HasStat(i))
				{
					StatAddNew(i, max);
				}
				else
				{					
					UpdateStatMax(i);
					RestoreStat(i);
				}
			}
		}
				
		//resist stats
		statsCount = EnumGetMax( 'ECharacterDefenseStats' ) + 1;
		for ( i = 0; i < statsCount; i+=1 )
		{
			if(i != CDS_None)
			{
				res.points = GetAttributeValueInternal(ResistStatEnumToName(i, true));
				res.percents = GetAttributeValueInternal(ResistStatEnumToName(i, false));
				if(res.points != emptyRes || res.percents != emptyRes)
				{
					if(GetResistStatIndex(resistStats, i) < 0)
					{
						ResistStatAddNew(i);
					}
					else
					{					
						RecalcResistStat(i);
					}
				}
			}
		}
				
		return true;
	}
	*/
	
	/*
		Reads all attributes of character and checks which of them are ability names with difficulry modes defined.
		Then the abilities are cached in an array (for dynamic difficulty mode switching).
	*/
	/* moved to c++
	private function CacheDifficultyAbilities()
	{
		var dm : CDefinitionsManagerAccessor;
		var abs, atts, tags : array<name>;
		var i : int;
	
		dm = theGame.GetDefinitionsManager();
		charStats.GetAbilities(abs);		
		dm.GetUniqueContainedAbilities( abs, atts );
		
		for(i=0; i<atts.Size(); i+=1)
		{
			tags.Clear();
			dm.GetAbilityTags(atts[i], tags);
			
			if(!tags.Contains(theGame.params.DIFFICULTY_TAG_DIFF_ABILITY))
				continue;	//not a difficulty ability
			
			//one ability can be used for several modes, so no 'else' here			
			if(tags.Contains(theGame.params.DIFFICULTY_TAG_EASY))
				difficultyAbilities[EDM_Easy].PushBack(atts[i]);
			if(tags.Contains(theGame.params.DIFFICULTY_TAG_MEDIUM))
				difficultyAbilities[EDM_Medium].PushBack(atts[i]);
			if(tags.Contains(theGame.params.DIFFICULTY_TAG_HARD))
				difficultyAbilities[EDM_Hard].PushBack(atts[i]);
			if(tags.Contains(theGame.params.DIFFICULTY_TAG_HARDCORE))
				difficultyAbilities[EDM_Hardcore].PushBack(atts[i]);
		}
	}
	*/
	
	/* moved to c++
	//returns true if given stat is already defined in the stats array
	private function HasStat(stat : EBaseCharacterStats) : bool
	{
		var j : int;
		
		for(j=0; j<statPoints.Size(); j+=1)
			if(statPoints[j].type == stat)
				return true;
				
		return false;
	}
	*/
	
	//returns used HP type or BCS_Undefined if error
	public function UsedHPType() : EBaseCharacterStats
	{
		var j : int;
		var hasEss, hasVit : bool;
		
		hasEss = HasStat( BCS_Essence ) && GetStatMax( BCS_Essence ) > 0.0f;
		hasVit = HasStat( BCS_Vitality ) && GetStatMax( BCS_Vitality ) > 0.0f;

		if(hasVit && !hasEss)
			return BCS_Vitality;
		else if(!hasVit && hasEss)
			return BCS_Essence;
		else
			return BCS_Undefined;
	}
	
	//adds new stat to character stats
	/* moved to c++
	private function StatAddNew(s : EBaseCharacterStats, optional max : float)
	{
		var stat : SBaseStat;
		
		if(max > 0)
			stat.max = max;
		else
			stat.max = CalculateAttributeValue(GetAttributeValueInternal(StatEnumToName(s)));
			
		if(s == BCS_Vitality || s == BCS_Essence)
		{
			stat.max = stat.max * CalculateAttributeValue(GetAttributeValueInternal(theGame.params.DIFFICULTY_HP_MULTIPLIER));
		}
			
		stat.type = s;
		statPoints.PushBack(stat);
		RestoreStat(s);
	}
	*/
	
	//adds new resist stat to character stats
	/* moved to c++
	private function ResistStatAddNew(s : ECharacterDefenseStats)
	{
		var emptyRes : SResistanceValue;
	
		emptyRes.type = s;
		resistStats.PushBack(emptyRes);
		RecalcResistStat(s);
	}
	*/
	
	//updates resist stat value
	/* moved to c++
	protected function RecalcResistStat(stat : ECharacterDefenseStats)
	{
		var i : int;
	
		i = GetResistStatIndex(resistStats, stat);
	
		if(i >= 0)
		{
			resistStats[i].points = GetAttributeValueInternal(ResistStatEnumToName(stat, true));
			resistStats[i].percents = GetAttributeValueInternal(ResistStatEnumToName(stat, false));
		}
	}
	*/
		
	//restores stat to max or 0 depending on stat
	/*
	public function RestoreStat(i : EBaseCharacterStats)
	{
		switch(i)
		{
			case BCS_Toxicity:
			case BCS_Focus:
				SetStatPointCurrent(i, 0);
				break;
			default:
				SetStatPointCurrent(i, GetStatMax(i));
		}
	}
	*/
	
	/*
		Returns how many percents of max of given stat this actor has. Returns -1 if actor does not have this stat (undefined max value).
	*/
	/* moved to c++
	public final function GetStatPercents(stat : EBaseCharacterStats) : float
	{
		var i : int;
		var size : int;
		
		size = statPoints.Size();
		for( i=0; i < size; i+=1 )
			if(stat == statPoints[i].type)
				return statPoints[i].current / statPoints[i].max;
			
		return -1;
	}
	*/
	
	/*
		FOR CUSTOM USE ONLY!
		Forces setting given stat to given value.
	*/	
	public function ForceSetStat( stat : EBaseCharacterStats, val : float )
	{
		var prev : float;
			
		prev = GetStat(stat);
		SetStatPointCurrent(stat, MinF(GetStatMax(stat), MaxF(0, val)) );
		
		if(prev != GetStat(stat))
		{
			if( stat == BCS_Vitality )
			{
				OnVitalityChanged();				
			}
			else if( stat == BCS_Toxicity )
			{
				OnToxicityChanged();
			}
			else if( stat == BCS_Focus )
			{
				OnFocusChanged();
			}
			else if( stat == BCS_Air )
			{
				OnAirChanged();
			}
		}
	}
	
	//returns current value of given stat
	//the optional param is not used - here just for forward compatibility since we cannot overload functions :/
	/* moved to c++
	public function GetStat(stat : EBaseCharacterStats, optional skipLock : bool) : float
	{		
		var i : int;
		
		for(i=0; i<statPoints.Size(); i+=1)
			if(stat == statPoints[i].type)
				return statPoints[i].current;
				
		return -1;
	}
	*/
	
	//returns max value of given stat
	/* moved to c++
	public function GetStatMax(stat : EBaseCharacterStats) : float
	{		
		var i : int;
		
		for(i=0; i<statPoints.Size(); i+=1)
			if(stat == statPoints[i].type)
				return statPoints[i].max;
	
		return -1;
	}
	*/

	//returns current and max value of given stat
	/*
	public function GetStats( stat : EBaseCharacterStats, out curr : float, out max : float )
	{		
		var i : int;
		
		for( i=0; i < statPoints.Size(); i += 1 )
		{
			if ( stat == statPoints[ i ].type )
			{
				curr = statPoints[ i ].current;
				max  = statPoints[ i ].max;
				return;
			}
		}
		curr = -1;
		max  = -1;
	}
	*/
	
	/* moved to c++
	protected final function SetStatPointCurrent(stat : EBaseCharacterStats, val : float)
	{
		var i : int;
		
		for(i=0; i<statPoints.Size(); i+=1)
		{
			if(stat == statPoints[i].type)
			{
				statPoints[i].current = val;
				if ( stat == BCS_Air )
					this.OnAirChanged();
				return;
			}
		}
	}
	*/
	
	//for updating
	/*
	public function SetStatPointMax(stat : EBaseCharacterStats, val : float)
	{
		var i : int;
		
		for(i=0; i<statPoints.Size(); i+=1)
		{
			if(stat == statPoints[i].type)
			{
				statPoints[i].max = val;
				return;
			}
		}
	}
	*/
	
	//reduces current stat value
	protected function InternalReduceStat(stat : EBaseCharacterStats, amount : float)
	{
		SetStatPointCurrent(stat, MaxF( 0, GetStat(stat, true) - MaxF( 0, amount ) ) );
	}
	
	public function DrainAir(cost : float, optional delay : float )
	{
		//drain air
		if(cost > 0)
		{			
			InternalReduceStat(BCS_Air, cost);
			owner.StartAirRegen();
		}
		
		//regen delay (cost can be 0 - action costs nothing but it does generate delay)
		if(delay > 0)
			owner.PauseEffects(EET_AutoAirRegen, 'AirCostDelay', false, delay);		
	}
	
	public function DrainSwimmingStamina(cost : float, optional delay : float )
	{
		if(cost > 0)
		{			
			InternalReduceStat(BCS_SwimmingStamina, cost);
			owner.StartSwimmingStaminaRegen();
		}
		
		//regen delay (cost can be 0 - action costs nothing but it does generate delay)
		if(delay > 0)
			owner.PauseEffects(EET_AutoSwimmingStaminaRegen, 'SwimmingStaminaCostDelay', false, delay);		
	}
	
	//action - stamina action type
	//fixedValue - fixed value to drain, used only when ESAT_FixedValue is used
	//abilityName - name of the ability to use when passing ESAT_Ability
	//dt - if set then then stamina cost is treated as cost per second and thus multiplied by dt
	//costMult - if set (other than 0 or 1) then the actual cost is multiplied by this value
	//
	//returns actual final cost used
	public function DrainStamina(action : EStaminaActionType, optional fixedCost : float, optional fixedDelay : float, optional abilityName : name, optional dt : float, optional costMult : float) : float
	{
		var cost, delay : float;

		GetStaminaActionCost(action, cost, delay, fixedCost, fixedDelay, abilityName, dt, costMult);
		
		//drain stamina
		if(cost > 0)
		{
			InternalReduceStat(BCS_Stamina, cost);
			owner.StartStaminaRegen();
		}
		
		//regen delay (cost can be 0 - action costs nothing but it does generate delay)
		if(delay > 0)
		{
			if(IsNameValid(abilityName))
				owner.PauseEffects(EET_AutoStaminaRegen, abilityName, true, delay, true);
			else
				owner.PauseEffects(EET_AutoStaminaRegen, StaminaActionTypeToName(action), true, delay, true);
		}
		
		return cost;
	}
	
	//returns action's stamina cost and delay
	public function GetStaminaActionCost(action : EStaminaActionType, out cost : float, out delay : float, optional fixedCost : float, optional fixedDelay : float, optional abilityName : name, optional dt : float, optional costMult : float)
	{
		var costAtt, delayAtt : SAbilityAttributeValue;
		
		if(action == ESAT_FixedValue)
		{
			cost = fixedCost;
			delay = MaxF(0, fixedDelay);
		}
		else
		{
			GetStaminaActionCostInternal(action, dt > 0.0f, costAtt, delayAtt, abilityName);
	
			cost = CalculateAttributeValue(costAtt);
			delay = CalculateAttributeValue(delayAtt);
		}
		
		if(costMult != 0)
		{
			cost *= costMult;
		}
		
		if(dt > 0)
		{			
			cost *= dt;
		}
	}
	
	protected function GetStaminaActionCostInternal(action : EStaminaActionType, isPerSec : bool, out cost : SAbilityAttributeValue, out delay : SAbilityAttributeValue, optional abilityName : name)
	{
		var costAttributeName, delayAttributeName, attribute : name;
		var tags : array<name>;
		var val : SAbilityAttributeValue;
	
		//clear first
		cost = val;
		delay = val;
	
		theGame.params.GetStaminaActionAttributes(action, isPerSec, costAttributeName, delayAttributeName);
		
		//stats are in an ability - not added to the character
		if(action == ESAT_Ability)
		{
			if(isPerSec)
				attribute = theGame.params.STAMINA_COST_PER_SEC_DEFAULT;
			else 
				attribute = theGame.params.STAMINA_COST_DEFAULT;
				
			cost = GetSkillAttributeValue(abilityName, attribute, false, true);
			delay = GetSkillAttributeValue(abilityName, theGame.params.STAMINA_DELAY_DEFAULT, false, true);
		}
		//stats are on the character
		else
		{
			cost = GetAttributeValueInternal(costAttributeName);
			delay = GetAttributeValueInternal(delayAttributeName);
		}
		
		cost += GetAttributeValueInternal('stamina_cost_modifier');
		delay += GetAttributeValueInternal('stamina_delay_modifier');
	}
	
	/*
		If *addBaseCharAttribute* is set then adds also the attribute value from character base (base, global passive skills etc).
		If *addSkillModsAttribute* is set then also adds modifiers from other skills that influence this skill (e.g. skill increasing spell power for all igni skills)
	*/
	public function GetSkillAttributeValue(abilityName: name, attributeName : name, addBaseCharAttribute : bool, addSkillModsAttribute : bool) : SAbilityAttributeValue
	{
		var min, max :SAbilityAttributeValue;
		
		theGame.GetDefinitionsManager().GetAbilityAttributeValue(abilityName, attributeName, min, max);
		return GetAttributeRandomizedValue(min, max);
	}
	
	public function DrainFocus(amount : float )
	{
		InternalReduceStat(BCS_Focus, amount);
		OnFocusChanged();
	}
	
	public function DrainMorale(amount : float )
	{
		InternalReduceStat(BCS_Morale, amount);
		owner.StartMoraleRegen();
	}
	
	public function DrainToxicity(amount : float )
	{
		InternalReduceStat(BCS_Toxicity, amount);
		OnToxicityChanged();
	}
	
	//called only by owner to actually reduce vitality when dealt final damage
	public function DrainVitality(amount : float)
	{	
		SetStatPointCurrent(BCS_Vitality, MaxF( 0, GetStat(BCS_Vitality) - MaxF(0, amount) ));
		owner.StartVitalityRegen();
		
		if(GetStat(BCS_Vitality) <= 0 && owner.UsesVitality())
		{
			owner.SignalGameplayEvent( 'Death' );
			owner.SetAlive(false);
		}
		
		OnVitalityChanged();
	}
	
	//called only by owner to actually reduce essence when dealt final damage
	public function DrainEssence(amount : float)
	{
		SetStatPointCurrent(BCS_Essence, MaxF( 0, GetStat(BCS_Essence) - MaxF(0, amount) ) );
		owner.StartEssenceRegen();
		
		if(GetStat(BCS_Essence) <= 0 && owner.UsesEssence())
		{
			owner.SignalGameplayEvent( 'Death' );
			owner.SetAlive(false);
		}
	}
	
	public function AddPanic( amount : float )
	{
		SetStatPointCurrent( BCS_Panic, RoundF(MaxF( 0, GetStat( BCS_Panic ) - amount )) );
		owner.StartPanicRegen();
	}
	
	/*
	public function ResetStaticPanic()
	{
		SetStatPointCurrent( BCS_PanicStatic, 0.f );
	}
	
	public function SetStaticPanic( amount : float )
	{
		var temp : int;
		var currVal : float;
		
		currVal = GetStat( BCS_Panic );
		
		SetStatPointCurrent( BCS_PanicStatic, RoundF(amount) );
		
		owner.StartPanicRegen();
	}
	
	public function GetStaticPanic() : int
	{
		return RoundF( GetStat( BCS_PanicStatic ) ) ;
	}*/
	
	//adds given amount of points to particular stat
	public function GainStat( stat : EBaseCharacterStats, amount : float )
	{
		var statWithoutLock, statWithLock, lock, max : float;
		var hadOverheal : bool;
		var mi, ma : SAbilityAttributeValue;
		
		statWithoutLock = GetStat(stat, true);
		statWithLock = GetStat(stat, false);
		lock = statWithLock - statWithoutLock;
		max = GetStatMax(stat);
		
		SetStatPointCurrent(stat, MinF( max - lock, statWithoutLock + MaxF(0, amount) ) );
		
		if( stat == BCS_Vitality )
		{
			OnVitalityChanged();
			if ( (W3PlayerAbilityManager)this && owner == GetWitcherPlayer() && GetWitcherPlayer().HasRunewordActive('Runeword 4 _Stats') && GetWitcherPlayer().IsInCombat() && (statWithoutLock + amount) > max )
			{
				theGame.GetDefinitionsManager().GetAbilityAttributeValue('Runeword 4 _Stats', 'max_bonus', mi, ma);				
				hadOverheal = (overhealBonus > (0.005 * GetStatMax(BCS_Vitality)));
				overhealBonus += (statWithoutLock + amount) - GetStatMax(stat);
				overhealBonus = MinF(overhealBonus, max * ma.valueMultiplicative);
				thePlayer.PlayRuneword4FX();				
			}
		}
		else if( stat == BCS_Toxicity )
			OnToxicityChanged();
		else if( stat == BCS_Focus )
			OnFocusChanged();
	}
	
	//Recalculates and updates max value of given stat
	/*
	public function UpdateStatMax(stat : EBaseCharacterStats)
	{
		var statName : name;
		var statValue : float;
		
		statName = StatEnumToName(stat);
		statValue = CalculateAttributeValue(GetAttributeValueInternal(statName), stat == BCS_Vitality);
		
		if(stat == BCS_Vitality || stat == BCS_Essence)
		{
			statValue *= CalculateAttributeValue(GetAttributeValueInternal(theGame.params.DIFFICULTY_HP_MULTIPLIER));
		}
		
		SetStatPointMax(stat, statValue);
	}
	*/
	
	//FIXME
	//TODO
	//ABB set params for applicator e.g. based on skill level etc.
	public function GetApplicatorParamsFor(applicator : W3ApplicatorEffect, out pwrStatValue : SAbilityAttributeValue)
	{
	}
	
	//Updates stats due to difficulty mode being changed
	/* moved to c++
	public function UpdateStatsForDifficultyLevel(d : EDifficultyMode)
	{
		if(usedDifficultyMode == d)
			return;
				
		UpdateDifficultyAbilities(d);		
		usedDifficultyMode = d;
	}
	*/
	
	/*
		Removes difficulty abilities for modes other than passed new mode and adds not yet added abilities for new difficulty mode.
	*/
	/* moved to c++
	private function UpdateDifficultyAbilities(newDifficulty : EDifficultyMode)
	{
		var dm : CDefinitionsManagerAccessor;
		var i : int;
		var abs : array<name>;
		var newDiffTag, newAbility : name;
	
		dm = theGame.GetDefinitionsManager();
		charStats.GetAbilities(abs);
		newDiffTag = GetDifficultyTagForMode(newDifficulty);
		
		//remove old diff abilities
		for(i=0; i<abs.Size(); i+=1)
		{
			if(dm.AbilityHasTag(abs[i], theGame.params.DIFFICULTY_TAG_DIFF_ABILITY) && !dm.AbilityHasTag(abs[i], newDiffTag))
				charStats.RemoveAbility(abs[i]);
		}
		
		//add new
		for(i=0; i<difficultyAbilities[newDifficulty].Size(); i+=1)
		{
			newAbility = difficultyAbilities[newDifficulty][i];
			if(!charStats.HasAbility(newAbility))
				charStats.AddAbility(newAbility, false);
		}
	}
	*/
	
	public function IgnoresDifficultySettings() : bool
	{
		return ignoresDifficultySettings;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////    ---===  @EVENTS  ===---    ////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	protected function OnVitalityChanged();	
	protected function OnToxicityChanged();
	protected function OnFocusChanged();
	protected function OnAirChanged();
	
	//remember about OnAbilityRemoved !!!
	public function OnAbilityAdded(abilityName : name)
	{
		var idx : int;
	
		if(!owner)
			return;		//script adding abilities before OnSpawned() is processed - we don't need to update anything in that case
	
		if(IsAbilityBlocked(abilityName))
		{
			idx = FindBlockedAbility(abilityName);
			blockedAbilities[idx].count += 1;			//the ability is already blocked so we need to increase the counter
			charStats.RemoveAbility(abilityName);		//remove the ability that was added - since it's blocked. The Remove decreases the counter as it removes
			blockedAbilities[idx].count += 1;			//increase the counter again as we want to store the info that additional instance of ability is on character
		}
		else
		{
			OnAbilityChanged(abilityName);
		}
	}
	
	//remember about OnAbilityAdded !!!
	public function OnAbilityRemoved(abilityName : name)
	{
		var idx : int;
		
		if(!owner)
			return;		//script removing abilities before OnSpawned() is processed - we don't need to update anything in that case
			
		if(IsAbilityBlocked(abilityName))
		{
			idx = FindBlockedAbility(abilityName);
			blockedAbilities[idx].count -= 1;
			//we don't erase ability from array if count is 0 because later the ability could be added again and thus would override the blocking mechanism
		}
		else
		{
			OnAbilityChanged(abilityName);
			
			if(abilityName == 'Runeword 4 _Stats')
				ResetOverhealBonus();
		}
	}
	
	//Called when an ability has changed (been added or removed)
	protected function OnAbilityChanged(abilityName : name)
	{
		var atts, tags : array<name>;
		var i,size,stat, j : int;
		var oldMax, maxVit, maxEss : float;
		var resistStatChanged, tmpBool : bool;
		var dm : CDefinitionsManagerAccessor;
		var val : SAbilityAttributeValue;
		var buffs : array<CBaseGameplayEffect>;
		var regenBuff : W3RegenEffect;
		var cannotAddAttributes : array< name >;
				
		dm = theGame.GetDefinitionsManager();
		dm.GetAbilityAttributes(abilityName, atts);		
		resistStatChanged = false;
		size = atts.Size();
		
		//check for difficulty ignores
		if(dm.AbilityHasTag(abilityName, theGame.params.DIFFICULTY_TAG_IGNORE))
		{
			ignoresDifficultySettings = true;
			difficultyAbilities.Clear();
			usedDifficultyMode = EDM_NotSet;
		}
		
		// In most cases this list will consist of zero of one element
		// so searching is fast.
		owner.GetListOfCannotAddAttributes( cannotAddAttributes );
		
		for(i=0; i<size; i+=1)
		{					
			if ( cannotAddAttributes.Contains( atts[i] ) )
			{
				continue;
			}
		
			//  -------------------  check if added ability is cached and if so update the proper cache
			//  Base Stat
			stat = StatNameToEnum(atts[i]);
			if(stat != BCS_Undefined)
			{
				if(!HasStat(stat))
				{
					//did not have this stat at all so far
					StatAddNew(stat);
				}
				else
				{
					//if already had stat
					if(abilityName == theGame.params.GLOBAL_ENEMY_ABILITY || abilityName == theGame.params.GLOBAL_PLAYER_ABILITY || abilityName == theGame.params.ENEMY_BONUS_PER_LEVEL || abilityName == theGame.params.ENEMY_BONUS_PER_DELEVEL)
					{
						//if this is the global ability added to all then we need to restore stat after update...
						UpdateStatMax(stat);
						RestoreStat(stat);
					}
					else
					{
						//... otherwise to multiply current value by percentage equal to percentage present before the update
						oldMax = GetStatMax(stat);
						UpdateStatMax(stat);
						MutliplyStatBy(stat, GetStatMax(stat) / oldMax);
					}
				}
				continue;
			}
			
			//  Resist Stat
			stat = ResistStatNameToEnum(atts[i], tmpBool);
			if(stat != CDS_None)
			{
				if ( HasResistStat( stat ) )
				{
					RecalcResistStat(stat);
					resistStatChanged = true;
				}								
				else
				{
					//if did not have this stat at all so far
					ResistStatAddNew(stat);
				}
				
				continue;
			}
			
			//power stat
			stat = PowerStatNameToEnum(atts[i]);
			if(stat != CPS_Undefined)
			{
				owner.UpdateApplicatorBuffs();
				continue;
			}
			
			//regen stat
			stat = RegenStatNameToEnum(atts[i]);
			if(stat != CRS_Undefined && stat != CRS_UNUSED)
			{
				buffs = owner.GetBuffs();
				
				for(j=0; j<buffs.Size(); j+=1)
				{
					regenBuff = (W3RegenEffect)buffs[j];
					if(regenBuff)
					{
						if(regenBuff.GetRegenStat() == stat && IsBuffAutoBuff(regenBuff.GetEffectType()))
						{
							regenBuff.UpdateEffectValue();
							break;
						}
					}
				}
				if( stat == CRS_Essence )
				{
					owner.StartEssenceRegen();
				}
			}
			
			//difficulty attributes
			if(!ignoresDifficultySettings && atts[i] == theGame.params.DIFFICULTY_HP_MULTIPLIER)
			{		
				//check if vit / ess is used. At this point on spawn it's too early to call owner.UsesVitality();

				maxVit = GetStatMax( BCS_Vitality );
				maxEss = GetStatMax( BCS_Essence );
				if(maxVit > 0)
				{
					oldMax = maxVit;
					UpdateStatMax(BCS_Vitality);					
					MutliplyStatBy(BCS_Vitality, GetStatMax(BCS_Vitality) / oldMax);
				}
				
				if(maxEss > 0)
				{
					oldMax = maxEss;
					UpdateStatMax(BCS_Essence);					
					MutliplyStatBy(BCS_Essence, GetStatMax(BCS_Essence) / oldMax);
				}
				
				continue;
			}		
		}
		
		if(resistStatChanged)
			owner.RecalcEffectDurations();
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////  @RUNEWORD OVERHEAL /////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////
	public function GetOverhealBonus() : float
	{
		return overhealBonus;
	}
	
	public function ResetOverhealBonus()
	{
		overhealBonus = 0;
		thePlayer.StopEffect('runeword_4');
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////  @DEBUG  ////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////
	
	public function Debug_GetUsedDifficultyMode() : EDifficultyMode
	{
		return usedDifficultyMode;
	}
}
