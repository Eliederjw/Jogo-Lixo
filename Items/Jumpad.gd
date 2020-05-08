extends Area2D

export var y_boost = -4000
export var x_boost = 4000


func _on_Jumpad_body_entered(body):
#	if body.has_method("hurt"):
	if rotation_degrees == 0:
		$AnimationPlayer.play("boost")
		body.jump_boost(y_boost)
		
	if rotation_degrees > 0:
		$AnimationPlayer.play("boost")
		body.jump_boost(y_boost)
		body.speed_boost(x_boost)
		
	if rotation_degrees < 0:
		$AnimationPlayer.play("boost")
		body.jump_boost(y_boost)
		body.speed_boost(-x_boost)
	
