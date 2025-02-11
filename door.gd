extends StaticBody3D

@export var required_item:GameItem

@export_group("Linking")
@export var interaction_area:Area3D
@export var expression_label:Label3D
@export var animation_player:AnimationPlayer

var is_open:bool = false
@onready var initial_rotation = rotation.y

func _physics_process(delta):
	var player = get_player_in_range()
	if player:
		expression_label.show()
		var camera = get_viewport().get_camera_3d()
		if camera:
			expression_label.look_at(camera.global_transform.origin, Vector3.UP)
		if Input.is_action_just_pressed("interact"):
			check_inventory(player.inventory)
	else:
		expression_label.hide()
	if is_open:
		rotation.y = lerp_angle(rotation.y, initial_rotation + deg_to_rad(90), delta * 10)
	else:
		rotation.y = lerp_angle(rotation.y, initial_rotation, delta * 10)

func get_player_in_range() -> Player:
	for body in interaction_area.get_overlapping_bodies():
		if body is Player:
			return body
	return null

func check_inventory(inventory:PlayerInventory):
	if inventory.has_item(required_item):
		open()

func check_key_item(item:GameItem):
	if item == required_item:
		open()

func open():
	is_open = !is_open
