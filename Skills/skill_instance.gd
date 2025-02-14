extends Node
class_name SkillInstance

@export var owning_player:Player
@export var trigger:StringName
@export var resource:SkillResource

## The current cooldown of the Spell
var cooldown_timer:Timer = Timer.new()
var cast_timer:Timer = Timer.new()


enum ReadyState {READY, ON_COOLDOWN, NO_RESOURCE, BLOCKED, CASTING}
## If the Spell currently is ready to cast or not
var ready_state:ReadyState = ReadyState.BLOCKED

func ready() -> void:
	cooldown_timer.autostart = false
	cooldown_timer.one_shot = true
	cast_timer.autostart = false
	cast_timer.one_shot = true
	add_child(cooldown_timer)
	add_child(cast_timer)
	if resource:
		cooldown_timer.wait_time = resource.cooldown
		cast_timer.wait_time = resource.cooldown

func _physics_process(delta: float) -> void:
	ready_state = get_ready_state()
	if ready_state == ReadyState.READY:
		if Input.is_action_just_pressed(trigger):
			cast_skill()

func get_ready_state() -> ReadyState:
	if !cooldown_timer.is_stopped():
		return ReadyState.ON_COOLDOWN
	else:
		for cost in resource.costs:
			var player_resource:PlayerResourceInstance = owning_player.resources.get_resource(cost.resource)
			if !player_resource:
				return ReadyState.NO_RESOURCE
			if resource.amount < cost.cost:
				return ReadyState.NO_RESOURCE
		return ReadyState.READY

func cast_skill():
	owning_player.motion_machine.apply_force(Vector3.UP * 5)
