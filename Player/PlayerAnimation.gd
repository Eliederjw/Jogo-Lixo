extends AnimatedSprite

func _on_Player_animate(motion, is_on_floor, hurt, dead):
	if !dead:
		if motion.y < 0 and !hurt:
			play("jump" + str(Global.player))
		elif motion.y < 0 and hurt:
			play("hurt" + str(Global.player))
		elif motion.x > 0 and is_on_floor:
			play("walk" + str(Global.player)) 
			flip_h = false
		elif motion.x < 0 and is_on_floor:
			play("walk" + str(Global.player))
			flip_h = true
		else:
			play("idle" + str(Global.player))
	else:
		play("dead" + str(Global.player))
