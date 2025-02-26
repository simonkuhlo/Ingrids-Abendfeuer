extends ActionActive
class_name ActionToggle

@export var costs_per_second:Array[ObtainableResourceCost] = []

func _on_casting_state_processing(delta:float) -> void:
	if _apply_cost_per_second(delta):
		_cast()
	else:
		state.travel(state.missing_resource_state)
	if Input.is_action_just_pressed(trigger):
		state.travel(state.cooldown_state)

func _cast() -> void:
	print("Casting Testskill")

func _apply_cost_per_second(delta:float) -> bool:
	for cost in costs_per_second:
		var entity_resource:ObtainableResource = entity.resources.get_resource_by_type(cost.type)
		if !entity_resource:
			return false
		if entity_resource.current_value < cost.amount * delta:
			return false
		entity_resource.current_value -= cost.amount * delta
	return true
