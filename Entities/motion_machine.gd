extends Node
class_name MotionMachine

@export_group("Stats")
@export var jump_strength:float = 6
@export var max_move_speed:float = 10
@export var acceleration:float = 20
@export var turning_rate:float = 5

@export_group("Settings")
## The friction while airborne
@export var air_friction:float = 5
## The friction while grounded
@export var ground_friction:float = 30
@export var gravity:float = 9.81
@export_subgroup("Camera")
@export var mouse_sensitivity:float = 1
@export var camera_tilt_upper_limit:float = PI / 3.0
@export var camera_tilt_lower_limit:float = -PI / 8.0

@export_group("Linking")
## The Camera3D associated with the controlled entity
@export var camera:Camera3D
## The CameraPivot of the selected camera
@export var camera_pivot:Node3D
## The entity that should be controlled by this script
@export var controlled_entity:CharacterBody3D
@export var grounded_expression:BoolExpressionNode
@export var state_chart:StateChart
@export var body:Node3D
@export var compass:Node3D
@export var visualizer1:RayCast3D
@export var visualizer2:RayCast3D
@export var visualizer3:RayCast3D

## Input mode
var _aiming:bool = false
var _camera_input_direction:Vector2 = Vector2.ZERO

var previous_movement_velocity:Vector3 = Vector3.ZERO
var movement_velocity:Vector3 = Vector3.ZERO

@onready var current_movement_strength:float = 1
@onready var current_friction:float = 1

func _unhandled_input(event: InputEvent) -> void:
	var player_is_using_mouse := (
		event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if player_is_using_mouse:
		_camera_input_direction.x = -event.relative.x * mouse_sensitivity
		_camera_input_direction.y = event.relative.y * mouse_sensitivity

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("aim"):
		_aiming = true
	else:
		_aiming = false
	camera_pivot.rotation.x += _camera_input_direction.y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, camera_tilt_lower_limit, camera_tilt_upper_limit)
	camera_pivot.rotation.y += _camera_input_direction.x * delta
	_camera_input_direction = Vector2.ZERO
	grounded_expression.value = controlled_entity.is_on_floor()
	_apply_friction(current_friction, delta)
	_apply_movement(delta)
	visualizer1.target_position = controlled_entity.velocity
	controlled_entity.move_and_slide()

func _on_airborne_activated():
	acceleration = 5
	current_friction = air_friction
	apply_force(movement_velocity)

func _on_airborne_physics_processing(delta):
	var pull_force:Vector3 = Vector3.DOWN * gravity * delta
	apply_force(pull_force)

func _on_grounded_activated():
	controlled_entity.velocity.y = maxf(controlled_entity.velocity.y, 0)
	acceleration = 40
	current_friction = ground_friction

func _on_normal_physics_processing(delta):
	if Input.is_action_just_pressed("jump") and grounded_expression.value:
		state_chart.send_event("want_jump")

func _on_jump_activated():
	apply_force(Vector3.UP * jump_strength)

func _apply_friction(strength:float, delta:float):
	var friction:float = strength * delta
	friction += controlled_entity.velocity.length() * 0.01 * delta
	controlled_entity.velocity = controlled_entity.velocity.move_toward(Vector3.ZERO, friction)

func apply_force(force:Vector3):
	controlled_entity.velocity += force

func set_force(force:Vector3):
	movement_velocity = Vector3.ZERO
	previous_movement_velocity = Vector3.ZERO
	controlled_entity.velocity = force

func _prepare_movement(delta) -> Vector3:
	var input_vector:Vector2 = Input.get_vector("move_right", "move_left", "move_backwards",  "move_forwards") 
	var direction:Vector3
	if _aiming:
		body.rotation.y = lerp_angle(body.rotation.y, 0, turning_rate * delta)
		controlled_entity.global_rotation.y = lerp_angle(controlled_entity.global_rotation.y, camera_pivot.global_rotation.y, turning_rate * delta)
		direction = (controlled_entity.transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	else:
		direction = (camera_pivot.transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
		if input_vector:
			compass.look_at(compass.global_transform.origin + direction)
			body.rotation.y = lerp_angle(body.rotation.y, compass.rotation.y - deg_to_rad(180), turning_rate * delta)
	visualizer3.target_position = direction
	direction.y = 0
	return direction

func _apply_movement(delta):
	var direction = _prepare_movement(delta)
	if direction:
		var current_velocity:Vector3 = controlled_entity.velocity
		var next_velocity:Vector3 = current_velocity
		for i in range(3): # x, y, z
			if direction[i]:
				if sign(current_velocity[i]) == sign(direction[i]): # Same direction
					if abs(current_velocity[i]) < abs(max_move_speed):
						next_velocity[i] = move_toward(current_velocity[i], direction[i] * max_move_speed * current_movement_strength, acceleration * delta)
				else: # Opposite directions
					next_velocity[i] = move_toward(current_velocity[i], direction[i] * max_move_speed * current_movement_strength, acceleration * delta)
		controlled_entity.velocity = next_velocity
