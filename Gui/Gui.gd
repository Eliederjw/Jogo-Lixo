extends CanvasLayer

onready var life_icon = $Control/TextureRect/HBoxContainer/Life/LifeIcon

onready var air_jump = $Control/AbilitiesSlot/air_jump_slot
onready var teleport = $Control/AbilitiesSlot/teleport_slot
onready var flight = $Control/AbilitiesSlot/flight_slot
onready var beam = $Control/AbilitiesSlot/beam_slot
onready var abilities_slot = $Control/AbilitiesSlot

var abilities = []

func _ready():
	life_icon.set_frame(Global.player)
	#stage label
	$Control/Stage. text = "Fase " + str(Global.level_number)
	
func _process(delta):
	pass

func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)

func update_abilities():
	clear_slots()
	set_abilities_visible()
	
func set_abilities_visible():
	for i in abilities:
		match i:
			"air_jump":
				air_jump.visible = true
			"teleport":
				teleport.visible = true
			"flight":
				flight.visible = true
			"beam":
				beam.visible = true

func clear_slots():
	var index
	for i in abilities_slot.get_child_count():
		abilities_slot.get_child(i).visible = false

func get_abilities_on(abilities_on):
	abilities = abilities_on
	update_abilities()

	
