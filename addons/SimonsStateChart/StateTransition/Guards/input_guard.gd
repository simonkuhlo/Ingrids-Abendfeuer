@icon("res://addons/SimonsStateChart/Icons/ActiveStateGuard.svg")
@tool
extends TransitionGuard
class_name InputGuard

@export var input_name:StringName

enum check_type {PHYSICS_PROCESS, PROCESS, TICK}
@export var check_during:check_type = check_type.TICK

@export var hold_allowed:bool = false

var input_active:bool

func _ready():
	pass

func _process(delta):
	if check_during == check_type.PROCESS:
		check_input_active()

func _physics_process(delta):
	if check_during == check_type.PHYSICS_PROCESS:
		check_input_active()

func is_statisfied() -> bool:
	if check_during == check_type.TICK:
		check_input_active()
	return input_active

func check_input_active() -> void:
	if hold_allowed:
		input_active = Input.is_action_pressed(input_name)
	else:
		input_active = Input.is_action_just_pressed(input_name)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	return warnings
