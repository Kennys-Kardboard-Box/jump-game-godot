extends KinematicBody2D

class_name Player

export var speed = 30.0
export var max_jump_height = 96.0
export var jump_duration = 1.0
export var float_jump_height = 32.0
export var float_jump_duration = 4.0

onready var gravity = (2 * max_jump_height)/(pow(jump_duration/2, 2))
onready var float_gravity = (2 * float_jump_height)/(pow(float_jump_duration/2, 2))
onready var initial_velocity = sqrt(2 * max_jump_height * gravity)
onready var float_initial_velocity = sqrt(2 * float_jump_height * float_gravity)
onready var raycast = $RayCast2D
onready var raycasts = [$RayCast2D, $RayCast2D2, $RayCast2D3]

var is_floating: bool = false
var is_jumping: bool = true
var has_floated_this_jump: bool = false
var velocity = Vector2()
var on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var weighted_velocity = Vector2()
	if is_floating:
		velocity.y += float_gravity * delta
	else:
		velocity.y += gravity * delta
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	if on_floor:
#		bounce(is_floating, 1)
	weighted_velocity = velocity
	weighted_velocity.x *= speed
	weighted_velocity = move_and_slide(weighted_velocity, Vector2.UP)
	velocity.y = weighted_velocity.y
	for ray in raycasts:
		ray.enabled = weighted_velocity.y >= 0
		if ray.is_colliding():
			var collided_floor = ray.get_collider() as Floor
			if collided_floor:
				collided_floor.bounce_player(self)
#			bounce(1)
			break
#	raycast.enabled = weighted_velocity.y >= 0
#	raycast.force_raycast_update()
#	if raycast.is_colliding():# and raycast.enabled:
#		bounce(1)
	on_floor = is_on_floor()
	if Input.is_action_just_pressed("ui_accept"):
		if is_floating:
			is_floating = false
		if not has_floated_this_jump and not is_floating:
			is_floating = true
			print("Float")
			has_floated_this_jump = true
			velocity.y = -float_initial_velocity
	pass


func bounce(bounce_factor):
	is_jumping = false
	is_floating = false
	has_floated_this_jump = false
	velocity.y = -initial_velocity * bounce_factor
