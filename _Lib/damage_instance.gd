class_name DamageInstance

var source:GameEntity
var damage:float

func _init(new_source:GameEntity, new_damage:float = 0):
	source = new_source
	damage = new_damage
