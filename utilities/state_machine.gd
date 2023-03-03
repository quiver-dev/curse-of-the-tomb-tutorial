extends Node
class_name StateMachine


var states = {}
var current_state = null
var previous_state = null
var host = null


func initialize(host, initial_state):
	self.host = host

	if initial_state != null:
		set_state(initial_state)


func add_state(key, node):
	states[key] = node


func set_state(new_state):
	if not states.has(new_state):
		print("State machine does not have state %s" % new_state)
		return

	previous_state = current_state
	current_state = new_state

	if previous_state != null:
		states[previous_state]._exit(new_state, host)

	if current_state != null:
		states[current_state]._enter(previous_state, host)


func _physics_process(delta: float) -> void:
	if current_state == null:
		return

	states[current_state]._execute(delta, host)

	var next_state = states[current_state]._get_next_state(host)
	if next_state != null:
		set_state(next_state)
