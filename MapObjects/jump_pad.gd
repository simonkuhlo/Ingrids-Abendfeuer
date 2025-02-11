@tool
extends StaticBody3D

@export var marker:Marker3D
@export var raycast:RayCast3D
@export var detection_area:Area3D
@export var strength:float = 20

func visualize():
	raycast.target_position = Vector3.UP * strength * 0.5

func _ready():
	visualize()

func _physics_process(delta):
	if !Engine.is_editor_hint():
		for body in detection_area.get_overlapping_bodies():
			if body is Player:
				var force = self.global_position.direction_to(marker.global_position).normalized() * strength
				body.motion_machine.set_force(force)
				#queue_free()
