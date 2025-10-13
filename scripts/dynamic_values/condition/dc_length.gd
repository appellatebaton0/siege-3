extends DynamicFloatValue ## Should be int but... eh. nrn.
class_name DynamicLengthCondition

## Returns the length of an array

## The input, an array / string
@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child
				break

func value() -> float:
	if input == null:
		return 0.0
	
	return len(input.value())
