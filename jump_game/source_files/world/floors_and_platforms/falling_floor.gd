extends Floor

class_name FallingFloor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fall_speed = 400.0
export var shake_direction = Vector2()

const shake_distance = 20.0
const shake_time = 0.75

onready var fall_timer = $TimerBeforeFall
onready var destroy_timer = $FallTimer
onready var tween = $Tween
onready var sprite = $Sprite
onready var shake_distance_by_size_x = shake_distance / scale.x
onready var shake_distance_by_size_y = shake_distance / scale.y

var should_fall = false
var is_shaking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func bounce_player(player):
	.bounce_player(player)
	if not is_shaking:
		is_shaking = true
		_set_fall()
		tween.interpolate_method(self, "_shake", 0.0 , 5.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		tween.start()


func _shake(time):
	print(sin(time * PI))
	var new_pos = shake_direction * sin(time * PI)
	new_pos.x *= shake_distance_by_size_x
	new_pos.y *= shake_distance_by_size_y
	sprite.position = new_pos
	pass


func _set_fall():
	fall_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if should_fall:
		global_position.y += fall_speed * delta
	pass


func _on_TimerBeforeFall_timeout():
	should_fall = true
	destroy_timer.start()
	print("fall")
	pass # Replace with function body.




func _on_FallTimer_timeout():
	print("gone")
	is_shaking = false
	should_fall = false
	queue_free()
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	sprite.position = Vector2()
	pass # Replace with function body.
