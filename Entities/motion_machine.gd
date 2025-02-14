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
@export var air_acceleration:float = 5
## The friction while grounded
@export var ground_friction:float = 30
@export var ground_acceleration:float = 40
@export var gravity:float = 9.81

@export_subgroup("Camera")
@export var mouse_sensitivity:float = 1
@export var camera_tilt_upper_limit:float = PI / 3.0
@export var camera_tilt_lower_limit:float = -PI / 8.0

@export_group("Linking")
## The Camera3D associated with the controlled entity
@export var _camera:Camera3D
## The CameraPivot of the selected camera
@export var camera_pivot:Node3D
## The entity that should be controlled by this script
@export var controlled_entity:CharacterBody3D
@export var grounded_expression:BoolExpressionNode
@export var state_chart:StateChart
@export var body:EntitySkin
@export var compass:Node3D
@export var visualizer1:RayCast3D
@export var visualizer2:RayCast3D
@export var visualizer3:RayCast3D

## Input mode
var _aiming:bool = false
var _camera_input_direction:Vector2 = Vector2.ZERO

## The magnitude of Force that can be applied to the body by movement
var current_movement_strength:float = 1
var current_friction:float = 1

const friction_playerspeed_factor:float = 0.5

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
	visualizer1.target_position = controlled_entity.velocity
	controlled_entity.move_and_slide()

func _on_airborne_activated():
	acceleration = air_acceleration
	current_friction = air_friction

func _on_airborne_physics_processing(delta):
	var pull_force:Vector3 = Vector3.DOWN * gravity * delta
	apply_force(pull_force)
	_apply_movement(delta)
	if Input.is_action_just_pressed("dash"):
		state_chart.send_event("want_dash")

func _on_grounded_activated():
	controlled_entity.velocity.y = maxf(controlled_entity.velocity.y, 0)
	acceleration = ground_acceleration
	current_friction = ground_friction

func _on_normal_physics_processing(delta):
	_apply_movement(delta)
	if Input.is_action_just_pressed("jump"):
		state_chart.send_event("want_jump")
	if Input.is_action_just_pressed("dash"):
		state_chart.send_event("want_dash")

func _on_jump_activated():
	apply_force(Vector3.UP * jump_strength)

func _apply_friction(strength:float, delta:float):
	var friction:float = strength * delta
	friction += controlled_entity.velocity.length() * friction_playerspeed_factor * delta
	controlled_entity.velocity = controlled_entity.velocity.move_toward(Vector3.ZERO, friction)

func apply_force(force:Vector3):
	controlled_entity.velocity += force

func set_force(force:Vector3):
	controlled_entity.velocity = force

var _target_angle:float = 0
func _prepare_movement(delta) -> Vector3:
	var move_direction:Vector3 = Vector3.ZERO
	# Calculate movement input and align it to the camera's direction.
	var raw_input := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards" , 0.4)
	var forward:Vector3
	var right:Vector3
	# Should be projected onto the ground plane.
	forward = _camera.global_basis.z
	right = _camera.global_basis.x
	move_direction = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	if _aiming:
		_target_angle = Vector3.FORWARD.signed_angle_to(forward, Vector3.UP)
	else:
		# To not orient the character too abruptly, we filter movement inputs we
		# consider when turning the skin. This also ensures we have a normalized
		# direction for the rotation basis.
		if move_direction.length() > 0.2:
			var view_direction = move_direction.normalized()
			_target_angle = Vector3.BACK.signed_angle_to(view_direction, Vector3.UP)
	body.global_rotation.y = lerp_angle(body.rotation.y, _target_angle, turning_rate * delta)
	return move_direction

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
		body.walk()
	else:
		body.idle()

func _on_dashing_physics_processing(delta):
	controlled_entity.velocity = controlled_entity.global_transform.basis * Vector3.BACK * 30
