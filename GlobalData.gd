extends Node

@onready var Inv_save_path = "user://inv_save.save"
@onready var Settings_save_path = "user://settings.save"

@onready var fullInv:PlayerInventory = preload("res://Inventory/inventory.gd").new()

@onready var MainMenuScene = load("res://MainMenu/MainMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_inv_data()

func save_inv_data():
	var file = FileAccess.open(Inv_save_path, FileAccess.WRITE)
	file.store_var(fullInv)
	print("Inventory save")
	
func mergeInventories(Inv: PlayerInventory):
	for i in Inv.inventory:
		fullInv.add_item(i.item, i.amount)
	
func ProccedToNextLevel(nextLevel:PackedScene, InventoryData: PlayerInventory):
	mergeInventories(InventoryData)
	save_inv_data()
	print(get_tree().change_scene_to_packed(nextLevel))
	
func load_inv_data():
	if FileAccess.file_exists(Inv_save_path):
		var file = FileAccess.open(Inv_save_path, FileAccess.READ)
		fullInv = file.get_var() as PlayerInventory
		print("Data loaded successfully")
	else:
		print("Error loading Data")
		
func CallMainMenu(SaveData:bool = false, temp_inv:PlayerInventory = preload("res://Inventory/inventory.gd").new()):
	if(SaveData):
		mergeInventories(temp_inv)
		save_inv_data()
	get_tree().change_scene_to_packed(MainMenuScene)
