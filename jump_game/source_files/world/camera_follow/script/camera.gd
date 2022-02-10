extends Camera2D

var player


func _ready():
	var parent = get_parent()
	player = parent.get_node("Player")


func _on_Deleter_body_entered(body):
	if body == player:
		print("dead")
	pass
