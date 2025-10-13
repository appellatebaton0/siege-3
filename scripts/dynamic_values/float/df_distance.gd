class_name DynamicDistanceFloatValue extends DynamicFloatValue
## Returns the distance between two nodes.

## The first node.
@export var node_a:DynamicNodeValue
## The second node.
@export var node_b:DynamicNodeValue

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodeValue:
			if node_a == null:
				node_a = child
			elif node_b == null:
				node_b = child

func value() -> float:
	if node_a != null and node_b != null:
		var real_a = node_a.value()
		var real_b = node_b.value()
		if real_a is Node2D and real_b is Node2D:
			return real_a.global_position.distance_to(real_b.global_position)
	return -1.0
