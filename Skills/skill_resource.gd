extends Resource
class_name SkillResource

@export var name:StringName
## Cooldown in seconds
@export var cooldown:float
## How long it takes to cast the skill in seconds
@export var cast_time:float

@export_group("Charges")
## How many charges can be stored at once
@export var charges:int = 1
@export var cooldown_between_charges:float
@export var reload_charges_per_cooldown:int = 1

@export_group("")
## Array of resources that are needed to cast the skill
@export var costs:Array[PlayerResourceCost]

enum CastMode {ONESHOT, TOGGLE, CONTINUOUS}
@export var cast_mode:CastMode = CastMode.ONESHOT

@export var instance:PackedScene
