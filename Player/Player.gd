extends KinematicBody2D

class_name PlayerState

var motion = Vector2(0,0)
var gravity = true
var dance_enable = false
var speed_boost = 0
var hurt = false
var dead = false
var deadline = 0
var directionx = 0

var is_flying = false
var invincible = false

const GRAVITY = 200 
const FRICTION = 0.9
const SPEED = 1200 
const UP = Vector2(0,-1)
const JUMP_SPEED = 4000 
const WORLD_LIMIT = 500
const BOOST_MULTIPLIER = 1.5

signal animate
signal offset
signal jump
signal teleport
signal hurt
signal dead

func _ready():
	connect("jump", Abilities, "on_jump")
	connect("teleport", Abilities, "on_teleport")
	connect("hurt", Abilities, "on_hurt")
	connect("dead", Abilities, "on_dead")
	
func _physics_process(delta):
	move()
	victory_jump(dance_enable)
	animate()
	move_and_slide(motion, UP)
	apply_gravity(gravity)
	apply_friction()
	Abilities.set_is_on_floor(is_on_floor())
		
func set_gravity(status):
	gravity = status

func apply_gravity(status):
	if status == true:
	
		if position.y > WORLD_LIMIT:
			dead()
		if is_on_floor() and motion.y > 0:
			motion.y = 1
		if is_on_ceiling():
			motion.y = 100
	
		else: 
			motion.y += GRAVITY

func set_direction(input_directionx):
	directionx = input_directionx
	
func move():
	if not is_flying:
		motion.x = (SPEED + speed_boost) * directionx
		camera_offset()

func jump():
	if is_on_floor() and not is_flying:
		hurt = false
		is_flying = false
		motion.y = -JUMP_SPEED
		$Jump.play()
		
func air_jump(jump_speed):
	is_flying = false
	motion.y = 0
	motion.y -= jump_speed
	$Jump.play()
	emit_signal("jump")
	
func teleport(teleport_position):
	is_flying = false
	emit_signal("teleport")
	position.x = position.x + teleport_position

func fly(flight_speed, directiony, directionx):
	is_flying = true
	motion.y = directiony
	motion.x = directionx
	motion = motion * flight_speed
	camera_offset()

func set_is_flying(status):
	is_flying = status
	
func camera_offset():
	emit_signal("offset", directionx)

func animate():
	emit_signal("animate", motion, is_on_floor(), hurt, dead)
	
func hurt():
	if !invincible:
		if Global.lives == 0:
			dead()
		else:
			position.y -= 6
			get_tree().call_group("GameState", "lose_lives")
			motion.y = -JUMP_SPEED
			emit_signal("hurt")
			hurt = true
			invincible = true
			$InvincibleTimer.start()
			$FlickerAnimation.play("Flicker")
			$Pain.play()
	
func jump_boost(boost):
	yield(get_tree(),"idle_frame")
	motion.y = boost * BOOST_MULTIPLIER

func apply_friction():
	if abs(speed_boost) < 10:
		speed_boost = 0
	else: 
		speed_boost *= 0.9
		
func speed_boost(boost):
	yield(get_tree(),"idle_frame")
	speed_boost = boost
	
func victory_jump(enable):
	if enable == true:
		if is_on_floor():
			motion.y -= JUMP_SPEED
	
func dead():
	if dead == false:
		is_flying = false
		$CollisionShape2D.queue_free()
		set_physics_process(false)
		motion = Vector2(0,0)
		get_tree().call_group("Input", "disable_input", true)
		dead = true
		emit_signal("dead")
		deadline = position.y + 50
		animate()
		get_tree().call_group("BGM", "pause")
		$Died.play()
		$Fail.play()
		$DeadTimer.start()
		
func on_portal_reach():
	dance_enable = true
	is_flying = false
	
### TIMERS ###

func _on_DeadTimer_timeout():
	set_physics_process((true))
	motion.y -= JUMP_SPEED
	if position.y > deadline:
		get_tree().call_group("GameState", "end_game")

func _on_InvincibleTimer_timeout():
	invincible = false

