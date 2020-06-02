extends Position2D

var collision = false

func _process(delta):
	if $TeleportRay.is_colliding():
		collision = true
	else:
		collision = false
	
	get_tree().call_group("Player", "set_teleport_collision", collision)
		
func set_teleport_position(direction, DISPLACEMENT):
	position.x = DISPLACEMENT * direction
	$TeleportRay.cast_to *= direction
	
