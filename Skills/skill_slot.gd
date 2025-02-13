extends Node
class_name SkillSlot

## Holds a skill instance and lets it interact with the player

## The input that triggers interaction with this slot
@export var trigger:StringName

## The Resource of the skill in this slot
@export var resource:SkillResource

## The Player that owns this slot
@export var player:Player

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
			var player_resource:PlayerResourceInstance = player.resources.get_resource(cost.resource)
			if !player_resource:
				return ReadyState.NO_RESOURCE
			if resource.amount < cost.cost:
				return ReadyState.NO_RESOURCE
		return ReadyState.READY

func cast_skill():
	var skill_instance:SkillInstance = resource.instance.instantiate()
	skill_instance.caster = player
	player.skill_instances.add_child(skill_instance)
