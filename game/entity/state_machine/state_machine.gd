class_name StateMachine
extends Node


@export var initial_state: NodePath
@onready var current_state: State = get_node(initial_state)

var states := {}


# Initialize state machine
func _ready() -> void:
	await owner.ready
	
	for state in get_children():
		if state is State:
			states[state.state_id] = state
			state.transition_requested.connect(_on_transition_requested)
	
	current_state._enter()


# Calls _process for the currewnt state
func _process(delta: float) -> void:
	current_state._state_process(delta)


# Calls _physics_process for the currewnt state
func _physics_process(delta: float) -> void:
	current_state._state_physics_process(delta)


# Handles transition requests
func _on_transition_requested(new_state_name: StringName, message := {}) -> void:
	var new_state: State = states.get(new_state_name)
	
	if new_state != null:
		if new_state != current_state:
			current_state._exit()
			new_state._enter(message)
			current_state = new_state