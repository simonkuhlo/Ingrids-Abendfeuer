extends Node3D
class_name CollectAnimation

var rotation_speed:float = 1
var travel_target:GameEntity
var initial_distance:float = 1
var travel_speed:float = 1

func _init(target:GameEntity):
	travel_target = target

func _ready():
	initial_distance = global_transform.origin.distance_to(travel_target.global_transform.origin)

func _physics_process(delta):
	rotate_y(deg_to_rad(360 * rotation_speed) * delta)
	if travel_target:
		if global_transform.origin.distance_to(travel_target.global_transform.origin) > 0.1:
			global_position = global_transform.origin.move_toward(travel_target.global_transform.origin, travel_speed * delta)
			var scale_value:float = max(global_transform.origin.distance_to(travel_target.global_transform.origin) / initial_distance, 0.1)
			scale = Vector3(scale_value,scale_value,scale_value)
			travel_speed += 1000 * delta
		else:
			queue_free()
	else:
		queue_free()
