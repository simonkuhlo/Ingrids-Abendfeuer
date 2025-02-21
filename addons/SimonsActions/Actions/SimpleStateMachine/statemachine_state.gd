class_name StateMachineState

signal state_entered
signal physics_processing(delta:float)
signal state_exited

var name:StringName

func _init(new_name:StringName = "None"):
	name = new_name
