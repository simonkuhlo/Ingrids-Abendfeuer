extends Control

@export var state_to_watch:StateChartState

@onready var tab_container = $VBoxContainer/TabContainer


func _on_button_pressed():
	tab_container.visible = !tab_container.visible
