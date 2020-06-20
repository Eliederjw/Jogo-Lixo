extends Control

var directionx = 0
var directiony = 0
var enabled = true

func _ready():
	add_to_group("Input")
	
func _process(delta):
	if enabled:
		set_directionx()
		move_direction()
		jump()
		air_jump()
		teleport()
		flight()

func set_directionx():
	get_tree().call_group("Player", "set_direction", directionx)
	get_tree().call_group("Abilities", "set_direction", directiony, directionx)
	
func move_direction():
	if Input.is_action_pressed ("left")and not Input.is_action_pressed ("right"):
		directionx = -1
	if Input.is_action_pressed ("right") and not Input.is_action_pressed ("left"):
		directionx = 1
	if Input.is_action_pressed ("up") and not Input.is_action_pressed ("down"):
		directiony = -1
	if Input.is_action_pressed ("down") and not Input.is_action_pressed ("up"):
		directiony = 1
		
	if Input.is_action_just_released("left"):
		directionx = 0
	if Input.is_action_just_released ("right"):
		directionx = 0
	if Input.is_action_just_released ("up"):
		directiony = 0
	if Input.is_action_just_released ("down"):
		directiony = 0
	

func jump():
	if Input.is_action_just_pressed("jump"):
		get_tree().call_group("Player", "jump")

func air_jump():
	if Input.is_action_just_pressed("jump"):
		if Abilities.has_ability("air_jump"):
			get_tree().call_group("Abilities", "air_jump")

func teleport():
	if Input.is_action_just_pressed("teleport"):
		if Abilities.has_ability("teleport"):
			get_tree().call_group("Abilities", "teleport")
			
func flight():
	if Input.is_action_just_pressed("flight"):
		if Abilities.has_ability("flight"):
			get_tree().call_group("Abilities", "flight")
		

func disable_input(disable):
	directionx = 0
	set_directionx()
	enabled = !disable

func on_portal_reach():
	disable_input(true)

