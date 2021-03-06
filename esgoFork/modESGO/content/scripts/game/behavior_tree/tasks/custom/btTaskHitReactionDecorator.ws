/***********************************************************************/
/** Witcher Script file
/***********************************************************************/
/** Copyright © 2012 CD Projekt RED
/** Author : Patryk Fiutowski, Andrzej Kwiatkowski
/***********************************************************************/

class CBTTaskHitReactionDecorator extends CBTTaskPlayAnimationEventDecorator
{
	public var createHitReactionEvent 	: name;
	public var increaseHitCounterOnlyOnMeleeDmg : bool;
	
	private var hitsToRaiseGuard 		: int;
	private var raiseGuardChance 		: int;
	
	private var hitsToCounter	 		: int;	
	private var counterChance	 		: int;
	private var counterStaminaCost		: float;
	
	private var damageData 				: CDamageData;
	private var damageIsMelee 			: bool;
	private var rotateNode 				: CNode;
	private var lastAttacker 			: CGameplayEntity;

	protected var reactionDataStorage 	: CAIStorageReactionData;
	
	function IsAvailable() : bool
	{
		return (GetActor().CanPlayHitAnim() && !GetNPC().IsUnstoppable() );
	}
	
	function OnActivate() : EBTNodeStatus
	{
		var npc : CNewNPC = GetNPC();
		
		GetStats();
		
		npc.SetIsInHitAnim(true);
		
		InitializeReactionDataStorage();
		reactionDataStorage.ChangeAttitudeIfNeeded( npc, (CActor)lastAttacker );
		
		if ( CheckGuardOrCounter() && ( !increaseHitCounterOnlyOnMeleeDmg || damageIsMelee ) )
		{
			npc.DisableHitAnimFor(0.1);
			npc.SetIsInHitAnim(false);
			return BTNS_Completed;
		}
		
		return BTNS_Active;
	}
	
	/*latent function Main() : EBTNodeStatus
	{
		hitCounter = 0;
		
		while ( isActive )
		{
			
			SleepOneFrame();
		}
		return BTNS_Active;
	}*/
	
	function OnDeactivate()
	{
		var npc : CNewNPC = GetNPC();
		
		npc.SetIsTranslationScaled( false );
		npc.SetIsInHitAnim(false);
	}
	
	function GetStats()
	{
		var raiseGuardMultiplier : int;
		var counterMultiplier : int;
		var Scaling : DynamicScaling;
		
		Scaling = new DynamicScaling in this;
		
		hitsToRaiseGuard = CeilF(Scaling.GuardHitNumberMult()*(int)CalculateAttributeValue(GetActor().GetAttributeValue('hits_to_raise_guard')));
		raiseGuardChance = (int)MaxF(0, 100*(Scaling.GuardRaiseCh() * CalculateAttributeValue(GetActor().GetAttributeValue('raise_guard_chance'))));
		raiseGuardMultiplier = (int)MaxF(0, 100*(Scaling.GuardMultPH() * CalculateAttributeValue(GetActor().GetAttributeValue('raise_guard_chance_mult_per_hit'))));
		
		hitsToCounter = CeilF(Scaling.CounterHitNumberMult()*(int)CalculateAttributeValue(GetActor().GetAttributeValue('hits_to_roll_counter')));
		counterChance = (int)MaxF(0, 100*(Scaling.CounterCh() * CalculateAttributeValue(GetActor().GetAttributeValue('counter_chance'))));
		counterMultiplier = (int)MaxF(0, 100*(Scaling.CounterMultPH() * CalculateAttributeValue(GetActor().GetAttributeValue('counter_chance_per_hit'))));
		
		counterStaminaCost = CalculateAttributeValue(GetNPC().GetAttributeValue( 'counter_stamina_cost' ));
		
		raiseGuardChance += Max( 0, GetNPC().GetHitCounter() - 1 ) * raiseGuardMultiplier;
		counterChance += Max( 0, GetNPC().GetHitCounter() - 1 ) * counterMultiplier;
		
		if ( hitsToRaiseGuard < 0 )
		{
			hitsToRaiseGuard = 65536;
		}
		delete Scaling;
	}
	
	function CheckGuardOrCounter() : bool
	{
		var npc : CNewNPC = GetNPC();
		var hitCounter : int;
		
		if( npc.HasTag( 'olgierd_gpl' ) )
		{
			if( AbsF( NodeToNodeAngleDistance( thePlayer, npc ) ) > 90 )
			{
				return false;
			}
		}
		
		hitCounter = npc.GetHitCounter();
		if ( hitCounter >= hitsToRaiseGuard && npc.CanGuard() )
		{
			GetStats();
			if( Roll( raiseGuardChance ) )
			{		
				if ( npc.RaiseGuard() )
				{
					npc.SignalGameplayEvent('HitReactionTaskCompleted');
					return true;
				}
			}
		}
		if ( !npc.IsHuman() && GetActor().GetMovingAgentComponent().GetName() != "wild_hunt_base" && hitCounter >= hitsToCounter  )
		{
			if( Roll( counterChance ) && npc.GetStat( BCS_Stamina ) >= counterStaminaCost )
			{
				npc.SignalGameplayEvent('LaunchCounterAttack');
				return true;
			}
		}
		
		return false;
	}
	
	function CheckDistanceToAttacker( attacker : CActor ) : bool
	{
		var dist : float;
		
		dist = VecDistanceSquared(GetActor().GetWorldPosition(), attacker.GetWorldPosition() );
		return false;
	}
	
	function OnListenedGameplayEvent( eventName : name ) : bool
	{
		var npc : CNewNPC = GetNPC();
		
		if ( eventName == 'BeingHit' )
		{			
			damageData 		= (CDamageData) GetEventParamBaseDamage();
			damageIsMelee 	= damageData.isActionMelee;
			
			lastAttacker = damageData.attacker;
			
			if ( !npc.IsInFistFightMiniGame() && (CActor)lastAttacker )
				theGame.GetBehTreeReactionManager().CreateReactionEventIfPossible( lastAttacker, 'CombatNearbyAction', 5.f, 10.f, 999.0f, -1, true); //reactionSystemSearch
			
			rotateNode = GetRotateNode();
			//if ( isActive && ( !increaseHitCounterOnlyOnMeleeDmg || (increaseHitCounterOnlyOnMeleeDmg && damageIsMelee) ) )
			if ( !increaseHitCounterOnlyOnMeleeDmg || (increaseHitCounterOnlyOnMeleeDmg && damageIsMelee) )
				npc.IncHitCounter();			
			
			
			if ( isActive && CheckGuardOrCounter() )
			{
				npc.DisableHitAnimFor(0.1);
				Complete(true);
				return false;
			}
			
			
			//this node is decorated with ProlongHLCombat meaning that if event will return true combat will be activated
			if ( damageData.hitReactionAnimRequested  )
				return true;
			else
				return false;
		}
		else if ( eventName == 'CriticalState' )
		{
			if ( isActive )
			{
				Complete(true);
			}
			else
				npc.DisableHitAnimFor(0.1);
		}
		else if ( eventName == 'CounterExecuted' )
		{
			npc.ResetHitCounter( 0, 0 );
		}
		
		return false;
	}
	
	function OnGameplayEvent( eventName : name ) : bool
	{
		if ( eventName == 'RotateEventStart'  )
		{
			GetNPC().SetRotationAdjustmentRotateTo( rotateNode );
			return true;
		}
		else if ( eventName == 'RotateAwayEventStart' )
		{
			GetNPC().SetRotationAdjustmentRotateTo( rotateNode, 180.0 );
			return true;
		}
		else if ( eventName == 'WantsToPerformDodge' )
		{
			Complete(true);
			return true;
		}
		
		return super.OnGameplayEvent(eventName);
	}
	
	function GetRotateNode() : CNode
	{
		/*
		if ( (CNode)damageData.causer )
			return (CNode)damageData.causer;
		else if ( damageData.attacker )
			return damageData.attacker;
		*/
		if ( lastAttacker )
			return lastAttacker;
		
		return GetCombatTarget();
	}
	
	var cachedPos : Vector;
	function OnAnimEvent( animEventName : name, animEventType : EAnimationEventType, animInfo : SAnimationEventAnimInfo ) : bool
	{
		var owner 			: CNewNPC;
		var player			: CR4Player;
		var movementAdjustor	: CMovementAdjustor;
		var ticket 				: SMovementAdjustmentRequestTicket;
		
		player = thePlayer;
		
		/*if ( animEventName == 'ScaleTranslation' && GetCombatTarget() == player )
		{
			owner = GetNPC();
			movementAdjustor = owner.GetMovingAgentComponent().GetMovementAdjustor();
			ticket = movementAdjustor.GetRequest( 'ScaleTranslation' );
			
			if ( animEventType == AET_DurationStart )
			{
				movementAdjustor.CancelByName( 'ScaleTranslation' );
				ticket = movementAdjustor.CreateNewRequest( 'ScaleTranslation' );
				movementAdjustor.BindToEventAnimInfo( ticket, animInfo );
				movementAdjustor.MaxLocationAdjustmentSpeed( ticket, 1000000 );
				movementAdjustor.ScaleAnimation( ticket );
				cachedPos = owner.GetWorldPosition();
				owner.SetIsTranslationScaled( true );
			}
			else if ( animEventType == AET_DurationEnd )
				owner.SetIsTranslationScaled( false );
			
			movementAdjustor.SlideTo( ticket, VecNormalize( VecFromHeading( owner.GetHeading() + 180 ) ) * player.GetHitReactTransScale() + cachedPos );
		}*/
		return super.OnAnimEvent(animEventName,animEventType,animInfo);
	}
	
	function InitializeReactionDataStorage()
	{
		storageHandler = new CAIStorageHandler in this;
		storageHandler.Initialize( 'ReactionData', '*CAIStorageReactionData', this );
		reactionDataStorage = (CAIStorageReactionData)storageHandler.Get();
	}
}

class CBTTaskHitReactionDecoratorDef extends CBTTaskPlayAnimationEventDecoratorDef
{
	default instanceClass = 'CBTTaskHitReactionDecorator';

	editable var createHitReactionEvent : CBehTreeValCName;
	editable var increaseHitCounterOnlyOnMeleeDmg : CBehTreeValBool;
	
	default rotateOnRotateEvent 		= false;
	default disableHitOnActivation 		= false;
	default disableLookatOnActivation 	= true;
	
	public function Initialize()
	{
		SetValCName(createHitReactionEvent,'BeingHitAction');
		SetValBool(increaseHitCounterOnlyOnMeleeDmg,true);
		super.Initialize();
	}
	
	function InitializeEvents()
	{
		super.InitializeEvents();
		listenToGameplayEvents.PushBack( 'CriticalState' );
		listenToGameplayEvents.PushBack( 'BeingHit' );
		listenToGameplayEvents.PushBack( 'CounterExecuted' );
	}
}

////////////////////////////////////////////////////
// CBTCondBeingHit
class CBTCondBeingHit extends IBehTreeTask
{	
	var timeOnLastHit 	: float;
	var beingHit 		: bool;
	
	default timeOnLastHit 	= 0.0;
	default beingHit		= false;
	
	function IsAvailable() : bool
	{
		var npc : CNewNPC = GetNPC();
		if ( timeOnLastHit + 2.0 < GetLocalTime() )
		{
			beingHit = false;
		}
		if ( beingHit )
		{
			return true;
		}
		return false;
	}
	function OnGameplayEvent( eventName : name ) : bool
	{
		var npc : CNewNPC = GetNPC();
		
		if ( eventName == 'BeingHit' )
		{
			beingHit 		= true;
			timeOnLastHit 	= GetLocalTime(); 
			return true;
		}
		return false;
	}
}

class CBTCondBeingHitDef extends IBehTreeConditionalTaskDefinition
{
	default instanceClass = 'CBTCondBeingHit';
	
	function InitializeEvents()
	{
		super.InitializeEvents();
		listenToGameplayEvents.PushBack( 'BeingHit' );
	}
}


////////////////////////////////////////////////////
// CBTCompleteOnHit
class CBTCompleteOnHit extends IBehTreeTask
{	
	public var onlyIfCanPlayHitAnim : bool;
	
	function OnGameplayEvent( eventName : name ) : bool
	{
		var npc : CNewNPC = GetNPC();
		
		if( onlyIfCanPlayHitAnim && !npc.CanPlayHitAnim() )
			return false;
		
		if ( eventName == 'BeingHit' )
		{
			Complete(true);
			return true;
		}
		return false;
	}
}

class CBTCompleteOnHitDef extends IBehTreeTaskDefinition
{
	default instanceClass = 'CBTCompleteOnHit';
	
	private editable var onlyIfCanPlayHitAnim : bool;
	
}




