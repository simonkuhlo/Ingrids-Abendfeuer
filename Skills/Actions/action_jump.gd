extends ActionOneshot

@export var jump_strength:float = 5

func _on_blocked_state_processing(delta) -> void:
	super._on_blocked_state_processing(delta)
	if entity.is_on_floor():
		state.travel(state.ready_state)

func _on_ready_state_processing(delta) -> void:
	if !entity.is_on_floor():
		state.travel(state.blocked_state)
		return
	super._on_ready_state_processing(delta)

func _cast():
	entity.motion_machine.apply_force(Vector3.UP * jump_strength)
