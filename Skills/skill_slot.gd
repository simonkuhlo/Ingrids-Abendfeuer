extends Node
class_name SkillSlot

## Holds a skill instance and lets it interact with the player

## The input that triggers interaction with this slot
@export var trigger:StringName

## The Resource of the skill in this slot
@export var resource:SkillResource
## The instance of the skill in this slot
@onready var instance:SkillInstance
