extends AnimatedSprite

func _on_Spikeman_animate(motion):
	if motion.y < 0:
		play("jump")
	else:
		play("stand")
	
	
	
