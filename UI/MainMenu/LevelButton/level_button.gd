extends Button

@export var sceneToLoad: LevelResource

func _on_button_down() -> void:
	GlobalData.load_level(sceneToLoad)
