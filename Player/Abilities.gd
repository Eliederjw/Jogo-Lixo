extends Node

class_name PlayerAbilities

var abilities = ["air_jump", "teleport"]

var teleport_collision = false
var teleport = true
var teleport_position = 0

func has_ability(ability):
	for i in abilities:
		if i == ability:
			return true

### TELEPORT ###
			
func teleport():
	if teleport:
		return teleport_position
	else:
		return 0

func set_teleport_collision(status):
	teleport_collision = status

func set_teleport(status):
	teleport = status

func set_teleport_position(position):
	teleport_position = position
	return teleport_position
	

