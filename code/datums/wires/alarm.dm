
/datum/wires/alarm
	holder_type = /obj/machinery/alarm
	wire_count = 5

/datum/wires/alarm/New()
	wire_names=list(
		"[AALARM_WIRE_IDSCAN]" 		= "ID scan",
		"[AALARM_WIRE_POWER]" 		= "Power",
		"[AALARM_WIRE_SYPHON]" 		= "Syphon",
		"[AALARM_WIRE_AI_CONTROL]" 	= "AI Control",
		"[AALARM_WIRE_AALARM]" 		= "Alarm"
	)
	..()

var/const/AALARM_WIRE_IDSCAN = 1
var/const/AALARM_WIRE_POWER = 2
var/const/AALARM_WIRE_SYPHON = 4
var/const/AALARM_WIRE_AI_CONTROL = 8
var/const/AALARM_WIRE_AALARM = 16


/datum/wires/alarm/CanUse(var/mob/living/L)
	if(!..())
		return 0
	var/obj/machinery/alarm/A = holder
	if(A.wiresexposed)
		return 1
	return 0

/datum/wires/alarm/GetInteractWindow()
	var/obj/machinery/alarm/A = holder
	. += ..()
	. += text("<br>\n[(A.locked ? "The Air Alarm is locked." : "The Air Alarm is unlocked.")]<br>\n[((A.shorted || (A.stat & (NOPOWER|BROKEN|FORCEDISABLE))) ? "The Air Alarm is offline." : "The Air Alarm is working properly!")]<br>\n[(A.stat & NOAICONTROL ? "The 'AI control allowed' light is off." : "The 'AI control allowed' light is on.")]")

/datum/wires/alarm/UpdateCut(var/index, var/mended, var/mob/user)
	var/obj/machinery/alarm/A = holder
	..()
	var/obj/I = user.get_active_hand()
	switch(index)
		if(AALARM_WIRE_IDSCAN)
			if(!mended)
				A.locked = 1
//				to_chat(world, "Idscan wire cut")

		if(AALARM_WIRE_POWER)
			A.shock(user, 50,get_conductivity(I))
			A.shorted = !mended
			A.update_icon()
//			to_chat(world, "Power wire cut")

		if (AALARM_WIRE_AI_CONTROL)
			mended ? A.enable_AI_control() : A.disable_AI_control()
//				to_chat(world, "AI Control Wire Cut")

		if(AALARM_WIRE_SYPHON)
			if(!mended)
				A.mode = 3 // AALARM_MODE_PANIC
				A.apply_mode()
//				to_chat(world, "Syphon Wire Cut")

		if(AALARM_WIRE_AALARM)
			//if (A.alarm_area.atmosalert(2))
			//	A.post_alert(2)
			A.update_icon()

/datum/wires/alarm/UpdatePulsed(var/index)
	var/obj/machinery/alarm/A = holder
	..()
	switch(index)
		if(AALARM_WIRE_IDSCAN)
			A.locked = !A.locked
//			to_chat(world, "Idscan wire pulsed")

		if (AALARM_WIRE_POWER)
//			to_chat(world, "Power wire pulsed")
			if(A.shorted == 0)
				A.shorted = 1
				A.update_icon()

			spawn(20 MINUTES)
				if (!isnull(A))
					if (A.shorted == 1)
						A.shorted = 0
						A.update_icon()

		if (AALARM_WIRE_AI_CONTROL)
//			to_chat(world, "AI Control wire pulsed")
			if(!(A.stat & NOAICONTROL))
				A.disable_AI_control(disrupt = FALSE)
			spawn(100)	
				if(A.stat & NOAICONTROL)
					if(A && !IsIndexCut(AALARM_WIRE_AI_CONTROL))
						A.enable_AI_control()

		if(AALARM_WIRE_SYPHON)
//			to_chat(world, "Syphon wire pulsed")
			if(A.mode == 1) // AALARM_MODE_SCRUB
				A.mode = 3 // AALARM_MODE_PANIC
			else
				A.mode = 1 // AALARM_MODE_SCRUB
			A.apply_mode()

		if(AALARM_WIRE_AALARM)
//			to_chat(world, "Aalarm wire pulsed")
			//if (A.alarm_area.atmosalert(0))
			//	A.post_alert(0)
			A.update_icon()
