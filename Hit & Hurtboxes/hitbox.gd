extends Area3D
class_name HitBox


var damage_instance:DamageInstance

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area:Area3D):
	print("I hit something")
	if area is HurtBox:
		area.get_hit(damage_instance)
