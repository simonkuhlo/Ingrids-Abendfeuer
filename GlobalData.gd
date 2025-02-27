extends Node

#Save Paths for Inventory and Settings
var Inv_save_path = "user://inv_save.save"
var Settings_save_path = "user://settings.save"

#Globally existent PlayerInventory
var fullInv:PlayerInventory = PlayerInventory.new()


@export_group("Ui Elements")
#MainMenu preload
@export var MainMenuScene:PackedScene
#PauseMenu preload
@export var PauseMenu:PackedScene

#Current Playstate
enum PlayState {MAINMENU, INLEVEL}
var state:PlayState = PlayState.MAINMENU
var currentScenePacked:PackedScene = MainMenuScene

func _ready() -> void:
	load_inv_data()

#save current global PlayerInventory to the safefile
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

#Adds all items from the given inventory to the global inventory
func merge_inventories(Inv: PlayerInventory):
	for i in Inv.inventory:
		fullInv.add_item(i.item, i.amount)

#Loads the given Level and safes the Inventory globally
func change_level(nextLevel:LevelResource, InventoryData: PlayerInventory):
	merge_inventories(InventoryData)
	save_inv_data()
	load_level(nextLevel)

#Loads a given Level without saving any data
func load_level(levelToLoad:LevelResource):
	get_tree().paused = false
	state = PlayState.INLEVEL
	get_tree().change_scene_to_packed(levelToLoad.scene)
	currentScenePacked = levelToLoad.scene
	await get_tree().process_frame #wait two frames to ensure the scene has actually been loaded
	await get_tree().process_frame
	var pm = PauseMenu.instantiate()
	pm.currentlevel = levelToLoad
	get_tree().get_current_scene().add_child(pm)

#Loads The MainMenu back Up (Optionally saves a given inventory to the global inventory)
func call_main_menu(SaveData:bool = false, temp_inv:PlayerInventory = preload("res://Inventory/inventory.gd").new()):
	get_tree().paused = false
	if(SaveData):
		merge_inventories(temp_inv)
		save_inv_data()
	get_tree().change_scene_to_packed(MainMenuScene)
	currentScenePacked = MainMenuScene
	state = PlayState.MAINMENU
