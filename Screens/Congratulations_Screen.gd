extends Control

func _ready():
	$HBoxContainer/CenterContainer/Label.text = "Parabéns! \n Você coletou " + str((Global.coins_collected * 100)/246) + "% das moedas"

func _on_bttVoltar_pressed():
	get_tree().change_scene(Global.screens["start"])
