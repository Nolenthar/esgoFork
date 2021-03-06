/***********************************************************************/
/** Copyright © 2009-2012
/** Author : Dexio's Late Night R&D Home Center, the collective mind of CDP
/***********************************************************************/

enum EConverserType
{
	CT_General,
	CT_Nobleman,
	CT_Guard,
	CT_Mage,
	CT_Bandit,
	CT_Scoiatael,
	CT_Peasant,
	CT_Poor,
	CT_Child
};


statemachine import class CNewNPC extends CActor
{
	//////////////////////////////////////////
	//EDITABLE
	
	editable var isImmortal 		: bool;				//this is bad should set the immortality mode simply, left because it would screw up entities
	editable var isInvulnerable 	: bool;				//this is bad should set the immortality mode simply, left because it would screw up entities
	editable var willBeUnconscious 	: bool;				//this is bad should set the immortality mode simply, left because it would screw up entities
	editable var minUnconsciousTime : float;    		default minUnconsciousTime = 20.f;
	
	editable var unstoppable		: bool;				hint unstoppable = "won't play hit reaction nor critical state reaction";
	
	editable var RemainsTags 		: array<name>;		hint RemainsTags="If set then the NPC's remains will be tagged with given tags";
	editable var level 				: int;				default level = 1;
	editable var Level				: int;
	editable var downscaleLevel		: int;
	saved	 var currentLevel		: int;
	editable saved var levelFakeAddon     : int;				default levelFakeAddon = 0;
	private	 saved var newGamePlusFakeLevelAddon : bool;		default newGamePlusFakeLevelAddon = false;
	editable var isMiniBossLevel    : bool;				default isMiniBossLevel = false;
	editable var suppressBroadcastingReactions		: bool;		default suppressBroadcastingReactions = false;
	editable saved var dontUseReactionOneLiners		: bool;		default dontUseReactionOneLiners = false;
	editable saved var disableConstrainLookat		: bool;		default disableConstrainLookat = false;
	
	editable var isMonsterType_Group   : bool;  		default isMonsterType_Group = false;
	
	editable var useSoundValue		: bool;				default useSoundValue = false;
	editable var soundValue			: int;	
	
	
	editable var clearInvOnDeath			: bool;	
	default clearInvOnDeath = false;
	
	editable var noAdaptiveBalance : bool;
	default noAdaptiveBalance = false;
	
	editable var grantNoExperienceAfterKill : bool;
	default grantNoExperienceAfterKill = false;
	
	hint disableConstrainLookat = "It will disable lookats form reactions and from QuestLookat block";
	hint useSoundValue = "If true it will add the SoundValue to the threat Rating used for combat music control";
	hint soundValue = "This value will be added or subtracted from sound system to achieve final threat Rating";
	///////////////////////////////////////////////////////
	
	// NPC type
	import private saved var npcGroupType 		: ENPCGroupType;	default npcGroupType = ENGT_Enemy;
	
	// for horse
	private optional autobind 	horseComponent 		: W3HorseComponent = single;
	private var 		isHorse 			: bool;
	private saved var 	canFlee				: bool; 	default 	canFlee	= true;
	private var 		isFallingFromHorse 	: bool; 	default 	isFallingFromHorse = false;
	
	private var		immortalityInitialized	: bool;
	
	// for player to enable following other rider
	private var 	canBeFollowed 			: bool;		default 		canBeFollowed = false;

	//for agony state
	private var 	bAgony					: bool;		default 		bAgony 	= false;
	private var		bFinisher 				: bool;		default 		bFinisher = false;
	private var		bPlayDeathAnim 			: bool;		default			bPlayDeathAnim = true;
	private var		bAgonyDisabled			: bool;		default			bAgonyDisabled = false;
	private var		bFinisherInterrupted	: bool;
	
	private var		bIsInHitAnim : bool;
	
	// for combat 
	private var		threatLevel					: int;				default			threatLevel = 10;
	private var 	counterWindowStartTime 		: EngineTime;		//timestamp of moment when the counter window was opened
	private var		bIsCountering				: bool;
	private var		allowBehGraphChange			: bool;				default			allowBehGraphChange = true;
	private var		aardedFlight				: bool;				//set when hit by aard to check aard related fall kills
	public var		lastMeleeHitTime			: EngineTime;		//time when last hit by melee attack
	
	private saved var preferedCombatStyle : EBehaviorGraph;
	
	// for stance
	private var		previousStance				: ENpcStance;		default			previousStance	= NS_Normal;
	private var		regularStance				: ENpcStance;		default			regularStance	= NS_Normal;
	
	//fight stage
	private var 	currentFightStage			: ENPCFightStage;
	
	// for states
	private var 	currentState 				: CName;			default 		autoState = 'NewIdle';

	private var 	behaviorGraphEventListened	: array<name>;
	
	// for visual
	private var 	isTemporaryOffGround			: bool;
	
	// for water
	private var		isUnderwater 				: bool;		default isUnderwater = false;
	
	// to check whether npc's hitreaction animation is scaled
	private var isTranslationScaled 			: bool; 
	
	//tauntedToAttack
	private var tauntedToAttackTimeStamp 		: float;
	
	private var hitCounter 						: int;		default hitCounter = 0;
	private var totalHitCounter 				: int;		default totalHitCounter = 0;
	public var customHits 						: bool;		default customHits = false;
	
	//public var enemy 							: CActor;
	
	//for debug purpouse
	public var isTeleporting 					: bool;			default isTeleporting = false;
	
	
	//flying creatures in interiors
	//private editable var interior : bool;
	//default interior = false;	
	
	// inventory
	public var itemToEquip 						: SItemUniqueId;
	
	//achievement
	private saved var wasBleedingBurningPoisoned 	: bool;		default wasBleedingBurningPoisoned = false;
	
	// misc
	public 	var wasInTalkInteraction				: bool;
	private var wasInCutscene						: bool;
	public 	var shieldDebris 						: CItemEntity;
	public 	var lastMealTime						: float;	default lastMealTime = -1;// Used for food component
	public 	var packName							: name;		// Used for animal movements
	public 	var isPackLeader						: bool;		// Used for animal movements
	private var mac 								: CMovingPhysicalAgentComponent;
	
	//reactions, talking
	private saved  var isTalkDisabled				: bool; default isTalkDisabled = false;
	private   	   var isTalkDisabledTemporary		: bool; default isTalkDisabledTemporary = false;
	
	//flag fro adding ng+ levels OnSpawn
	private var wasNGPlusLevelAdded					: bool; default wasNGPlusLevelAdded = false;
	
	event OnGameDifficultyChanged( previousDifficulty : int, currentDifficulty : int )
	{
		if ( HasAbility('difficulty_CommonEasy') ) RemoveAbility('difficulty_CommonEasy');
		if ( HasAbility('difficulty_CommonMedium') )  RemoveAbility('difficulty_CommonMedium');
		if ( HasAbility('difficulty_CommonHard') )  RemoveAbility('difficulty_CommonHard');
		if ( HasAbility('difficulty_CommonHardcore') )  RemoveAbility('difficulty_CommonHardcore');
		
		switch ( theGame.GetSpawnDifficultyMode() )
		{
		case EDM_Easy:
			AddAbility('difficulty_CommonEasy');
			break;
		case EDM_Medium:
			AddAbility('difficulty_CommonMedium');
			break;
		case EDM_Hard:
			AddAbility('difficulty_CommonHard');
			break;
		case EDM_Hardcore:
			AddAbility('difficulty_CommonHardcore');
			break;
		}	

		AddTimer('AddLevelBonuses', 0.1, true, false, , true);	
	}
	
	timer function ResetTalkInteractionFlag( td : float , id : int)
	{
		if ( !IsSpeaking() )
		{
			wasInTalkInteraction = false;
			RemoveTimer('ResetTalkInteractionFlag');
		}
	}
		
	protected function OnCombatModeSet( toggle : bool )
	{
		super.OnCombatModeSet( toggle );
		
		if( toggle )
		{
			SetCombatStartTime();
			SetCombatPartStartTime();
			
			//autogen level is not updated when player levels up so we need to check it when enemy enters combat
			//apart from that we do similar recalc when we target enemy (show health bar)
			//cannot do this on player level up as actors are not streamed and it generates 1s+ freeze due to few thousands actors checked
			RecalcLevel();
		}
		else
		{
			ResetCombatStartTime();
			ResetCombatPartStartTime();
		}		
	}
	
	public function SetImmortalityInitialized(){ immortalityInitialized = true; }
	
	public function SetNPCType( type : ENPCGroupType ) { npcGroupType = type; }
	public function GetNPCType() : ENPCGroupType { return npcGroupType; }
	
	public function SetCanBeFollowed( val : bool ) { canBeFollowed = val; }
	public function CanBeFollowed() : bool { return canBeFollowed; }
	
	event OnPreAttackEvent(animEventName : name, animEventType : EAnimationEventType, data : CPreAttackEventData, animInfo : SAnimationEventAnimInfo )
	{
		var witcher : W3PlayerWitcher;
		var levelDiff : int;
	
		super.OnPreAttackEvent(animEventName, animEventType, data, animInfo);
		
		if(animEventType == AET_DurationStart )
		{
			/* AK : we are draining stamina on all special actions now, but not globally on regular attacks
			if ( IsHeavyAttack(data.attackName))
				DrainStamina(ESAT_HeavyAttack);
			else
				DrainStamina(ESAT_LightAttack);
			*/
			
			witcher = GetWitcherPlayer();
			
			
			
			if(GetTarget() == witcher )
			{
				levelDiff = GetLevel() - witcher.GetLevel();
				
				if ( levelDiff < theGame.params.LEVEL_DIFF_DEADLY )
					this.SetDodgeFeedback( true );
			}
			
			if ( IsCountering() )
			{
				//if has skill, toxicity and can dodge
				if(GetTarget() == witcher && ( thePlayer.IsActionAllowed(EIAB_Dodge) || thePlayer.IsActionAllowed(EIAB_Roll) ) && witcher.GetStat(BCS_Toxicity) > 0 && witcher.CanUseSkill(S_Alchemy_s16))
					witcher.StartFrenzy();
			}
		}
		else if(animEventType == AET_DurationEnd )
		{
			witcher = GetWitcherPlayer();
			
			if(GetTarget() == witcher )
			{		
				this.SetDodgeFeedback( false );
			}
		}
	}
	
	public function SetDodgeFeedback( flag : bool )
	{
		
		if ( flag )
		{
			thePlayer.SetDodgeFeedbackTarget( this );
		}
		else
		{
			thePlayer.SetDodgeFeedbackTarget( NULL );
		}
	}
	
	event OnBlockingSceneEnded( optional output : CStorySceneOutput)
	{
		super.OnBlockingSceneEnded( output );
		wasInCutscene = true;
	}
	
	public function WasInCutscene() : bool
	{
		return wasInCutscene;
	}
	
	//UI: quick function to check whether NPC's are VIP (to highlight their name in a special color beyond their attitude)
	public function IsVIP() : bool
	{
		var tags : array<name>;
		var i : int;
		
		// iterating through tags will be probably faster than HasTag function
		tags = GetTags();
		for ( i = 0; i < tags.Size(); i+=1 )
		{
			if ( tags[i] == 'vip' )
			{
				return true;
			}
		}
		
		return false;
	}
	
	/////////////////////////////////////////////
	// Defaults
	/////////////////////////////////////////////	
	
	/*
		Initialize NPC
	*/
	event OnSpawned(spawnData : SEntitySpawnData )
	{
		var lvlDiff, playerLevel : int;
		var heading 		: float;
		var remainingDuration : float;
		var oldLevel : int;
		
		if (!spawnData.restored)
			currentLevel = level;
		
		super.OnSpawned(spawnData);
		
		//Set threat level
		SetThreatLevel();
		
		//set default state after spawn
		GotoStateAuto();		
		
		// reset temporary "disable talk"
		isTalkDisabledTemporary = false;
		
		//set immortality mode
		if(!spawnData.restored && !immortalityInitialized )
		{
			SetCanPlayHitAnim( true );
			
			if(isInvulnerable)
			{
				SetImmortalityMode(AIM_Invulnerable, AIC_Default);
			}
			else if(isImmortal)
			{
				SetImmortalityMode(AIM_Immortal, AIC_Default);
			}
			else if( willBeUnconscious )
			{
				SetImmortalityMode(AIM_Unconscious, AIC_Default);
				SignalGameplayEventParamFloat('ChangeUnconsciousDuration',minUnconsciousTime);
			}
			else if ( npcGroupType == ENGT_Commoner || npcGroupType == ENGT_Guard || npcGroupType == ENGT_Quest )
			{
				SetImmortalityMode(AIM_Unconscious, AIC_Default);	
			}
		}
		
		// Special push priorities
		if( npcGroupType == ENGT_Guard )
		{
			SetOriginalInteractionPriority( IP_Prio_5 );
			RestoreOriginalInteractionPriority();
		}
		else if( npcGroupType == ENGT_Quest )
		{
			SetOriginalInteractionPriority( IP_Max_Unpushable );
			RestoreOriginalInteractionPriority();
		}
		
		/*if( npcGroupType == ENGT_Guard || npcGroupType == ENGT_Commoner )
			GetComponent('talk').SetEnabled(false);*/
		
		mac = (CMovingPhysicalAgentComponent)GetMovingAgentComponent();
		if(mac && IsFlying() )
			mac.SetAnimatedMovement( true );
		
		// register for collision reports
		RegisterCollisionEventsListener();		
		
		// set default for NPC's focus mode sound visualisation, and if no other colour has been assigned.
		if (focusModeSoundEffectType == FMSET_None)
			SetFocusModeSoundEffectType( FMSET_Gray );
		
		heading	= AngleNormalize( GetHeading() );
		//update requestedFacingDirection to match current heading
		SetBehaviorVariable( 'requestedFacingDirection', heading );
		
		if ( disableConstrainLookat )
			SetBehaviorVariable( 'disableConstraintLookat', 1.f);
			
		// switch for voiceovers for npcs on foot
		SoundSwitch( "vo_3d", 'vo_3d_long', 'head' );
		
		AddAnimEventCallback('EquipItemL' ,			'OnAnimEvent_EquipItemL');
		AddAnimEventCallback('HideItemL' ,			'OnAnimEvent_HideItemL');
		AddAnimEventCallback('HideWeapons' ,		'OnAnimEvent_HideWeapons');
		AddAnimEventCallback('TemporaryOffGround' ,	'OnAnimEvent_TemporaryOffGround');
		AddAnimEventCallback('OwlSwitchOpen' ,		'OnAnimEvent_OwlSwitchOpen');
		AddAnimEventCallback('OwlSwitchClose' ,		'OnAnimEvent_OwlSwitchClose');
		AddAnimEventCallback('Goose01OpenWings' ,	'OnAnimEvent_Goose01OpenWings');
		AddAnimEventCallback('Goose01CloseWings' ,	'OnAnimEvent_Goose01CloseWings');
		AddAnimEventCallback('Goose02OpenWings' ,	'OnAnimEvent_Goose02OpenWings');
		AddAnimEventCallback('Goose02CloseWings' ,	'OnAnimEvent_Goose02CloseWings');
		AddAnimEventCallback('NullifyBurning' ,		'OnAnimEvent_NullifyBurning');
		AddAnimEventCallback('setVisible' ,			'OnAnimEvent_setVisible');
		AddAnimEventCallback('extensionWalk' ,		'OnAnimEvent_extensionWalk');
		AddAnimEventCallback('weaponSoundType' ,	'OnAnimEvent_weaponSoundType');
		
		if( HasTag( 'olgierd_gpl' ) )
		{
			AddAnimEventCallback('IdleDown' ,					'OnAnimEvent_IdleDown');
			AddAnimEventCallback('IdleForward' ,				'OnAnimEvent_IdleForward');
			AddAnimEventCallback('IdleCombat' ,					'OnAnimEvent_IdleCombat');
			AddAnimEventCallback('WeakenedState' ,				'OnAnimEvent_WeakenedState');
			AddAnimEventCallback('WeakenedStateOff' ,			'OnAnimEvent_WeakenedStateOff');
			AddAnimEventCallback('SlideAway' ,					'OnAnimEvent_SlideAway');
			AddAnimEventCallback('SlideForward' ,				'OnAnimEvent_SlideForward');
			AddAnimEventCallback('SlideTowards' ,				'OnAnimEvent_SlideTowards');
			AddAnimEventCallback('OpenHitWindow' ,				'OnAnimEvent_WindowManager');
			AddAnimEventCallback('CloseHitWindow' ,				'OnAnimEvent_WindowManager');
			AddAnimEventCallback('OpenCounterWindow' ,			'OnAnimEvent_WindowManager');
			AddAnimEventCallback('BC_Weakened' ,				'OnAnimEvent_PlayBattlecry');
			AddAnimEventCallback('BC_Attack' ,					'OnAnimEvent_PlayBattlecry');
			AddAnimEventCallback('BC_Parry' ,					'OnAnimEvent_PlayBattlecry');
			AddAnimEventCallback('BC_Sign' ,					'OnAnimEvent_PlayBattlecry');
			AddAnimEventCallback('BC_Taunt' ,					'OnAnimEvent_PlayBattlecry');
		}
		
		if(HasAbility('_canBeFollower') && theGame.GetDifficultyMode() != EDM_Hardcore) 
			RemoveAbility('_canBeFollower');

		//if ( level > 3 && HasTag('main_quest_opponent') )
			//level += theGame.newGameLevelAddon;
			
		//FIXME URGENT - what if player is not spawned yet?
		if( (!spawnData.restored || !wasNGPlusLevelAdded)  && (FactsQuerySum("NewGamePlus") > 0 || (!HasAbility('NoAdaptBalance') && currentLevel > 1 ) ) )
		{
			if ( theGame.IsActive() )
			{
				if( ( FactsQuerySum("NewGamePlus") > 0 ) && !HasTag('animal') )
				{
					if( !HasAbility('NPCDoNotGainBoost') && !HasAbility('NewGamePlusFakeLevel') )
					{
						currentLevel = level;
					}
					else if ( !HasAbility('NPCDoNotGainNGPlusLevel') )
					{
						newGamePlusFakeLevelAddon = true;
					}
					
					wasNGPlusLevelAdded = true;
					
				}
				else
				{
					// Prolog modifier	for easy and normal
					if ( ( theGame.GetDifficultyMode() == EDM_Easy || theGame.GetDifficultyMode() == EDM_Medium ) && playerLevel == 1 && npcGroupType != ENGT_Guard && !HasAbility('PrologModifier'))
					{
						AddAbility('PrologModifier');
					}
				}
			}	
		}		
	}
	
	protected function SetAbilityManager()
	{
		if(npcGroupType != ENGT_Commoner)
			abilityManager = new W3NonPlayerAbilityManager in this;		
	}
	
	protected function SetEffectManager()
	{
		if(npcGroupType != ENGT_Commoner)
			super.SetEffectManager();
	}
	
	//Dynamic Scaling - Start

	public function GetIsContractTypeMonster() : bool
	{
		if ( HasAbility('mh302_Leshy') || HasAbility('mh202_nekker') || HasAbility('mh106_HAG') || HasAbility('mh306_dao') || HasAbility('qMH208_Noonwraith') || HasAbility('mh305_doppler') || HasAbility('mh305_doppler_geralt') || HasAbility('mh301_Gryphon') || HasAbility('mh307_Minion') || HasAbility('mh207_wraith') || HasAbility('mh207_wraith_boss') || HasAbility('qMH101_cockatrice') || HasAbility('mon_wraith_mh') || HasAbility('mon_nightwraith_mh') || HasAbility('mon_noonwraith_mh') || HasAbility('mon_wild_hunt_minionMH') || HasAbility('mon_forktail_mh') || HasAbility('mon_fogling_mh') || HasAbility('q302_mh104') || HasAbility('qmh303_suc') || HasAbility('qmh210_lamia') || HasAbility('qmh208_forktail') || HasAbility('qmh108_fogling') || HasAbility('qmh304_ekima') || HasAbility('qmh206_bies') )
			return true;
		else return false;
	}
	
	public function GetIsBoss() : bool
	{
		if ( HasAbility('WildHunt_Eredin') || HasAbility('WildHunt_Imlerith') || HasAbility('WildHunt_Caranthir') || HasAbility('WildHunt_Caranthir_NGPlus') || HasAbility('WildHunt_Imlerith_NGPlus') || HasAbility('WildHunt_Eredin_NGPlus') || HasAbility('mon_witch1') || HasAbility('mon_witch2') || HasAbility('mon_witch3') || HasAbility('q104_whboss') || HasAbility('q202_IceGiantDOOM') || HasAbility('mon_nightwraith_iris') || HasAbility('mon_toad_base') || HasAbility('q604_caretaker') || HasAbility('mon_djinn') )
			return true;
		else return false;
	}
	
	public function GetIsGroupTypeMonster() : bool
	{
		if ( HasAbility('mon_boar_base') || HasAbility('mon_black_spider_base') || GetSfxTag() == 'sfx_alghoul' || GetSfxTag() == 'sfx_endriaga' || GetSfxTag() == 'sfx_ghoul' || GetSfxTag() == 'sfx_wraith' || GetSfxTag() == 'sfx_wild_dog' || GetSfxTag() == 'sfx_drowner' || GetSfxTag() == 'sfx_fogling' || HasAbility('mon_erynia') || GetSfxTag() == 'sfx_harpy'  || GetSfxTag() == 'sfx_nekker' ||  GetSfxTag() == 'sfx_siren' || GetSfxTag() == 'sfx_wildhunt_minion' || HasAbility('mon_rotfiend') || HasAbility('mon_rotfiend_large') )
			return true;
		else return false;
	}
	
	private function CalculateLevel () : int
	{
		var level_ : int;
		var ScalingInit : DynamicScaling;
		var ciriEntity  : W3ReplacerCiri;
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		
		ScalingInit = new DynamicScaling in this;
		
		ScalingInit.SetValues();
		
		if ( ScalingInit.Scale() ) 
		{
			if ( !ScalingInit.ScalingCheck() )
			{
				if ( ( GetWitcherPlayer().GetLevel() >= 1 ) && ( GetWitcherPlayer().GetLevel() < ScalingInit.TierOneHighestLevel ) && ( ScalingInit.MaximumLevelCap > ScalingInit.TierOneLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierOneGroupMinimumAdded, ScalingInit.TierOneGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierOneHumanMin, ScalingInit.TierOneHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}			
					else 
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierOneMaximumAdded, ScalingInit.TierOneMinimumAdded );
					}
				}
				else if ( ( GetWitcherPlayer().GetLevel() >= ScalingInit.TierTwoLowestLevel ) && ( GetWitcherPlayer().GetLevel() < ScalingInit.TierTwoHighestLevel ) && ( ScalingInit.MaximumLevelCap > ScalingInit.TierTwoLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierTwoGroupMinimumAdded, ScalingInit.TierTwoGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierTwoHumanMin, ScalingInit.TierTwoHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierTwoMaximumAdded, ScalingInit.TierTwoMinimumAdded );
					}
				}
				else if ( ( GetWitcherPlayer().GetLevel() >= ScalingInit.TierThreeLowestLevel ) && ( GetWitcherPlayer().GetLevel() < ScalingInit.TierThreeHighestLevel ) && ( ScalingInit.MaximumLevelCap > ScalingInit.TierThreeLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierThreeGroupMinimumAdded, ScalingInit.TierThreeGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierThreeHumanMin, ScalingInit.TierThreeHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierThreeMaximumAdded, ScalingInit.TierThreeMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= ScalingInit.TierFourLowestLevel ) && ( GetWitcherPlayer().GetLevel() < ScalingInit.TierFourHighestLevel ) && ( ScalingInit.MaximumLevelCap > ScalingInit.TierFourLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFourGroupMinimumAdded, ScalingInit.TierFourGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFourHumanMin, ScalingInit.TierFourHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFourMaximumAdded, ScalingInit.TierFourMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= ScalingInit.TierFiveLowestLevel ) && ( GetWitcherPlayer().GetLevel() < ScalingInit.MaximumLevelCap ) && ( ScalingInit.MaximumLevelCap > ScalingInit.TierFiveLowestLevel ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFiveGroupMinimumAdded, ScalingInit.TierFiveGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFiveHumanMin, ScalingInit.TierFiveHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFiveMaximumAdded, ScalingInit.TierFiveMinimumAdded );
					}
				}		
				else if ( ( GetWitcherPlayer().GetLevel() >= ScalingInit.MaximumLevelCap ) )
				{	
					if ( GetIsGroupTypeMonster() )
					{
						level_ = ScalingInit.MaximumLevelCap + RandRange( ScalingInit.TierFiveGroupMinimumAdded, ScalingInit.TierFiveGroupMaximumAdded );
					}
					else if ( GetSfxTag() == 'sfx_rat' )
					{
						level_ = 1;
					}
					else if ( IsHuman() )
					{
						level_ = GetWitcherPlayer().GetLevel() + RandRange( ScalingInit.TierFiveHumanMin, ScalingInit.TierFiveHumanMax );
					}
					else if ( HasAbility('mon_djinn') )
					{
						level_ = GetWitcherPlayer().GetLevel()-10;
					}
					else if ( HasAbility( 'fistfight_minigame' ) )
					{
						level_ = 1;
					}		
					else
					{
						level_ = ScalingInit.MaximumLevelCap + RandRange( ScalingInit.TierFiveMaximumAdded, ScalingInit.TierFiveMinimumAdded );
					}
				}
			}
			else if ( ScalingInit.ScalingCheck() )
			{
				if ( GetLevel()-12 > GetWitcherPlayer().GetLevel() )  
				{
					if ( ScalingInit.HDCM() )
							level_ = level;
						else
							level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH4') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH3') ) );
				}
				else if ( GetLevel()+12 < GetWitcherPlayer().GetLevel() && ScalingInit.Pushover() )  
				{						
					level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL4') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL3') ) );
				}
				else if ( GetLevel()-6 >= GetWitcherPlayer().GetLevel() )  
				{
					level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH2') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSH1') ) );
				}
				else if ( GetWitcherPlayer().GetLevel() > GetLevel()+6 )  
				{ 
					level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL2') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL1') ) );
				}
				else if ( GetSfxTag() == 'sfx_rat' )
				{
					level_ = 1;
				}
				else if ( HasAbility('mon_djinn') )
				{
					level_ = GetWitcherPlayer().GetLevel()-10;
				}
				else if ( HasAbility( 'fistfight_minigame' ) )
				{
					level_ = 1;
				}		
				else level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSN1') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSN2') ) );
				if ( level_ > ScalingInit.MaximumLevelCap ) level_ = GetWitcherPlayer().GetLevel() + RandRange( StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL2') ), StringToInt( theGame.GetInGameConfigWrapper().GetVarValue('SCOptionLG', 'GSL1') ) );
			}
		}
		else level_ = level;
		
		if ( ciriEntity )
			level_ = level;	

		if ( level_ <= 0 )
			level_ = 1;
		
		delete ScalingInit;
		
		return level_;
	}
	
	//Dynamic Scaling - End
	
	public function  SetLevel ( _level : int )
	{
		currentLevel = _level;
		AddTimer('AddLevelBonuses', 0.1, true, false, , true);
	}
	
	private function SetThreatLevel()
	{
		var temp : float;
		
		temp = CalculateAttributeValue(GetAttributeValue('threat_level'));
		if ( temp >= 0.f )
		{
			threatLevel = (int)temp;
		}
		else
		{
			LogAssert(false,"No threat_level attribute set. Threat level set to 0");
			threatLevel = 0;
		}
	}
	public function ChangeThreatLevel( newValue : int )
	{
		threatLevel = newValue;
	}
	
	/* C++ */ public function GetHorseUser() : CActor
	{
		if( horseComponent )
		{
			return horseComponent.GetCurrentUser();
		}
		
		return NULL;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Combat
	
	public function GetPreferedCombatStyle() : EBehaviorGraph
	{
		return preferedCombatStyle;
	}
	
	public function SetPreferedCombatStyle( _preferedCombatStyle : EBehaviorGraph )
	{
		preferedCombatStyle = _preferedCombatStyle;
	}
	
	//checks weather and if needed adds/removes weather bonus from NPC
	timer function WeatherBonusCheck(dt : float, id : int)
	{
		var curGameTime : GameTime;
		var dayPart : EDayPart;
		var bonusName : name;
		var curEffect : CBaseGameplayEffect;
		var moonState : EMoonState;
		var weather : EWeatherEffect;
		var params : SCustomEffectParams;
		
		if ( !IsAlive() )
		{
			return;
		}
		
		moonState = GetCurMoonState();
		
		curGameTime = GameTimeCreate();
		dayPart = GetDayPart(curGameTime);
		
		weather = GetCurWeather();
		
		bonusName = ((W3NonPlayerAbilityManager)abilityManager).GetWeatherBonus(dayPart, weather, moonState);
		
		curEffect = GetBuff(EET_WeatherBonus);
		if (curEffect)
		{
			if ( curEffect.GetAbilityName() == bonusName )
			{
				return;
			}
			else
			{
				RemoveBuff(EET_WeatherBonus);
			}
		}
		
		if (bonusName != 'None')
		{
			params.effectType = EET_WeatherBonus;
			params.creator = this;
			params.sourceName = "WeatherBonus";
			params.customAbilityName = bonusName;
			AddEffectCustom(params);
		}
	}
	
	public function IsFlying() : bool
	{
		var result : bool;
		result = ( this.GetCurrentStance() == NS_Fly );
		return result;
	}
	
	public function IsRanged() : bool
	{
		//MS: Please change this to a more general function (e.g. checks whether it has a 'Ranged' ability )
		var weapon : SItemUniqueId;
		var weapon2 : SItemUniqueId;
	
		weapon = this.GetInventory().GetItemFromSlot( 'l_weapon' );
		weapon2 = this.GetInventory().GetItemFromSlot( 'r_weapon' );
		
		return ( this.GetInventory().GetItemCategory( weapon ) == 'bow' || this.GetInventory().GetItemCategory( weapon2 ) == 'crossbow' );
		
	}
	
	// Used to know when the npc model is not touching the ground, even if the capsule in on ground
	// Needed for freezing bomb
	public function IsVisuallyOffGround() : bool
	{
		if( isTemporaryOffGround ) 
			return true;
		if( IsFlying() ) 
			return true;
			
		return false;
	}

	public function SetIsHorse()
	{
		if ( horseComponent )
			isHorse = true;
	}
	
	public function IsHorse() : bool
	{
		return isHorse;
	}
	
	public function GetHorseComponent() : W3HorseComponent
	{
		if ( isHorse )
			return horseComponent;
		else
			return NULL;
	}
	
	public function HideHorseAfter( time : float )
	{
		if( !isHorse )
			return;
		
		SetVisibility( false );
		SetGameplayVisibility( false );
		
		AddTimer( 'HideHorse', time );
	}
	
	private timer function HideHorse( delta : float , id : int )
	{
		Teleport( thePlayer.GetWorldPosition() + thePlayer.GetHeadingVector() * 1000.0 );
		
		SetVisibility( true );
		SetGameplayVisibility( true );
	}
	
	public function KillHorseAfter( time : float )
	{
		if( !isHorse )
			return;
		AddTimer( 'KillHorse', time );
	}
	
	private timer function KillHorse( delta : float , id : int )
	{
		SetKinematic( false );
		Kill( true );
		SetAlive( false );
		GetComponentByClassName( 'CInteractionComponent' ).SetEnabled( false );
		PlayEffect( 'hit_ground' );
	}
	
	public timer function RemoveAxiiFromHorse( delta : float , id : int )
	{
		RemoveAbility( 'HorseAxiiBuff' );
	}
	
	public function ToggleCanFlee( val : bool ) { canFlee = val; }
	public function GetCanFlee() : bool 		{ return canFlee; }
	
	public function SetIsFallingFromHorse( val : bool ) 		
	{ 
		if( val )
		{
			AddBuffImmunity( EET_HeavyKnockdown, 'SetIsFallingFromHorse', true );
			isFallingFromHorse = true;
		}
		else
		{
			RemoveBuffImmunity( EET_HeavyKnockdown, 'SetIsFallingFromHorse' );
			isFallingFromHorse = false;
		}
	}
	public function GetIsFallingFromHorse() : bool 				{ return isFallingFromHorse; }
	
	public function SetCounterWindowStartTime(time : EngineTime)	{counterWindowStartTime = time;}
	public function GetCounterWindowStartTime() : EngineTime		{return counterWindowStartTime;}
	
	
	function GetThreatLevel() : int
	{
		return threatLevel;
	}
	
	function GetSoundValue() : int
	{
		return soundValue;
	}
		
	public function WasTauntedToAttack()
	{
		tauntedToAttackTimeStamp = theGame.GetEngineTimeAsSeconds();
	}
	
	//hax
	//--------------------------------------------------------
	timer function MaintainSpeedTimer( d : float , id : int)
	{
		this.SetBehaviorVariable( 'Editor_MovementSpeed', 0 );
	}
	timer function MaintainFlySpeedTimer( d : float , id : int)
	{
		this.SetBehaviorVariable( 'Editor_FlySpeed', 0 );
	}
	//--------------------------------------------------------
	//hax end
	
	
	public function SetIsInHitAnim( toggle : bool )
	{
		bIsInHitAnim = toggle;
		if ( !toggle )
			this.SignalGameplayEvent('WasHit');
	}
	
	public function IsInHitAnim() : bool
	{
		return bIsInHitAnim;
	}
	
	public function CanChangeBehGraph() : bool
	{
		return allowBehGraphChange;
	}
	
	public function WeaponSoundType() : CItemEntity
	{
		var weapon : SItemUniqueId;
		weapon = GetInventory().GetItemFromSlot( 'r_weapon' );
		
		return GetInventory().GetItemEntityUnsafe(weapon);
	}

	
	/**************************************************/
	
	function EnableCounterParryFor( time : float )
	{
		bCanPerformCounter = true;
		AddTimer('DisableCounterParry',time,false);
	}
	
	timer function DisableCounterParry( td : float , id : int)
	{
		bCanPerformCounter = false;
	}
	
	var combatStorage : CBaseAICombatStorage;
	
	public final function IsAttacking() : bool
	{
		if ( !combatStorage )
			combatStorage = (CBaseAICombatStorage)GetAIStorageObject('CombatData');
			
		if(combatStorage)
		{
			return combatStorage.GetIsAttacking();
		}
		
		return false;
	}
		
	public final function RecalcLevel()
	{
		if(!IsAlive())
			return;
			
		AddLevelBonuses(0, 0);
	}
	
	/****************************** @PARRY *****************************************************************************/
	protected function PerformCounterCheck(parryInfo: SParryInfo) : bool
	{
		return false;
	}
	
	//Performs a check for parry and if successfull then parries the attack
	protected function PerformParryCheck(parryInfo : SParryInfo) : bool
	{
		var mult : float;
		var isHeavy : bool;
		var npcTarget : CNewNPC;
		var fistFightParry : bool;
		
		if ( !parryInfo.canBeParried )
			return false;
		
		if( this.IsHuman() && ((CHumanAICombatStorage)this.GetAIStorageObject('CombatData')).IsProtectedByQuen() )
			return false;
		if( !CanParryAttack() )
			return false;
		if( !FistFightCheck(parryInfo.target, parryInfo.attacker, fistFightParry) )
			return false;
		if( IsInHitAnim() && HasTag( 'imlerith' ) )
			return false;	
		
		npcTarget = (CNewNPC)parryInfo.target;
		
		if( npcTarget.IsShielded(parryInfo.attacker) || ( !npcTarget.HasShieldedAbility() && parryInfo.targetToAttackerAngleAbs < 90 ) || (  npcTarget.HasTag( 'olgierd_gpl' ) && parryInfo.targetToAttackerAngleAbs < 120 ) )
		{	
			isHeavy = IsHeavyAttack(parryInfo.attackActionName);
						
			//inform combat task that we can do actual parry now
			if( HasStaminaToParry( parryInfo.attackActionName ) && ( HasAbility( 'ablParryHeavyAttacks' ) || !isHeavy ) )
			{
				//set attack type for behavior for parry anim switch
				SetBehaviorVariable( 'parryAttackType', (int)PAT_Light );
				
				if( isHeavy )
					SignalGameplayEventParamInt( 'ParryPerform', 1 );
				else
					SignalGameplayEventParamInt( 'ParryPerform', 0 );
			}
			else
			{
				//set attack type for behavior for parry anim switch
				SetBehaviorVariable( 'parryAttackType', (int)PAT_Heavy );
			
				if( isHeavy )
					SignalGameplayEventParamInt( 'ParryStagger', 1 );
				else
					SignalGameplayEventParamInt( 'ParryStagger', 0 );
			}
			
			if( parryInfo.attacker == thePlayer && parryInfo.attacker.IsWeaponHeld( 'fist' ) && !parryInfo.target.IsWeaponHeld( 'fist' ) )
			{
				parryInfo.attacker.SetBehaviorVariable( 'reflectAnim', 1.f );
				parryInfo.attacker.ReactToReflectedAttack(this);				
			}
			else 
			{
				if( isHeavy )
				{
					ToggleEffectOnShield( 'heavy_block', true );
				}
				else
				{
					ToggleEffectOnShield( 'light_block', true );
				}
			}
			
			return true;
		}		
		
		return false;
	}
		
	public function GetTotalSignSpellPower(signSkill : ESkill) : SAbilityAttributeValue
	{		
		return GetPowerStatValue(CPS_SpellPower);
	}
	
	/*script*/ event OnPocessActionPost(action : W3DamageAction)
	{
		var actorVictim : CActor;
		var time : float;
		var gameplayEffect : CBaseGameplayEffect;
		var template : CEntityTemplate;
		var fxEnt : CEntity;
		
		super.OnPocessActionPost(action);
		
		//runeword: increase hypnosis duration with each successfull strike
		actorVictim = (CActor)action.victim;
		if(HasBuff(EET_AxiiGuardMe) && (thePlayer.HasAbility('Glyphword 14 _Stats', true) || thePlayer.HasAbility('Glyphword 18 _Stats', true)) && action.DealtDamage())
		{
			time = CalculateAttributeValue(thePlayer.GetAttributeValue('increas_duration'));
			gameplayEffect = GetBuff(EET_AxiiGuardMe);
			gameplayEffect.SetTimeLeft( gameplayEffect.GetTimeLeft() + time );
			
			template = (CEntityTemplate)LoadResource('glyphword_10_18');
			
			if(GetBoneIndex('head') != -1)
			{				
				fxEnt = theGame.CreateEntity(template, GetBoneWorldPosition('head'), GetWorldRotation(), , , true);
				fxEnt.CreateAttachmentAtBoneWS(this, 'head', GetBoneWorldPosition('head'), GetWorldRotation());
			}
			else
			{
				fxEnt = theGame.CreateEntity(template, GetBoneWorldPosition('k_head_g'), GetWorldRotation(), , , true);
				fxEnt.CreateAttachmentAtBoneWS(this, 'k_head_g', GetBoneWorldPosition('k_head_g'), GetWorldRotation());
				
			}
			
			fxEnt.PlayEffect('axii_extra_time');
			fxEnt.DestroyAfter(5);
		}
	}
	////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////  @STATS  ///////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////
	
	timer function AddLevelBonuses (dt : float, id : int)
	{
		var i : int;
		var lvlDiff, downscaleLevel : int;
		var ciriEntity  : W3ReplacerCiri;
		var maxstam : float;
		var Scaling : DynamicScaling;
		
		RemoveTimer('AddLevelBonuses');
		
		ciriEntity = (W3ReplacerCiri)thePlayer;
		Scaling = new DynamicScaling in this;
		Level = CalculateLevel();
		
		if( ( ( GetNPCType() != ENGT_Guard ) && ( !HasAbility( 'fistfight_minigame' ) ) && ( Level + (int)CalculateAttributeValue(GetAttributeValue('level',,true)) < 2 ) ) ) return;
			
		if ( HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) RemoveAbility(theGame.params.ENEMY_BONUS_DEADLY); else
		if ( HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) RemoveAbility(theGame.params.ENEMY_BONUS_HIGH); else
		if ( HasAbility(theGame.params.ENEMY_BONUS_LOW) ) RemoveAbility(theGame.params.ENEMY_BONUS_LOW); else
		if ( HasAbility(theGame.params.MONSTER_BONUS_DEADLY) ) RemoveAbility(theGame.params.MONSTER_BONUS_DEADLY); else
		if ( HasAbility(theGame.params.MONSTER_BONUS_HIGH) ) RemoveAbility(theGame.params.MONSTER_BONUS_HIGH); else
		if ( HasAbility(theGame.params.MONSTER_BONUS_LOW) ) RemoveAbility(theGame.params.MONSTER_BONUS_LOW);
		
		if ( Scaling.Scale() )
		{	
		/*	if ( (GetLevel() - CalculateLevel()) <= 0 )
			{*/
				if ( IsHuman() && GetStat( BCS_Essence, true ) < 0 )
				{
					if ( GetNPCType() != ENGT_Guard )
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) /*&& !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL)*/ ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level-1);
					} 
					else
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) /*&& !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL)*/ ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, Level-1);
					}
					
					if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffHuman') ) AddAbility('CiriHardcoreDebuffHuman');
				} 
				else
				{
					if ( GetStat( BCS_Vitality, true ) > 0 ) // if monster, but based on vitality ( animal )
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL_GROUP) /*&& !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL_GROUP)*/ ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL_GROUP, Level-1);
					} 
					else
					{
						if ( (int)CalculateAttributeValue( GetAttributeValue('armor') ) > 0 )
						{
							if ( GetIsMonsterTypeGroup() )
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED) /*&& !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP_ARMORED)*/ ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED, Level-1);
							}
							else
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED) /*&& !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_ARMORED)*/ ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED, Level-1);
							}
						}
						else
						{
							if ( GetIsMonsterTypeGroup() )
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP) /*&& !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP)*/ ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP, Level-1);
							}
							else
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL) /*&& !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL)*/ ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL, Level-1);
							}
						}
						
						if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffMonster') ) AddAbility('CiriHardcoreDebuffMonster');
					}	 
				}
			/*}
			else
			if ( (GetLevel() - CalculateLevel()) > 0 )
			{
				downscaleLevel = CalculateLevel();
				
				if ( IsHuman() && GetStat( BCS_Essence, true ) < 0 )
				{
					if ( GetNPCType() != ENGT_Guard )
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_DELEVEL, downscaleLevel-1);
					} 
					else
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_DELEVEL, downscaleLevel-1);
					}
					
					if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffHuman') ) AddAbility('CiriHardcoreDebuffHuman');
				} 
				else
				{
					if ( GetStat( BCS_Vitality, true ) > 0 ) // if monster, but based on vitality ( animal )
					{
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_DELEVEL_GROUP) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_DELEVEL_GROUP, downscaleLevel-1);
					} 
					else
					{
						if ( (int)CalculateAttributeValue( GetAttributeValue('armor') ) > 0 )
						{
							if ( GetIsMonsterTypeGroup() )
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP_ARMORED) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP_ARMORED, downscaleLevel-1);
							}
							else
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_ARMORED)  ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_DELEVEL_ARMORED, downscaleLevel-1);
							}
						}
						else
						{
							if ( GetIsMonsterTypeGroup() )
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_DELEVEL_GROUP, downscaleLevel-1);
							}
							else
							{
								if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_DELEVEL) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_DELEVEL, downscaleLevel-1);
							}
						}
						
						if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffMonster') ) AddAbility('CiriHardcoreDebuffMonster');
					}	 
				}			
			}*/
		}
		else
		{
			if ( IsHuman() && GetStat( BCS_Essence, true ) < 0 )
			{
				if ( GetNPCType() != ENGT_Guard )
				{
					if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, currentLevel-1);
				} 
				else
				{
					if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, 1 + GetWitcherPlayer().GetLevel() + RandRange( 11, 13 ) );
				}
				
				if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffHuman') ) AddAbility('CiriHardcoreDebuffHuman');
					
				if ( !ciriEntity ) 
				{
					if ( Scaling.LevelBonuses() )
					{
						lvlDiff = (int)CalculateAttributeValue(GetAttributeValue('level',,true)) - thePlayer.GetLevel();
						if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) { AddAbility(theGame.params.ENEMY_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
						else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) AddAbility(theGame.params.ENEMY_BONUS_HIGH, true);}
						else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
						else 					  { if ( !HasAbility(theGame.params.ENEMY_BONUS_LOW) ) AddAbility(theGame.params.ENEMY_BONUS_LOW, true); }	
					}	
				}	 
			} 
			else
			{
				if ( GetStat( BCS_Vitality, true ) > 0 ) // if monster, but based on vitality ( animal )
				{
					if ( !ciriEntity ) 
					{
						if ( Scaling.LevelBonuses() )
						{					
							lvlDiff = (int)CalculateAttributeValue(GetAttributeValue('level',,true)) - thePlayer.GetLevel();
							if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !HasAbility(theGame.params.ENEMY_BONUS_DEADLY) ) { AddAbility(theGame.params.ENEMY_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
							else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !HasAbility(theGame.params.ENEMY_BONUS_HIGH) ) AddAbility(theGame.params.ENEMY_BONUS_HIGH, true);}
							else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
							else 					  { if ( !HasAbility(theGame.params.ENEMY_BONUS_LOW) ) AddAbility(theGame.params.ENEMY_BONUS_LOW, true); }		
						}
						if ( !HasAbility(theGame.params.ENEMY_BONUS_PER_LEVEL) ) AddAbilityMultiple(theGame.params.ENEMY_BONUS_PER_LEVEL, currentLevel-1);
					}
				} 
				else
				{
					
					if ( (int)CalculateAttributeValue( GetAttributeValue('armor') ) > 0 )
					{
						if ( GetIsMonsterTypeGroup() )
						{
							if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP_ARMORED, currentLevel-1);
						} 
						else
						{
							if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_ARMORED, currentLevel-1);
						}
					}
					else
					{
						if ( GetIsMonsterTypeGroup() )
						{
							if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL_GROUP, currentLevel-1);
						} 
						else
						{
							if ( !HasAbility(theGame.params.MONSTER_BONUS_PER_LEVEL) ) AddAbilityMultiple(theGame.params.MONSTER_BONUS_PER_LEVEL, currentLevel-1);
						}
					}
					
					
					if ( thePlayer.IsCiri() && theGame.GetDifficultyMode() == EDM_Hardcore && !HasAbility('CiriHardcoreDebuffMonster') ) AddAbility('CiriHardcoreDebuffMonster');
						
					if ( !ciriEntity ) 
					{
						if ( Scaling.LevelBonuses() )
						{
							lvlDiff = (int)CalculateAttributeValue(GetAttributeValue('level',,true)) - thePlayer.GetLevel();
							if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { if ( !HasAbility(theGame.params.MONSTER_BONUS_DEADLY) ) { AddAbility(theGame.params.MONSTER_BONUS_DEADLY, true); AddBuffImmunity(EET_Blindness, 'DeadlyEnemy', true); AddBuffImmunity(EET_WraithBlindness, 'DeadlyEnemy', true); } }	
							else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { if ( !HasAbility(theGame.params.MONSTER_BONUS_HIGH) ) AddAbility(theGame.params.MONSTER_BONUS_HIGH, true); }
							else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
							else 					  { if ( !HasAbility(theGame.params.MONSTER_BONUS_LOW) ) AddAbility(theGame.params.MONSTER_BONUS_LOW, true); }		
						}
					}
				}	 
			}		
		}
		
		maxstam = abilityManager.GetStatMax(BCS_Stamina);

		switch( Scaling.Aggression() )
		{
			case 0: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.25); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 1: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.50); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 2: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*0.75); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 3:
			break;
			case 4: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*1.25); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 5: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*1.5); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
			case 6: abilityManager.SetStatPointMax(BCS_Stamina, maxstam*2); ForceSetStat(BCS_Stamina, abilityManager.GetStatMax(BCS_Stamina));
			break;
		}
		delete Scaling;
	}
	
	public function GainStat( stat : EBaseCharacterStats, amount : float )
	{
		//dont increase panic if npc is a player's mounted horse and player has mutagen
		if(stat == BCS_Panic && IsHorse() && thePlayer.GetUsedVehicle() == this && thePlayer.HasBuff(EET_Mutagen25))
		{
			return;
		}
		
		super.GainStat(stat, amount);
	}
	
	public function ForceSetStat(stat : EBaseCharacterStats, val : float)
	{
		//dont increase panic if npc is a player's mounted horse and player has mutagen
		if(stat == BCS_Panic && IsHorse() && thePlayer.GetUsedVehicle() == this && thePlayer.HasBuff(EET_Mutagen25) && val >= GetStat(BCS_Panic))
		{
			return;
		}
		
		super.ForceSetStat(stat, val);
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////  @ACHIEVEMENTS /////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////
	
	timer function FundamentalsAchFailTimer(dt : float, id : int)
	{
		RemoveTag('failedFundamentalsAchievement');
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////  @CRITICAL STATES  /////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////
	protected function CriticalBuffInformBehavior(buff : CBaseGameplayEffect)
	{
		SignalGameplayEventParamInt('CriticalState',(int)GetBuffCriticalType(buff));
	}
	
	/*
		Called when new critical effect has started
		This will interrupt current critical state
		
		returns true if the effect got fired properly
	*/
	public function StartCSAnim(buff : CBaseGameplayEffect) : bool
	{
		if(super.StartCSAnim(buff))
		{
			CriticalBuffInformBehavior(buff);
			return true;
		}
		 
		return false;
	}
	
	public function CSAnimStarted(buff : CBaseGameplayEffect) : bool
	{
		return super.StartCSAnim(buff);
	}
	
	function SetCanPlayHitAnim( flag : bool )
	{
		if( !flag && this.IsHuman() && this.GetAttitude( thePlayer ) != AIA_Friendly )
		{
			super.SetCanPlayHitAnim( flag );
		}
		else
		{
			super.SetCanPlayHitAnim( flag );
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Fistfight
	event OnStartFistfightMinigame()
	{
		var Scaling : DynamicScaling;
		Scaling = new DynamicScaling in this;
		super.OnStartFistfightMinigame();
		
		thePlayer.ProcessLockTarget( this );
		SignalGameplayEventParamInt('ChangePreferedCombatStyle',(int)EBG_Combat_Fists );
		SetTemporaryAttitudeGroup( 'fistfight_opponent', AGP_Fistfight );
		ForceVulnerableImmortalityMode();
		if ( !thePlayer.IsFistFightMinigameToTheDeath() )
			SetImmortalityMode(AIM_Unconscious, AIC_Fistfight);
		RecalcLevel();
		if(FactsQuerySum("NewGamePlus") > 0 && !Scaling.Scale() )
		{FistFightNewGamePlusSetup();}
		FistFightHealthSetup();
		ApplyFistFightLevelDiff();
		delete Scaling;
	}
	
	event OnEndFistfightMinigame()
	{	
		SignalGameplayEvent('ResetPreferedCombatStyle');
		ResetTemporaryAttitudeGroup( AGP_Fistfight );
		RestoreImmortalityMode();
		LowerGuard();
		if ( IsKnockedUnconscious() )
		{
			SignalGameplayEvent('ForceStopUnconscious');
		}
		if ( !IsAlive() )
		{
			Revive();
		}
		FistFightHealthSetup();
		RemoveFistFightLevelDiff();
		super.OnEndFistfightMinigame();
	}
		
	private function FistFightHealthSetup()
	{
		
		if ( HasAbility( 'fistfight_minigame' ) )
		{
			FistFightersHealthDiff();
		}
		else return;

	}
	
	private function FistFightersHealthDiff()
	{
		var vitality 		: float;
		
		if ( HasAbility( 'StatsFistsTutorial' ) )
		{
			AddAbility( 'HealthFistFightTutorial', false );
		}
		else if ( HasAbility( 'StatsFistsEasy' ) )
		{
			AddAbility( 'HealthFistFightEasy', false );
		}
		else if ( HasAbility( 'StatsFistsMedium' ) )
		{
			AddAbility( 'HealthFistFightMedium', false );
		}
		else if ( HasAbility( 'StatsFistsHard' ) )
		{
			AddAbility( 'HealthFistFightHard', false );
		}
		vitality = abilityManager.GetStatMax( BCS_Vitality );
		SetHealthPerc( 100 );
	}
	
	private function FistFightNewGamePlusSetup()
	{
		if ( HasAbility( 'NPCLevelBonus' ) )
		{
			RemoveAbilityMultiple( 'NPCLevelBonus', theGame.params.GetNewGamePlusLevel() );
			newGamePlusFakeLevelAddon = true;
			currentLevel -= theGame.params.GetNewGamePlusLevel();
			RecalcLevel(); 
		}
	}
	
	private function ApplyFistFightLevelDiff()
	{
		var lvlDiff 	: int;
		var i 			: int;
		var attribute 	: SAbilityAttributeValue; 
		var min, max	: SAbilityAttributeValue;
		var ffHP, ffAP	: SAbilityAttributeValue;
		var dm 			: CDefinitionsManagerAccessor; 
		
		lvlDiff = (int)CalculateAttributeValue(GetAttributeValue('level',,true)) - thePlayer.GetLevel();
		
		if ( !HasAbility('NPC fists _Stats') )
		{
			dm = theGame.GetDefinitionsManager();
			dm.GetAbilityAttributeValue('NPC fists _Stats', 'vitality', min, max);
			ffHP = GetAttributeRandomizedValue(min, max);
			dm.GetAbilityAttributeValue('NPC fists _Stats', 'attack_power', min, max);
			ffAP = GetAttributeRandomizedValue(min, max);
		}
		
   		if ( lvlDiff < -theGame.params.LEVEL_DIFF_HIGH )
		{
			for (i=0; i < 5; i+=1)
			{
				AddAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW, true);
				attribute = GetAttributeValue('vitality');
				attribute += ffHP;
				if (attribute.valueMultiplicative <= 0)
				{
					RemoveAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW);
					return;
				}
				attribute = GetAttributeValue('attack_power');
				attribute += ffAP;
				if (attribute.valueMultiplicative <= 0)
				{
					RemoveAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW);
					return;
				}
			}
		}
		else if ( lvlDiff < 0 )
		{
			for (i=0; i < -lvlDiff; i+=1)
			{
				AddAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW, true);
				attribute = GetAttributeValue('vitality');
				if (attribute.valueMultiplicative <= 0)
				{
					RemoveAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW);
					return;
				}
				attribute = GetAttributeValue('attack_power');
				if (attribute.valueMultiplicative <= 0)
				{
					RemoveAbility(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW);
					return;
				}
			}
		}
		else if ( lvlDiff > theGame.params.LEVEL_DIFF_HIGH )
			AddAbilityMultiple(theGame.params.ENEMY_BONUS_FISTFIGHT_HIGH, 5);
		else if ( lvlDiff > 0  )
			AddAbilityMultiple(theGame.params.ENEMY_BONUS_FISTFIGHT_HIGH, lvlDiff);
	}
	
	private function RemoveFistFightLevelDiff()
	{
		RemoveAbilityMultiple(theGame.params.ENEMY_BONUS_FISTFIGHT_LOW, 5);
		RemoveAbilityMultiple(theGame.params.ENEMY_BONUS_FISTFIGHT_HIGH, 5);
	}

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// NPC Stance
	
	private function IsThisStanceRegular( Stance : ENpcStance ) : bool
	{
		if( Stance == NS_Normal || 
			Stance == NS_Strafe ||
			Stance == NS_Retreat )
		{
			return true;
		}
		
		return false;
	}
	
	private function IsThisStanceDefensive( Stance : ENpcStance ) : bool
	{
		if( Stance == NS_Guarded || 
			Stance == NS_Guarded )
		{
			return true;
		}
		
		return false;
	}
	
	function GetCurrentStance() : ENpcStance
	{
		var l_currentStance : int;
		l_currentStance = (int)this.GetBehaviorVariable( 'npcStance');
		return l_currentStance;
	}
	
	function GetRegularStance() : ENpcStance
	{
		return this.regularStance;
	}
	
	function ReturnToRegularStance()
	{
		this.SetBehaviorVariable( 'npcStance',(int)this.regularStance);
	}
	
	function IsInRegularStance() : bool
	{
		if(	GetCurrentStance() == GetRegularStance() )
		{
			return true;
		}
		
		return false;
	}
	
	function ChangeStance( newStance : ENpcStance ) : bool
	{
		if ( IsThisStanceDefensive( newStance ) )
		{
			LogChannel('NPC ChangeStance', "You shouldn't use this function to change to this stance - " + newStance );
		}
		else if ( IsThisStanceRegular( newStance ) )
		{
			if ( this.SetBehaviorVariable( 'npcStance',(int)newStance) )
			{
				this.regularStance = newStance;
				return true;
			}
		}
		else
		{
			return this.SetBehaviorVariable( 'npcStance',(int)newStance);
		}
		return false;
	}
	
	function RaiseGuard() : bool
	{
		SetGuarded( true );
		return true;
	}
	
	function LowerGuard() : bool
	{
		SetGuarded( false );
		return true;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	Agony section
	//
	
	function IsInAgony() : bool
	{
		return bAgony;
	}
	
	function EnterAgony()
	{
		bAgony = true;
	}
	
	function EndAgony()
	{
		bAgony = false;
	}
	
	function EnableDeathAndAgony()
	{
		bPlayDeathAnim = true;
		bAgonyDisabled = false;
	}
	
	function EnableDeath()
	{
		bPlayDeathAnim = true;
	}
	
	function EnableAgony()
	{
		bAgonyDisabled = false;
	}
	
	function DisableDeathAndAgony()
	{
		bPlayDeathAnim = false;
		bAgonyDisabled = true;
	}
	function DisableAgony()
	{
		bAgonyDisabled = true;
	}
	
	function IsAgonyDisabled() : bool
	{
		return bAgonyDisabled;
	}
	
	function IsInFinisherAnim() : bool
	{
		return bFinisher;
	} 
	
	function FinisherAnimStart()
	{
		bPlayDeathAnim = false;		
		bFinisher = true;
		SetBehaviorMimicVariable( 'gameplayMimicsMode', (float)(int)GMM_Death );
	}
	
	function FinisherAnimInterrupted()
	{
		bPlayDeathAnim 			= true;		
		bFinisher 				= false;
		bFinisherInterrupted 	= true;
	}
	
	function ResetFinisherAnimInterruptionState()
	{
		bFinisherInterrupted = false;
	}
	
	function WasFinisherAnimInterrupted() : bool
	{
		return bFinisherInterrupted;
	}
	
	function FinisherAnimEnd()
	{
		bFinisher = false;
	}
	
	function ShouldPlayDeathAnim() : bool
	{
		return bPlayDeathAnim;
	}
	
	function NPCGetAgonyAnim() : CName
	{
		var agonyType : float;
		agonyType = GetBehaviorVariable( 'AgonyType');
		
		if (agonyType == (int)AT_ThroatCut)
		{
			return 'man_throat_cut_start';
		}
		else if(agonyType == (int)AT_Knockdown)
		{
			return 'man_wounded_crawl_killed';
		}
		else
			return '';
	}
	
	function GeraltGetAgonyAnim() : CName
	{
		var agonyType : float;
		agonyType = GetBehaviorVariable( 'AgonyType');
		
		if (agonyType == (int)AT_ThroatCut)
		{
			return 'man_ger_throat_cut_attack_01';
		}
		else if(agonyType == (int)AT_Knockdown)
		{
			return 'man_ger_crawl_finish';
		}
		else
			return '';
	}
	/*
	function updateDeathType( optional killed : bool )
	{
		var agonyType : float;
		
		agonyType = GetAgonyType();
		if (agonyType == (int)AT_Knockdown)
		{
			if ( killed )
				SetDeathType(DT_CrawlKilled);
			else
				SetDeathType(DT_CrawlDying);
		}
		else if (agonyType == (int)AT_ThroatCut)
		{
			if ( killed )
				SetDeathType(DT_ThroatCut);
			else
				SetDeathType(DT_ThroatCut);
		}
	}
	*/
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	On Hit section
	//	
	protected function PlayHitAnimation(damageAction : W3DamageAction, animType : EHitReactionType)
	{
		var node : CNode;
				
		SetBehaviorVariable( 'HitReactionWeapon', ProcessSwordOrFistHitReaction( this, (CActor)damageAction.attacker ) );
		SetBehaviorVariable( 'HitReactionType',(int)animType);
		if ( damageAction.attacker )
		{
			node = (CNode)damageAction.causer;
			if (node)
			{
				SetHitReactionDirection(node);
			}
			else
			{
				SetHitReactionDirection(damageAction.attacker);
			}
			SetDetailedHitReaction(damageAction.GetSwingType(), damageAction.GetSwingDirection());
		}
		
		if ( this.customHits )
		{
			damageAction.customHitReactionRequested = true;
		}
		else
		{
			damageAction.hitReactionAnimRequested = true;
		}
	}
	
	public function ReactToBeingHit(damageAction : W3DamageAction, optional buffNotApplied : bool) : bool
	{
		var ret 							: bool;
		var percentageLoss					: float;
		var totalHealth						: float;
		var damaveValue						: float;
		var healthLossToForceLand_perc		: SAbilityAttributeValue;
		var witcher							: W3PlayerWitcher;
		var node							: CNode;
		var boltCauser						: W3BoltProjectile;
		var attackAction					: W3Action_Attack;
		
		damaveValue 				 = damageAction.GetDamageDealt();
		totalHealth 				 = GetMaxHealth();
		percentageLoss 			 	= damaveValue / totalHealth;
		healthLossToForceLand_perc 	 = GetAttributeValue( 'healthLossToForceLand_perc' );
		
		//if hit when flying - add knockdown to fall to the ground and disable hit anim
		if( percentageLoss >= healthLossToForceLand_perc.valueBase && ( GetCurrentStance() == NS_Fly || ( !IsUsingVehicle() && GetCurrentStance() != NS_Swim && !((CMovingPhysicalAgentComponent) GetMovingAgentComponent()).IsOnGround()) ) )
		{
			// More conditions in a separate if for lisibilty
			if( !((CBaseGameplayEffect) damageAction.causer ) )
			{
				damageAction.AddEffectInfo(	EET_Knockdown);
			}
		}
		
		//if hit is caused by bodkin bolt, hitreaction should be a chance 
		boltCauser = (W3BoltProjectile)( damageAction.causer );
		if( boltCauser )
		{
			if( HasAbility( 'AdditiveHits' ) )
			{
				SetUseAdditiveHit( true, true, true );
				ret = super.ReactToBeingHit(damageAction, buffNotApplied);
				
				if( ret || damageAction.DealsAnyDamage())
					SignalGameplayDamageEvent('BeingHit', damageAction );
			}
			else if( HasAbility( 'mon_wild_hunt_default' ) )
			{
				ret = false;
			}
			else if( !boltCauser.HasTag( 'bodkinbolt' ) || this.IsUsingHorse() || RandRange(100) < 75.f ) 
			{
				ret = super.ReactToBeingHit(damageAction, buffNotApplied);
				
				if( ret || damageAction.DealsAnyDamage())
					SignalGameplayDamageEvent('BeingHit', damageAction );
			}
			else
			{
				ret = false;
			}
		}
		else
		{
			ret = super.ReactToBeingHit(damageAction, buffNotApplied);
			
			if( ret || damageAction.DealsAnyDamage() )
				SignalGameplayDamageEvent('BeingHit', damageAction );
		}
		
		if( damageAction.additiveHitReactionAnimRequested == true )
		{
			node = (CNode)damageAction.causer;
			if (node)
			{
				SetHitReactionDirection(node);
			}
			else
			{
				SetHitReactionDirection(damageAction.attacker);
			}
		}
		
		if(((CPlayer)damageAction.attacker || !((CNewNPC)damageAction.attacker)) && damageAction.DealsAnyDamage())
			theTelemetry.LogWithLabelAndValue( TE_FIGHT_ENEMY_GETS_HIT, damageAction.victim.ToString(), (int)damageAction.processedDmg.vitalityDamage + (int)damageAction.processedDmg.essenceDamage );
		
		// we're being hit by the player we should break the charm
		witcher = GetWitcherPlayer();
		if ( damageAction.attacker == witcher && HasBuff( EET_AxiiGuardMe ) )
		{
			//...unless the skill is at level 3
			if(!witcher.CanUseSkill(S_Magic_s05) || witcher.GetSkillLevel(S_Magic_s05) < 3)
				RemoveBuff(EET_AxiiGuardMe, true);
		}
		
		if(damageAction.attacker == thePlayer && damageAction.DealsAnyDamage() && !damageAction.IsDoTDamage())
		{
			attackAction = (W3Action_Attack) damageAction;
			
			/*
			if(attackAction.IsCriticalHit() || SkillNameToEnum(attackAction.GetAttackTypeName()) == S_Sword_s02)
				theGame.VibrateControllerVeryHard();//player attacks npc, rend or critical hit
			else if(thePlayer.IsHeavyAttack(attackAction.GetAttackName()) )
				theGame.VibrateControllerHard();//player attacks npc, heavy attack
			else
				theGame.VibrateControllerLight();//player attacks npc, light attack
			*/
			
			//Perk reducing stamina to 0
			if(attackAction && attackAction.UsedZeroStaminaPerk())
			{
				ForceSetStat(BCS_Stamina, 0.f);
			}
		}
		
		return ret;
	}
	
	//** hit counter - it counts hits!
	public function GetHitCounter(optional total : bool) : int
	{
		if ( total )
			return totalHitCounter;
		return hitCounter;
	}
	
	public function IncHitCounter()
	{
		hitCounter += 1;
		totalHitCounter += 1;
		AddTimer('ResetHitCounter',2.0,false);
	}
	
	public timer function ResetHitCounter( deta : float , id : int)
	{
		hitCounter = 0;
	}	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//	Death section
	
	function Kill(optional ignoreImmortalityMode : bool, optional attacker : CGameplayEntity, optional source : name )
	{
		var action : W3DamageAction;
		
		if ( theGame.CanLog() )
		{		
			LogDMHits("CActor.Kill: called for actor <<" + this + ">>");
		}
		
		action = GetKillAction(ignoreImmortalityMode, attacker, source);
		
		if ( this.IsKnockedUnconscious() )
		{
			DisableDeathAndAgony();
			OnDeath(action);
		}
		else if ( !abilityManager )
		{
			OnDeath(action);
		}
		else
		{
			if ( ignoreImmortalityMode )
				this.immortalityFlags = 0;
				
			theGame.damageMgr.ProcessAction(action);
		}
		
		delete action;
	}
	
	public final function GetLevel() : int
	{
		return (int)CalculateAttributeValue(GetAttributeValue('level',,true));
	}
	
	public final function GetLevelFromLocalVar() : int
	{
		return currentLevel;
	}
	
	function GetExperienceDifferenceLevelName( out strLevel : string ) : string
	{
		var lvlDiff, lvlDisplay : int;
		var ciriEntity  : W3ReplacerCiri;
		var Scaling : DynamicScaling;
		
		Scaling = new DynamicScaling in this;
		
		if ( !Scaling.Scale() )
		{
			lvlDisplay = GetLevel() + levelFakeAddon;
			
			if ( newGamePlusFakeLevelAddon )
			{
				lvlDisplay += theGame.params.GetNewGamePlusLevel();
			}
			
			lvlDiff = lvlDisplay - thePlayer.GetLevel();
				
			if( GetAttitude( thePlayer ) != AIA_Hostile )
			{
				if( ( GetAttitudeGroup() != 'npc_charmed' ) )
				{
					strLevel = "";
					return "none";
				}
			}
			
			ciriEntity = (W3ReplacerCiri)thePlayer;
			if ( ciriEntity )
			{
				strLevel = "<font color=\"#66FF66\">" + lvlDisplay + "</font>"; // #B red
				return "normalLevel";
			}

			
			 if ( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY )
			{
				strLevel = "";
				return "deadlyLevel";
			}	
			else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )
			{
				strLevel = "<font color=\"#FF1919\">" + lvlDisplay + "</font>"; // #B red
				return "highLevel";
			}
			else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )
			{
				strLevel = "<font color=\"#66FF66\">" + lvlDisplay + "</font>"; // #B green
				return "normalLevel";
			}
			else
			{
				strLevel = "<font color=\"#E6E6E6\">" + lvlDisplay + "</font>"; // #B grey
				return "lowLevel";
			}
		}

		if( GetAttitude( thePlayer ) != AIA_Hostile )
		{
			if( ( GetAttitudeGroup() != 'npc_charmed' ) )
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
	
	//checks if player should be given exp when this npc dies
	private function ShouldGiveExp(attacker : CGameplayEntity) : bool
	{
		var actor : CActor;
		var npc : CNewNPC;
		var victimAt : EAIAttitude;
		var giveExp : bool;
		
		victimAt = GetAttitudeBetween(thePlayer, this);
		giveExp = false;
		
		//only exp if victim is hostile
		if(victimAt == AIA_Hostile)
		{
			if(attacker == thePlayer && !((W3PlayerWitcher)thePlayer) )
			{
				//player is not Geralt - no exp
				giveExp = false;
			}
			else if(attacker == thePlayer)
			{
				//player kill
				giveExp = true;
			}
			//only if close, skip for player to give exp for cliff aard pushes
			else if(VecDistance(thePlayer.GetWorldPosition(), GetWorldPosition()) <= 20)
			{
				npc = (CNewNPC)attacker;
				if(!npc || npc.npcGroupType != ENGT_Guard)	//no exp from policemen kills				
				{
					actor = (CActor)attacker;
					if(!actor)
					{
						//if there is no attacking actor
						giveExp = true;
					}
					else if(actor.HasTag(theGame.params.TAG_NPC_IN_PARTY) || actor.HasBuff(EET_AxiiGuardMe))
					{
						//if attacker is in player's party or charmed with axii
						giveExp = true;
					}							
				}
			}
		}
		
		return giveExp;
	}
	
	function AddBestiaryKnowledge()
	{
		var manager : CWitcherJournalManager;
		manager = theGame.GetJournalManager();
		if ( HasAbility( 'NoJournalEntry' )) return; else
		if ( GetSfxTag() == 'sfx_arachas' && HasAbility('mon_arachas_armored') )	activateBaseBestiaryEntryWithAlias("BestiaryArmoredArachas", manager); else
		if ( GetSfxTag() == 'sfx_arachas' && HasAbility('mon_poison_arachas')  )	activateBaseBestiaryEntryWithAlias("BestiaryPoisonousArachas", manager); else
		if ( GetSfxTag() == 'sfx_bear' )											activateBaseBestiaryEntryWithAlias("BestiaryBear", manager); else
		if ( GetSfxTag() == 'sfx_alghoul' )											activateBaseBestiaryEntryWithAlias("BestiaryAlghoul", manager); else
		if ( HasAbility('mon_greater_miscreant') )									activateBaseBestiaryEntryWithAlias("BestiaryMiscreant", manager); else
		if ( HasAbility('mon_basilisk') )											activateBaseBestiaryEntryWithAlias("BestiaryBasilisk", manager); else
		if ( HasAbility('mon_boar_base') )											activateBaseBestiaryEntryWithAlias("BestiaryBoar", manager); else
		if ( HasAbility('mon_black_spider_base') )									activateBaseBestiaryEntryWithAlias("BestiarySpider", manager); else
		if ( HasAbility('mon_toad_base') )											activateBaseBestiaryEntryWithAlias("BestiaryToad", manager); else
		if ( HasAbility('q604_caretaker') )											activateBaseBestiaryEntryWithAlias("Bestiarycaretaker", manager); else
		if ( HasAbility('mon_nightwraith_iris') )									activateBaseBestiaryEntryWithAlias("BestiaryIris", manager); else
		if ( GetSfxTag() == 'sfx_cockatrice' )										activateBaseBestiaryEntryWithAlias("BestiaryCockatrice", manager); else
		if ( GetSfxTag() == 'sfx_arachas' && !HasAbility('mon_arachas_armored') && !HasAbility('mon_poison_arachas') ) activateBaseBestiaryEntryWithAlias("BestiaryCrabSpider", manager); else
		if ( GetSfxTag() == 'sfx_katakan' && HasAbility('mon_ekimma') )				activateBaseBestiaryEntryWithAlias("BestiaryEkkima", manager); else
		if ( GetSfxTag() == 'sfx_elemental_dao' )									activateBaseBestiaryEntryWithAlias("BestiaryElemental", manager); else
		if ( GetSfxTag() == 'sfx_endriaga' && HasAbility('mon_endriaga_soldier_tailed') ) activateBaseBestiaryEntryWithAlias("BestiaryEndriaga", manager); else
		if ( GetSfxTag() == 'sfx_endriaga' && HasAbility('mon_endriaga_worker') )	activateBaseBestiaryEntryWithAlias("BestiaryEndriagaWorker", manager); else
		if ( GetSfxTag() == 'sfx_endriaga' && HasAbility('mon_endriaga_soldier_spikey') ) activateBaseBestiaryEntryWithAlias("BestiaryEndriagaTruten", manager); else
		if ( HasAbility('mon_forktail_young') || HasAbility('mon_forktail') || HasAbility('mon_forktail_mh') ) activateBaseBestiaryEntryWithAlias("BestiaryForktail", manager); else
		if ( GetSfxTag() == 'sfx_ghoul' )											activateBaseBestiaryEntryWithAlias("BestiaryGhoul", manager); else
		if ( GetSfxTag() == 'sfx_golem' )											activateBaseBestiaryEntryWithAlias("BestiaryGolem", manager); else
		if ( GetSfxTag() == 'sfx_katakan' && !HasAbility('mon_ekimma') )			activateBaseBestiaryEntryWithAlias("BestiaryKatakan", manager); else
		if ( GetSfxTag() == 'sfx_ghoul' && HasAbility('mon_greater_miscreant') )	activateBaseBestiaryEntryWithAlias("BestiaryMiscreant", manager); else
		if ( HasAbility('mon_nightwraith')|| HasAbility('mon_nightwraith_mh') )	activateBaseBestiaryEntryWithAlias("BestiaryMoonwright", manager); else
		if ( HasAbility('mon_noonwraith'))										activateBaseBestiaryEntryWithAlias("BestiaryNoonwright", manager); else
		if ( HasAbility('mon_lycanthrope') )									activateBaseBestiaryEntryWithAlias("BestiaryLycanthrope", manager); else
		if ( GetSfxTag() == 'sfx_werewolf' )										activateBaseBestiaryEntryWithAlias("BestiaryWerewolf", manager); else
		if ( GetSfxTag() == 'sfx_wyvern' )											activateBaseBestiaryEntryWithAlias("BestiaryWyvern", manager); else
		if ( HasAbility('mon_czart') )											activateBaseBestiaryEntryWithAlias("BestiaryCzart", manager); else
		if ( GetSfxTag() == 'sfx_bies' )											activateBaseBestiaryEntryWithAlias("BestiaryBies", manager); else
		if ( GetSfxTag() == 'sfx_wild_dog' )										activateBaseBestiaryEntryWithAlias("BestiaryDog", manager); else
		if ( GetSfxTag() == 'sfx_drowner' )											activateBaseBestiaryEntryWithAlias("BestiaryDrowner", manager); 
		if ( GetSfxTag() == 'sfx_elemental_ifryt' )									activateBaseBestiaryEntryWithAlias("BestiaryFireElemental", manager); else
		if ( GetSfxTag() == 'sfx_fogling' )											activateBaseBestiaryEntryWithAlias("BestiaryFogling", manager); else
		if ( GetSfxTag() == 'sfx_gravehag' )										activateBaseBestiaryEntryWithAlias("BestiaryGraveHag", manager); else
		if ( GetSfxTag() == 'sfx_gryphon' )											activateBaseBestiaryEntryWithAlias("BestiaryGriffin", manager); else
		if ( HasAbility('mon_erynia') )											activateBaseBestiaryEntryWithAlias("BestiaryErynia", manager); else
		if ( GetSfxTag() == 'sfx_harpy' )											activateBaseBestiaryEntryWithAlias("BestiaryHarpy", manager); else
		if ( GetSfxTag() == 'sfx_ice_giant' )										activateBaseBestiaryEntryWithAlias("BestiaryIceGiant", manager); else
		if ( GetSfxTag() == 'sfx_lessog' )											activateBaseBestiaryEntryWithAlias("BestiaryLeshy", manager); else
		if ( GetSfxTag() == 'sfx_nekker' )											activateBaseBestiaryEntryWithAlias("BestiaryNekker", manager); else
		if ( GetSfxTag() == 'sfx_siren' )											activateBaseBestiaryEntryWithAlias("BestiarySiren", manager); else
		if ( HasTag('ice_troll') )												activateBaseBestiaryEntryWithAlias("BestiaryIceTroll", manager); else
		if ( GetSfxTag() == 'sfx_troll_cave' )										activateBaseBestiaryEntryWithAlias("BestiaryCaveTroll", manager); else
		if ( GetSfxTag() == 'sfx_waterhag' )										activateBaseBestiaryEntryWithAlias("BestiaryWaterHag", manager); else
		if ( GetSfxTag() == 'sfx_wildhunt_minion' )									activateBaseBestiaryEntryWithAlias("BestiaryWhMinion", manager); else
		if ( GetSfxTag() == 'sfx_wolf' )											activateBaseBestiaryEntryWithAlias("BestiaryWolf", manager); else
		if ( GetSfxTag() == 'sfx_wraith' )											activateBaseBestiaryEntryWithAlias("BestiaryWraith", manager); else
		if ( HasAbility('mon_cyclops') ) 										activateBaseBestiaryEntryWithAlias("BestiaryCyclop", manager); else
		if ( HasAbility('mon_ice_golem') )										activateBaseBestiaryEntryWithAlias("BestiaryIceGolem", manager); else
		if ( HasAbility('mon_gargoyle') )										activateBaseBestiaryEntryWithAlias("BestiaryGargoyle", manager); else
		if ( HasAbility('mon_rotfiend') || HasAbility('mon_rotfiend_large')) 	activateBaseBestiaryEntryWithAlias("BestiaryGreaterRotFiend", manager);
		
		
	}
	
	
	public function CalculateExperiencePoints(optional skipLog : bool) : int
	{
		var finalExp : int;
		var exp : float;
		var lvlDiff : int;
		var modDamage, modArmor, modVitality, modOther : float;
		
		if ( grantNoExperienceAfterKill || HasAbility('Zero_XP' ) || GetNPCType() == ENGT_Guard ) return 0;
		
		modDamage = CalculateAttributeValue(GetAttributeValue('RendingDamage',,true));
		modDamage += CalculateAttributeValue(GetAttributeValue('BludgeoningDamage',,true));
		modDamage += CalculateAttributeValue(GetAttributeValue('FireDamage',,true));
		modDamage += CalculateAttributeValue(GetAttributeValue('ElementalDamage',,true));
		modDamage += CalculateAttributeValue(GetPowerStatValue(CPS_AttackPower, , true));
		modDamage *= 5;
		
		modArmor = CalculateAttributeValue(GetTotalArmor()) * 100;
		
		modVitality = GetStatMax(BCS_Essence) + 3 * GetStatMax(BCS_Vitality);

		if ( HasAbility('AcidSpit' ) ) modOther = modOther + 2;
		if ( HasAbility('Aggressive' ) ) modOther = modOther + 2;
		if ( HasAbility('Charge' ) ) modOther = modOther + 3;
		if ( HasAbility('ContactBlindness' ) ) modOther = modOther + 2;
		if ( HasAbility('ContactSlowdown' ) ) modOther = modOther + 2;
		if ( HasAbility('Cursed' ) ) modOther = modOther + 2;
		if ( HasAbility('BurnIgnore' ) ) modOther = modOther + 2;
		if ( HasAbility('DamageBuff' ) ) modOther = modOther + 2;
		if ( HasAbility('Draconide' ) ) modOther = modOther + 2;
		if ( HasAbility('Fireball' ) ) modOther = modOther + 2;
		if ( HasAbility('Flashstep' ) ) modOther = modOther + 2;
		if ( HasAbility('Flying' ) ) modOther = modOther + 10;
		if ( HasAbility('Frost' ) ) modOther = modOther + 4;
		if ( HasAbility('EssenceRegen' ) ) modOther = modOther + 2;
		if ( HasAbility('Gargoyle' ) ) modOther = modOther + 2;
		if ( HasAbility('Hypnosis' ) ) modOther = modOther + 2;
		if ( HasAbility('IceArmor' ) ) modOther = modOther + 5;
		if ( HasAbility('InstantKillImmune' ) ) modOther = modOther + 2;
		if ( HasAbility('JumpAttack' ) ) modOther = modOther + 2;
		if ( HasAbility('Magical' ) ) modOther = modOther + 2;
		if ( HasAbility('MistForm' ) ) modOther = modOther + 2;
		if ( HasAbility('MudTeleport' ) ) modOther = modOther + 2;
		if ( HasAbility('MudAttack' ) ) modOther = modOther + 2;
		if ( HasAbility('PoisonCloud' ) ) modOther = modOther + 2;
		if ( HasAbility('PoisonDeath' ) ) modOther = modOther + 2;
		if ( HasAbility('Rage' ) ) modOther = modOther + 2;
		if ( HasAbility('Relic' ) ) modOther = modOther + 5;
		if ( HasAbility('Scream' ) ) modOther = modOther + 2;
		if ( HasAbility('Shapeshifter' ) ) modOther = modOther + 5;
		if ( HasAbility('Shout' ) ) modOther = modOther + 2;
		if ( HasAbility('Spikes' ) ) modOther = modOther + 2;
		if ( HasAbility('StaggerCounter' ) ) modOther = modOther + 2;
		if ( HasAbility('StinkCloud' ) ) modOther = modOther + 2;
		if ( HasAbility('Summon' ) ) modOther = modOther + 2;
		if ( HasAbility('Tail' ) ) modOther = modOther + 5;
		if ( HasAbility('Teleport' ) ) modOther = modOther + 5;
		if ( HasAbility('Thorns' ) ) modOther = modOther + 2;
		if ( HasAbility('Throw' ) ) modOther = modOther + 2;
		if ( HasAbility('ThrowFire' ) ) modOther = modOther + 2;
		if ( HasAbility('ThrowIce' ) ) modOther = modOther + 2;
		if ( HasAbility('Vampire' ) ) modOther = modOther + 2;
		if ( HasAbility('Venom' ) ) modOther = modOther + 2;
		if ( HasAbility('VitalityRegen' ) ) modOther = modOther + 5;
		if ( HasAbility('Wave' ) ) modOther = modOther + 2;
		if ( HasAbility('WeakToAard' ) ) modOther = modOther - 2;
		if ( HasAbility('TongueAttack' ) ) modOther = modOther + 2;
		
		exp = ( modDamage + modArmor + modVitality + modOther ) / 99;
		
		if( ( FactsQuerySum("NewGamePlus") > 0 ) ) currentLevel -= theGame.params.GetNewGamePlusLevel();
		
		if  ( IsHuman() ) 
		{
			if ( exp > 1 + ( currentLevel * 2 ) ) { exp = 1 + ( currentLevel * 2 ); }
		} else
		{
			if ( exp > 5 + ( currentLevel * 4 ) ) { exp = 5 + ( currentLevel * 4 ); } 
		}
				
		//if  ( IsHuman() ) { exp = exp + 1; } else { exp = exp + 1; }
		exp += 1;
				
		//In NG+ we double ALL received exp below level 50 to make the curve behave the same way in NG+ as in base game - W3LevelManager.AddPoints
		
		if( ( FactsQuerySum("NewGamePlus") > 0 ) )
			lvlDiff = currentLevel - thePlayer.GetLevel() + theGame.params.GetNewGamePlusLevel();
		else
			lvlDiff = currentLevel - thePlayer.GetLevel();
		if 		( lvlDiff >= theGame.params.LEVEL_DIFF_DEADLY ) { exp = 25 + exp * 1.5; }	
		else if ( lvlDiff >= theGame.params.LEVEL_DIFF_HIGH )  { exp = exp * 1.05; }
		else if ( lvlDiff > -theGame.params.LEVEL_DIFF_HIGH )  { }
		else { exp = 2; }
		

		if ( theGame.GetDifficultyMode() == EDM_Easy ) exp = exp * 1.2; else
		if ( theGame.GetDifficultyMode() == EDM_Hard ) exp = exp * 0.9; else
		if ( theGame.GetDifficultyMode() == EDM_Hardcore ) exp = exp * 0.8;
		finalExp = RoundF( exp );
		
		if(!skipLog)
		{
			LogStats("--------------------------------");
			LogStats("-      [CALCULATED EXP]        -");
			LogStats("- base, without difficulty and -");
			LogStats("-   level difference bonuses   -");
			LogStats("--------------------------------");
			LogStats(" -> for entity : " + GetName());
			LogStats("--------------------------------");
			LogStats("* modDamage : " + modDamage);
			LogStats("* modArmor : " + modArmor);
			LogStats("* modVitality : " + modVitality);
			LogStats("+ modOther : " + modOther);
			LogStats("--------------------------------");
			LogStats(" BASE EXPERIENCE POINTS = [ " + finalExp + " ]");
			LogStats("--------------------------------");
		}
		
		return finalExp;
	}
	
	event OnDeath( damageAction : W3DamageAction  )
	{		
		var inWater, fists, tmpBool : bool;		
		var attackAction : W3Action_Attack;
		var expPoints, npcLevel, lvlDiff : int;
		var weaponID : SItemUniqueId;
		var actor : CActor;
		var abilityName, tmpName : name;
		var abilityCount, maxStack, itemExpBonus, radius : float;
		var addAbility : bool;
		var min, max, bonusExp : SAbilityAttributeValue;
		var mutagen : CBaseGameplayEffect;
		var monsterCategory : EMonsterCategory;
		var allItems : array<SItemUniqueId>;
		var attitudeToPlayer : EAIAttitude;
		var i, j : int;
		var ciriEntity  : W3ReplacerCiri;
		var blizzard : W3Potion_Blizzard;
		var gameplayEffect 	: CBaseGameplayEffect;
		var entities  		: array< CGameplayEntity >;
		var targetEntity	: CActor;
		var minDist			: float;
		var params			: SCustomEffectParams;
		var act : W3DamageAction;
		var damages : array<SRawDamage>;
		var ents : array<CGameplayEntity>;
		var atts : array<name>;
		var dmg : SRawDamage;
		var burningCauser : W3Effect_Burning;
		var template : CEntityTemplate;
		var fxEnt : CEntity;

		//Dynamic Scaling - Begin
		var ScalingInit : DynamicScaling;
		
		ScalingInit = new DynamicScaling in this;
		//Dynamic Scaling - End
		
		ciriEntity = (W3ReplacerCiri)thePlayer;		
		
		if ( (thePlayer.HasAbility('Glyphword 10 _Stats', true) || thePlayer.HasAbility('Glyphword 18 _Stats', true)) && (HasBuff(EET_AxiiGuardMe) || HasBuff(EET_Confusion)) )
		{
			if(thePlayer.HasAbility('Glyphword 10 _Stats', true))
				abilityName = 'Glyphword 10 _Stats';
			else
				abilityName = 'Glyphword 18 _Stats';
				
			min = thePlayer.GetAbilityAttributeValue(abilityName, 'glyphword_range');
			FindGameplayEntitiesInRange(entities, this, CalculateAttributeValue(min), 10,, FLAG_OnlyAliveActors + FLAG_ExcludeTarget, this); 	
			
			minDist = 10000;
			for (i = 0; i < entities.Size(); i += 1)
			{
				if ( entities[i] == thePlayer.GetHorseWithInventory() || entities[i] == thePlayer || !IsRequiredAttitudeBetween(thePlayer, entities[i], true) )
					continue;
					
				if ( VecDistance2D(this.GetWorldPosition(), entities[i].GetWorldPosition()) < minDist)
				{
					minDist = VecDistance2D(this.GetWorldPosition(), entities[i].GetWorldPosition());
					targetEntity = (CActor)entities[i];
				}
			}
			
			if ( targetEntity )
			{
				if ( HasBuff(EET_AxiiGuardMe) )
					gameplayEffect = GetBuff(EET_AxiiGuardMe);
				else if ( HasBuff(EET_Confusion) )
					gameplayEffect = GetBuff(EET_Confusion);
				
				params.effectType 				= gameplayEffect.GetEffectType();
				params.creator 					= gameplayEffect.GetCreator();
				params.sourceName 				= gameplayEffect.GetSourceName();
				params.duration 				= gameplayEffect.GetDurationLeft();
				if ( params.duration < 5.0f ) 	params.duration = 5.0f;
				params.effectValue 				= gameplayEffect.GetEffectValue();
				params.customAbilityName 		= gameplayEffect.GetAbilityName();
				params.customFXName 			= gameplayEffect.GetTargetEffectName();
				params.isSignEffect 			= gameplayEffect.IsSignEffect();
				params.customPowerStatValue 	= gameplayEffect.GetCreatorPowerStat();
				params.vibratePadLowFreq 		= gameplayEffect.GetVibratePadLowFreq();
				params.vibratePadHighFreq		= gameplayEffect.GetVibratePadHighFreq();
				
				targetEntity.AddEffectCustom(params);
				gameplayEffect = targetEntity.GetBuff(params.effectType);
				gameplayEffect.SetTimeLeft(params.duration);
				
				template = (CEntityTemplate)LoadResource('glyphword_10_18');
				
				if ( GetBoneIndex( 'pelvis' ) != -1 )
				{
					fxEnt = theGame.CreateEntity(template, GetBoneWorldPosition('pelvis'), GetWorldRotation(), , , true);
					fxEnt.CreateAttachmentAtBoneWS(this, 'pelvis', GetWorldPosition(), GetWorldRotation());
				}
				else
				{
					fxEnt = theGame.CreateEntity(template, GetBoneWorldPosition('k_pelvis_g'), GetWorldRotation(), , , true);
					fxEnt.CreateAttachmentAtBoneWS(this, 'k_pelvis_g', GetWorldPosition(), GetWorldRotation());
				}
				
				fxEnt.PlayEffect('out');
				fxEnt.DestroyAfter(5);
				
				if ( targetEntity.GetBoneIndex( 'pelvis' ) != -1 )
				{
					fxEnt = theGame.CreateEntity(template, targetEntity.GetBoneWorldPosition('pelvis'), targetEntity.GetWorldRotation(), , , true);
					fxEnt.CreateAttachmentAtBoneWS(targetEntity, 'pelvis', targetEntity.GetWorldPosition(), GetWorldRotation());
				}
				else
				{
					fxEnt = theGame.CreateEntity(template, targetEntity.GetBoneWorldPosition('k_pelvis_g'), targetEntity.GetWorldRotation(), , , true);
					fxEnt.CreateAttachmentAtBoneWS(targetEntity, 'k_pelvis_g', targetEntity.GetWorldPosition(), GetWorldRotation());
				}
				
				fxEnt.PlayEffect('in');
				fxEnt.DestroyAfter(5);
			}
		}
		
		super.OnDeath( damageAction );
		
		//Dynamic Scaling - Begin
		if(ScalingInit.BestiaryFix())
		{
			if ( !IsHuman() && VecDistance(thePlayer.GetWorldPosition(), GetWorldPosition()) <= 20 && !ciriEntity && !HasTag('NoBestiaryEntry') ) AddBestiaryKnowledge();	
		}
		else if(!ScalingInit.BestiaryFix())
		{
			if ( !IsHuman() && damageAction.attacker == thePlayer && !ciriEntity && !HasTag('NoBestiaryEntry') ) AddBestiaryKnowledge();
		}
		//Dynamic Scaling - End
		
		if ( !WillBeUnconscious() )
		{
			if ( theGame.GetWorld().GetWaterDepth( this.GetWorldPosition() ) > 0 )
			{
				if ( this.HasEffect( 'water_death' ) ) this.PlayEffectSingle( 'water_death' );
			}
			else
			{
				if ( this.HasEffect( 'blood_spill' ) ) this.PlayEffectSingle( 'blood_spill' );
			}
		}
		
		// For npc sharing the same behavior graph (like animals)
		if ( ( ( CMovingPhysicalAgentComponent ) this.GetMovingAgentComponent() ).HasRagdoll() )
		{
			SetBehaviorVariable('HasRagdoll', 1 );
		}
		
		// MS: Fix for 122671
		if ( (W3AardProjectile)( damageAction.causer ) )
		{
			DropItemFromSlot( 'r_weapon' );
			DropItemFromSlot( 'l_weapon' );
			this.BreakAttachment();
		}
		
		SignalGameplayEventParamObject( 'OnDeath', damageAction );
		theGame.GetBehTreeReactionManager().CreateReactionEvent( this, 'BattlecryGroupDeath', 1.0f, 20.0f, -1.0f, 1 );
		
		attackAction = (W3Action_Attack)damageAction;
		
		//disable Agony when in water
		if ( ((CMovingPhysicalAgentComponent)GetMovingAgentComponent()).GetSubmergeDepth() < 0 )
		{
			inWater = true;
			DisableAgony();
		}
		
		// riders die on ragdoll so sound events have to be played here
		if( IsUsingHorse() )
		{
			SoundEvent( "cmb_play_hit_heavy" );
			SoundEvent( "grunt_vo_death" );
		}
						
		if(damageAction.attacker == thePlayer && ((W3PlayerWitcher)thePlayer) && thePlayer.GetStat(BCS_Toxicity) > 0 && thePlayer.CanUseSkill(S_Alchemy_s17))
		{
			thePlayer.AddAbility(SkillEnumToName(S_Alchemy_s17), true);
			if (thePlayer.GetSkillLevel(S_Alchemy_s17) > 1)
				thePlayer.AddAbility(SkillEnumToName(S_Alchemy_s17), true);
			if (thePlayer.GetSkillLevel(S_Alchemy_s17) > 2)
				thePlayer.AddAbility(SkillEnumToName(S_Alchemy_s17), true);
		}
		
		OnChangeDyingInteractionPriorityIfNeeded();
		
		actor = (CActor)damageAction.attacker;
		
		//experience
		if(ShouldGiveExp(damageAction.attacker))
		{
			npcLevel = (int)CalculateAttributeValue(GetAttributeValue('level',,true));
			lvlDiff = npcLevel - GetWitcherPlayer().GetLevel();
			expPoints = CalculateExperiencePoints();
			//(int)CalculateAttributeValue(GetAttributeValue('experience',,true));
			
			if(expPoints > 0)
			{				
				theGame.GetMonsterParamsForActor(this, monsterCategory, tmpName, tmpBool, tmpBool, tmpBool);
				if(MonsterCategoryIsMonster(monsterCategory))
				{
					bonusExp = thePlayer.GetAttributeValue('nonhuman_exp_bonus_when_fatal');
				}
				else
				{
					bonusExp = thePlayer.GetAttributeValue('human_exp_bonus_when_fatal');
				}				
				
				//Dynamic Scaling - Begin
				if ( ScalingInit.XPScalingCheck() )
				{
					expPoints = RoundMath( expPoints * (1 + CalculateAttributeValue(bonusExp) ) * ScalingInit.XPScalingModifier() * ScalingInit.ExperienceModifier() );
				}
				else
				{
					expPoints = RoundMath( expPoints * (1 + CalculateAttributeValue(bonusExp) ) * ScalingInit.ExperienceModifier() );
				}
				
				GetWitcherPlayer().AddPoints(EExperiencePoint, RoundF( expPoints * theGame.expGlobalMod_kills ), false );
				
				delete ScalingInit;
				//Dynamic Scaling - End
			}			
		}
				
		//---------------------- achievement progress
		attitudeToPlayer = GetAttitudeBetween(this, thePlayer);
		
		if(attitudeToPlayer == AIA_Hostile && !HasTag('AchievementKillDontCount'))
		{
			//charmed NPCs kills		
			if(actor && actor.HasBuff(EET_AxiiGuardMe))
			{
				theGame.GetGamerProfile().IncStat(ES_CharmedNPCKills);
				FactsAdd("statistics_cerberus_sign");
			}
			
			//aard cliff kills
			if( aardedFlight && damageAction.GetBuffSourceName() == "FallingDamage" )
			{
				theGame.GetGamerProfile().IncStat(ES_AardFallKills);
			}
				
			//environment kills
			if(damageAction.IsActionEnvironment())
			{
				theGame.GetGamerProfile().IncStat(ES_EnvironmentKills);
				FactsAdd("statistics_cerberus_environment");
			}
		}
		
		//wanted dead or bovine achievement
		if(HasTag('cow'))
		{
			if( (damageAction.attacker == thePlayer) ||
				((W3SignEntity)damageAction.attacker && ((W3SignEntity)damageAction.attacker).GetOwner() == thePlayer) ||
				((W3SignProjectile)damageAction.attacker && ((W3SignProjectile)damageAction.attacker).GetCaster() == thePlayer) ||
				( (W3Petard)damageAction.attacker && ((W3Petard)damageAction.attacker).GetOwner() == thePlayer)
			){
				theGame.GetGamerProfile().IncStat(ES_KilledCows);
			}
		}
		
		//player only kills - there's a similar check below - see that one too!
		if ( damageAction.attacker == thePlayer )
		{
			theGame.GetMonsterParamsForActor(this, monsterCategory, tmpName, tmpBool, tmpBool, tmpBool);
			
			//mutagen 18 - hp regen bonus
			if(thePlayer.HasBuff(EET_Mutagen18))
			{
				//don't add for non-hostile animals
				
				if(monsterCategory != MC_Animal || IsRequiredAttitudeBetween(this, thePlayer, true))
				{			
					abilityName = thePlayer.GetBuff(EET_Mutagen18).GetAbilityName();
					abilityCount = thePlayer.GetAbilityCount(abilityName);
					
					if(abilityCount == 0)
					{
						addAbility = true;
					}
					else
					{
						theGame.GetDefinitionsManager().GetAbilityAttributeValue(abilityName, 'mutagen18_max_stack', min, max);
						maxStack = CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
						
						if(maxStack >= 0)
						{
							addAbility = (abilityCount < maxStack);
						}
						else
						{
							addAbility = true;
						}
					}
					
					if(addAbility)
					{
						thePlayer.AddAbility(abilityName, true);
					}
				}
			}
			
			// Mutagen 6 - increases max vitality after each kill
			if (thePlayer.HasBuff(EET_Mutagen06))
			{
				//don't add for non-hostile animals
				if(monsterCategory != MC_Animal || IsRequiredAttitudeBetween(this, thePlayer, true))
				{	
					mutagen = thePlayer.GetBuff(EET_Mutagen06);
					thePlayer.AddAbility(mutagen.GetAbilityName(), true);
				}
			}
			
			//Blizzard potion
			if(IsRequiredAttitudeBetween(this, thePlayer, true))
			{
				blizzard = (W3Potion_Blizzard)thePlayer.GetBuff(EET_Blizzard);
				if(blizzard)
					blizzard.KilledEnemy();
			}
			
			if(!HasTag('AchievementKillDontCount'))
			{
				if (damageAction.GetIsHeadShot() && monsterCategory == MC_Human )		
					theGame.GetGamerProfile().IncStat(ES_HeadShotKills);
					
				//cerberus achievement
				if( (W3SignEntity)damageAction.causer || (W3SignProjectile)damageAction.causer)
				{
					FactsAdd("statistics_cerberus_sign");
				}
				else if( (CBaseGameplayEffect)damageAction.causer && ((CBaseGameplayEffect)damageAction.causer).IsSignEffect())
				{
					FactsAdd("statistics_cerberus_sign");
				}
				else if( (W3Petard)damageAction.causer )
				{
					FactsAdd("statistics_cerberus_petard");
				}
				else if( (W3BoltProjectile)damageAction.causer )
				{
					FactsAdd("statistics_cerberus_bolt");
				}				
				else
				{
					if(!attackAction)
						attackAction = (W3Action_Attack)damageAction;
						
					fists = false;
					if(attackAction)
					{
						weaponID = attackAction.GetWeaponId();
						if(damageAction.attacker.GetInventory().IsItemFists(weaponID))
						{
							FactsAdd("statistics_cerberus_fists");
							fists = true;
						}						
					}
					
					if(!fists && damageAction.IsActionMelee())
					{
						FactsAdd("statistics_cerberus_melee");
					}
				}
			}
		}
		
		//player telemetry kills, direct or indirect
		if( damageAction.attacker == thePlayer || !((CNewNPC)damageAction.attacker) )
		{
			theTelemetry.LogWithLabelAndValue(TE_FIGHT_ENEMY_DIES, this.ToString(), GetLevel());
		}
		
		//player direct kill - achievements
		if(damageAction.attacker == thePlayer && !HasTag('AchievementKillDontCount'))
		{
			if ( attitudeToPlayer == AIA_Hostile )
			{
				//Swank achievement
				if(!HasTag('AchievementSwankDontCount'))
				{
					if(FactsQuerySum("statistic_killed_in_10_sec") >= 4)
						theGame.GetGamerProfile().AddAchievement(EA_Swank);
					else
						FactsAdd("statistic_killed_in_10_sec", 1, 10);
				}
				
				//Finesse achievement		
				if(GetWitcherPlayer() && !thePlayer.ReceivedDamageInCombat() && !GetWitcherPlayer().UsedQuenInCombat())
				{
					theGame.GetGamerProfile().IncStat(ES_FinesseKills);
				}
			}
			
			//Fundamentals First achievement
			if((W3PlayerWitcher)thePlayer)
			{
				if(!thePlayer.DidFailFundamentalsFirstAchievementCondition() && HasTag(theGame.params.MONSTER_HUNT_ACTOR_TAG) && !HasTag('failedFundamentalsAchievement'))
				{
					theGame.GetGamerProfile().IncStat(ES_FundamentalsFirstKills);
				}
			}
		}
					
		//igni
		if(!inWater && (W3IgniProjectile)damageAction.causer)
		{
			//burning effect + agony if killed by igni
			if(RandF() < 0.3 && !WillBeUnconscious() )
			{
				AddEffectDefault(EET_Burning, this, 'IgniKill', true);
				EnableAgony();
				SignalGameplayEvent('ForceAgony');			
			}
		}
		
		//glyphword igni explosion		
		if(damageAction.attacker == thePlayer && thePlayer.HasAbility('Glyphword 20 _Stats', true) && damageAction.GetBuffSourceName() != "Glyphword 20")
		{
			burningCauser = (W3Effect_Burning)damageAction.causer;			
			
			if(IsRequiredAttitudeBetween(thePlayer, damageAction.victim, true, false, false) && ((burningCauser && burningCauser.IsSignEffect()) || (W3IgniProjectile)damageAction.causer))
			{
				damageAction.SetForceExplosionDismemberment();
				
				//get radius
				radius = CalculateAttributeValue(thePlayer.GetAbilityAttributeValue('Glyphword 20 _Stats', 'radius'));
				
				//get damages
				theGame.GetDefinitionsManager().GetAbilityAttributes('Glyphword 20 _Stats', atts);
				for(i=0; i<atts.Size(); i+=1)
				{
					if(IsDamageTypeNameValid(atts[i]))
					{
						dmg.dmgType = atts[i];
						dmg.dmgVal = CalculateAttributeValue(thePlayer.GetAbilityAttributeValue('Glyphword 20 _Stats', dmg.dmgType));
						damages.PushBack(dmg);
					}
				}
				
				//get alive actors in sphere
				FindGameplayEntitiesInSphere(ents, GetWorldPosition(), radius, 1000, , FLAG_OnlyAliveActors);
				
				//deal additional damage & burning
				for(i=0; i<ents.Size(); i+=1)
				{
					if(IsRequiredAttitudeBetween(thePlayer, ents[i], true, false, false))
					{
						act = new W3DamageAction in this;
						act.Initialize(thePlayer, ents[i], damageAction.causer, "Glyphword 20", EHRT_Heavy, CPS_SpellPower, false, false, true, false);
						
						for(j=0; j<damages.Size(); j+=1)
						{
							act.AddDamage(damages[j].dmgType, damages[j].dmgVal);
						}
						
						act.AddEffectInfo(EET_Burning, , , , , 0.5f);
						
						theGame.damageMgr.ProcessAction(act);
						delete act;
					}
				}
				
				template = (CEntityTemplate)LoadResource('glyphword_20_explosion');
				
				if ( GetBoneIndex( 'pelvis' ) != -1 )
					theGame.CreateEntity(template, GetBoneWorldPosition('pelvis'), GetWorldRotation(), , , true);
				else
					theGame.CreateEntity(template, GetBoneWorldPosition('k_pelvis_g'), GetWorldRotation(), , , true);
			}
		}
		
		//killed in fist fight
		if(attackAction && IsWeaponHeld('fist') && damageAction.attacker == thePlayer && !thePlayer.ReceivedDamageInCombat() && !HasTag('AchievementKillDontCount'))
		{
			weaponID = attackAction.GetWeaponId();
			if(thePlayer.inv.IsItemFists(weaponID))
				theGame.GetGamerProfile().AddAchievement(EA_FistOfTheSouthStar);
		}
		
		//achievement for killing npc with its own arrow
		if(damageAction.IsActionRanged() && damageAction.IsBouncedArrow())
		{
			theGame.GetGamerProfile().IncStat(ES_SelfArrowKills);
		}
	}
	
	event OnChangeDyingInteractionPriorityIfNeeded()
	{
		if ( WillBeUnconscious() )
			return true;
		if ( HasTag('animal') )
		{
			return true;
		}
			
		//to play awesome death anim
		this.SetInteractionPriority(IP_Max_Unpushable);
	}
	
	event OnFireHit(source : CGameplayEntity)
	{	
		super.OnFireHit(source);
		
		if ( HasTag('animal') )
		{
			Kill(,source);
		}
		
		if ( !IsAlive() && IsInAgony() )
		{
			//abandon agony if is active
			SignalGameplayEvent('AbandonAgony');
			//enable ragdoll
			SetKinematic(false);
		}
	}
	
	event OnAardHit( sign : W3AardProjectile )
	{
		var staminaDrainPerc : float;
		var fxEnt : W3VisualFx;
		var template : CEntityTemplate;
		
		SignalGameplayEvent( 'AardHitReceived' );
		
		aardedFlight = true;
		
		RemoveAllBuffsOfType(EET_Frozen);
		
		//need to be much higher than actually wanted - we get info when ragdoll stops moving
		//the event of ragdol hitting ground is useless as it comes 0.5 sec after applying ragdol
		
		super.OnAardHit(sign);
		
		if ( HasTag('small_animal') )
		{
			Kill();
		}
		if ( IsShielded(sign.GetCaster()) )
		{
			ToggleEffectOnShield('aard_cone_hit', true);
		}
		else if ( HasAbility('ablIgnoreSigns') )
		{
			this.SignalGameplayEvent( 'IgnoreSigns' );
			this.SetBehaviorVariable( 'bIgnoreSigns',1.f );
			AddTimer('IgnoreSignsTimeOut',0.2,false);
		}
		
		//Glyphword 6 _Stats
		staminaDrainPerc = sign.GetStaminaDrainPerc();
		if(IsAlive() && staminaDrainPerc > 0.f && IsRequiredAttitudeBetween(this, sign.GetCaster(), true))
		{
			DrainStamina(ESAT_FixedValue, staminaDrainPerc * GetStatMax(BCS_Stamina));
			/*
			template = (CEntityTemplate)LoadResource('glyphword_6');
			if(GetBoneIndex('pelvis') != -1)
			{
				fxEnt = (W3VisualFx)theGame.CreateEntity(template, GetBoneWorldPosition('pelvis'), GetWorldRotation(), , , true);
				fxEnt.CreateAttachment(this, 'pelvis');
			}
			else			
			{
				fxEnt = (W3VisualFx)theGame.CreateEntity(template, GetBoneWorldPosition('k_pelvis_g'), GetWorldRotation(), , , true);
				fxEnt.CreateAttachment(this, 'k_pelvis_g');
			}
			*/
		}
		
		if ( !IsAlive() )
		{
			//abandon agony if is active
			SignalGameplayEvent('AbandonAgony');
			
			// Ignore the following monsters because we don't have time to make a properly working ragdoll for them
			// Also ignores all the animals because only some have a proper ragdoll
			if( !HasAbility( 'mon_bear_base' )
				&& !HasAbility( 'mon_golem_base' )
				&& !HasAbility( 'mon_endriaga_base' )
				&& !HasAbility( 'mon_gryphon_base' )
				&& !HasAbility( 'q604_shades' )
				&& !IsAnimal()	)
			{			
				//enable ragdoll			
				SetKinematic(false);
			}
		}
	}
	
	event OnAxiiHit( sign : W3AxiiProjectile )
	{
		super.OnAxiiHit(sign);
		
		if ( HasAbility('ablIgnoreSigns') )
		{
			this.SignalGameplayEvent( 'IgnoreSigns' );
			this.SetBehaviorVariable( 'bIgnoreSigns',1.f );
			AddTimer('IgnoreSignsTimeOut',0.2,false);
		}
	}
	
	private const var SHIELD_BURN_TIMER : float;
	default SHIELD_BURN_TIMER = 1.0;
	
	private var beingHitByIgni : bool;
	private var firstIgniTick, lastIgniTick : float;
	
	event OnIgniHit( sign : W3IgniProjectile )
	{
		var horseComponent : W3HorseComponent;
		super.OnIgniHit( sign );
		
		SignalGameplayEvent( 'IgniHitReceived' );
		
		if ( HasAbility( 'ablIgnoreSigns') )
		{
			this.SignalGameplayEvent( 'IgnoreSigns' );
			this.SetBehaviorVariable('bIgnoreSigns',1.f);
			AddTimer('IgnoreSignsTimeOut',0.2,false);
		}
		
		if ( HasAbility( 'IceArmor') )
		{
			this.RemoveAbility( 'IceArmor' );
			this.StopEffect( 'ice_armor' );
			this.PlayEffect( 'ice_armor_hit' );
		}
		
		if( IsShielded( sign.GetCaster() ) )
		{
			if( sign.IsProjectileFromChannelMode() )
			{
				SignalGameplayEvent( 'BeingHitByIgni' );
				
				if( !beingHitByIgni )
				{
					beingHitByIgni = true;
					firstIgniTick = theGame.GetEngineTimeAsSeconds();
					ToggleEffectOnShield( 'burn', true );
					RaiseShield();
				}
				
				if( firstIgniTick + SHIELD_BURN_TIMER < theGame.GetEngineTimeAsSeconds() )
				{
					ProcessShieldDestruction();
					return false;
				}

				AddTimer( 'IgniCleanup', 0.2, false );
			}
			else
			{
				ToggleEffectOnShield( 'igni_cone_hit', true );
			}
		}
		
		horseComponent = GetHorseComponent();
		if ( horseComponent )
			horseComponent.OnIgniHit(sign);
		else
		{
			horseComponent = GetUsedHorseComponent();
			if ( horseComponent )
				horseComponent.OnIgniHit(sign);
		}
	}
	
	public function IsBeingHitByIgni() : bool
	{
		return beingHitByIgni;
	}
	
	function ToggleEffectOnShield(effectName : name, toggle : bool)
	{
		var itemID : SItemUniqueId;
		var inv : CInventoryComponent;
		
		inv = GetInventory();
		itemID = inv.GetItemFromSlot('l_weapon');
		if ( toggle )
			inv.PlayItemEffect(itemID,effectName);
		else
			inv.StopItemEffect(itemID,effectName);
	}
	
	timer function IgniCleanup( dt : float , id : int)
	{
		if( beingHitByIgni )
		{
			ToggleEffectOnShield( 'burn', false );
			AddTimer( 'LowerShield', 0.5 );
			beingHitByIgni = false;
		}
	}
	
	timer function IgnoreSignsTimeOut( dt : float , id : int)
	{
		this.SignalGameplayEvent( 'IgnoreSignsEnd' );
		this.SetBehaviorVariable( 'bIgnoreSigns',0.f);
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	
	function SetIsTeleporting( b : bool )
	{
		isTeleporting = b;
		/*
		if ( isTeleporting )
			SetImmortalityMode( AIM_Invulnerable, AIC_Combat );
		else
			SetImmortalityMode( AIM_None, AIC_Combat );
			*/
	}
	
	function IsTeleporting() : bool
	{
		return isTeleporting;
	}

	function SetUnstoppable( toggle : bool )
	{
		unstoppable = toggle;
	}
	
	function IsUnstoppable() : bool
	{
		return unstoppable;
	}
	
	function SetIsCountering( toggle : bool )
	{
		bIsCountering = toggle;
	}
	
	function IsCountering() : bool
	{
		return bIsCountering;
	}
	
	/**
	
	*/
	timer function Tick(deltaTime : float, id : int)
	{
		//PFTODO: this should be here??
		//this.target = GetTarget();
	}
	
	private function UpdateBumpCollision()
	{
		var npc				: CNewNPC;
		var collisionData	: SCollisionData;
		var collisionNum	: int;
		var i				: int;
		//var mac				: CMovingPhysicalAgentComponent;
		
		
		//mac	= ( CMovingPhysicalAgentComponent ) GetMovingAgentComponent();
		
		if( mac )// && VecLengthSquared( mac.GetVelocity() ) > 1.0f )
		{
			// Get collisions with other characters
			collisionNum	= mac.GetCollisionCharacterDataCount();
			for( i = 0; i < collisionNum; i += 1 )
			{
				collisionData	= mac.GetCollisionCharacterData( i );
				npc	= ( CNewNPC ) collisionData.entity;
				if( npc ) // should be true
				{
					this.SignalGameplayEvent( 'AI_GetOutOfTheWay' ); 					// break the job if we can
					this.SignalGameplayEventParamObject( 'CollideWithPlayer', npc );	// Actual collision
					theGame.GetBehTreeReactionManager().CreateReactionEvent( this, 'BumpAction', 1, 1, 1, 1, false );
					
					// Only one collisuion, at least for now
					break;
				}
			}
		}
	}


	public function SetIsTranslationScaled(b : bool)						{isTranslationScaled = b;}
	public function GetIsTranslationScaled() : bool						{return isTranslationScaled;}	
	
	// Action point
	import final function GetActiveActionPoint() : SActionPointId;


	//////////////////////////////////////////////////////////////////////////////////////////
	// W2 Transfer
	//

	//////////////////////////////////////////////////////////////////////////////////////////
	
	// Is in an interior?
	import final function IsInInterior() : bool;	
	
	// Is in danger
	import final function IsInDanger() : bool;
	
	// Is seeing any non-friendly guyz
	import final function IsSeeingNonFriendlyNPC() : bool;

	// Is AI enabled
	import final function IsAIEnabled() : bool;
	
	// Find best action point
	import final function FindActionPoint( out apID : SActionPointId, out category : name );
			
	// Get default despawn point for this NPC
	import final function GetDefaultDespawnPoint( out spawnPoint : Vector ) : bool;
	

	// Makes actor noticed by NPC
	import final function NoticeActor( actor : CActor );
	
	// If actor is noticed, forces it to be forgotten
	import final function ForgetActor( actor : CActor );
	
	// Forces to forget all noticed actors
	import final function ForgetAllActors();
	
	// Retrieves a noticed item with the given index
	import final function GetNoticedObject( index : int) : CActor;
	
	//////////////////////////////////////////////////////////////////////////////////////////

	import final function GetPerceptionRange() : float;
		
	//////////////////////////////////////////////////////////////////////////////////////////
	
	import final function PlayDialog( optional forceSpawnedActors : bool ) : bool;
 
	//////////////////////////////////////////////////////////////////////////////////////////
	
	// Get reaction script by index
	import final function GetReactionScript( index : int ) : CReactionScript;
	
	import final function IfCanSeePlayer() : bool;
	
	import final function GetGuardArea() : CAreaComponent;
	import final function SetGuardArea( areaComponent : CAreaComponent );
	
	import final function IsConsciousAtWork() : bool;
	import final function GetCurrentJTType() : int;
	import final function IsInLeaveAction() : bool;
	import final function IsSittingAtWork() : bool;
	import final function IsAtWork() : bool;
	import final function IsPlayingChatScene() : bool;
	import final function CanUseChatInCurrentAP() : bool;
	
	// Makes attacker noticed by NPC in guard area even if it was actually outside
	import final function NoticeActorInGuardArea( actor : CActor );
	//////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////////////////ANIM EVENTS////////////////////////////////////////////
	event OnAnimEvent_EquipItemL( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		GetInventory().MountItem( itemToEquip, true );
	}
	event OnAnimEvent_HideItemL( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		GetInventory().UnmountItem( itemToEquip, true );
	}
	event OnAnimEvent_HideWeapons( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		var inventory 	: CInventoryComponent = GetInventory();
		var ids 		: array<SItemUniqueId>;
		var i 			: int;
		
		ids = inventory.GetAllWeapons();
		for( i = 0; i < ids.Size() ; i += 1 )
		{
			if( inventory.IsItemHeld( ids[i] ) || inventory.IsItemMounted( ids[i] ) )
				inventory.UnmountItem( ids[i], true );
		}
	}
	
	event OnAnimEvent_TemporaryOffGround( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		if( animEventType == AET_DurationEnd )
		{
			isTemporaryOffGround = false;
		}
		else
		{
			isTemporaryOffGround = true;
		}
	}
	event OnAnimEvent_weaponSoundType( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		WeaponSoundType().SetupDrawHolsterSounds();
	}
	
	event OnAnimEvent_IdleDown( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetBehaviorVariable( 'idleType', 0.0 );
	}
	
	event OnAnimEvent_IdleForward( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetBehaviorVariable( 'idleType', 1.0 );
	}
	
	event OnAnimEvent_IdleCombat( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetBehaviorVariable( 'idleType', 2.0 );
	}
	
	event OnAnimEvent_WeakenedState( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetWeakenedState( true );
	}
	
	event OnAnimEvent_WeakenedStateOff( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetWeakenedState( false );
	}
	
	public function SetWeakenedState( val : bool )
	{
		if( val )
		{
			AddAbility( 'WeakenedState', false );
			AddTimer( 'ResetHitCounter', 0.0, false );
			SetBehaviorVariable( 'weakenedState', 1.0 );
			PlayEffect( 'olgierd_energy_blast' );
			
			if( HasTag( 'ethereal' ) && !HasAbility( 'EtherealSkill_4' ) )
			{
				AddAbility( 'EtherealMashingFixBeforeSkill4' );
			}
		}
		else
		{
			RemoveAbility( 'WeakenedState' );
			SetBehaviorVariable( 'weakenedState', 0.0 );
			StopEffect( 'olgierd_energy_blast' );
			
			if( HasTag( 'ethereal' ) && !HasAbility( 'EtherealSkill_4' ) )
			{
				RemoveAbility( 'EtherealMashingFixBeforeSkill4' );
			}
		}
	}
	
	public function SetHitWindowOpened( val : bool )
	{
		if( val )
		{
			AddAbility( 'HitWindowOpened', false );
			SetBehaviorVariable( 'hitWindowOpened', 1.0 );
		}
		else
		{
			RemoveAbility( 'HitWindowOpened' );
			SetBehaviorVariable( 'hitWindowOpened', 0.0 );
		}
	}

	event OnAnimEvent_WindowManager( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		if( animEventName == 'OpenHitWindow' )
		{
			SetHitWindowOpened( true );
		}
		else if( animEventName == 'CloseHitWindow' )
		{
			SetHitWindowOpened( false );
		}
		else if( animEventName == 'OpenCounterWindow' )
		{
			SetBehaviorVariable( 'counterHitType', 1.0 );
			AddTimer( 'CloseHitWindowAfter', 0.75 );
		}
	}

	event OnAnimEvent_SlideAway( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		var ticket 				: SMovementAdjustmentRequestTicket;
		var movementAdjustor	: CMovementAdjustor;
		var slidePos 			: Vector;
		var slideDuration		: float;
		
		movementAdjustor = GetMovingAgentComponent().GetMovementAdjustor();
		movementAdjustor.CancelByName( 'SlideAway' );
		
		ticket = movementAdjustor.CreateNewRequest( 'SlideAway' );
		slidePos = GetWorldPosition() + ( VecNormalize2D( GetWorldPosition() - thePlayer.GetWorldPosition() ) * 0.75 );
		
		if( theGame.GetWorld().NavigationLineTest( GetWorldPosition(), slidePos, GetRadius(), false, true ) ) 
		{
			slideDuration = VecDistance2D( GetWorldPosition(), slidePos ) / 35;
			
			movementAdjustor.Continuous( ticket );
			movementAdjustor.AdjustmentDuration( ticket, slideDuration );
			movementAdjustor.AdjustLocationVertically( ticket, true );
			movementAdjustor.BlendIn( ticket, 0.25 );
			movementAdjustor.SlideTo( ticket, slidePos );
			movementAdjustor.RotateTowards( ticket, GetTarget() );
		}

		return true;	
	}
	
	event OnAnimEvent_SlideForward( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		var ticket 				: SMovementAdjustmentRequestTicket;
		var movementAdjustor	: CMovementAdjustor;
		var slidePos 			: Vector;
		var slideDuration		: float;
		
		movementAdjustor = GetMovingAgentComponent().GetMovementAdjustor();
		movementAdjustor.CancelByName( 'SlideForward' );
		
		ticket = movementAdjustor.CreateNewRequest( 'SlideForward' );
		slidePos = GetWorldPosition() + ( VecNormalize2D( GetWorldPosition() - thePlayer.GetWorldPosition() ) * 0.75 );
		
		if( theGame.GetWorld().NavigationLineTest( GetWorldPosition(), slidePos, GetRadius(), false, true ) ) 
		{
			slideDuration = VecDistance2D( GetWorldPosition(), slidePos ) / 35;
			
			movementAdjustor.Continuous( ticket );
			movementAdjustor.AdjustmentDuration( ticket, slideDuration );
			movementAdjustor.AdjustLocationVertically( ticket, true );
			movementAdjustor.BlendIn( ticket, 0.25 );
			movementAdjustor.SlideTo( ticket, slidePos );
		}

		return true;	
	}
	
	event OnAnimEvent_SlideTowards( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		var ticket 				: SMovementAdjustmentRequestTicket;
		var movementAdjustor	: CMovementAdjustor;
		
		movementAdjustor = GetMovingAgentComponent().GetMovementAdjustor();
		movementAdjustor.CancelByName( 'SlideTowards' );
		
		ticket = movementAdjustor.CreateNewRequest( 'SlideTowards' );

		movementAdjustor.AdjustLocationVertically( ticket, true );
		movementAdjustor.BindToEventAnimInfo( ticket, animInfo );
		movementAdjustor.MaxLocationAdjustmentSpeed( ticket, 4 );
		movementAdjustor.ScaleAnimation( ticket );
		movementAdjustor.SlideTowards( ticket, thePlayer, 1.0, 1.25 );
		movementAdjustor.RotateTowards( ticket, GetTarget() );

		return true;	
	}
	
	event OnAnimEvent_PlayBattlecry( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		if( animEventName == 'BC_Sign' )
		{
			PlayVoiceset( 100, "q601_olgierd_taunt_sign" );
		}
		else if( animEventName == 'BC_Taunt' )
		{
			PlayVoiceset( 100, "q601_olgierd_taunt" );
		}
		else
		{
			if( RandRange( 100 ) < 75 )
			{
				if( animEventName == 'BC_Weakened' )
				{
					PlayVoiceset( 100, "q601_olgierd_weakened" );
				}
				else if( animEventName == 'BC_Attack' )
				{
					PlayVoiceset( 100, "q601_olgierd_fast_attack" );
				}
				else if( animEventName == 'BC_Parry' )
				{
					PlayVoiceset( 100, "q601_olgierd_taunt_parry" );
				}
				else
				{
					return false;
				}
			}
		}
	}
	
	//move to OWL class
	event OnAnimEvent_OwlSwitchOpen( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('owl_01');
	}
	//move to OWL class
	event OnAnimEvent_OwlSwitchClose( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('owl_02');
	}
	// move to GOOSE class
	event OnAnimEvent_Goose01OpenWings( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('goose_01_wings');
	}
	// move to GOOSE class
	event OnAnimEvent_Goose01CloseWings( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('goose_01');
	}
	// move to GOOSE class
	event OnAnimEvent_Goose02OpenWings( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('goose_02_wings');
	}
	// move to GOOSE class
	event OnAnimEvent_Goose02CloseWings( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetAppearance('goose_02');
	}

	event OnAnimEvent_NullifyBurning( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		RemoveAllBuffsOfType(EET_Burning);
	}

	event OnAnimEvent_setVisible( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetVisibility( true );
		SetGameplayVisibility( true );
	}
	
	event OnAnimEvent_extensionWalk( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo )
	{
		SetBehaviorVariable( 'UsesExtension', 1 );
	}
	
	////////////////////////////////////////////////////////////////////////////////////////
	
	event OnEquippedItem( category : name, slotName : name )
	{
		if ( slotName == 'r_weapon' )
		{
			switch( category )
			{			
				case 'axe1h':
				case 'axe2h':
					SetBehaviorVariable( 'EquippedItemR', (int) RIT_Axe );
					break;		
				case 'halberd2h':
					SetBehaviorVariable( 'EquippedItemR', (int) RIT_Halberd );
					break;
				case 'steelsword' :
				case 'silversword' :
					SetBehaviorVariable( 'EquippedItemR', (int) RIT_Sword );
					break;
				case 'crossbow' :
					SetBehaviorVariable( 'EquippedItemR', (int) RIT_Crossbow );
					break;
				default:
					SetBehaviorVariable( 'EquippedItemR', (int) RIT_None );
					break;
			}
		}
		else if ( slotName == 'l_weapon' )
		{
			switch( category )
			{
				case 'shield' :
					SetBehaviorVariable( 'EquippedItemL', (int) LIT_Shield );
					break;
				case 'bow' :
					SetBehaviorVariable( 'EquippedItemL', (int) LIT_Bow );
					break;
				case 'usable' :
					SetBehaviorVariable( 'EquippedItemL', (int) LIT_Torch );
					break;
				default:
					SetBehaviorVariable( 'EquippedItemL', (int) LIT_None );
					break;
			}
		}
		
		if ( category != 'fist' && category != 'work' && category != 'usable' && IsInCombat() && GetTarget() == thePlayer && thePlayer.GetTarget() == this )
			thePlayer.OnTargetWeaponDrawn();
	}
	
	event OnHolsteredItem( category : name, slotName : name )
	{
		if ( slotName == 'r_weapon' )
		{
			SetBehaviorVariable( 'EquippedItemR', (int) RIT_None );
		}
		else if ( slotName == 'l_weapon' )
		{
			SetBehaviorVariable( 'EquippedItemL', (int) LIT_None );
		}
	}
	
	function IsTalkDisabled () : bool
	{
		return isTalkDisabled || isTalkDisabledTemporary;
	}
	
	public function DisableTalking( disable : bool, optional temporary : bool )
	{		
		if ( temporary )
		{
			isTalkDisabledTemporary = disable;
		}
		else
		{
			isTalkDisabled = disable;
		}
	}

	public function CanStartTalk() : bool
	{
		// block talk interaction for working npcs who are not conscious at work
		if( IsAtWork() && !IsConsciousAtWork() || IsTalkDisabled () )
			return false;
			
		if(HasBuff(EET_AxiiGuardMe) || HasBuff(EET_Confusion))
			return false;
			
		return !IsFrozen() && CanTalk( true );
	}
	
	event OnInteraction( actionName : string, activator : CEntity )
	{
		var horseComponent		: W3HorseComponent;
		var ciriEntity  		: W3ReplacerCiri;
		var isAtWork			: bool;
		var isConciousAtWork 	: bool;
		
		LogChannel( 'DialogueTest', "Event Interaction Used" );
		if ( actionName == "Talk" )
		{	
			LogChannel( 'DialogueTest', "Activating TALK Interaction - PLAY DIALOGUE" );
			// By default, play dialog
			if ( !PlayDialog() )
			{
				// No main dialog found
				
				EnableDynamicLookAt( thePlayer, 5 );
				ciriEntity = (W3ReplacerCiri)thePlayer;
				if ( ciriEntity )
				{
				}
				else
				{
					//play greeting										
					if( !IsAtWork() || IsConsciousAtWork() )
					{
						PlayVoiceset(100, "greeting_geralt" );
					}
					else
						PlayVoiceset(100, "sleeping" );
					
					wasInTalkInteraction = true;
					AddTimer( 'ResetTalkInteractionFlag', 1.0, true, , , true);
				}
			}
		}
		if ( actionName == "Finish" )
		{
			/*if( SignalGameplayEventReturnInt( 'IsFinisherHandledByTask',0 ) == 1 )
			{
				SignalGameplayEvent( 'AgonyFinisher' );
			}
			SignalGameplayEvent( 'AgonyFinisher ');*/
		}
		else if( actionName == "AxiiCalmHorse" )
		{
			SignalGameplayEvent( 'HorseAxiiCalmDownStart' );
		}
	}
	
	event OnInteractionActivationTest( interactionComponentName : string, activator : CEntity )
	{
		var stateName : name;
		var horseComp : W3HorseComponent;
		
		if( interactionComponentName == "talk" )
		{
			if( activator == thePlayer && thePlayer.CanStartTalk() && CanStartTalk() )
			{	
				return true;
			}
		}
		else if( interactionComponentName == "Finish" && activator == thePlayer )
		{
			stateName = thePlayer.GetCurrentStateName();
			if( stateName == 'CombatSteel' || stateName == 'CombatSilver' )
				return true;
		}
		else if( interactionComponentName == "horseMount" && activator == thePlayer )
		{
			if( !thePlayer.IsActionAllowed( EIAB_MountVehicle ) || thePlayer.IsInAir() )
				return false;
			if ( horseComponent.IsInHorseAction() || !IsAlive() )
				return false;
			if ( GetAttitudeBetween(this,thePlayer) == AIA_Hostile && !( HasBuff(EET_Confusion) || HasBuff(EET_AxiiGuardMe) ) )
				return false;
			
			if( mac.IsOnNavigableSpace() )
			{
				if( theGame.GetWorld().NavigationLineTest( activator.GetWorldPosition(), this.GetWorldPosition(), 0.05, false, true ) ) 
				{
					// test creatures existence on the path
					if( theGame.TestNoCreaturesOnLine( activator.GetWorldPosition(), this.GetWorldPosition(), 0.4, (CActor)activator, this, true ) ) 
					{
						return true;
					}
					
					return false;
				}
			}
			else
			{
				horseComp = this.GetHorseComponent();
				
				if( horseComp )
				{
					horseComp.mountTestPlayerPos = activator.GetWorldPosition();
					horseComp.mountTestPlayerPos.Z += 0.5;
					horseComp.mountTestHorsePos = this.GetWorldPosition();
					horseComp.mountTestHorsePos.Z += 0.5;
					
					if( !theGame.GetWorld().StaticTrace( horseComp.mountTestPlayerPos, horseComp.mountTestHorsePos, horseComp.mountTestEndPos, horseComp.mountTestNormal, horseComp.mountTestCollisionGroups ) )
					{
						return true;
					}
				}
				
				return false;
			}
		}
		/*else if( interactionComponentName == "follow" && canBeFollowed && activator == thePlayer && !thePlayer.IsUsingHorse() )
		{
			if( GetAttitude( thePlayer ) != AIA_Hostile )
			{
				thePlayer.SetCanFollowNpc( true, (CActor)this );
				return true;
			}
		}*/
		/*else if( interactionComponentName == "horseFollow" && canBeFollowed && activator == thePlayer && thePlayer.IsUsingHorse() && !thePlayer.GetUsedHorseComponent().CanFollowNpc() )
		{
			if( GetHorseUser() != thePlayer && GetHorseUser().GetAttitude( thePlayer ) != AIA_Hostile )
			{
				thePlayer.GetUsedHorseComponent().SetCanFollowNpc( true, GetHorseComponent() );
				return true;
			}
		}*/
		
		return false;	
	}
	
	event OnInteractionTalkTest()
	{
		return CanStartTalk();		
	}

	//not optimised - fix this!!! Method "SetNPCHealthPercent" is called to often
	event OnInteractionActivated( interactionComponentName : string, activator : CEntity )
	{
		//LogChannel( 'DialogueTest', "Event Interaction Activated" );
		
		//if( interactionComponentName == "Finish" && (CPlayer)activator )
		//{
		//		theUI.GetHud().UpdateInteractionButton( false );
		//}
	}
	
	event OnInteractionDeactivated( interactionComponentName : string, activator : CEntity )
	{
		//if( interactionComponentName == "Finish" && (CPlayer)activator )
		//{
		//		theUI.GetHud().UpdateInteractionButton( false );
		//}
	}

	// DIALOG STATE EVENTS
	
	//event OnBlockingScenePrepare( scene: CStoryScene )
	//event OnBlockingSceneStarted( scene: CStoryScene )
	//{
		//super.OnBlockingSceneStarted( scene );
		//this is not needed
		//PushState('NpcDialogScene');				//TODO - Exiting Work, fast finishing all tasks
	//}
	
	event OnBehaviorGraphNotification( notificationName : name, stateName : name )
	{
		var i: int;		
		for ( i = 0; i < behaviorGraphEventListened.Size(); i += 1 )
		{
			if( behaviorGraphEventListened[i] == notificationName )
			{
				SignalGameplayEventParamCName( notificationName, stateName );
			}
		}
		super.OnBehaviorGraphNotification( notificationName, stateName );
	}
	
	public function ActivateSignalBehaviorGraphNotification( notificationName : name )
	{
		if( !behaviorGraphEventListened.Contains( notificationName ) )
		{
			behaviorGraphEventListened.PushBack( notificationName );
		}
	}
	
	public function DeactivateSignalBehaviorGraphNotification( notificationName : name )
	{
		behaviorGraphEventListened.Remove( notificationName );
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// Abilities/Perks
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	function IsShielded( target : CNode ) : bool
	{
		var targetToSourceAngle	: float;
		var protectionAngleLeft, protectionAngleRight : float;
		
		if( target )
		{
			if( HasShieldedAbility() && IsGuarded() )
			{
				targetToSourceAngle = NodeToNodeAngleDistance(target, this);
				protectionAngleLeft = CalculateAttributeValue( this.GetAttributeValue( 'protection_angle_left' ) );
				protectionAngleRight = CalculateAttributeValue( this.GetAttributeValue( 'protection_angle_right' ) );
				
				// npcs is shielded more from left
				if( targetToSourceAngle < protectionAngleRight && targetToSourceAngle > protectionAngleLeft )
				{
					return true;
				}
			}
			return false;
		}
		else
			return HasShieldedAbility() && IsGuarded();
	}
	
	function HasShieldedAbility() : bool
	{
		var attval : float;
		attval = CalculateAttributeValue( this.GetAttributeValue( 'shielded' ) );
		if( attval >= 1.f )
			return true;
		else
			return false;
	}
	
	function RaiseShield()
	{
		SetBehaviorVariable( 'bShieldUp', 1.f );
	}
	
	timer function LowerShield( td : float , id : int)
	{
		SetBehaviorVariable( 'bShieldUp', 0.f );
	}
		
	public function ProcessShieldDestruction()
	{	
		var shield : CEntity;
		
		if( HasTag( 'imlerith' ) )
			return;
			
		SetBehaviorVariable( 'bShieldbreak', 1.0 );
		AddEffectDefault( EET_Stagger, thePlayer, "ParryStagger" );
		shield = GetInventory().GetItemEntityUnsafe( GetInventory().GetItemFromSlot( 'l_weapon' ) );
		ToggleEffectOnShield( 'heavy_block', true );
		DropItemFromSlot( 'l_weapon', true );
	}

	event OnIncomingProjectile( isBomb : bool ) // this is used to react for projectiles from player
	{
		if( IsShielded( thePlayer ) )
		{
			RaiseShield();
			AddTimer( 'LowerShield', 3.0 );
		}
	}
	
	function ShouldAttackImmidiately() : bool
	{
		return  tauntedToAttackTimeStamp > 0 && ( tauntedToAttackTimeStamp + 10 > theGame.GetEngineTimeAsSeconds() );
	}
	
	function CanAttackKnockeddownTarget() : bool
	{
		var attval : float;
		attval = CalculateAttributeValue(this.GetAttributeValue('attackKnockeddownTarget'));
		if ( attval >= 1.f )
			return true;
		else
			return false;
	}
	
	event OnProcessRequiredItemsFinish()
	{
		var inv : CInventoryComponent = this.GetInventory();
		var heldItems, heldItemsNames, mountedItems : array<name>;
		
		if ( thePlayer.GetTarget() == this )
			thePlayer.OnTargetWeaponDrawn();
		
		// to keep visuals with the data from npc class
		SetBehaviorVariable( 'bIsGuarded', (int)IsGuarded() );
		
		inv.GetAllHeldAndMountedItemsCategories(heldItems, mountedItems);
				
		// shield section
		if ( this.HasShieldedAbility() )
		{
			RaiseGuard();
		}
		
		inv.GetAllHeldItemsNames( heldItemsNames );
		
		if ( heldItemsNames.Contains('fists_lightning') || heldItemsNames.Contains('fists_fire') )
		{
			this.PlayEffect('hand_fx');
			theGame.GetBehTreeReactionManager().CreateReactionEventIfPossible( this, 'FireDanger', -1, 5.0f, 1, -1, true, true );
		}
		else
		{
			this.StopEffect('hand_fx');
			theGame.GetBehTreeReactionManager().RemoveReactionEvent( this, 'FireDanger' );
		}
		
		if ( mountedItems.Contains('shield') )
		{
			this.AddAbility('CannotBeAttackedFromBehind', false);
			LowerGuard();
		}
		else
		{
			this.RemoveAbility('CannotBeAttackedFromBehind');
		}
	}
	
	public function ProcessSpearDestruction() : bool //returns true if spear is destroyed//
	{
		var appearanceName : name;
		var shouldDrop : bool;
		var spear : CEntity;
		
		appearanceName = 'broken';
		spear = GetInventory().GetItemEntityUnsafe( GetInventory().GetItemFromSlot( 'r_weapon' ) );
		spear.ApplyAppearance( appearanceName );
		DropItemFromSlot('r_weapon', true);
		return true;
		
	}	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// Vital spots
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	function PlayVitalSpotAmbientSound( soundEvent : string )
	{
		SoundEvent( soundEvent, 'pelvis' );
	}
	
	function StopVitalSpotAmbientSound( soundEvent : string)
	{
		SoundEvent( soundEvent, 'pelvis' );
	}
	
	event OnScriptReloaded()
	{
		//Log( "OnScriptReloaded called on " + this );
	}
		

	
	
	//Method for changing the fight stage for bossfights and mini-bosses
	//Remember to set the max value of the npcFightStage in NPC behavior graph to maximum used stage
	//e.g. if an NPC has two fight stages, the max value should be 1 (0 is first stage, 1 is the second)
	public function ChangeFightStage( fightStage : ENPCFightStage )
	{
		currentFightStage =  fightStage;
		SetCurrentFightStage();
	}
	//Method sets the npcFightStage behavior variable for current npc fight stage
	public function SetCurrentFightStage()
	{
		SetBehaviorVariable( 'npcFightStage', (float)(int)currentFightStage, true );
	}
	
	public function GetCurrentFightStage() : ENPCFightStage
	{
		return currentFightStage;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	public function SetBleedBurnPoison()
	{
		wasBleedingBurningPoisoned = true;
	}
	
	public function WasBurnedBleedingPoisoned() : bool
	{
		return wasBleedingBurningPoisoned;
	}
	
	//checks if victim has quen and if so modifies accordingly scheduled buffs
	public function HasAlternateQuen() : bool
	{
		var npcStorage : CHumanAICombatStorage;
		
		npcStorage = (CHumanAICombatStorage)GetAIStorageObject('CombatData');
		if(npcStorage && npcStorage.IsProtectedByQuen() )
		{
			return true;
		}		
		
		return false;
	}
	
	
	public function GetIsMonsterTypeGroup() : bool	{ return isMonsterType_Group; }

	//////////////////////////////////////////////////////////////////////////////////////////
	// Update visual debug information
	//////////////////////////////////////////////////////////////////////////////////////////
	function UpdateAIVisualDebug()
	{	
/*		var vd : CVisualDebug;
		var pos : Vector;
		var col : Color;
		var att : EAIAttitude;
		var target : CActor;
		var idx, subIndex : int;
		var displayMode : name;
		
		super.UpdateAIVisualDebug();
	
		displayMode = theGame.aiInfoDisplayMode;		
		if( displayMode == 'all' || displayMode == 'npc' )
		{	
			vd = GetAIVisualDebug();
			pos = GetVisualDebugPos();
			col = GetVisualDebugColor();
			
			att = GetAttitude( thePlayer );			
			vd.= GetTarget();
			if( target && target.combatSlots && target.combatSlots.HasActorInCombatSlot( this ) )
			{
				idx = target.combatSlots.GetCombatSlotIndex( this, subIndex );
				if( idx != -1 )
				{
					vd.AddText('inSlot', "IN COMBAT SLOT "+idx+", "+subIndex, pos, false, 14, Color(0, 255, 0), false, 1.0 );
					vd.AddText('offSlot', "OffSlot: "+offSlot, pos, false, 15, Color(0, 255, 0), false, 1.0 );					
				}
				else
				{
					vd.RemoveText('inSlot');
					vd.RemoveText('offSlot');
				}
			}
			else
			{
				vd.RemoveText('inSlot');
				vd.RemoveText('offSlot');
			}
			
			if( combatIdleGroupIdx != -1 )
			{
				vd.AddText('inIdleSlot', "IN COMBAT IDLE GROUP "+combatIdleGroupIdx, pos, false, 14, Color(0, 255, 255), false, 1.0 );
			}
			else
			{
				vd.RemoveText('inIdleSlot');
			}
		}
*/	}

	//this event comes from behavior graph <- when Idle/Walk/Run becomes current active state
	event OnAllowBehGraphChange()
	{
		allowBehGraphChange = true;
	}
	//this event comes from behavior graph <- when Idle/Walk/Run is no longer current active state
	event OnDisallowBehGraphChange()
	{
		allowBehGraphChange = false;
	}

	event OnObstacleCollision( object : CObject, physicalActorindex : int, shapeIndex : int  )
	{
		var  ent : CEntity;
		var component : CComponent;
		component = (CComponent) object;
		if( !component )
		{
			return false;
		}
		
		ent = component.GetEntity();
		//this.SignalGameplayEvent('CollisionWithObstacle');
		if ( (CActor)ent != this )
		{
			//FIXME URGENT - THIS WILL ALSO GET CALLED IF ENT IS NOT AN ACTOR - INTENDED?
			this.SignalGameplayEventParamObject('CollisionWithObstacle',ent);
		}
	}
	
	event OnActorCollision( object : CObject, physicalActorindex : int, shapeIndex : int  )
	{
		var  ent : CEntity;
		var component : CComponent;
		component = (CComponent) object;
		if( !component )
		{
			return false;
		}
		
		ent = component.GetEntity();
		if ( ent != this )
		{
			this.SignalGameplayEventParamObject('CollisionWithActor', ent );
			
			// horse charge
			if( horseComponent )
			{
				horseComponent.OnCharacterCollision( ent );
			}
		}
	}
	
	event OnActorSideCollision( object : CObject, physicalActorindex : int, shapeIndex : int  )
	{
		var  ent : CEntity;
		var horseComp : W3HorseComponent;
		var component : CComponent;
		component = (CComponent) object;
		if( !component )
		{
			return false;
		}
		
		ent = component.GetEntity();
		if ( ent != this )
		{
			this.SignalGameplayEventParamObject('CollisionWithActor', ent );
			
			// horse charge
			if( horseComponent )
			{
				horseComponent.OnCharacterSideCollision( ent );
			}
		}
	}
	
	event OnStaticCollision( component : CComponent )
	{
		SignalGameplayEventParamObject('CollisionWithStatic',component);
	}
	
	event OnBoatCollision( object : CObject, physicalActorindex : int, shapeIndex : int  )
	{
		var  ent : CEntity;
		var component : CComponent;
		component = (CComponent) object;
		if( !component )
		{
			return false;
		}
		
		ent = component.GetEntity();
		if ( ent != this )
		{
			this.SignalGameplayEventParamObject('CollisionWithBoat', ent );
		}
	}
	
	////////////////
	// water
	////////////////
	
	public function IsUnderwater() : bool { return isUnderwater; }
	public function ToggleIsUnderwater ( toggle : bool ) { isUnderwater = toggle; }
	
	event OnOceanTriggerEnter()
	{
		SignalGameplayEvent('EnterWater');
	}
	
	event OnOceanTriggerLeave()
	{
		SignalGameplayEvent('LeaveWater');
	}
	
	////////////////
	// ragdoll triggering
	////////////////
		
	var isRagdollOn : bool; default isRagdollOn = false;
	
	event OnInAirStarted()
	{		
		/*if( !isInAir && !IsSwimming() && !IsUnderwater() && GetCurrentStance() != NS_Fly )
		{
			isInAir = true;
			isRagdollOn = false;
			AddTimer( 'DelayRagdollSwitch', 0.25 );
		}*/
	}
	
	event OnRagdollOnGround()
	{		
		var params : SCustomEffectParams;
		
		if( GetIsFallingFromHorse() )
		{
			params.effectType = EET_Ragdoll;
			params.creator = this;
			params.sourceName = "ragdoll_dismount";
			params.duration = 0.5;
			AddEffectCustom( params );
			SignalGameplayEvent( 'RagdollFromHorse' ); 
			SetIsFallingFromHorse( false );
		}
		else if( IsInAir() )
		{
			SetIsInAir(false);
		}
	}
	
	var m_storedInteractionPri : EInteractionPriority;
	default	m_storedInteractionPri = IP_NotSet;
	
	event OnRagdollStart()
	{
		var currentPri : EInteractionPriority;
	
		// store interaction priority when actor is alive and set unpushable
		currentPri = GetInteractionPriority();
		if ( currentPri != IP_Max_Unpushable && IsAlive() )
		{
			m_storedInteractionPri = currentPri;
			SetInteractionPriority( IP_Max_Unpushable );
		}
	}
	
	event OnNoLongerInRagdoll()
	{
		aardedFlight = false;
		
		// restore interaction priority when ragdoll is finished
		if ( m_storedInteractionPri != IP_NotSet && IsAlive() )
		{
			SetInteractionPriority( m_storedInteractionPri );
			m_storedInteractionPri = IP_NotSet;
		}
	}
	
	timer function DelayRagdollSwitch( td : float , id : int)
	{
		var params : SCustomEffectParams;
	
		if( IsInAir() )
		{
			isRagdollOn = true;
			params.effectType = EET_Ragdoll;
			params.duration = 5;
			
			AddEffectCustom(params);
		}
	}

	event OnRagdollIsAwayFromCapsule( ragdollPosition : Vector, entityPosition : Vector )
	{
	}
	
	event OnRagdollCloseToCapsule( ragdollPosition : Vector, entityPosition : Vector )
	{
	}
	
	event OnTakeDamage( action : W3DamageAction )
	{
		var i : int;
		var abilityName : name;
		var abilityCount, maxStack : float;
		var min, max : SAbilityAttributeValue;
		var addAbility : bool;
		var witcher : W3PlayerWitcher;
		var attackAction : W3Action_Attack;
		var gameplayEffects : array<CBaseGameplayEffect>;
		var template : CEntityTemplate;
		var hud : CR4ScriptedHud;
		var ent : CEntity;

		super.OnTakeDamage(action);
		
		//player's mutagen 10 (dmg bonus for each successfull sword attack)
		if(action.IsActionMelee() && action.DealsAnyDamage())
		{
			witcher = (W3PlayerWitcher)action.attacker;
			if(witcher && witcher.HasBuff(EET_Mutagen10))
			{
				abilityName = thePlayer.GetBuff(EET_Mutagen10).GetAbilityName();
				abilityCount = thePlayer.GetAbilityCount(abilityName);
				
				if(abilityCount == 0)
				{
					addAbility = true;
				}
				else
				{
					theGame.GetDefinitionsManager().GetAbilityAttributeValue(abilityName, 'mutagen10_max_stack', min, max);
					maxStack = CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
					
					if(maxStack >= 0)
					{
						addAbility = (abilityCount < maxStack);
					}
					else
					{
						addAbility = true;
					}
				}
				
				if(addAbility)
				{
					thePlayer.AddAbility(abilityName, true);
				}
			}
			
			attackAction = (W3Action_Attack)action;

			if ( witcher && attackAction && attackAction.attacker == witcher )
			{
				if ( !attackAction.IsParried() && !attackAction.IsCountered() )
				{
					if ( witcher.HasAbility( 'Runeword 11 _Stats', true ) )
					{
						gameplayEffects = witcher.GetPotionBuffs();
						theGame.GetDefinitionsManager().GetAbilityAttributeValue( 'Runeword 11 _Stats', 'duration', min, max );
						
						for ( i = 0; i < gameplayEffects.Size(); i+=1 )
						{
							gameplayEffects[i].SetTimeLeft( gameplayEffects[i].GetTimeLeft() + min.valueAdditive );
							
							hud = (CR4ScriptedHud)theGame.GetHud();
							if (hud)
							{
								hud.ShowBuffUpdate();
							}
						}
					}
				}
			}
		}
		
		if(action.IsActionMelee())
			lastMeleeHitTime = theGame.GetEngineTime();
	}
	
	public function GetInteractionData( out actionName : name, out text : string ) : bool
	{
		if ( CanStartTalk() && !IsInCombat() )
		{
			actionName	= 'Talk';
			text		= "panel_button_common_talk";
			return true;
		}
		return false;
	}
	
	public function IsAtWorkDependentOnFireSource() : bool
	{
		if ( IsAPValid(GetActiveActionPoint()) )
		{
			return theGame.GetAPManager().IsFireSourceDependent( GetActiveActionPoint() );
		}
		
		return false;
	}
	
	public function FinishQuen(skipVisuals : bool)
	{
		SignalGameplayEvent('FinishQuen');
	}

	public function IsAxiied() : Bool
	{
		return HasBuff( EET_AxiiGuardMe ) || HasBuff( EET_Confusion );
	}
	
	private timer function CloseHitWindowAfter( dt : float, id : int )
	{
		SetBehaviorVariable( 'counterHitType', 0.0 );
	}
}

exec function IsFireSource( tag : name )
{
	var npc : CNewNPC;

	npc = ( CNewNPC )theGame.GetEntityByTag( tag );	
	
	LogChannel('SD', "" + npc.IsAtWorkDependentOnFireSource() );
}	

