extends Button
class_name LevelLoadButton

@export var level_to_load: LevelResource
@export_group("Linking")
@export var name_label:Label
@export var texture_rect:TextureRect

func _ready():
	pressed.connect(_on_pressed)
	if level_to_load:
		name_label.text = level_to_load.name
		if level_to_load.preview_image:
			texture_rect.texture = level_to_load.preview_image
			
func _on_pressed() -> void:
	GlobalData.load_level(level_to_load)
