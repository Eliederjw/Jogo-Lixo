class_name Abilities

var abilities = ["air_jump", "teleport"]

func has_ability(ability):
	for i in abilities:
		if i == ability:
			return true

func teleport():
	pass


