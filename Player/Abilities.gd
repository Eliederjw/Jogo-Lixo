extends Node

class_name PlayerAbilities

var abilities = []
var abilities_on = []

var teleport_collision = false
var teleport = true
var teleport_position = 0

var air_jump = 1
var total_jumps = 1
var jump_speed = 4000

enum {HAS_JUMP, JUMP, LAND}

func _ready():
	pass

func _process(delta):
	updateGUI()

func load_game():
	abilities = Global.abilities
	turn_on_abilities()

func new_game():
	abilities = []
	abilities_on = []
	

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
		set_teleport(false)
		return teleport_position
	else:
		return 0

func set_teleport_collision(status):
	teleport_collision = status

func set_teleport_position(position):
	teleport_position = position
	return teleport_position

func set_teleport(status):
	if status == true:
		if not is_on("teleport"):
			abilities_on.append("teleport")
		
	elif status == false:
		abilities_on.erase("teleport")

### AIR JUMP
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

func add_ability():
	var stage = Global.level_number
	match stage:
		1:
			abilities.append("air_jump")
		2: 
			abilities.append("teleport")

func turn_on_abilities():
	for i in abilities:
		if not is_on(i):
			abilities_on.append(i)

func update_ability():
	Global.abilities = abilities

func updateGUI():
	get_tree().call_group("GUI", "get_abilities_on", abilities_on)

func on_portal_reach():
	add_ability()
	turn_on_abilities()
	update_ability()
