extends Control

onready var bunny1 = get_node("VBoxContainer/HBoxBunnies/bunny1")
onready var bunny2 = get_node("VBoxContainer/HBoxBunnies/bunny2")
onready var bttContinue = get_node("VBoxContainer/HBoxContinue")

var pressed = false

func _ready():
	Global.load_coins()
	Global.load_lives()
	Global.load_level_number()
	if Global.level_number > 1:
		bttContinue.visible = true
	else:
		bttContinue.visible = false	
	
func _on_bttContinue_pressed():
	if pressed == false:
		pressed = true
		Global.load_coins()
		Global.load_lives()
		Global.load_level_number()
		$JogarSound.play()
		
func _on_bttNewGame_pressed():
	if pressed == false:
		pressed = true
		Global.new_game()
		Global.save_coins()
		Global.save_lives()
		Global.save_level_number()
		$JogarSound.play()
	
func _on_JogarSound_finished():
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

###Used to count the total number of coins in all levels.
###Uncomment this function on func _ready
#func count_levels_coins():
#	var level
#	var coins = 1
#
#	for coins in Global.levels.size():
#		level = load(Global.levels[coins]).instance()
#		add_child(level)
#		Global.coins_total += level.get_tree().get_nodes_in_group("Coins").size()
#		level.free()
#		print (Global.coins_total)

