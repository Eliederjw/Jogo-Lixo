extends Control

onready var bunny1 = get_node("VBoxContainer/HBoxBunnies/bunny1")
onready var bunny2 = get_node("VBoxContainer/HBoxBunnies/bunny2")
onready var bttContinue = get_node("VBoxContainer/HBoxContinue")

var pressed = false

func _ready():
	Global.load_coins()
	Global.load_lives()
	Global.load_level_number()
	Global.load_coins_collected()
	if Global.level_number > 1:
		bttContinue.visible = true
	else:
		bttContinue.visible = false
	
func _on_bttContinue_pressed():
	if pressed == false:
		pressed = true
		$JogarSound.play()
		
func _on_bttNewGame_pressed():
	if pressed == false:
		pressed = true
		Global.new_game()
		Global.save_coins()
		Global.save_lives()
		Global.save_level_number()
		Global.save_coins_collected()
		$JogarSound.play()
	
func _on_JogarSound_finished():
	if Global.level_number == Global.levels.size():
		get_tree().change_scene("res://Screens/Congratulations_Screen.tscn")
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

