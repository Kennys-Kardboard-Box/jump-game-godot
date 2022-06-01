extends Position2D

export (String, FILE) var floor_file 
onready var floor_scene = load(floor_file) as PackedScene

onready var timer = $Timer
onready var falling_floor = get_child(0)
onready var floor_size = falling_floor.scale

var timer_started = false

func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not falling_floor and not timer_started:
		timer.start()
		timer_started = true
	pass


func spawn_floor():
	var floor_instance = floor_scene.instance() as StaticBody2D
	if floor_instance:
		add_child(floor_instance)
		move_child(floor_instance, 0)
		floor_instance.position = Vector2()
		floor_instance.scale = floor_size
		falling_floor = get_child(0)
	pass


func _on_Timer_timeout():
	spawn_floor()
	timer_started = false
	pass # Replace with function body.
