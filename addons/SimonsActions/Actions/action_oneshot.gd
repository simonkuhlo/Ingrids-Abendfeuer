extends ActionActive
class_name ActionOneshot

func _on_casting_state_entered() -> void:
	_cast()
	state.travel(state.cooldown_state)

func _cast() -> void:
	print("Casting Testskill")
