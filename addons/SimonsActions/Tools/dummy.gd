extends Node
class_name EntityDummy

@export var resources:ObtainableResourceManager
@export var hp_type:ObtainableResourceType

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print(resources.get_resource_by_type(hp_type).current_value)
