extends Node
class_name ObtainableResource

@export var type:ObtainableResourceType
@export var min_value:float = 0:
	set(new_value):
		if new_value > min_value:
			push_error("min_value must be smaller than max_value")
			return
		min_value = new_value
@export var max_value:float = 10:
	set(new_value):
		if new_value < min_value:
			push_error("max_value must be bigger than min_value")
			return
		max_value = new_value
@export var default_value:float = 1:
	set(new_value):
		if new_value >= max_value:
			default_value = max_value
			max_value_reached.emit()
		if new_value <= min_value:
			default_value = min_value
			min_value_reached.emit()
		default_value = new_value
		value_changed.emit()
@export var regen_per_second:float = 0
var current_value:float = 1:
	set(new_value):
		current_value = round(clampf(new_value, min_value, max_value)*100) / 100
		if current_value == max_value:
			max_value_reached.emit()
		if new_value == min_value:
			min_value_reached.emit()
		value_changed.emit()

## Emitted when current_value reaches the max_value
signal max_value_reached
## Emitted when current_value reaches the min_value
signal min_value_reached
## Emitted when current_value changes
signal value_changed

var timer = Timer.new()

func _ready() -> void:
	current_value = default_value
	timer.wait_time = 0.1
	timer.timeout.connect(_regenerate)
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)

func _regenerate():
	if current_value < max_value:
		current_value += regen_per_second / 10

## Tries to substract a given amount from the current amount. Returns true if successful.
func consume(amount:float) -> bool:
	if current_value - amount < min_value:
		return false
	current_value -= amount
	return true

## Returns true if the Resource currently has the given amount or more
func has_amount(amount:float) -> bool:
	if current_value - amount < min_value:
		return false
	return true
