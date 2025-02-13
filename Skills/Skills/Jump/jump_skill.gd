extends SkillInstance

@export var jump_strength:float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caster.motion_machine.apply_force(Vector3.UP * jump_strength)
	end_skill()
