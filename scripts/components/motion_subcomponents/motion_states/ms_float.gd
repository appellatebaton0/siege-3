class_name FloatMotionState extends MotionState
## Follows, floating, after a node.
func _init():
	component_id = "FloatMotionState"

@export var target:DynamicNodeValue

@export var max_speed:float = 90.0 ## The fastest the actor can go by just holding a direction

@export var friction:float = 5.0 ## How fast the actor slows down
@export var acceleration:float = 10.0 ## How fast the actor approaches MAX_SPEED

func _ready() -> void:
	if target == null:
		for child in get_children():
			if child is DynamicNodeValue:
				target = child

func phys_active(delta: float) -> void:
	if target != null:
		var targ_node = target.value()
		if targ_node is Node2D:
			var direction = actor.global_position.direction_to(targ_node.global_position)
			
			# If the player's holding a direction, move in that direction.
			if direction:
				component.direction = direction.x > 0
				
				character.velocity = vec2_move_towards(character.velocity, direction * max_speed, 60 * delta * acceleration)
			else:
				character.velocity = vec2_move_towards(character.velocity, Vector2.ZERO, 60 * delta * friction)
