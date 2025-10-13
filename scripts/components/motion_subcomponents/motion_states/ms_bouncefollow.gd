class_name BounceFollowMotionState extends MotionState
## Moves to follow another node while jumping constantly

func _init():
	component_id = "BounceFollowMotionState"

## The node to follow.
@export var target:DynamicNodeValue

## How much upwards velocity is applied on a jump.
@export var jump_velocity := 300.0

## How much the actor accelerates on the ground while trying to move, per second.
@export var floor_acceleration := 50.0
## How much the actor accelerates while trying to move, per second.
@export var air_acceleration := 50.0

## The maximum speed the actor can reach through this (other forces can apply more momentum).
@export var max_speed := 100.0

## How much gravity affects the actor.
@export var gravity_multiplier := 1.0


func _ready() -> void:
	if target == null:
		for child in get_children():
			if child is DynamicNodeValue:
				target = child

func phys_active(delta:float):
	if character.is_on_floor():
		character.velocity.y = min(character.velocity.y, -jump_velocity)
	else:
		character.velocity += gravity_multiplier * character.get_gravity() * delta
	
	var followee:Node = target.value()
	if followee is Node2D:
	
		var dir_to_followee:float = actor.global_position.direction_to(followee.global_position).x
		
		## The direction to move to get to the target. -1.0 or 1.0
		var direction:float = abs(dir_to_followee) / dir_to_followee
		
		var current_acceleration := floor_acceleration if character.is_on_floor() else air_acceleration
		if not abs(character.velocity.x) > max_speed:
			character.velocity.x = move_toward(character.velocity.x, direction * max_speed, delta * current_acceleration)
	
	#
	#if character.is_on_floor():
		#component.substate = "Walking" if character.velocity.x != 0 else "Idle"
	#else:
		#component.substate = "Midair"
	#
	#if not character.is_on_floor():
		#character.velocity += delta * character.get_gravity() * gravity_multiplier
	#
	#if is_moving:
		#should_move = true
	#
	#if should_jump:
		#if character.is_on_floor() and should_move:
			#character.velocity.y = min(character.velocity.y, -jump_velocity)
	#should_jump = false
	#
	#var current_friction := floor_friction if character.is_on_floor() else air_friction
	#if should_move:
		#var direction := -1 if facing_left else 1
	#
		## Set acceleration and friction.
		#var current_acceleration := floor_acceleration if character.is_on_floor() else air_acceleration
		#if direction:
			## If the actor isn't already moving faster
			#if not abs(character.velocity.x) > max_speed:
				#character.velocity.x = move_toward(character.velocity.x, direction * max_speed, delta * current_acceleration)
			#
		## Friction! Move towards 0 based on the current friction.
			#else:
				#character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
		#else:
			#character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
		#should_move = false
	#else:
		#character.velocity.x = move_toward(character.velocity.x, 0, delta * current_friction)
