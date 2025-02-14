extends Node
class_name SkillSlot

## Holds a skill instance and lets it interact with the player

## The input that triggers interaction with this slot
@export var trigger:StringName

## The Resource of the skill in this slot
@export var resource:SkillResource

## The Player that owns this slot
@export var player:Player

func _ready():
	var instance:SkillInstance = resource.instance.instantiate()
	instance.owning_player = player
	instance.trigger = trigger
	instance.resource = resource
	add_child(instance)
