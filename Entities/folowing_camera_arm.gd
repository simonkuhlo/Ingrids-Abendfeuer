extends SpringArm3D

@export var entity_to_follow:GameEntity

@export var arm_x:Marker3D
@export var camera:Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# rotation with mouse
	var mouse_motion = Input.get_last_mouse_velocity()
	# follow enitity
	self.global_position = entity_to_follow.global_position + Vector3.UP * 2

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * 0.05))
		arm_x.rotate_x(deg_to_rad(-event.relative.y * 0.05))
		arm_x.rotation.x = clamp(arm_x.rotation.x, deg_to_rad(-90), deg_to_rad(90))
