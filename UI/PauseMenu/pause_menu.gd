extends Control

var menuopen = false
@onready var currentlevel:LevelResource

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_resume_pressed() -> void:
	get_tree().paused = false
	$".".visible = false
	menuopen = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Pause")):
		if(menuopen):
			get_tree().paused = false
			$".".visible = false
			menuopen = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			get_tree().paused = true
			$".".visible = true
			menuopen = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_restart_pressed() -> void:
	GlobalData.load_level(currentlevel)

func _on_main_menu_pressed() -> void:
	GlobalData.call_main_menu()
