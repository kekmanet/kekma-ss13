/obj/machinery/driver_button
	name = "mass driver button"
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	desc = "A remote control switch for a mass driver."
	id_tag = "default"
	var/active = 0
	anchored = 1.0
	use_power = MACHINE_POWER_USE_IDLE
	idle_power_usage = 2
	active_power_usage = 4

	ghost_read = 0 // Deactivate ghost touching.
	ghost_write = 0

/obj/machinery/driver_button/New(turf/loc, var/w_dir=null)
	..()
	machine_flags |= MULTITOOL_MENU
	switch(w_dir)
		if(NORTH)
			pixel_y = 25 * PIXEL_MULTIPLIER
		if(SOUTH)
			pixel_y = -25 * PIXEL_MULTIPLIER
		if(EAST)
			pixel_x = 25 * PIXEL_MULTIPLIER
		if(WEST)
			pixel_x = -25 * PIXEL_MULTIPLIER

/obj/machinery/driver_button/npc_tamper_act(mob/living/L)
	attack_hand(L)

/obj/machinery/ignition_switch
	name = "ignition switch"
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"
	desc = "A remote control switch for a mounted igniter."

	var/active = 0
	anchored = 1.0
	use_power = MACHINE_POWER_USE_IDLE
	idle_power_usage = 2
	active_power_usage = 4

	ghost_read = 0 // Deactivate ghost touching.
	ghost_write = 0

/obj/machinery/ignition_switch/npc_tamper_act(mob/living/L)
	attack_hand(L)

/obj/machinery/flasher_button
	name = "flasher button"
	desc = "A remote control switch for a mounted flasher."
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"

	var/active = 0
	anchored = 1.0
	use_power = MACHINE_POWER_USE_IDLE
	idle_power_usage = 2
	active_power_usage = 4

	ghost_read = 0 // Deactivate ghost touching.
	ghost_write = 0

/obj/machinery/flasher_button/npc_tamper_act(mob/living/L)
	attack_hand(L)

/obj/machinery/crema_switch
	desc = "Burn baby burn!"
	name = "crematorium igniter"
	icon = 'icons/obj/power.dmi'
	icon_state = "crema_switch"
	anchored = 1.0
	req_access = list(access_crematorium)
	var/on = 0
	var/otherarea = null
	var/id = 1

	ghost_read = 0 // Deactivate ghost touching.
	ghost_write = 0

/obj/machinery/crema_switch/npc_tamper_act(mob/living/L)
	attack_hand(L)
