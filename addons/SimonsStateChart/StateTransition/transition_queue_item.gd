extends Node
class_name TransitionQueueItem

signal transition_ready(transition:StateTransition)

var transition:StateTransition
var timer:Timer = Timer.new()

func _init(new_transition):
	transition = new_transition

func _ready():
	if transition.delay_seconds > 0:
		timer.one_shot = true
		timer.wait_time = transition.delay_seconds
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()
	else:
		_on_timer_timeout()

func _on_timer_timeout():
	emit_signal("transition_ready", self)
