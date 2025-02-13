extends Resource
class_name SkillResource

@export var name:StringName
@export var cooldown:float
@export var costs:Array[PlayerResourceCost]

enum CastMode {ONESHOT, TOGGLE, CONTINUOUS}
@export var cast_mode:CastMode = CastMode.ONESHOT

@export var instance:PackedScene
