class_name StashComponent extends Component
## Allows pulling and pushing a node in/out of a DV
## when a condition is met / signal is emitted.

func _init():
	component_id = "StashComponent"

@export var stash_value:ManualDynamicValue ## The place to store it

@export_group("Push Variables", "push_")
@export var push_node_value:DynamicNodeValue ## The node to store
@export var push_condition:DynamicCondition ## When to store the node_value.
@export var push_override := false ## Whether to put nodes in a stash regardless of whether it already has something in it.

@export_group("Pull Variables", "pull_")
@export var pull_location:DynamicNodeValue ## Where to store the node when it's pulled.
@export var pull_condition:DynamicCondition ## When to pull the stashed node.

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodeValue and push_node_value == null:
			push_node_value = child
		if child is DynamicNodeValue and pull_location == null:
			pull_location = child
		elif child is ManualDynamicValue and stash_value == null:
			stash_value = child
		elif child is DynamicCondition and push_condition == null:
			push_condition = child
		elif child is DynamicCondition and pull_condition == null:
			pull_condition = child

func _process(_delta: float) -> void:
	if push_condition.value() and push_condition != null:
		push()
	elif pull_condition.value() and pull() != null:
		pull()

func push() -> bool:
	if push_node_value != null:
		var node = push_node_value.value()
		
		if node != null and (push_override or not stash_value.filled()):
			# Remove it from the tree
			node.get_parent().remove_child(node)
			# And stuff it in the stash.
			stash_value.set_to(node)
			
			return true
	return false

func pull() -> bool:
	
	# Run all necessary checks
	if pull_location != null and stash_value != null:
		if stash_value.response is Node:
			# Pull the node out to the location.
			
			var node:Node = stash_value.response
			
			var location:Node = pull_location.value()
			
			if node != null and location != null:
				location.add_child(node)
				stash_value.set_to(null)
				if node is Node2D:
					node.global_position = actor.global_position
				return true
	return false
