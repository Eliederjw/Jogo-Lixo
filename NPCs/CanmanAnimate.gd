extends AnimatedSprite

func _on_Canman_animate(idle, flip):
	if idle == false:
		play("walk")
	else:
		play("stand")
		
	flip_h = flip
	
	
