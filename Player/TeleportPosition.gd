extends Position2D

var collision = false
var direction = 0

func _process(delta):
	get_direction()
	set_teleport_position(direction)
	check_collision()

func set_teleport_position(input_direction):
	position.x = 350 * direction
	$TeleportRay.cast_to *= direction

func get_direction():
	direction = GlobalInput.direction
	
func check_collision():
	if $TeleportRay.is_colliding():
		collision = true
	else:
		collision = false
