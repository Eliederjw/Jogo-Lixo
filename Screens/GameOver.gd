extends Control


func _on_bttRestart_pressed():
	get_tree().change_scene(Global.levels[Global.level_number])
	

func _on_bttVoltar_pressed():
	get_tree().change_scene(Global.screens["start"])
