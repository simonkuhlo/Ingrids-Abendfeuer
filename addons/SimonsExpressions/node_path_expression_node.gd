@icon("res://addons/SimonsExpressions/Icons/NodePathExpression.svg")
extends ExpressionNode
class_name NodePathExpressionNode

@export var value:NodePath:
	set(new_value):
		set_value(new_value)
	get():
		return get_value()

func set_value(new_value):
	_value = new_value
	super.set_value(new_value)
