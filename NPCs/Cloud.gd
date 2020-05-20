extends Node2D

const UP = Vector2(0,-1)

export var hspeed = 5
export var limit_left = 400
export var limit_right = 400
export var fire_wait = 1.0

var timeout = false
var motion = Vector2(hspeed,0)

func _ready():
	limit_left *= -1
	motion.x = hspeed
	$Cloud/Timer.wait_time = fire_wait
	
func _process(delta):
	check_limits()
	$Cloud.translate(motion)
	if $Cloud/RayCast2D.is_colliding():
		fire()

func check_limits():
	if $Cloud.position.x > limit_right:
		motion.x = -hspeed
	if $Cloud.position.x < limit_left:
		motion.x = hspeed

func move(delta):
	$Cloud.position.x += motion.x * delta
	
func fire():
	if not timeout:
		$Cloud/RayCast2D.add_child(load("res://NPCs/Lightning.tscn").instance())
		$Cloud/Timer.start()
		timeout = true

func _on_Timer_timeout():
	timeout = false
