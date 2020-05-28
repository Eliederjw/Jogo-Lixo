extends Node2D

var taken = false
var frames = 0

func _ready():
	frames = randi() % $AnimatedSprite.get_sprite_frames().get_frame_count("frames")
	$AnimatedSprite.set_frame(frames)
	
func _on_Area2D_body_entered(body):
	if not taken:
		taken = true
		$ScaleAnimation.stop()
		$AnimationPlayer.play("die")
		$AudioStreamPlayer.play()
		get_tree().call_group("GameState", "coins_up")

# Chamado na animação
func die():
	queue_free()
