extends Camera2D
export var offsetR = 700
export var offsetL = -700
export var offsetSpeed = 10

func _on_Player_offset(direction):
	offset += Vector2(offsetSpeed,0) * direction
	
	if offset < Vector2(offsetL,0):
		offset = Vector2(offsetL,0)
	
	if offset > Vector2(offsetR,0):
		offset = Vector2(offsetR,0)

