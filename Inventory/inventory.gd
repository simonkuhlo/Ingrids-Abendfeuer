extends Node
class_name PlayerInventory


var coins:int = 0
var inventory:Array[GameItemContainer] = []


func add_coins(amount:int):
	coins += amount

func add_item(item:GameItem, amount:int):
	var existing_container = _get_item_container(item)
	if existing_container:
		existing_container.amount += amount
	else:
		var container = GameItemContainer.new(item, amount)
		inventory.append(container)

func take_item(item:GameItem, amount:int) -> GameItemContainer:
	var existing_container = _get_item_container(item)
	if existing_container:
		var returned_container:GameItemContainer
		if amount < existing_container.amount:
			existing_container.amount -= amount
			returned_container = GameItemContainer.new(item, amount)
			return returned_container
		else:
			returned_container = existing_container
			inventory.erase(existing_container)
			return returned_container
	return null

func _get_item_container(item:GameItem) -> GameItemContainer:
	for container in inventory:
		if container.item == item:
			return container
	return null

func has_item(item:GameItem) -> bool:
	for container in inventory:
		if container.item == item:
			return true
	return false
