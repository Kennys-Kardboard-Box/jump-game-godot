extends Area2D



func _ready():
	pass 

func _on_Portal_body_entered(body):
	_is_player_on_portal(body)
	pass # Replace with function body.


func _is_player_on_portal(player: Player):
	if player:
		print("portal")
	pass
