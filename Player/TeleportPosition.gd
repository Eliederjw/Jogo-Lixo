extends Position2D

var collision = false
var direction = 0

const DISPLACEMENT = 400

func _ready():
	pass
	
func _process(delta):
	get_direction()
	set_teleport_position()
	check_collision()

func get_direction():
	direction = GlobalInput.directionx

func set_teleport_position():
	position.x = DISPLACEMENT * direction
	$TeleportRay.cast_to *= direction
	Abilities.set_teleport_position(position.x)
	
func check_collision():
	if $TeleportRay.is_colliding():
		collision = true
	else:
		collision = false
		
	Abilities.set_teleport_collision(collision)
		
