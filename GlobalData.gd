extends Node

@onready var Inv_save_path = "user://inv_save.save"
@onready var Settings_save_path = "user://settings.save"

@onready var fullInv:PlayerInventory = preload("res://Inventory/inventory.gd").new()

@onready var MainMenuScene:PackedScene = load("res://MainMenu/MainMenu.tscn")

enum PlayState {MAINMENU, INLEVEL}
@onready var state:PlayState = PlayState.MAINMENU
@onready var currentScene:PackedScene = MainMenuScene

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
	LoadLevel(nextLevel)

func LoadLevel(levelToLoad:PackedScene):
	get_tree().paused = false
	state = PlayState.INLEVEL
	get_tree().change_scene_to_packed(levelToLoad)
	currentScene = levelToLoad

func load_inv_data():
	if FileAccess.file_exists(Inv_save_path):
		var file = FileAccess.open(Inv_save_path, FileAccess.READ)
		fullInv = file.get_var() as PlayerInventory
		print("Data loaded successfully")
	else:
		print("Error loading Data")
		
func CallMainMenu(SaveData:bool = false, temp_inv:PlayerInventory = preload("res://Inventory/inventory.gd").new()):
	get_tree().paused = false
	if(SaveData):
		mergeInventories(temp_inv)
		save_inv_data()
	get_tree().change_scene_to_packed(MainMenuScene)
	state = PlayState.MAINMENU

func RestartLevel():
	get_tree().paused = false
	get_tree().reload_current_scene()
