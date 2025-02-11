extends Label

@export var inventory:PlayerInventory
@export var active:bool = false
var old_amount:int = 0


func _ready():
	if active:
		self.text = "Coins: " + str(inventory.coins)

func _process(delta):
	if active:
		if inventory.coins != old_amount:
			self.text = "Coins: " + str(inventory.coins)
			old_amount = inventory.coins
