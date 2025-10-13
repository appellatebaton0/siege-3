class_name PullAnchorMotionState extends MotionState
## Anchors to one node, and is pulled a set distance range towards another.

func _init():
	component_id = "PullAnchorMotionState"

## The node to anchor to.
@export var anchor:DynamicNodeValue
## The node to be pulled towards.
@export var pull:DynamicNodeValue
## The range of distance allowed from the anchor.
@export var magnetism_range := Vector2(0.0, 0.0)

func _ready() -> void:
	## Get from children if needed.
	for child in get_children():
		if child is DynamicNodeValue:
			if anchor == null:
				anchor = child
			elif pull == null:
				pull = child
	
	## Make sure it's (min,max)
	if magnetism_range.x > magnetism_range.y:
		magnetism_range = Vector2(magnetism_range.y, magnetism_range.x)

func _process(_delta: float) -> void:
	if anchor != null and pull != null:
		var anchor_node := anchor.value()
		var pull_node := pull.value()
		
		if anchor_node is Node2D:
			if pull_node is Node2D:
				actor.global_position = anchor_node.global_position
				
				var direction = anchor_node.global_position.direction_to(pull_node.global_position)
				var distance = anchor_node.global_position.distance_to(pull_node.global_position)
				
				## Lock the distance to the range
				distance = max(magnetism_range.x, min(distance, magnetism_range.y))
				
				actor.global_position += direction * distance
				
				
		
