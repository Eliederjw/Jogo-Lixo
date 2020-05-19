extends KinematicBody2D

export var speed = 200
export var fall_rim = false
export var gravity = true
export var idle_time = 1.0

var motion = Vector2(0,0)
var UP = Vector2(0,-1)
var direction = 1
var flip = false
var idle = false

const GRAVITY = 200

signal animate

func _ready():
	$Timer.wait_time = idle_time

func _physics_process(delta):
	appLy_gravity()
	check_rim()
	check_wall()
	move()
	animate()
	
func appLy_gravity():
	if !is_on_floor() and gravity == true:
		motion.y += GRAVITY
	
func move():
	if idle == false:
		motion.x = speed * direction
		move_and_slide(motion,UP)
	
func check_rim():
	if $RayCast2D.is_colliding() == false and fall_rim == false:
		direction *= -1
		flip = !flip
		$RayCast2D.position.x *= -1
		$RayCast2D.cast_to.x *= -1
		motion.x = 0
		yield(get_tree(),"idle_frame")
		idle = true
		$Timer.start()
		
func check_wall():
	if is_on_wall():
		direction *= -1
		flip = !flip
		$RayCast2D.position.x *= -1
		$RayCast2D.cast_to.x *= -1
		motion.x = 0
		yield(get_tree(),"idle_frame")
		idle = true
		$Timer.start()

func _on_Timer_timeout():
	idle = false
	
func animate():
	emit_signal("animate", idle, flip)
