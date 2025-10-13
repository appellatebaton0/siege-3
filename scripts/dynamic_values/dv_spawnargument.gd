class_name DynamicSpawnArgumentValue extends DynamicValue

## The node to grab the value from.
@export var from:DynamicNodeValue
var from_node:Node
## The value to grab from the spawn arguments.
@export var target_value := ""

func _ready() -> void:
	
	if from == null:
		for child in get_children():
			if child is DynamicNodeValue:
				from = child
	
	if from == null:
		print(name, " is sad :(")

func value() -> Variant:
	if from != null:
		from_node = from.value()
		if from_node != null:
			if from_node is Actor or from_node is Interface:
				if from_node.spawn_arguments.has(target_value):
					return from_node.spawn_arguments[target_value]
	return null
