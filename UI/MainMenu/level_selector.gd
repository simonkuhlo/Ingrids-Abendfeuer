extends Control

@export var listed_levels:Array[LevelResource] = []
@export var level_button_scene:PackedScene

@export var level_list:Container

# Called when the node enters the scene tree for the first time.
func _ready():
	for level in listed_levels:
		var button_instance = LevelLoadButton.new(level)
		level_list.add_child(button_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
