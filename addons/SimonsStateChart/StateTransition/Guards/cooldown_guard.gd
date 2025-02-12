@icon("res://addons/SimonsStateChart/Icons/ActiveStateGuard.svg")
@tool
extends TransitionGuard
class_name CooldownGuard

@export var cooldown_seconds:float = 0: 
	set(seconds):
		cooldown_seconds = seconds
		update_configuration_warnings()

var timer:Timer = Timer.new()

func _ready():
	if !Engine.is_editor_hint():
		timer.autostart = false
		timer.one_shot = true
		timer.wait_time = cooldown_seconds
		add_child(timer)
	var parent_transition = get_parent()
	if parent_transition is StateTransition:
		parent_transition.transition_taken.connect(_on_transition_taken)

func _on_transition_taken():
	timer.start()

func is_statisfied() -> bool:
	if timer.is_stopped():
		return true
	return false

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	return warnings
