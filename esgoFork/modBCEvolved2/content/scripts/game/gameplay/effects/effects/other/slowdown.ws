/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/






class W3Effect_Slowdown extends CBaseGameplayEffect
{
	private saved var slowdownCauserId : int;
	private saved var decayPerSec : float;			
	private saved var decayDelay : float;			
	private saved var delayTimer : float;			
	private saved var slowdown : float;				

	default isPositive = false;
	default isNeutral = false;
	default isNegative = true;
	default effectType = EET_Slowdown;
	default attributeName = 'slowdown';
	
	//Chicken: override duration calculation to make the effect continuous
	protected function CalculateDuration(optional setInitialDuration : bool)
	{
		//since slowdown loop sleeps for 0.1f now, we need effect duration to be a bit longer to cumulate
		//with previous one
		duration = 0.2f;
		
		if(setInitialDuration)
			initialDuration = duration;
	}
	
	event OnEffectAdded(optional customParams : W3BuffCustomParams)
	{
		var dm : CDefinitionsManagerAccessor;
		var min, max : SAbilityAttributeValue;
		var prc, pts, raw : float; //Chicken: new var for raw value
		
		super.OnEffectAdded(customParams);
		
		dm = theGame.GetDefinitionsManager();
		
		dm.GetAbilityAttributeValue(abilityName, 'decay_per_sec', min, max);
		decayPerSec = CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
		
		dm.GetAbilityAttributeValue(abilityName, 'decay_delay', min, max);
		decayDelay = CalculateAttributeValue(GetAttributeRandomizedValue(min, max));
		
		//Chicken start: calc final slowdown, apply YRDEN resist
		//prcs are not clamped to make negative resistance possible
		//points added (divided by 100 as slowdown factor < 1)
		raw = CalculateAttributeValue(effectValue);
		target.GetResistValue(CDS_ShockRes, pts, prc);
		slowdown = MaxF(0, raw - pts/100) * (1 - prc);
		slowdown = ClampF(slowdown, 0.1, 0.9);
		
		if(isSignEffect && GetCreator() == GetWitcherPlayer() && GetWitcherPlayer().GetPotionBuffLevel(EET_PetriPhiltre) == 3 && prc < 1)
		{
			slowdown = ClampF(slowdown, 0.5, 0.9); // 50% slowdown at least
		}
		/*
		slowdown = CalculateAttributeValue(effectValue);
		target.GetResistValue(CDS_ShockRes, pts, prc);
		slowdown = slowdown * (1 - ClampF(prc, 0, 1) );
		*/
		slowdownCauserId = target.SetAnimationSpeedMultiplier( 1 - slowdown );
		delayTimer = 0;
	}
	
	
	event OnUpdate(dt : float)
	{
		if(decayDelay >= 0 && decayPerSec > 0)
		{
			if(delayTimer >= decayDelay)
			{
				target.ResetAnimationSpeedMultiplier(slowdownCauserId);
				slowdown -= decayPerSec * dt;
				
				if(slowdown > 0)
					slowdownCauserId = target.SetAnimationSpeedMultiplier( 1 - slowdown );
				else
					isActive = false;
			}
			else
			{
				delayTimer += dt;
			}
		}
		
		super.OnUpdate(dt);
	}
	
	public function CumulateWith(effect: CBaseGameplayEffect)
	{
		super.CumulateWith(effect);
		delayTimer = 0;
	}
	
	event OnEffectRemoved()
	{
		super.OnEffectRemoved();		
		target.ResetAnimationSpeedMultiplier(slowdownCauserId);
	}	
}