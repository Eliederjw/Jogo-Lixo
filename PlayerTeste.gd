extends KinematicBody2D

class_name Player_Teste

var move_enable = true
var jump_enable = true
var motion = Vector2(0,0)
var direction = 1

export var friction = 2000
export var acceleration = 4000
export var max_speed = 800
export var jump_speed = 3500
export var gravity = 200

const UP = Vector2(0,-1)
const rt = 0.08

func _physics_process(delta):
	move(move_enable, delta)
	jump(jump_enable)
	move_and_slide(motion, UP)
	apply_gravity()
	

func apply_gravity():
		if is_on_floor() and motion.y > 0:
			motion.y = 1
		if is_on_ceiling():
			motion.y = 100
		else: 
			motion.y += gravity

func set_direction():
	if Input.is_action_pressed ("left") and not Input.is_action_pressed ("right"):
		direction = -1
	elif Input.is_action_pressed ("right") and not Input.is_action_pressed ("left"):
		direction = 1
	else:
		direction = 0
	
func move(enable, delta):
	if enable == true:
		if direction != 0:
			apply_acceleration(delta)
			print("acceleration")
		else:
			apply_friction(delta)
			print("friction")
	
func apply_acceleration(delta):
	motion.x +=  acceleration * rt * direction
	if abs(motion.x) > max_speed:
		motion.x = max_speed * direction
	
func apply_friction(delta):
	if motion.x < -friction*rt:
		motion.x += friction * rt
	elif motion.x > friction*rt:
		motion.x -= friction * rt
	else:
		motion.x = 0
	
		
func jump(enable):
	if enable == true:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			motion.y = -jump_speed
