@abstract class_name MotionState extends MotionSubComponent
## A specific MotionSubComponent which can only have one active per motioncomponent at a time.

## Whether or not this is the current state, for DVs
var is_current_state:bool = false

# Signals for when this state activates/deactivates.
@warning_ignore("unused_signal") signal became_active
@warning_ignore("unused_signal") signal became_inactive

## Switch to a different state if a DynamicValue is true, and the motionstate is the current one.
@export var switch_handles:Dictionary[DynamicValue, MotionState]

# Inactive
func phys_inactive(_delta:float):
	pass
func post_phys_inactive(_delta:float):
	pass
func inactive(_delta:float):
	pass

# On change
func on_active():
	pass
func on_inactive():
	pass
