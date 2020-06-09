extends KinematicBody2D

class_name Player

var motion = Vector2(0,0)
var gravity = true
var dance_enable = false
var air_jump = 1
var speed_boost = 0
var hurt = false
var dead = false
var deadline = 0
var direction = 0

var teleport = true
var invincible = false

const GRAVITY = 200 #300
const FRICTION = 0.9
const SPEED = 1200 #1100
const UP = Vector2(0,-1)
const JUMP_SPEED = 4000 # 5000
const WORLD_LIMIT = 500
const BOOST_MULTIPLIER = 1.5 #1.5
const TELEPORT_DISPLACEMENT = 350

signal animate
signal offset

func _ready():
	pass

func _physics_process(delta):
	move()
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

func jump():
	if is_on_floor():
		hurt = false
		motion.y = -JUMP_SPEED
		$Jump.play()

func air_jump():
	if not is_on_floor() and air_jump > 0:
		air_jump -= 1
		motion.y = 0
		motion.y -= JUMP_SPEED
		$Jump.play()
		
	if is_on_floor():
		air_jump = 1
	
func teleport():
	if Abilities.has_ability("teleport"):
		position.x = position.x + Abilities.teleport()
		Abilities.set_teleport(false)
		$TeleportTimer.start()

func set_direction(input_direction):
	direction = input_direction
	
func move():
	motion.x = (SPEED + speed_boost) * direction
	camera_offset()
	
func camera_offset():
	emit_signal("offset", direction)

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
			hurt = true
			invincible = true
			$InvincibleTimer.start()
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
	if dead == false:
		$CollisionShape2D.queue_free()
		set_physics_process(false)
		motion = Vector2(0,0)
		get_tree().call_group("Input", "disable_input", true)
		dead = true
		deadline = position.y + 50
		animate()
		get_tree().call_group("BGM", "pause")
		$Died.play()
		$Fail.play()
		$Timer.start()
	
func _on_Timer_timeout():
	set_physics_process((true))
	motion.y -= JUMP_SPEED
	if position.y > deadline:
		get_tree().call_group("GameState", "end_game")

### TIMERS ###

func _on_InvincibleTimer_timeout():
	invincible = false

func _on_TeleportTimer_timeout():
	Abilities.set_teleport(true)
	
