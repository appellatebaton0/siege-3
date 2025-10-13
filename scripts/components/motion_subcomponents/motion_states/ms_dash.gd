class_name DashMotionState extends MotionState
## Moves the actor in a straight line at a set speed, 
## and doesn't stop until the timer runs out,
## and it's not in a wall if given a CP_Area.

func _init():
	component_id = "DashMotionState"

## The state to switch to once deactivated.
@export var deactivation_state:MotionState

@export_group("Dash Configuration", "dash_")
@export var dash_speed := 0.0 ## The speed with which to dash
@export var dash_time := 0.0 ## The amount of time to dash FOR, minimum.
var time := 0.0 # The real, current dash time.
@export var dash_carry_y_velocity := false ## Whether to keep the current Y velocity, and not override it.
@export var dash_cooldown := 0.0 ## The delay before you can dash again
var cooldown := 0.0 # The real, current dash cooldown

@export_group("Collision Rules")
@export var override_mask := false ## Whether the actor should collide based on this collision_mask instead of the current one.
@export_flags_2d_physics var collision_mask = 0 ## The mask to use instead while dashing
@onready var real_collision_mask = character.collision_mask

@export_group("Area Checking", "check_")
@export var check_area:AreaComponent ## The area to use for continuing if in a wall.
@export_flags_2d_physics var check_mask ## The layer to filter for while checking for walls.

func on_active():
	# Change the collision layer if needed
	if override_mask:
		character.collision_mask = collision_mask
	
	time = dash_time # Start the timer over.
func on_inactive():
	# Change the collision layer back if needed
	if override_mask:
		character.collision_mask = real_collision_mask

func inactive(delta:float):
	cooldown = move_toward(cooldown, 0, delta)

func phys_active(delta:float):
	## Apply the velocity
	
	var direction = 1 if component.direction else -1
	character.velocity.x = direction * dash_speed
	
	if not dash_carry_y_velocity:
		character.velocity.y = 0
	
	## Check if you can deactivate
	var can_deactivate := true # Whether it can deactivate this frame.
	
	# If there's a check area, only allow deactivation
	# if nothing's colliding on the given layer.
	if check_area != null:
		can_deactivate = not check_area.has_overlapping_collisions_for(check_mask)
	
	## Attempt to deactivate
	if time <= 0 and can_deactivate and deactivation_state != null:
		component.change_state(deactivation_state)
		cooldown = dash_cooldown
	time = move_toward(time, 0, delta)
