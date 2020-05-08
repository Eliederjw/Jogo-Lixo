extends Control

func _ready():
	$CenterContainer/VBoxContainer/Label.text = "Fase " + str(Global.level_number)

func _on_bttRestart_pressed():
	get_tree().change_scene(Global.levels[Global.level_number])
