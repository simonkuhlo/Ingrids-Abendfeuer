extends Label

@export var resource_to_watch:ObtainableResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(resource_to_watch.type.name) + ": " + str(resource_to_watch.current_value) + " / " + str(resource_to_watch.max_value)
