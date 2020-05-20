extends Node2D

const UP = Vector2(0,-1)

export var hspeed = 0
export var vspeed = 0
export var limit_left = 0
export var limit_right = 0
export var limit_up = 0
export var limit_down = 0

export var bottom_collision : bool

var motion = Vector2(hspeed,vspeed)

func _ready():
	limit_up *= -1
	limit_left *= -1
	motion.x = hspeed
	motion.y = vspeed
	set_one_way_collision(bottom_collision)

func _physics_process(delta):
	check_limits(delta)
	move(delta)
	
func check_limits(delta):
	if $Movable_Platform.position.x > limit_right:
		motion.x = -hspeed
	if $Movable_Platform.position.x < limit_left:
		motion.x = hspeed
	if $Movable_Platform.position.y > limit_down:
		motion.y = -vspeed
	if $Movable_Platform.position.y < limit_up:
		motion.y = vspeed
	
func move(delta):
	$Movable_Platform.position.x += motion.x * delta
	$Movable_Platform.position.y += motion.y * delta

func set_one_way_collision(status):
	if status == true:
		$Movable_Platform/CollisionShape2D.one_way_collision = !status
	else: 
		$Movable_Platform/CollisionShape2D.one_way_collision = !status
		
		
