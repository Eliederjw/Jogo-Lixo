extends AnimatedSprite

func _on_Bananaman_animate(motion):
	if motion.y < 0:
		play("jump")
	else:
		play("stand")
		
