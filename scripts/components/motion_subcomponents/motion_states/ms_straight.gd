extends MotionState
class_name StraightMotionState
## Moves the actor in a straight direction at a given speed.

func _init():
	component_id = "StraightMotionState"


## The direction to move.
@export var direction:Vector2 = Vector2.ZERO

@export var max_speed:float = 90.0 ## The fastest the actor can go by just holding a direction.
@export var acceleration:float = 10.0 ## How fast the actor approaches max speed.

func _ready() -> void:
	direction = direction.normalized()

func phys_active(_delta:float):
	character.velocity = vec2_move_towards(character.velocity, direction * max_speed, acceleration)
	
