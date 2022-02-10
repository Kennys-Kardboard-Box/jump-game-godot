extends KinematicBody2D


export var speed = 30.0
export var jump_impulse = 200.0
export var gravity = 200.0
export var max_fall_speed = 400.0

var velocity = Vector2()
var on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	if on_floor: # and Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump_impulse
	velocity.y = min(velocity.y + (gravity * delta), max_fall_speed)
	velocity = move_and_slide(velocity, Vector2.UP)
	on_floor = is_on_floor()
	pass
