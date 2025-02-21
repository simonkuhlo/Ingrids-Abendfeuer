extends ActionBasic
class_name ActionActive

@export var trigger:StringName

func _on_ready_state_processing(delta):
	super._on_ready_state_processing(delta)
	if Input.is_action_just_pressed(trigger):
		state.travel(state.preparing_state)

func _on_preparing_state_processing(delta):
	if Input.is_action_pressed(trigger):
		super._on_preparing_state_processing(delta)
	else:
		state.travel(state.ready_state)
