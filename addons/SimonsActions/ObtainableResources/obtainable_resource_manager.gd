@tool
extends Node
class_name ObtainableResourceManager

var _registered_resources:Array[ObtainableResource]
var registered_resources:Array[ObtainableResource]:
	get:
		if !_registered_resources:
			_register_all_resources()
		return _registered_resources

func _register_resource(resource:ObtainableResource) -> void:
	if _registered_resources:
		if get_resource_by_type(resource.type):
			push_error("Resource type already exists!")
			_remove_resource(resource)
	_registered_resources.append(resource)

func _remove_resource(resource:ObtainableResource) -> void:
	_registered_resources.erase(resource)
	resource.queue_free()

func _register_all_resources() -> void:
	for child in get_children():
		if child is ObtainableResource:
			_register_resource(child)

func get_resource_by_type(type:ObtainableResourceType) -> ObtainableResource:
	for resource in registered_resources:
		if resource.type == type:
			return resource
	return
