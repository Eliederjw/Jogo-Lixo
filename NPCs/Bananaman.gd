extends KinematicBody2D

export var idle_time = 2.0
export var jump_speed = 3000

var gravity = true
var motion = Vector2(0,0)
var UP = Vector2(0,-1)
var idle = true

const GRAVITY = 200

signal animate

func _ready():
	$Timer.wait_time = idle_time
	$Timer.start()

func _physics_process(delta):
	jump()
	move_and_slide(motion, UP)
	appLy_gravity()
	animate()

func jump():
	if idle == false and is_on_floor():
		motion.y = -jump_speed
		idle = true
		$Timer.start()
	
func appLy_gravity():
	if !is_on_floor() and gravity == true:
		motion.y += GRAVITY
		
func _on_Timer_timeout():
	idle = false
	
func animate():
	emit_signal("animate", motion)
