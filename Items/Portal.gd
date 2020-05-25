extends Node2D

var reach_portal = false
var coins_enough = false

func _process(delta):
	get_tree().call_group("GameState", "portal_open")

func _on_Area2D_body_entered(body):
	if reach_portal == false and coins_enough == true:
		body.jump_enable = false
		body.move_enable = false
		body.dance_enable = true
		Global.save_lives()
		Global.save_coins()
		Global.save_coins_collected()
		Global.level_number += 1
		Global.save_level_number()
		get_tree().call_group("GUI","stop_timer")
		get_tree().call_group("BGM", "pause")
		$VictorySong.play()
		reach_portal = true


func _on_VictorySong_finished():
	if Global.level_number > Global.levels.size()-1:
		get_tree().call_group("GameState", "congratulations")
	else:
		get_tree().call_group("GameState", "win_stage")
	
