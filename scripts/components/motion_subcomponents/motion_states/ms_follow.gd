class_name FollowMotionState extends MotionState
## Follows another node directly, floating. Good for camera.

func _init():
	component_id = "FollowMotionState"

## The node to follow
@export var target:DynamicNodeValue
var node:Node2D

@export_group("Lerp Follow Amounts", "lerp_")
## How much to lerp towards the node on the x axis; 0 = none, 1 = instant.
@export_range(0.0, 1.0, 0.01) var lerp_x := 0.0
## How much to lerp towards the node on the y axis; 0 = none, 1 = instant.
@export_range(0.0, 1.0, 0.01) var lerp_y := 0.0

@export_group("Linear Follow Amounts", "linear_")
## How fast to move towards the node, per second.
@export var linear_follow := Vector2.ZERO

func _ready() -> void:
	if target == null:
		for child in get_children():
			if child is DynamicNodeValue:
				target = child
	
	if target != null:
		if target.value() is Node2D:
			node = target.value()

func active(delta:float):
	if node != null:
		var now := actor.to_local(actor.global_position)
		var goal := actor.to_local(node.global_position)
		var next:Vector2
		
		# Lerp follow
		next.x = lerp(now.x, goal.x, lerp_x)
		next.y = lerp(now.y, goal.y, lerp_y)
		
		# Linear follow
		next.x = move_toward(next.x, goal.x, linear_follow.x * (delta * 60))
		next.y = move_toward(next.y, goal.y, linear_follow.y * (delta * 60))
		
		# Apply the follow.
		actor.global_position = actor.to_global(next)
	## If the node value is null, try to fix that.
	elif target != null:
		if target.value() is Node2D:
			node = target.value()
		
