extends Node

#Save Paths for Inventory and Settings
@onready var Inv_save_path = "user://inv_save.save"
@onready var Settings_save_path = "user://settings.save"

#Globally existent PlayerInventory
@onready var fullInv:PlayerInventory = PlayerInventory.new()

#MainMenu preload
@onready var MainMenuScene:PackedScene = load("res://UI/MainMenu/MainMenu.tscn")

#PauseMenu preload
@onready var PauseMenu:PackedScene = load("res://UI/PauseMenu/PauseMenu.tscn")

#Current Playerstate
enum PlayState {MAINMENU, INLEVEL}
@onready var state:PlayState = PlayState.MAINMENU
@onready var currentScenePacked:PackedScene = MainMenuScene

func _ready() -> void:
	load_inv_data()

#save the current Global PlayerInventory to the safefile
func save_inv_data():
	var file = FileAccess.open(Inv_save_path, FileAccess.WRITE)
	file.store_var(fullInv)
	print("Inventory save")
	
#Loads Inventory data from Savefiles
func load_inv_data():
	if FileAccess.file_exists(Inv_save_path):
		var file = FileAccess.open(Inv_save_path, FileAccess.READ)
		fullInv = file.get_var() as PlayerInventory
		print("Data loaded successfully")
	else:
		print("Error loading Data")

#Adds the Items fron the given Inventory to the Global Inventory
func mergeInventories(Inv: PlayerInventory):
	for i in Inv.inventory:
		fullInv.add_item(i.item, i.amount)

#Loads the givenLevel and safes the Inventory globally
func ProccedToNextLevel(nextLevel:PackedScene, InventoryData: PlayerInventory):
	mergeInventories(InventoryData)
	save_inv_data()
	LoadLevel(nextLevel)

#Loads a given Level without saving any data
func LoadLevel(levelToLoad:PackedScene):
	get_tree().paused = false
	state = PlayState.INLEVEL
	get_tree().change_scene_to_packed(levelToLoad)
	currentScenePacked = levelToLoad
	await get_tree().process_frame #wait to frames to ensure the scene has actually been loaded
	await get_tree().process_frame
	var pm = PauseMenu.instantiate()
	pm.currentlevel = levelToLoad
	get_tree().get_current_scene().add_child(pm)

#Loads The MainMenu back Up (Optionaly saves an given Inventory to the global Inventory)
func CallMainMenu(SaveData:bool = false, temp_inv:PlayerInventory = preload("res://Inventory/inventory.gd").new()):
	get_tree().paused = false
	if(SaveData):
		mergeInventories(temp_inv)
		save_inv_data()
	get_tree().change_scene_to_packed(MainMenuScene)
	currentScenePacked = MainMenuScene
	state = PlayState.MAINMENU

#Restarts current Level
func RestartLevel():
	get_tree().paused = false
	get_tree().reload_current_scene()
