extends Path3D

@export var object_to_follow:Node3D
var previous_position:Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	global_transform.origin = object_to_follow.global_transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if object_to_follow:
		var current_position = object_to_follow.global_transform.origin + Vector3.DOWN * 4
		if current_position != previous_position:
			curve.add_point(current_position)
			previous_position = current_position
			if curve.get_point_count() > 1000:
				curve.remove_point(0)
