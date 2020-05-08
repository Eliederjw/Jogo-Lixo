extends Camera2D
export var offsetR = 700
export var offsetL = -700
export var offsetSpeed = 10

func _on_Player_offset():
	if Input.is_action_pressed ("left") and not Input.is_action_pressed ("right"):
		offset -= Vector2(offsetSpeed,0)
		if offset < Vector2(offsetL,0):
			offset = Vector2(offsetL,0)
		
	elif Input.is_action_pressed ("right") and not Input.is_action_pressed ("left"):
		offset += Vector2(offsetSpeed,0)
		if offset > Vector2(offsetR,0):
			offset = Vector2(offsetR,0)

