extends Node3D

var mouse_modes:Array = [Input.MOUSE_MODE_CAPTURED, Input.MOUSE_MODE_VISIBLE]
var mouse_caught:bool = true

func _ready():
	if mouse_caught:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		mouse_caught = !mouse_caught
		if mouse_caught:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
