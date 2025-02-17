extends Control

@export var listed_levels:Array[LevelResource] = []

@export var level_list:Container
@export var level_load_button_scene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for level in listed_levels:
		var button_instance:LevelLoadButton = level_load_button_scene.instantiate()
		button_instance.level_to_load = level
		level_list.add_child(button_instance)
