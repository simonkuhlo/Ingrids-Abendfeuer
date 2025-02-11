extends Label

@export var inventory:PlayerInventory
@export var active:bool = false

@export var coin_item:GameItem

var old_amount:int = 0

func _ready():
	if active:
		self.text = "Coins: " + str(get_current_coin_amount())

func _process(delta):
	if active:
		var coins = get_current_coin_amount()
		if coins != old_amount:
			self.text = "Coins: " + str(coins)
			old_amount = coins

func get_current_coin_amount() -> int:
	var item_container:GameItemContainer = inventory.get_item_container(coin_item)
	if item_container:
		return item_container.amount
	return 0
