@icon("res://addons/SimonsExpressions/Icons/AnyExpression.svg")
extends Node
class_name ExpressionNode

signal expression_value_changed(new_value)

var _value

func get_value():
	return _value

func set_value(new_value):
	_value = new_value
	expression_value_changed.emit(new_value)
