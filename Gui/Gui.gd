extends CanvasLayer

onready var life_icon = $Control/TextureRect/HBoxContainer/Life/LifeIcon
onready var air_jump = $Control/TextureRect2/air_jump_slot
onready var teleport = $Control/TextureRect2/teleport_slot
onready var flight = $Control/TextureRect2/flight_slot
onready var beam = $Control/TextureRect2/beam_slot

func _ready():
	life_icon.set_frame(Global.player)
	#stage label
	$Control/Stage. text = "Fase " + str(Global.level_number)
	
func _process(delta):
	pass

func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
	$Control/abilities_slot.get_child(0).visible = true

func set_air_jump_visible(visible):
	air_jump.visible = visible

func set_teleport_visible(visible):
	teleport.visible = visible
	
func set_flight_visible(visible):
	flight.visible = visible

func set_beam_visible(visible):
	beam.visible = visible
