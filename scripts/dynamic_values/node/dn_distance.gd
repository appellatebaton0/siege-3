class_name DynamicDistanceNodeValue extends DynamicNodeValue
## Returns the node from the list that's closest to another node.

@export var options:DynamicNodesValue
@export var to:DynamicNodeValue

enum dis_type{
	closest, ## Return the node closest to the target 
	farthest ## Return the node farthest from the target.
	}
## Which calculation to do for the node.
@export var type := dis_type.farthest

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodesValue and options == null:
			options = child
		elif child is DynamicNodeValue and to == null:
			to = child

func value() -> Node:
	if options != null and to != null:
		var to_node := to.value()
		var opt_nodes := options.value()
		
		if to_node is Node2D and opt_nodes != null:
			var best:Node2D = null
			var best_distance
			
			for node in opt_nodes:
				if node is Node2D:
					var this_distance = node.global_position.distance_to(to_node.global_position)
					
					## If none's been set, just use this one.
					if best == null:
						best = node
						best_distance = this_distance
						continue
					
					if type == dis_type.closest:
						
						if this_distance < best_distance:
							best = node
							best_distance = this_distance
							continue
					else:
						if this_distance > best_distance:
							best = node
							best_distance = this_distance
							continue
			return best
	return null
