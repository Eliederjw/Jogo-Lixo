extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible

func _on_Continue_pressed():
	get_tree().paused = !get_tree().paused
	visible = !visible

func _on_StartMenu_pressed():
	get_tree().paused = !get_tree().paused
	visible = !visible
	Global.level_number = 0
	get_tree().change_scene(Global.levels[Global.level_number])


func _on_Quit_pressed():
	get_tree().quit()
