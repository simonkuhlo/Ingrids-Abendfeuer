extends Button
class_name LevelLoadButton

@export var level_to_load: LevelResource

func _init(level:LevelResource = level_to_load):
	level_to_load = level
	if level_to_load:
		text = level_to_load.name

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	GlobalData.load_level(level_to_load)
