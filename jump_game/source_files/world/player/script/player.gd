extends KinematicBody2D


export var speed = 30.0
export var max_jump_height = 96.0
export var jump_duration = 3.0

onready var gravity = max_jump_height/(2 * pow(jump_duration, 2))
onready var initial_velocity = -sqrt(2 * max_jump_height * gravity)
onready var raycast = $RayCast2D

var velocity = Vector2()
var on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var weighted_velocity = Vector2()
	velocity.y += gravity
	if on_floor:
		velocity.y = initial_velocity
	weighted_velocity = velocity
	weighted_velocity.x *= speed
	weighted_velocity = move_and_slide(weighted_velocity)
	on_floor = is_on_floor()
	print(on_floor)
	pass
