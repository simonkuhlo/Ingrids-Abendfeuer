extends Resource
class_name SkillResource

@export var name:StringName
## Cooldown in seconds
@export var cooldown:float
## How long it takes to cast the skill in seconds
@export var cast_time:float
## Array of resources that are needed to cast the skill
@export var costs:Array[PlayerResourceCost]

enum CastMode {ONESHOT, TOGGLE, CONTINUOUS}
@export var cast_mode:CastMode = CastMode.ONESHOT

@export var instance:PackedScene
