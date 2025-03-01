@icon("res://addons/SimonsExpressions/Icons/NumericExpression.svg")
extends ExpressionNode
class_name NumericalExpressionNode

@export var value:float = 0:
	set(new_value):
		set_value(new_value)
	get():
		return get_value()

@export var max_value:float
@export var min_value:float

func set_value(new_value) -> void:
	if max_value:
		if new_value > max_value:
			new_value = max_value
	if min_value:
		if new_value < min_value:
			new_value = min_value
	super.set_value(new_value)
