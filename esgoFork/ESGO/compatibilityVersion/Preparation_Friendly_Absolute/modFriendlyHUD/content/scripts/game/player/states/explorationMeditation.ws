//---=== modFriendlyHUD ===---
state ExplorationMeditation in W3PlayerWitcher extends Exploration
{
	private var storedGameTime, updatedGameTime : GameTime;
	private var storedHoursPerMinute, hoursPerMinute : float;
	private var enteredStateSecs : float;
	private var refilled, fullHealth : bool;
	private	var noSaveLock : int;
	private	var meditationIdle : bool;

	event OnBehaviorGraphNotification( notificationName : name, stateName : name )
	{
		if ( parent.GetPlayerAction() == PEA_Meditation )
		{
			if( notificationName == 'OnPlayerActionStartFinished' && !meditationIdle )
			{
				meditationIdle = true;
				enteredStateSecs = theGame.GetEngineTimeAsSeconds();
			}
		}
		parent.OnBehaviorGraphNotification( notificationName, stateName );
	}
	
	event OnEnterState( prevStateName : name )
	{	
		super.OnEnterState( prevStateName );
		
		//parent.DisplayHudMessage( "ExplorationMeditation begin" );
		meditationIdle = false;
		enteredStateSecs = theGame.GetEngineTimeAsSeconds();
		storedHoursPerMinute = theGame.GetHoursPerMinute();
		hoursPerMinute = storedHoursPerMinute;
		storedGameTime = theGame.GetGameTime();
		updatedGameTime = storedGameTime;
		refilled = false;
		fullHealth = ( parent.GetStat( BCS_Vitality ) >= parent.GetStatMax( BCS_Vitality ) );
		HideItemsInHands();
		InternalBeginExplorationMeditation();
		if ( GetFHUDConfig().enableMeditationModules )
		{
			thePlayer.RemoveTimer( 'MeditationOffTimer' );
			ToggleMeditModules( true, "RealTimeMeditation" );
		}
		theGame.CreateNoSaveLock( "in_exploration_meditation", noSaveLock );
	}

	event OnLeaveState( nextStateName : name )
	{
		//parent.DisplayHudMessage( "ExplorationMeditation end" );
		meditationIdle = false;
		InternalEndExplorationMeditation();
		if ( GetFHUDConfig().enableMeditationModules )
		{
			thePlayer.AddTimer( 'MeditationOffTimer' , GetFHUDConfig().fadeOutTimeSeconds, false );
		}
		theGame.ReleaseNoSaveLock( noSaveLock );
		
		super.OnLeaveState( nextStateName );
	}
	
	event OnPlayerTickTimer( deltaTime : float )
	{
		super.OnPlayerTickTimer( deltaTime );
		
		if ( parent.GetPlayerAction() != PEA_Meditation )
		{
			parent.EndExplorationMeditation();
		}
		else
		{
			MeditationUpdate();
		}
	}
	
	private function InternalBeginExplorationMeditation()
	{
		var fastForward : CGameFastForwardSystem;

		fastForward = theGame.GetFastForwardSystem();
		fastForward.BeginFastForward();
		parent.PlayerStartAction( PEA_Meditation );
	}
	
	private function InternalEndExplorationMeditation()
	{
		var fastForward : CGameFastForwardSystem;
	
		fastForward = theGame.GetFastForwardSystem();
		fastForward.AllowFastForwardSelfCompletion();
		theGame.SetHoursPerMinute( storedHoursPerMinute );
		if ( parent.GetPlayerAction() == PEA_Meditation )
		{
			parent.PlayerStopAction( PEA_Meditation );
		}
		if ( GetFHUDConfig().resetRefillSettingToDefaultAfterMeditation )
		{
			GetFHUDConfig().ResetRefillPotionsWhileMeditating();
		}
		if ( GetFHUDConfig().fullHealthRegenAnyDifficulty )
		{
			parent.Heal( parent.GetStatMax( BCS_Vitality ) );
		}
	}
	
	private function MeditationUpdate()
	{
		var realTimeSecs, gameTimeSec : float;
		
		if ( GetDayPart( theGame.GetGameTime() ) != GetDayPart( updatedGameTime ) )
		{
			theGame.VibrateControllerVeryLight();
		}
		gameTimeSec = GameTimeToSeconds( theGame.GetGameTime() - updatedGameTime );
		realTimeSecs = ConvertGameSecondsToRealTimeSeconds( gameTimeSec );
		parent.UpdateEffectsAccelerated( realTimeSecs, hoursPerMinute / storedHoursPerMinute );
		if ( !fullHealth )
		{
			fullHealth = NotifyOnHealthRegenEnded();
		}
		if ( !refilled )
		{
			refilled = MeditationCheckRefill();
		}
		if ( hoursPerMinute < GetFHUDConfig().MAX_HOURS_PER_MINUTE && meditationIdle )
		{
			hoursPerMinute = MinF( GetFHUDConfig().MAX_HOURS_PER_MINUTE, storedHoursPerMinute + ( theGame.GetEngineTimeAsSeconds() - enteredStateSecs ) * GetFHUDConfig().HOURS_PER_MINUTE_PER_SECOND );
			theGame.SetHoursPerMinute( hoursPerMinute );
		}
		updatedGameTime = theGame.GetGameTime();
	}
	
	private function NotifyOnHealthRegenEnded() : bool
	{
		if ( parent.GetStat( BCS_Vitality ) >= parent.GetStatMax( BCS_Vitality ) )
		{
			theGame.VibrateControllerLight();
			return true;
		}
		return false;
	}
	
	private function MeditationCheckRefill() : bool
	{
		return parent.MeditationRefill( GameTimeToSeconds( theGame.GetGameTime() - storedGameTime ) );
	}
	
	private function HideItemsInHands()
	{
		if ( parent.GetCurrentMeleeWeaponType() != PW_None )
		{
			parent.OnEquipMeleeWeapon( PW_None, true, true );
		}
		if ( parent.IsHoldingItemInLHand() )
		{
			parent.HideUsableItem( true );
		}
		if ( parent.rangedWeapon )
		{
			parent.OnRangedForceHolster( true, true, false );
		}
	}
}
//---=== modFriendlyHUD ===---
