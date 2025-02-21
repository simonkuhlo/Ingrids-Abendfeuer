extends ActionActive
class_name ActionContinuous

@export var costs_per_second:Array[ObtainableResourceCost] = []

func _on_casting_state_processing(delta:float) -> void:
	if Input.is_action_pressed(trigger):
		if _apply_cost_per_second(delta):
			_cast()
		else:
			state.travel(state.missing_resource_state)
			return
	else:
		state.travel(state.cooldown_state)
		return

func _cast() -> void:
	print("Casting Testskill")

func _apply_cost_per_second(delta:float) -> bool:
	for cost in costs_per_second:
		if !_apply_resource_cost(cost, delta):
			return false
	return true
