@icon("res://addons/SimonsStateChart/Icons/StrExpression.svg")
extends ExpressionNode
class_name StringExpressionNode

@export var value:StringName = "":
	set(new_value):
		set_value(new_value)
	get():
		return get_value()

func set_value(new_value):
	_value = new_value
	super.set_value(new_value)
