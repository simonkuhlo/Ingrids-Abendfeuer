extends Button

@export var sceneToLoad: PackedScene

func _on_button_down() -> void:
	GlobalData.LoadLevel(sceneToLoad)
