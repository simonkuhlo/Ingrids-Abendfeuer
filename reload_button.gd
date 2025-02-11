extends Button


@export var world:Node3D


func _on_pressed():
	world.reload()
