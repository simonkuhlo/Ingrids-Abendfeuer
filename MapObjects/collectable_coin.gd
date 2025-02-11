extends Area3D
class_name CollectableCoin

@export var held_amount:int = 1

@export var rotation_speed:float = 1
@export var body:Node3D


func _physics_process(delta):
	body.rotate_y(deg_to_rad(360 * rotation_speed) * delta)

func get_picked_up(collector:GameEntity):
	set_deferred("monitorable", false)
	remove_child(body)
	var instance:CollectAnimation = CollectAnimation.new(collector)
	instance.add_child(body)
	instance.global_transform = global_transform
	get_tree().root.add_child(instance)
	queue_free()
