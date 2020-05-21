extends KinematicBody2D

var motion = Vector2(0,0)
var gravity = true
var move_enable = true
var jump_enable = true
var dance_enable = false
var air_jump = 1
var speed_boost = 0
var hurt = false
var dead = false

const GRAVITY = 200 #300
const FRICTION = 0.9
const SPEED = 1200 #1100
const UP = Vector2(0,-1)
const JUMP_SPEED = 4000 # 5000
const WORLD_LIMIT = 1000
const BOOST_MULTIPLIER = 1.5 #1.5


signal animate
signal offset

func _process(delta):
	pass
	
func _physics_process(delta):
	move(move_enable)
	jump(jump_enable)
	air_jump(jump_enable)
	victory_jump(dance_enable)
	animate()
	move_and_slide(motion, UP)
	apply_gravity(gravity)
	apply_friction()
	
		
func apply_gravity(status):
	if gravity == true:
	
		if position.y > WORLD_LIMIT:
			dead()
		if is_on_floor() and motion.y > 0:
			motion.y = 1
		if is_on_ceiling():
			motion.y = 100
					
		else: 
			motion.y += GRAVITY

func apply_friction():
	if abs(speed_boost) < 10:
		speed_boost = 0
	else: 
		speed_boost *= 0.9	

func jump(enable):
	if enable == true:
		if Input.is_action_just_pressed("jump") and is_on_floor():
				hurt = false
				motion.y = -JUMP_SPEED
				$Jump.play()
									
func air_jump(enable):					
	if enable == true:
		if Input.is_action_just_pressed("jump") and not is_on_floor() and air_jump > 0:
				air_jump -= 1
				motion.y = 0
				motion.y -= JUMP_SPEED
				$Jump.play()
		if is_on_floor():
			air_jump = 1
			
func move(enable):
	if enable == true:
		if Input.is_action_pressed ("left") and not Input.is_action_pressed ("right"):
			motion.x = -SPEED + speed_boost
			camera_offset()
			
		elif Input.is_action_pressed ("right") and not Input.is_action_pressed ("left"):
			motion.x = SPEED + speed_boost
			camera_offset()
		
		else:
			motion.x = speed_boost
	else: 
		motion.x = 0

func camera_offset():
	emit_signal("offset")

func animate():
	emit_signal("animate", motion, is_on_floor(), hurt, dead)
	
func hurt():
	if Global.lives == 0:
		dead()
	else:
		position.y -= 6
		get_tree().call_group("GameState", "lose_lives")
		motion.y = -JUMP_SPEED
		hurt = true
		$FlickerAnimation.play("Flicker")
		$Pain.play()

		
func jump_boost(boost):
	yield(get_tree(),"idle_frame")
	motion.y = boost * BOOST_MULTIPLIER

func speed_boost(boost):
	yield(get_tree(),"idle_frame")
	speed_boost = boost
	
func victory_jump(enable):
	if enable == true:
		if is_on_floor():
			motion.y -= JUMP_SPEED
	
func dead():
	$CollisionShape2D.queue_free()
	set_physics_process(false)
	motion = Vector2(0,0)
	dead = true
	animate()
	$Timer.start()

func _on_Timer_timeout():
	get_tree().call_group("GameState", "end_game")
