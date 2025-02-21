extends ActionBasic
class_name ActionPassive

func _on_ready_processing(delta) -> void:
	state.travel(state.preparing_state)

func _on_casting_processing(delta:float) -> void:
	_cast()

func _cast() -> void:
	print("Casting Testskill")
