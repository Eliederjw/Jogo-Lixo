extends Node2D

var reach_portal = false
var coins_enough = false
onready var player = get_node("../Player")

signal portal_reach

func _ready():
	connect("portal_reach", GlobalInput,"on_portal_reach")
	connect("portal_reach", Abilities, "on_portal_reach")
	connect("portal_reach", player, "on_portal_reach")

	
func _process(delta):
	get_tree().call_group("GameState", "portal_open")

func _on_Area2D_body_entered(body):
	if reach_portal == false and coins_enough == true:
		reach_portal = true
		notify_scripts()
		Global.level_number += 1
		Global.save_game()
		pause_BGM()
		show_stars()
		$VictorySong.play()
		
func _on_VictorySong_finished():
	if Global.level_number > Global.levels.size()-1:
		get_tree().call_group("GameState", "congratulations")
	else:
		get_tree().call_group("GameState", "win_stage")

func notify_scripts():
	# Input and Abilities are being notified
	emit_signal("portal_reach")

func show_stars():
	get_tree().call_group("GameState", "show_stars")
	
func player_dance(body):
	body.dance_enable = true
	
func pause_BGM():
	get_tree().call_group("BGM", "pause")
	
