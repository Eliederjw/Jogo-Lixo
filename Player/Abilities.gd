extends Node

class_name PlayerAbilities

var player_is_on_floor

var abilities = []
var abilities_on = []

var teleport_collision = false
var teleport = true
var teleport_position = 0
var teleport_wait = 3
var teleport_timer

var air_jumps = 1
var total_jumps = 1
var jump_speed = 4000

var flight_speed = 2000
var is_flying = false
var directiony = 0
var directionx = 0
var flight_wait = 8
var flight_duration = 5
var flight_timer
var flying_timer

func _ready():
	add_to_group("Abilities")
	set_teleport_timer()
	set_flight_timner()
	set_flying_timer()
	
	
func _process(delta):
	flying()
	set_air_jumps()
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
			
func add_ability():
	var stage = Global.level_number
	match stage:
		1:
			abilities.append("air_jump")
		2: 
			abilities.append("teleport")
		3: 
			abilities.append("flight")

func is_on(ability):
	for i in abilities_on:
		if i == ability:
			return true
		
func turn_on_abilities():
	for i in abilities:
		if not is_on(i):
			abilities_on.append(i)
			
### TIMERS ###

func set_teleport_timer():
	teleport_timer = Timer.new()
	teleport_timer.connect("timeout", self, "on_teleport_timeout")
	teleport_timer.set_one_shot(true)
	
func set_flight_timner():
	flight_timer = Timer.new()
	flight_timer.connect("timeout", self, "on_flight_timeout")
	flight_timer.set_one_shot(true)

func set_flying_timer():
	flying_timer = Timer.new()
	flying_timer.connect("timeout", self, "on_flying_timeout")
	flying_timer.set_one_shot(true)
	
### AIR JUMP ###

func air_jump():
	if is_on("air_jump"):
		if air_jumps > 0 and not player_is_on_floor:
			get_tree().call_group("Player", "air_jump", jump_speed)
			air_jumps -= 1

func set_air_jumps():
	if player_is_on_floor:
		air_jumps = total_jumps

### TELEPORT ###

func teleport():
	if is_on("teleport") and teleport_collision == false:
		set_teleport(false)
		get_tree().get_root().add_child(teleport_timer)
		teleport_timer.start(teleport_wait)
	else:
		teleport_position = 0
		
	get_tree().call_group("Player", "teleport", teleport_position)
	
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

func on_teleport_timeout():
	set_teleport(true)
	
### FLIGHT ###

func flight():
	if is_on("flight"):
		is_flying = true
		set_flight(false)
	else: 
		is_flying = false

func flying():
	if is_flying:
		get_tree().call_group("Player", "fly", flight_speed, directiony, directionx)
		
	get_tree().call_group("Player", "set_gravity", !is_flying)
	get_tree().call_group("Player", "set_is_flying", is_flying)
		
func set_flight(status):
	if status == true:
		if not is_on("flight"):
			abilities_on.append("flight")
	elif status == false:
		abilities_on.erase("flight")
		get_tree().get_root().add_child(flight_timer)
		get_tree().get_root().add_child(flying_timer)
		flight_timer.start(flight_wait)
		flying_timer.start(flight_duration)

func set_direction (input_directiony, input_directionx):
	directiony = input_directiony
	directionx = input_directionx
	
func on_flying_timeout():
	is_flying = false
	
func on_flight_timeout():
	set_flight(true)
	
#######

func set_is_on_floor(is_on_floor):
	player_is_on_floor = is_on_floor
	
func update_ability():
	Global.abilities = abilities

func updateGUI():
	get_tree().call_group("GUI", "get_abilities_on", abilities_on)
	
### Received signals

func on_teleport():
	if is_flying:
		is_flying = false
	
func on_hurt():
	if is_flying:
		is_flying = false

func on_dead():
	if is_flying:
		is_flying = false
	
func on_portal_reach():
	add_ability()
	turn_on_abilities()
	update_ability()
