class_name DynamicCastNodeValue extends DynamicNodeValue
## Ensures a child input is a node.

@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child

func value() -> Node:
	if input.value() is Node:
		return input.value()
	return null
