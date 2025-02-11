extends Label

@export var inventory:PlayerInventory
@export var active:bool = false

var old_amount:int = 0

#TODO Make this work with coins as inventoryitem

func _ready():
	pass
	if active:
		self.text = "Coins: " + str(inventory.coins)

func _process(delta):
	pass
	if active:
		if inventory.coins != old_amount:
			self.text = "Coins: " + str(inventory.coins)
			old_amount = inventory.coins
