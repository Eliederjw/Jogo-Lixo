extends CanvasLayer

onready var life_icon = $Control/TextureRect/HBoxContainer/Life/LifeIcon

var timer_stop = false

var time_start = 0
var time_now = 0


func _ready():
	life_icon.set_frame(Global.player)
	#timer 
	time_start = OS.get_unix_time()
	set_process(true)
	#stage label
	$Control/Stage. text = "Fase " + str(Global.level_number)
	
func _process(delta):
	if timer_stop == false:
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		var str_elapsed = "%02d : %02d" % [minutes, seconds]
		$Control/clock.text = str_elapsed

func stop_timer():
	timer_stop = true

func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
