@tool
extends Area3D
class_name CollectableItem

@export var held_amount:int = 1
@export var item:GameItem

@export var rotation_speed:float = 1
var body:Node3D

func _ready():
	if item:
		body = item.visual_instance.instantiate()
		body.scale = scale
		add_child(body)
	else:
		if !Engine.is_editor_hint():
			# If it holds no item, delete
			queue_free()

func _physics_process(delta):
	if !Engine.is_editor_hint():
		body.rotate_y(deg_to_rad(360 * rotation_speed) * delta)

func get_picked_up(collector:GameEntity):
	set_deferred("monitorable", false)
	remove_child(body)
	var instance:CollectAnimation = CollectAnimation.new(collector)
	instance.add_child(body)
	instance.global_transform = global_transform
	get_tree().root.add_child(instance)
	queue_free()
