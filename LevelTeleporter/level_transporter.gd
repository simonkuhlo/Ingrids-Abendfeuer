extends Node3D

@export var nextLevel:LevelResource


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_class("CharacterBody3D")):
		GlobalData.ProccedToNextLevel(nextLevel, body.inventory)
