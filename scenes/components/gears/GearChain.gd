class_name GearChain
extends Node

static var gear_ratios = {
	"SMALLtoBIG": 0.455,
	"BIGtoSMALL": 2.2,
	"MEDIUMtoSMALL": 1.8,
	"SMALLtoMEDIUM": 0.555,
	"MEDIUMtoBIG": 0.666,
	"BIGtoMEDIUM": 1.5,
	"BIGtoBIG": 1.0,
	"MEDIUMtoMEDIUM": 1.0,
	"SMALLtoSMALL": 1.0
}

static func check_chain(gear : GearComponent) -> bool:
	gear.is_checked = true
	if gear.next_gears.is_empty():
		return true
	var is_legal = true
	for g in gear.next_gears:
		# Case: g is stacked on top of or under gear
		if g == gear.stacked_gear or g == gear.base_gear:
			g.rotation_speed = gear.rotation_speed
			g.is_activated = true
		elif gear.is_activated && !g.is_activated:
			g.is_activated = true
			g.rotation_speed = -gear.rotation_speed * gear_ratios[gear.gear_size + "to" + g.gear_size]
		elif gear.is_activated && g.is_activated:
			if gear.rotation_speed * g.rotation_speed > 0:
				is_legal = false
				gear.show_jam()
				break
		if !g.is_checked:
			if !check_chain(g):
				gear.show_jam()
				is_legal = false
				break
	return is_legal

static func start_chain(gear : GearComponent):
	gear.is_activated = true
	var is_legal = check_chain(gear)
	if !is_legal:
		for g in gear.get_tree().get_nodes_in_group("Gear"):
			g.is_activated = false
			g.is_checked = false
