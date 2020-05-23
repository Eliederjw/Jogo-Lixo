extends Control


func _ready():
	var level
	var coins = 1

	for coins in Global.levels.size():
		level = load(Global.levels[coins]).instance()
		add_child(level)
		Global.coins_total += level.get_tree().get_nodes_in_group("Coins").size()
		level.free()		
		print ("Fase " + str(coins) + ": " + str(Global.coins_total))
		
	get_node("HBoxContainer/CenterContainer/Label").text = "Coins_Total: " + str(Global.coins_total)
