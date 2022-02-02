/* 


	SUICIDAL DOCTRINE (Version 1.0)
	by thy (@aldolammel)
	Github: https://github.com/aldolammel/Arma-3-Suicidal-Doctrine-Script
	Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2739692983
	
	
*/ ---------------------

	private ["_suicidalMethod","_deathShout",/* "_suicidalSide", */"_suicidal","_debugVbiedStatus","_debugDmtStatus","_vbied","_vbiedAmmo","_weldedDoors","_suicidalCanDrive",/* "_vbiedWrecked", */"_isVbiedInfinityFuel","_tryToFindSignal","_remoteTriggerRange","_vbiedDangerouslyClose","_vbiedDeadlyClose","_dmtVestIed","_dmtVestIedAmmo","_dmtDangerouslyClose","_dmtDeadlyClose","_vbiedDetonated","_dmtVestDetonated","_isSignalOn","_isSuicidalCuffed","_isDmtVestActivated"]; 
	
	if (!isServer) exitWith {};										// if is not any type of server, get out!
	
	
	/* EDITOR OPTIONS */
		/* which method the suicide will use */						_suicidalMethod			= 1;					// 1 = vbied / 2 = deadman trigger
		/* the suicidal cry */										_deathShout				= "suicideCry"; 		// sound name
		/* sets the suicide side  									_suicidalSide			= 0; NOT WORKING YET 	// 0 = opfor / 1 = blufor / 2 = independent / 3 = civilian */
		/* which unit is the suicide */ 							_suicidal 				= suicidal;				// unit name
		/* debug, vbied method monitor */ 							_debugVbiedStatus		= true; 				// true = on / false = off
		/* debug, deadmean trigger method monitor */ 				_debugDmtStatus			= true; 				// true = on / false = off
	/* Vbied method */
		/* which vehicle is vbied */ 								_vbied 					= vbied01;				// vehicle name
		/* what is vbied's explosive */ 							_vbiedAmmo 				= "Bomb_04_F";			// ammo name
		/* if vbied doors are welded */				 				_weldedDoors			= false;				// true = vbied locked / false = unlocked
		/* if the suicide can take the wheel */		 				_suicidalCanDrive 		= true; 				// true = yes / false = no
		/* if the vbied wreck will have collision 					_vbiedWrecked 			= true; NOT WORKING YET	// true = collision / false = no collision */
		/* if vbied fuel is infinite */ 							_isVbiedInfinityFuel 	= true; 				// true = infinity fuel / false = limited
		/* if not signal, suicide will try to find out */			_tryToFindSignal 		= true; 				// true = try to find / false = don't try
		/* range of suicide remote-trigger */						_remoteTriggerRange		= 1000;					// in mts between suicidal and vbied (at least 100m + than _vbiedDangerouslyClose) (default 1000)
		/* when the suicide detects the player */			 		_vbiedDangerouslyClose 	= 200;					// in mts close to the target (default 200)
		/* when vbied blows up */ 									_vbiedDeadlyClose 		= 20; 					// in mts close to the target (at least 30m less than _vbiedDangerouslyClose) (default 20)
	/* Deadman Trigger method */
		/* which vest will contain the explosive */ 				_dmtVestIed				= "V_Chestrig_blk";		// vest name
		/* what is vest's explosive */ 								_dmtVestIedAmmo			= "Rocket_03_HE_F";		// ammo name
		/* when the suicide detects the player */	 				_dmtDangerouslyClose 	= 80;					// in mts close to the target (default 80)
		/* when the vest blows up */ 								_dmtDeadlyClose 		= 10; 					// in mts close to the target (at least 8m less than _dmtDangerouslyClose) (default 10)

	
	/* CORE / DO NOT CHANGE! */
	_vbiedDetonated 	= false; 									// sets vbied to undetonated yet.
	_dmtVestDetonated 	= false; 									// sets dead man trigger vest to undetonated yet.
	_isSignalOn		 	= false; 									// sets the suicidal remote-trigger signal off.
	_isSuicidalCuffed 	= false; 									// sets suicidal as not handcuffed.
	_isDmtVestActivated = false; 									// sets the explosive vest to start off.
	removeAllWeapons _suicidal; 									// forces the removal of any weapons from the suicidal.
	_suicidal setBehaviour "AWARE"; 								// forces the suicidal to pay attention.
	_suicidal setCombatMode "GREEN"; 								// force the suicidal to never fire, keep formation.
	_suicidal enableDynamicSimulation false;						// prevents the suicidal from having the feature turned on.
	_vbied enableDynamicSimulation 	false;							// prevents vbied from having the feature turned on.
	
	
	While {_suicidalMethod == 1} do 								// Looping while: se doctrine method is vbied, do it:
	{					
		if (_debugVbiedStatus == true) then  													// if debug on, so...
		{
			// show info:
			hint format ["Suicidal is %1, %2, %3 and %4.\n\nRemoteTriggerSignal = %5\n\nDoorsWelded = %6.\n\nSuicidalCanDrive = %7.\n\nVBIEDdetonation = %8.\n\n", lifeState _suicidal, behaviour _suicidal, combatMode _suicidal, speedMode _suicidal, _isSignalOn, _weldedDoors, _suicidalCanDrive, _vbiedDetonated];
		};
		
		if (alive _suicidal) then 																// if the suicidal is alive, so...
		{
			_playerNearest = objNull; 															// sets that, for the time being, there is no player nearby.							
			_suicidal allowFleeing 0; 															// suicidal is not panic.
			  
			if ((_vbied distance _suicidal) <= _remoteTriggerRange) then 						// if distante between the suicidal and vbied is equal or less than remote-trigger range, so...
			{
				_isSignalOn = true; 															// has signal.				
				{ 																				// starts the forEach...
					_dist = vehicle _x distance _vbied; 										// _dist is the distance between something and vbied.
					
					if (isPlayer _x and _dist < _vbiedDangerouslyClose) then 					// if the something is a player and that distance is XXm close to the vbied, so...
					{
						_playerNearest = _x;													// the player target receive their own variable.
						_vbiedDangerouslyClose = _dist;											// XXm is the distance between the player and vbied.
					};
				} forEach playableUnits; 														// completes forEach, calculating only for players.
				
				if ( !(_suicidal in _vbied) and (_weldedDoors == false)) then  					// if suicidal is not into vbied, and vbied isn't its doors welded, then...
				{
					_wp = group _suicidal addWaypoint [position _vbied, 0]; 					// creating the waypoint to vbied;
					_wp waypointAttachVehicle _vbied; 											// creating the waypoint to vbied;
					_wp setWaypointType "GETIN";												// creating the waypoint to vbied;
					//_wp setWaypointStatements ["true", "{_x assignAsCargo _vbied} foreEach units _suicidal;"];
				};
				
			} else 																				// if suicidal if too far away, faça...
			{
				if (_tryToFindSignal == true) then 												// if suicidal is allowed to find out the signal, so...
				{
					_suicidal setBehaviour "AWARE";												// suicidal no longer cares about their own safety.
					_suicidal setCombatMode "GREEN"; 											// suicidal holds fire, keep formation
					_suicidal setSpeedMode "LIMITED";											// suicidal moves not too fast.
					_suicidal move getPos _vbied;										 		// suicidal moves to vbied arounds, but out of explosion range.
				};
			};
			
			if (_suicidal getVariable ["ace_captives_isHandcuffed", false]) then 				// if the suicidal is handcuffed, then...
			{
				_isSuicidalCuffed = true; 														// understand that suicidal is handcuffed.
				_isSignalOn = false; 															// remote trigger signal is cut off.
				removeGoggles _suicidal;														// removes any cosmetic from the suicidal's face.
				removeHeadgear _suicidal;														// removes any cosmetic from the suicidal head.
				//removeAllAssignedItems _suicidal;												// Unassigns and deletes all linked items from inventory.
				removeAllContainers _suicidal; 													// removes backpack, vest and uniform.
					//removeBackpack _suicidal; 												// remove the backpack.
					//removeVest _suicidal;														// remove the vest.
					//removeUniform _suicidal;													// remove the uniform.
						
				_suicidal addGoggles "G_Blindfold_01_white_F"; 									// adds a blindfold over the suicide's eyes;
			};
			
			// DANGEROUSLY CLOSE
			if (!isNull _playerNearest) then 																						// if there is a player nearby, so...
			{				
				if (_suicidal in _vbied) then  																						// if suicidal is inside vbied then...
				{	
					_suicidal setBehaviour "CARELESS"; 																				// suicidal no longer cares about their life.
					
					if (_suicidalCanDrive == true) then 																			// if the suicidal can drive, then...
					{						
						if ((driver (vehicle _suicidal)) isEqualTo _suicidal ) then 												// if the suicidal in vbied driver position then...
						{
							_suicidal setBehaviour "CARELESS"; 																		// suicidal no longer cares about their own safety.
							_suicidal setSpeedMode "FULL";																			// suicidal moves at full speed...
							_suicidal move getPos _playerNearest; 																	// up the player.
						};

						if ((_vbied distance _playerNearest) <= (_vbiedDeadlyClose + 10)) then 										// if player is almost at _vbiedDeadlyClose (plus a few meters of margin), then...
						{
							_suicidal directSay _deathShout; 																		// suicidal screams.
						};
					} else 																											// If suicidal can't drive, do it...
					{
						_vbied lockDriver true;																						// lock driver position.
					};
					
				} else																												// if suicidal is on foot, do...
				{
					if ((_suicidal distance _playerNearest) <= (_vbiedDeadlyClose + 30)) then   									// if player is almost at _vbiedDeadlyClose (plus a few meters of margin), then...
					{
						_suicidal setBehaviour "COMBAT"; 																			// suicidal enter combat mode.
						_suicidal setCombatMode "RED";																				// suicidal fire at will, engage at will/loose formation.
						_suicidal allowFleeing 1; 																					// the suicidal gets panic.
					};
					
				};
				
				// DEADLY CLOSE				
				if ((_vbied distance _playerNearest) <= _vbiedDeadlyClose) then 													// if distance between vbied and player is less than or equal to XXm, then...
				{	
					// if the suicide is conscious, has trigger signal, is uncuffed and vbied has not already exploded:
					if ((lifeState _suicidal == "HEALTHY") and (_isSignalOn == true) and (_isSuicidalCuffed == false) and (_vbiedDetonated == false)) then 	// then...
					{
						_suicidal directSay _deathShout; 																			// suicidal screams.
						sleep 0.3; 																									// waits a while before the next action.
						_boom = _vbiedAmmo createVehicle getPos _vbied; 															// a bomb is created at the vbied's position, causing it to detonate instantly.
						_vbiedDetonated = true; 																					// sets vbied as detonated.
						
						if (_suicidal in _vbied) then 																				// if suicidal inside vbied, so...
						{
							deletevehicle _suicidal; 																				// the suicidal is deleted (dead or not).
						};
						_suicidalMethod != 1;																						// While is now false ('different from 1' = false), ending the While/loop.
					};
				};
			};
		} else 																														// if the suicidal is not alive, do:
		{
			_suicidal directSay ""; 																								// shut up.
		};
		
		if (alive _vbied) then  												// if vbied is alive then...
		{										
			_vbied setUnloadInCombat [true, false]; 							// [cargo,turrets] the vbied crew isn't able to dismount from the main cabin. If there are units in the cargo, they can.
			
			if (_weldedDoors == true) then 										// if the doors were welded then...
			{
				_vbied setVehicleLock "LOCKED"; 								// force lock vbied doors.
			} else 
			{
				_vbied setVehicleLock "UNLOCKED"; 								// unlock vehicle, preventing any choices made in the EDEN editor.
			};
			
			if (_isVbiedInfinityFuel == true) then { 							// if vbied fuel is infinite then...
				
				if (fuel _vbied < 0.5) then 									// when the fuel is low then...
				{
					_vbied setFuel 1;											// fill up the vbied's fuel tank.
				};
			};
			
			if ((damage _vbied) > 0.9) then 									// when vbied is about to blows up, then...
			{
				sleep 0.3; 														// waits a while before the next action.
				_boom = _vbiedAmmo createVehicle getPos _vbied; 				// a bomb is created at the vbied's position, causing it to detonate instantly.
				_vbiedDetonated = true; 										// sets vbied as detonated.
				_suicidalMethod != 1;											// While is now false ('different from 1' = false), ending the While/loop.
			};
		};
		sleep 1;																// a looping breath.
	};	
	
	
	While {_suicidalMethod == 2} do 								// Looping while: se doctrine method is dead man trigger, do it:
	{
		_playerNearest = objNull; 														// determines that, for the time being, there is no player nearby.							
				
		if (_debugDmtStatus == true) then  												// if debug on, so...
		{
			// show info:
			hint format ["Suicidal is %1 (%2), %3 and %4.\n\nVestActivated = %5.\n\nVestDetonated = %6.", lifeState _suicidal, (1 - damage _suicidal)*100, behaviour _suicidal, combatMode _suicidal, _isDmtVestActivated, _dmtVestDetonated];
		};	
		
		if (alive _suicidal) then 														// if the suicidal is alive, so...
		{
			//removeGoggles _suicidal;													// removes any cosmetic from the suicidal's face.
			//removeHeadgear _suicidal;													// removes any cosmetic from the suicidal head.
			//removeAllAssignedItems _suicidal;											// Unassigns and deletes all linked items from inventory.
			//removeAllContainers _suicidal; 											// removes backpack, vest and uniform.
				removeBackpack _suicidal; 												// remove the backpack.
				removeVest _suicidal;													// remove the wrong vest.
				//removeUniform _suicidal;												// remove the uniform.
			
			_suicidal addVest _dmtVestIed;												// add the correct suicidal vest.
			_suicidal allowFleeing 0; 													// suicidal is not panic.
			
			{ 																			// starts the forEach...
			_dist = vehicle _x distance _suicidal; 										// _dist is the distance between something and the suicidal.
			
				if (isPlayer _x and _dist < _dmtDangerouslyClose) then 					// if the something is a player and that distance is XXm close to the suicidal, so...
				{
					_playerNearest = _x;												// the player target receive their own variable.
					_dmtDangerouslyClose = _dist;										// XXm is the distance between the player and suicidal.					
				};
			} forEach playableUnits; 													// conclui o forEach, calculando somente para players.
		
													//(THERE'S A BUG WITH ACE)
			if ((_isDmtVestActivated == false) and ((damage _suicidal) >= 0.1)) then 	// if the suicidal vest isn't activated and the suicidal gets hurt, so... 
			{	
				sleep 0.5;																// waits a while before next action.
				_isDmtVestActivated = true; 											// suicidal actives the vest.
			};
			
			if (_suicidal getVariable ["ace_captives_isHandcuffed", false]) then 		// if the suicidal is handcuffed, then...
			{
				_isSuicidalCuffed = true; 												// understand that suicidal is handcuffed.
				_isDmtVestActivated = false; 											// vest disabled.
				removeGoggles _suicidal;												// removes any cosmetic from the suicidal's face.
				removeHeadgear _suicidal;												// removes any cosmetic from the suicidal head.
				//removeAllAssignedItems _suicidal;										// Unassigns and deletes all linked items from inventory.
				removeAllContainers _suicidal; 											// removes backpack, vest and uniform.
					//removeBackpack _suicidal; 										// remove the backpack.
					//removeVest _suicidal;												// remove the vest.
					//removeUniform _suicidal;											// remove the uniform.
						
				_suicidal addGoggles "G_Blindfold_01_white_F"; 							// adds a blindfold over the suicidal's eyes;
			};
			
			// DANGEROUSLY CLOSE
			if (!isNull _playerNearest) then 														// if there is a player nearby, then...
			{						
				_isDmtVestActivated = true;															// suicidal trigger activates the detonator and presses the trigger (which will detonate if he lets go).
				_suicidal setBehaviour "CARELESS"; 													// suicidal no longer cares about their own safety.
				_suicidal setCombatMode "RED"; 														// suicida fire at will, engage at will/loose formation.
				
				if ((lifeState _suicidal != "HEALTHY") and (_isDmtVestActivated == true)) then		// if suicidal becomes unconscious or incapacitated, and the vest is activated, so...
				{
					sleep (3 + random 4); 															// wait from X to Y seconds before...
					_boom = _dmtVestIedAmmo createVehicle getPos _suicidal; 						// a bomb is created at the suicidal's position, causing it to detonate instantly.
					_dmtVestDetonated = true; 														// sets the suicidal vest as detonated.
					deletevehicle _suicidal; 														// the suicidal is deleted (dead or not).
					_suicidalMethod != 2;															// While is now false ('different from 2' = false), ending the While/loop.
				};
				
				if (!isNull objectParent _suicidal) then  											// if the suicidal is inside a vehicle, then...
				{					
					_suicidal leaveVehicle objectParent _suicidal;									// suicidal dismount;
				};
				
				_suicidal setSpeedMode "FULL";														// suicidal moves at full speed...
				_suicidal move getPos _playerNearest; 												// up the player.
				
				if ((_suicidal distance _playerNearest) <= (_dmtDeadlyClose + 8)) then 				// if player is almost at _dmtDeadlyClose (plus a few meters of margin), then...
				{
					_suicidal directSay _deathShout; 												// suicidal screams.
				};

				// DEADLY CLOSE				
				if ((_suicidal distance _playerNearest) <= _dmtDeadlyClose) then 					// if distance between suicidal and player is less than or equal to XXm, then...
				{	
					if ((_isSuicidalCuffed == false) and (_dmtVestDetonated == false)) then 		// if the suicidal isn't uncuffed and the vest hasn't already blew up, then...
					{
						sleep 0.3; 																	// waits a while before the next action.
						_boom = _dmtVestIedAmmo createVehicle getPos _suicidal; 					// a bomb is created at the suicidal's position, causing it to detonate instantly.
						_dmtVestDetonated = true; 													// sets the suicidal vest as detonated.
						deletevehicle _suicidal; 													// the suicidal is deleted (dead or not).
						_suicidalMethod != 2;														// While is now false ('different from 2' = false), ending the While/loop.
					};
				};
			};
			
		} else 																						// if the suicidal is not alive, do...
		{
			if ((_isDmtVestActivated == true) and (_dmtVestDetonated == false)) then 				// if the vest's detonator is activated, and if the vest hasn't already detonated, then...
			{
				sleep (1 + random 4); 																// waits a split second before the next action.
				_boom = _dmtVestIedAmmo createVehicle getPos _suicidal; 							// a bomb is created at the suicidal's position, causing it to detonate instantly.
				_dmtVestDetonated = true; 															// sets the suicidal vest as detonated.
				deletevehicle _suicidal; 															// the suicidal is deleted (dead or not).
				_suicidalMethod != 2;																// While is now false ('different from 2' = false), ending the While/loop.
			};
		};
		
		sleep 2;													// breath of execution.
	};
