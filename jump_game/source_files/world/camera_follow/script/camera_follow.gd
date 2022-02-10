extends Node2D


onready var follower = $Follower


func _ready():
	pass


func _physics_process(delta):
	if follower.global_position.y < global_position.y:
		global_position.y = follower.global_position.y
	pass
