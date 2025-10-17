class_name DynamicVectorSumFloatValue extends DynamicFloatValue
## Returns the total amount of velocity.

@export var input:DynamicVector2Value

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicVector2Value:
				input = child
				break

func value() -> float:
	if input != null:
		var input_val = input.value()
		return abs(input_val.x) + abs(input_val.y)
	return 0.0
