@icon("res://StateChartLib/Icons/BoolExpression.svg")
extends ExpressionNode
class_name BoolExpressionNode

@export var value:bool:
	set(new_value):
		set_value(new_value)
	get():
		if !get_value():
			return false
		return get_value()

func set_value(new_value):
	_value = new_value
	super.set_value(new_value)
