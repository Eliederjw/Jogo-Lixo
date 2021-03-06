extends Node

const STARTING_LIVES = 3
const STARTING_COINS = 0
const STARTING_LEVEL_NUMBER = 1

var levels = ["res://Screens/StartScreen.tscn",
			"res://Levels/Level1.tscn",
			"res://Levels/Level2.tscn",
			"res://Levels/Level3.tscn",
			"res://Levels/Level4.tscn",
			"res://Levels/Level5.tscn",
			"res://Levels/Level6.tscn"]
var level_number = 0
var lives = 0
var coins = 0
var player = 0


func new_game():
	lives = STARTING_LIVES
	coins = STARTING_COINS
	level_number = STARTING_LEVEL_NUMBER

func reset_vars():
	if lives > 0:
		Global.lives -= 1
		Global.save_lives()
	load_lives()
	load_coins()

	#LOAD FUNCTIONS
func load_lives():
	lives = int(load_file("user://lives.json"))
	
func load_level_number():
	level_number = int(load_file("user://level_number.json"))
		
func load_coins():
	coins = int(load_file("user://coins.json"))

	#SAVE FUNCTIONS
func save_lives():
	save_file("user://lives.json", lives)

func save_level_number():
	save_file("user://level_number.json", level_number)

func save_coins():
	save_file("user://coins.json", coins)

	#BASE FUNCTIONS
func load_file(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	file.close()
	return text

func save_file(filename, content):
	var file = File.new()
	file.open(filename, File.WRITE)
	file.store_string(str(content))
	file.close()
