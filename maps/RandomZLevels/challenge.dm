//Challenge Areas

/area/awaymission/challenge/start
	name = "Where Am I?"
	icon_state = "away"

/area/awaymission/challenge/main
	name = "\improper Danger Room"
	icon_state = "away1"
	requires_power = 0

/area/awaymission/challenge/end
	name = "Administration"
	icon_state = "away2"
	requires_power = 0


/obj/machinery/power/emitter/energycannon
	name = "Energy Cannon"
	desc = "A heavy duty industrial laser."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "emitter"
	anchored = 1
	density = 1

	use_power = MACHINE_POWER_USE_NONE
	idle_power_usage = 0
	active_power_usage = 0

	active = 1
	locked = 1
	state = 2

/obj/machinery/power/emitter/energycannon/update_icon()
	if(powered && get_powernet() && get_satisfaction() > min_satisfaction && active)
		icon_state = "emitter_+a"
	else
		icon_state = "emitter"
