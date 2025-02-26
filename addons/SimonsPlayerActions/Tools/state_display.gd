extends Label

@export var action_to_watch:ActionInterface
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var current_text = get_current_text()
	if current_text != text:
		text = current_text

func get_current_text() -> StringName:
	var current_text:StringName = action_to_watch.name
	current_text += ": "
	current_text += action_to_watch.state.current_state.name
	return current_text
