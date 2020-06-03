extends CanvasLayer

onready var life_icon = $Control/TextureRect/HBoxContainer/Life/LifeIcon

func _ready():
	life_icon.set_frame(Global.player)
	#stage label
	$Control/Stage. text = "Fase " + str(Global.level_number)
	
func _process(delta):
	pass

func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
