extends Component
class_name MotionComponent
## Allows the actor to behave like a character, with a state machine for motion.

var me:CharacterBody2D = get_me()
func _init() -> void:
	component_id = "Motion"

# Allows the motioncomponent to be overridden by any node
var overrider:Node = null

# The direction the actor is assumed to be facing, false for left, true for right.
var direction:bool 

# All the motion states
@onready var motion_states:Array[MotionState] = get_motion_states()
func get_motion_states() -> Array[MotionState]:
	var states:Array[MotionState]
	
	for child in get_children():
		if child is MotionState:
			states.append(child)
	
	return states
# All the subcomponents, minus the states.
@onready var motion_sub_components:Array[MotionSubComponent] = get_motion_sub_components()
func get_motion_sub_components() -> Array[MotionSubComponent]:
	var states:Array[MotionSubComponent]
	
	for child in get_children():
		if child is MotionSubComponent and child is not MotionState:
			states.append(child)
	
	return states

## The state the machine starts on.
@export var initial_state:MotionState
# The current state
var current_state:MotionState

# Change the current state
func change_state(to:MotionState):
	if current_state != null:
		current_state.on_inactive()
		current_state.became_inactive.emit()
		current_state.is_current_state = false
	
	current_state = to
	
	current_state.on_active()
	current_state.became_active.emit()
	current_state.is_current_state = true

func _ready() -> void:
	if initial_state != null:
		change_state(initial_state)
	elif len(motion_states) > 0:
		change_state(motion_states[0])

func _process(delta: float) -> void:
	# Run each state's applicable function for processing
	for state in motion_states:
		if state == current_state:
			state.active(delta)
			
			# Manage all the active dynamic state-switching handles
			for handle in state.switch_handles.keys():
				if handle is DynamicValue: # It is, INTELLISENSE.
					if handle.value():
						change_state(state.switch_handles[handle])
		else:
			state.inactive(delta)
	for component in motion_sub_components:
		component.active(delta)

func _physics_process(delta: float) -> void:
	# Run each state's applicable function for physics
	
	if overrider == null:
		for state in motion_states:
			if state == current_state:
				state.phys_active(delta)
			else:
				state.phys_inactive(delta)
		
		for component in motion_sub_components:
			component.phys_active(delta)
	
	# Move & slide
	me.move_and_slide()
	
	if overrider == null:
		for state in motion_states:
			if state == current_state:
				state.post_phys_active(delta)
			else:
				state.post_phys_inactive(delta)
		
		for component in motion_sub_components:
			component.post_phys_active(delta)
	
	# Apply the velocity to the actor instead of the component
	actor.global_position = me.global_position
	me.position = Vector2.ZERO

func _on_respawned():
	me.velocity = Vector2.ZERO
