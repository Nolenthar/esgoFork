
class CBTTaskGuardChange extends IBehTreeTask
{
	var raiseGuardChance 	: int;
	var lowerGuardChance 	: int;
	var onActivate 			: bool;
	var onDectivate 		: bool;
	var onMain				: bool;
	var raiseCheck			: bool;
	var lowerCheck			: bool;
	var frequency 			: float;
	var lastChange			: float;
	
	default lastChange = 0.f;
	
	latent function Main() : EBTNodeStatus
	{
		var npc : CNewNPC;
		
		while( onMain )
		{
			Sleep( frequency );
			GuardChange();
		}
		return BTNS_Active;
	}
	
	
	function OnActivate() : EBTNodeStatus
	{
		if ( onActivate )
		{
			GuardChange();
		}
		return BTNS_Active;
	}
	
	
	
	function OnDeactivate()
	{
		if ( onDectivate )
		{
			GuardChange();
		}
	}
	
	function GuardChange()
	{
		var npc : CNewNPC = GetNPC();
		var Scaling : DynamicScaling;
		var action : EBufferActionType;
		
		Scaling = new DynamicScaling in this;
		
		if( Scaling.HeavyAttackBlockBreak() && !GetNPC().HasStaminaToParry('attack_heavy') )
		{
			if ( npc.IsGuarded() )
			{
				npc.LowerGuard();
			}
			return;
		}
		
		if ( lastChange + frequency >= GetLocalTime() )
		{
			return;
		}
		
		GetStats();
		
		if ( lowerCheck && npc.IsGuarded() )
		{
			if ( RandRange(100) < lowerGuardChance )
			{
				npc.LowerGuard();
			}
			lastChange = GetLocalTime();
		}
		else if ( raiseCheck && !npc.IsGuarded() && npc.CanGuard() )
		{
			if ( RandRange(100) < raiseGuardChance )
			{
				npc.RaiseGuard();
			}
			lastChange = GetLocalTime();
		}
	}
	
	function GetStats()
	{
		var npc : CNewNPC = GetNPC();
		var Scaling : DynamicScaling;
		
		Scaling = new DynamicScaling in this;
		
		raiseGuardChance = (int)(100*(Scaling.GuardRaiseCh() * CalculateAttributeValue(npc.GetAttributeValue('raise_guard_chance'))));
		lowerGuardChance = (int)(100*(Scaling.GuardLowerCh() * CalculateAttributeValue(npc.GetAttributeValue('lower_guard_chance'))));
		
		delete Scaling;
	}
	
}
class CBTTaskGuardChangeDef extends IBehTreeTaskDefinition
{
	default instanceClass = 'CBTTaskGuardChange';

	editable var onActivate 		: bool;
	editable var onDectivate 		: bool;
	editable var onMain				: bool;
	editable var frequency 			: float;
	editable var raiseCheck			: bool;
	editable var lowerCheck			: bool;
	
	default onActivate	= true;
	default onDectivate = false;
	default onMain		= false;
	default raiseCheck = true;
	default lowerCheck = true;
	
	default frequency = 4.0;
}

class CBTTaskForceChangeGuard extends IBehTreeTask
{
	var onActivate 			: bool;
	var onDectivate 		: bool;
	var raiseGuard			: bool;
	var lowerGuard			: bool;
	
	function OnActivate() : EBTNodeStatus
	{
		if ( onActivate )
		{
			GuardChange();
		}
		return BTNS_Active;
	}
	
	function OnDeactivate()
	{
		if ( onDectivate )
		{
			GuardChange();
		}
	}
	
	function GuardChange()
	{
		if ( lowerGuard )
		{
			GetNPC().LowerGuard();
		}
		else if ( raiseGuard )
		{
			GetNPC().RaiseGuard();
		}
	}
	
}

class CBTTaskForceChangeGuardDef extends IBehTreeTaskDefinition
{
	default instanceClass = 'CBTTaskForceChangeGuard';

	editable var onActivate 		: bool;
	editable var onDectivate 		: bool;
	editable var raiseGuard			: bool;
	editable var lowerGuard			: bool;
}