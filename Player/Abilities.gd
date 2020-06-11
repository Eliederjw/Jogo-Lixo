extends Node

class_name PlayerAbilities

var abilities = Global.abilities
var abilities_on = ["air_jump"]

var teleport_collision = false
var teleport = true
var teleport_position = 0

var air_jump = 1
var total_jumps = 1
var jump_speed = 4000

enum {HAS_JUMP, JUMP, LAND}

func has_ability(ability):
	for i in abilities:
		if i == ability:
			return true

func is_on(ability):
	for i in abilities_on:
		if i == ability:
			return true

### TELEPORT ###
			
func teleport():
	if is_on("teleport"):
		return teleport_position
	else:
		return 0
		
func air_jump(TAG):
	if is_on("air_jump"):
		match TAG:
			HAS_JUMP:
				if air_jump > 0:
					return true
			JUMP:			
				air_jump -= 1
				return jump_speed
			LAND:
				air_jump = total_jumps
			

func set_teleport_collision(status):
	teleport_collision = status

func set_teleport_position(position):
	teleport_position = position
	return teleport_position

func add_ability():
	var stage = Global.level_number()
	match stage:
		1:
			Global.abilities.append("air_jump")

func on_portal_reach():
	print("Abilities portal reach")

