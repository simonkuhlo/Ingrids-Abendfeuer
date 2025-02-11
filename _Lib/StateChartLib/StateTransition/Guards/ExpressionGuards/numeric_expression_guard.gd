@icon("res://_Lib/StateChartLib/Icons/TransitionGuard.svg")
@tool
extends TransitionGuard
class_name NumericExpressionGuard

@export var expression: NumericalExpressionNode
enum SYMBOL {
	IS,
	IS_NOT,
	GREATER,
	GREATER_OR_EQUAL,
	LESSER,
	LESSER_OR_EQUAL
}
@export var symbol: SYMBOL
@export var compare_value: float

func is_statisfied() -> bool:
	if not expression:
		push_warning("NumericExpressionGuard: No expression set")
		return false
	
	var current_value = expression.value
	
	match symbol:
		SYMBOL.IS:
			return is_equal_approx(current_value, compare_value)
		SYMBOL.IS_NOT:
			return not is_equal_approx(current_value, compare_value)
		SYMBOL.GREATER:
			return current_value > compare_value
		SYMBOL.GREATER_OR_EQUAL:
			return current_value >= compare_value
		SYMBOL.LESSER:
			return current_value < compare_value
		SYMBOL.LESSER_OR_EQUAL:
			print(current_value <= compare_value)
			return current_value <= compare_value
		_:
			push_warning("NumericExpressionGuard: Invalid symbol")
			return false

func _get_configuration_warning() -> String:
	if not expression:
		return "No NumericalExpressionNode set"
	return ""
