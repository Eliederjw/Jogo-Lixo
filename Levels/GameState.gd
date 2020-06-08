extends Node2D

var lives = Global.lives
var coins = Global.coins
var lives_up_coins = 30
var level_coins_total = 0
var level_coins_collected = 0

func reach_portal():
	pass

func _ready():
	add_to_group("GameState")
	update_GUI()
	GlobalInput.enabled = true
	level_coins_total = get_tree().get_nodes_in_group("Coins").size()
	
func _enter_tree():
	add_child(load(Global.screens["pause"]).instance())
		
func lose_lives():
	lives -= 1
	update_GUI()
	update_Global()
	
func update_GUI():
	get_tree().call_group("GUI", "update_GUI", lives, coins)
	
func update_Global():
	Global.lives = lives
	Global.coins = coins
	
func coins_up():
	coins += 1
	level_coins_collected +=1
	Global.coins_collected += 1
	update_GUI()
	update_Global()
	
	var multiples_of_coins = (coins % lives_up_coins) == 0
	if multiples_of_coins:
		life_up()

func portal_open():
	if level_coins_collected >= int(level_coins_total*0.8):
		$Portal/AnimatedSprite.play("full")
		$Portal/Particles2D.emitting = true
		$Portal.coins_enough = true
	else:
		$Portal/AnimatedSprite.play("empty")
		
func life_up():
	lives += 1
	$Music/LifeUp.play()
	update_GUI()
	update_Global()

func win_stage():
	get_tree().change_scene(Global.screens["stage"])	

func show_stars():
	var star_screen = load("res://Screens/StarScreen.tscn").instance()
	add_child(star_screen)
	
	star_screen.check_number_of_coins(level_coins_collected, level_coins_total)
	
func congratulations():
	get_tree().change_scene(Global.screens["congratulation"])
	
func end_game():
	Global.reset_vars()
	get_tree().change_scene(Global.screens["gameover"])
	
