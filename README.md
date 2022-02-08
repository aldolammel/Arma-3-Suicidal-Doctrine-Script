# Arma-3-Suicidal-Doctrine-Script
This script brings some methods of mid-east suicidal doctrine. Through the only one .sqf the mission editor is able to control which method their suicidal unit will use, just flagging it on code available. This is ready for multiplayer and single player, as well as dedicated servers or not. Some images on Steam Workshop.
Below, the AI behaviors through the methods:

...............

**VBIED METHOD**
- A suicide operator steers the vehicle-bomb (VBIED) to a target and, at the right moment, a remote detonation trigger is pressed by the suicide.

**Ways to detonate:**
- If the suicidal AI responsible for the VBIED presses the detonation trigger;
- If the VBIED suffers severe damage;

**Ways to NOT detonate:**
- Killing the suicidal AI before detonation;
- Capture (handcuff) the suicidal when (and if) dismounted;
- No player approaching the VBIED;

**Rules:**
- Suicidal will NOT have any kind of firearm. If so, this will be automatically removed;
- If the player gets too close to the VBIED with the live suicidal onboard, the suicidal will press the remote-trigger (if into the signal range) and the VBIED will explode.
- If the player gets too close to the VBIED with the live suicidal dismounted, the suicidal will press the remote-trigger and the VBIED will explode.
- If the player gets too close to the VBIED with the dead suicidal onboard, the VBIED will NOT explode.
- If the player gets too close to the VBIED with the dead suicidal dismounted, the VBIED will NOT explode.
- If the player gets too close to the VBIED with the incapacitated or unconscious suicidal onboard, the VBIED will NOT explode.
- If the player gets too close to the VBIED with the incapacitated or unconscious suicidal dismounted, the VBIED will NOT explode.
- If the player gets too close to the VBIED with the live suicidal onboard and with access to the driver's position, the suicidal takes the wheel and heads towards the player, and will press the remote-trigger and the VBIED will explode.
- If the player gets too close to the VBIED with the live suicidal onboard, but without access to the driver's position, the suicidal will wait for the player to get closer, press the remote-trigger and the VBIED will explode.
- If the VBIED is engaged, the vehicle may explode.
- If the VBIED is engaged, and the suicidal is killed onboard, the VBIED will not necessarily explode.
- If the player gets too close to the dismounted suicidal, but the player is out the range of the VBIED, the suicidal will NOT explode the VBIED, but the suicide will flee on foot.
- If the player gets too close to the dismounted suicidal, and both are within the VBIED's range, the suicide will press the remote-trigger and the VBIED will explode.
- If the player gets too close to the empty VBIED, even with the suicidal at a distance with remote signal, the suicidal will press the remote-trigger and the VBIED will explode.
- If the VBIED has its doors welded, the onboard suicidal will NOT be able to dismount from the vehicle under any circumstances;
- If the VBIED has its doors welded, the player will be NOT able to board the VBIED;
- If the VBIED has its doors unlocked, the on boarded suicide is able to dismount in some cases;
- If the VBIED has its doors unlocked, the player will be able to board the VBIED and drive it;
- If the suicidal is handcuffed, suicidal is unable to detonate the VBIED;
- If the suicidal is handcuffed, any cosmetic on their head will be replaced by a blindfold;
- If the suicidal is handcuffed, any backpack or vest will be removed from them;
- If the suicidal is handcuffed and later released, suicidal will NOT be able to detonate the VBIED;
- If the suicidal is handcuffed, this does not prevent the VBIED from exploding if the vehicle suffers too much damage;
- If the dismounted suicidal is allowed to drive, and the VBIED doors are NOT welded, the suicidal will board the VBIED and take the wheel.
- If the dismounted suicidal is allowed to drive, but the VBIED doors are welded, the suicidal will attempt to preserve their life but remain around of the VBIED.
- If the dismounted suicidal is NOT allowed to drive, and the VBIED doors are NOT welded, the suicidal will board the VBIED.
- If the dismounted suicidal is NOT allowed to drive, and the VBIED doors are welded, the suicidal will attempt to preserve their life but remain around of the VBIED.
- If the dismounted suicidal has NO signal on the remote-trigger and the player gets too close to the VBIED, the VBIED will NOT explode.
- If the dismounted suicidal has NO signal on the remote-trigger, the suicidal will try (or not) to look for a signal, getting closer to the VBIED;
- If the dismounted suicidal has NO signal on the remote-trigger and recovers signal, if the player is too close to the VBIED, the VBIED will explode;

...............

**DEAD MAN TRIGGER METHOD**
- A suicidal operator wears a suicidal belt/vest and detonates theirself by releasing a reverse-pressure trigger.

**Ways to detonate:**
- If the AI kill itself, with the detonator activated, release the detonation trigger.
- If the suicidal AI, with the detonator activated, is killed.
- If the suicidal AI, with the detonator activated, becomes incapacitated or unconscious.

**Ways to NOT detonate:**
- No player approaching the suicidal;
- Capture (handcuff) the suicide before he released the trigger (you're so dead!);

**Rules:**
- The suicidal will NOT have any kind of firearm. If so, this will be automatically removed;
- If the player enters the suicidal's action range, the suicidal will activate their vest, press the trigger and run towards the player, releasing the trigger when close to detonate.
- If the player enters the suicidal's action range, and the suicidal is on boarded in a vehicle, the suicidal will dismount, activate their vest, press the trigger and run towards the player, releasing the trigger when close to detonate.
- If the suicidal has the vest disabled and receives a non-lethal shot, the suicidal will activate the vest and press the trigger, waiting for the player to approach or be killed for the detonation.
- If the suicidal has the vest disabled and receives a lethal shot, the vest will NOT explode.
- If the suicidal detects the player, the suicidal will activate the vest and press the trigger, waiting for the player to approach or be killed for the detonation.
- If the suicidal has the vest activated and receives a non-lethal shot, and the player is not close, the vest will NOT explode.
- If the suicidal has the vest activated and receives a lethal shot, the trigger will be released and the vest will explode, with or without player close.
- If the suicidal is incapacitated or unconscious, there will be a random delay between 3 to 7 seconds, the trigger will be released and the vest will explode.
- If the suicidal is killed, with a random delay between 1 to 4 seconds, the trigger will be released and the vest will explode.
- If the suicidal is handcuffed, the suicidal will be impatience to detonate the vest;
- If the suicidal is handcuffed, any cosmetic on his head will be replaced by a blindfold;
- If the suicidal is handcuffed, any backpack or vest will be removed from them;
- If the suicidal is handcuffed and later released, the suicide will be NOT able to detonate the vest;

...............

**CLASSIC SUICIDE BOMBER METHOD**
- A suicide operator wears a suicidal belt/vest and detonates theirself by pressing a trigger.

**Ways to detonate:**
- If the AI kill itself, releasing the detonation trigger.

**Ways to NOT detonate:**
- Killing the suicidal through a decent distance;
- No player approaching when the suicidal still alive;
- Capture (handcuff) the suicidal before they press the trigger (you're so dead!);

**Rules:**
- The suicidal will NOT have any kind of firearm. If so, this will be automatically removed;
- If the target enters the suicidal's action range, the suicidal will run towards the target, pressing the trigger when close to detonate.
- If the target enters the suicidal's action range, and the suicidal is on boarded in a vehicle, the suicidal will dismount and run towards the target, pressing the trigger when close to detonate.
- If the suicidal receives a lethal shot, the vest will NOT explode.
- If the suicidal detects the target, the suicidal will waiting for the target to approach.
- If the suicidal is incapacitated or unconscious, the vest will NOT explode.
- If the suicidal is killed by some distance, the vest will NOT explode.
- If the suicidal is handcuffed, the suicidal will be impatience to detonate the vest;
- If the suicidal is handcuffed, any cosmetic on his head will be replaced by a blindfold;
- If the suicidal is handcuffed, any backpack or vest will be removed from them;
- If the suicidal is handcuffed and later released, the suicide will be NOT able to detonate the vest;

...............

# Ideas or fix?
https://forums.bohemia.net/forums/topic/237502-release-suicidal-doctrine-script/

Cheers, 
thy
