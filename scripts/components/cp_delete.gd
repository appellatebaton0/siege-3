class_name DeleteComponent extends Component
## Deletes a given node via a signal or condition.

signal finished ## Emits when it's finished deleting, for proper OOA

func _init():
	component_id = "Delete"

## The node to delete.
@export var target:DynamicNodeValue
@export var targets:DynamicNodesValue
## The condition to meet before deletion
@export var condition:DynamicCondition

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodeValue and target == null:
			target = child
		elif child is DynamicCondition and condition == null:
			condition = child
		elif child is DynamicNodesValue and targets == null:
			targets = child

func _process(_delta: float) -> void:
	if condition != null:
		if condition.value():
			delete()

func delete():
	if target != null:
		var node := target.value()
		
		if node != null:
			## If it's an actor, try to free it via a freecomponent,
			## then make sure the signal's emitted anyways.
			## This *could* cause problems?
			if node is Actor:
				for component in node.get_components():
					if component is FreeComponent:
						component.free_actor()
						return
				node.freeing.emit()
			
			## Toss the node if nothing else is handling the deletion.
			## "Fine, I'll do it myself."
			node.queue_free()
	
	if targets != null:
		## Free all the targets
		for subnode in targets.value():
		
			if subnode != null:
				## If it's an actor, try to free it via a freecomponent,
				## then make sure the signal's emitted anyways.
				## This *could* cause problems?
				if subnode is Actor:
					for component in subnode.get_components():
						if component is FreeComponent:
							component.free_actor()
							return
					subnode.freeing.emit()
				
				## Toss the node if nothing else is handling the deletion.
				## "Fine, I'll do it myself."
				subnode.queue_free()
	finished.emit()
