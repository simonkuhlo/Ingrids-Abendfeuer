extends ActionInterface
class_name ActionBasic

func _setup_states():
	state.blocked_state.state_entered.connect(_on_blocked_state_entered)
	state.blocked_state.physics_processing.connect(_on_blocked_state_processing)
	state.blocked_state.state_exited.connect(_on_blocked_state_exited)

	state.casting_state.state_entered.connect(_on_casting_state_entered)
	state.casting_state.physics_processing.connect(_on_casting_state_processing)
	state.casting_state.state_exited.connect(_on_casting_state_exited)

	state.cooldown_state.state_entered.connect(_on_cooldown_state_entered)
	state.cooldown_state.physics_processing.connect(_on_cooldown_state_processing)
	state.cooldown_state.state_exited.connect(_on_cooldown_state_exited)

	state.missing_resource_state.state_entered.connect(_on_missing_resource_state_entered)
	state.missing_resource_state.physics_processing.connect(_on_missing_resource_state_processing)
	state.missing_resource_state.state_exited.connect(_on_missing_resource_state_exited)

	state.preparing_state.state_entered.connect(_on_preparing_state_entered)
	state.preparing_state.physics_processing.connect(_on_preparing_state_processing)
	state.preparing_state.state_exited.connect(_on_preparing_state_exited)

	state.ready_state.state_entered.connect(_on_ready_state_entered)
	state.ready_state.physics_processing.connect(_on_ready_state_processing)
	state.ready_state.state_exited.connect(_on_ready_state_exited)

func _on_blocked_state_entered():
	pass

func _on_blocked_state_processing(delta):
	pass

func _on_blocked_state_exited():
	pass


func _on_casting_state_entered():
	pass

func _on_casting_state_processing(delta):
	pass

func _on_casting_state_exited():
	pass


func _on_cooldown_state_entered():
	if cooldown:
		cooldown_timer.start(cooldown)
	else:
		state.travel(state.ready_state)
		return

func _on_cooldown_state_processing(delta):
	pass

func _on_cooldown_state_exited():
	pass


func _on_missing_resource_state_entered():
	pass

func _on_missing_resource_state_processing(delta):
	for cost in costs:
		if !_check_resource_cost(cost):
			return
	state.travel(state.ready_state)

func _on_missing_resource_state_exited():
	pass


var prepare_time_left:float = 0
func _on_preparing_state_entered():
	for cost in costs:
		if !_apply_resource_cost(cost):
			state.travel(state.missing_resource_state)
			return
	if prepare_time:
		prepare_time_left = prepare_time
	else:
		state.travel(state.casting_state)
		return

func _on_preparing_state_processing(delta):
	prepare_time_left -= delta
	if prepare_time_left <= 0:
		state.travel(state.casting_state)
		return

func _on_preparing_state_exited():
	pass


func _on_ready_state_entered():
	pass

func _on_ready_state_processing(delta):
	for cost in costs:
		if !_check_resource_cost(cost):
			state.travel(state.missing_resource_state)
			return

func _on_ready_state_exited():
	pass
