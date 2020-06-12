extends Control

onready var bunny1 = get_node("VBoxContainer/HBoxBunnies/bunny1")
onready var bunny2 = get_node("VBoxContainer/HBoxBunnies/bunny2")
onready var bttContinue = get_node("VBoxContainer/HBoxContinue")

var pressed = false

signal new_game
signal load_game

func _ready():
	Global.load_game()
	if Global.level_number > 1:
		bttContinue.visible = true
	else:
		bttContinue.visible = false
	connect("new_game", Abilities, "new_game")
	connect("load_game", Abilities, "load_game")
	
func _on_bttContinue_pressed():
	if pressed == false:
		pressed = true
		$JogarSound.play()
		emit_signal("load_game")
		
func _on_bttNewGame_pressed():
	if pressed == false:
		pressed = true
		Global.new_game()
		Global.save_game()
		$JogarSound.play()
		emit_signal("new_game")
	
func _on_JogarSound_finished():
	if Global.level_number == Global.levels.size():
		get_tree().change_scene(Global.screens["congratulation"])
	else:	
		get_tree().change_scene(Global.levels[Global.level_number])
		queue_free()
		
func _on_bunny1_pressed():
		$SelectSound.play()
		enable_pressed(bunny2)
		uncheck_pressed(bunny2)
		bunny1.disabled = true
		Global.player = 0
	
func _on_bunny2_pressed():
		$SelectSound.play()
		enable_pressed(bunny1)
		uncheck_pressed(bunny1)	
		bunny2.disabled = true
		Global.player = 1

func uncheck_pressed(bunny):
	if bunny.is_pressed():
		bunny.pressed = false
	
func enable_pressed(bunny):
	if bunny.is_pressed():
		bunny.disabled = false

