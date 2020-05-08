extends Control


func _on_bttRestart_pressed():
	get_tree().change_scene(Global.levels[Global.level_number])
	

func _on_bttVoltar_pressed():
	Global.level_number = 0
	get_tree().change_scene(Global.levels[Global.level_number])
