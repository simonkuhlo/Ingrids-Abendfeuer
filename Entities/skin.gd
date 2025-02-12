extends Node3D
class_name EntitySkin

@export var animation_player:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func walk():
	animation_player.play("Ingo")

func fly():
	pass

func idle():
	animation_player.stop()
