extends Control

var direction = 0
var enabled = true

func _ready():
	add_to_group("Input")

func _process(delta):
	if enabled:
		set_direction()
		move_direction()
		jump()
		teleport()
		
func set_direction():
	get_tree().call_group("Player", "set_direction", direction)
	
func move_direction():
	if Input.is_action_pressed ("left") and not Input.is_action_pressed ("right"):
		direction = -1
	elif Input.is_action_pressed ("right") and not Input.is_action_pressed ("left"):
		direction = 1
	else:
		direction = 0
			
func jump():
	if Input.is_action_just_pressed("jump"):
		get_tree().call_group("Player", "jump")
		get_tree().call_group("Player", "air_jump")

func teleport():
	if Input.is_action_just_pressed("teleport"):
		get_tree().call_group("Player", "teleport")

func disable_input(disable):
	direction = 0
	set_direction()
	enabled = !disable

func on_portal_reach(status):
	disable_input(status)

