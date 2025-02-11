extends Node3D

@export var following:Node3D

func _physics_process(delta):
	global_position = following.global_position
