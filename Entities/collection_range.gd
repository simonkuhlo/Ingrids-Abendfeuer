extends Area3D

@export var inventory:PlayerInventory
@export var entity:GameEntity

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is CollectableCoin:
		inventory.add_coins(area.held_amount)
		area.get_picked_up(entity)
	elif area is CollectableItem:
		inventory.add_item(area.item, area.held_amount)
		area.get_picked_up(entity)
