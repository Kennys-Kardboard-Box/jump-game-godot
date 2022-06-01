extends StaticBody2D

class_name Floor

export var bounce_factor: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func bounce_player(player):
	player.bounce(bounce_factor)
	pass
