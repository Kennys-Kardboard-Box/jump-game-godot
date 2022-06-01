extends Camera2D

var player

onready var remote_transform = get_node("../CameraFollow/RemoteTransform2D") as RemoteTransform2D
onready var deleter = $Deleter


func _ready():
	var parent = get_parent()
	player = parent.get_node("Player")



func _physics_process(delta):
#	remote_transform.global_position.y = min(remote_transform.global_position.y, limit_bottom)
	deleter.global_position.y = min(deleter.global_position.y, limit_bottom)


func _on_Deleter_body_entered(body):
	if body == player:
		print("dead")
		body.queue_free()
		get_tree().reload_current_scene()
	pass
