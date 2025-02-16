extends Button

@export var sceneToLoad: PackedScene

func _on_button_down() -> void:
	get_tree().change_scene_to_packed(sceneToLoad)
