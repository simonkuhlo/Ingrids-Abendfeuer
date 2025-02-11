extends Area3D
class_name HurtBox

signal got_hit(damage:DamageInstance)

func get_hit(damage_instance:DamageInstance) -> void:
	got_hit.emit(damage_instance)
