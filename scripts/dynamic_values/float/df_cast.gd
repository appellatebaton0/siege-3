class_name DynamicCastFloatValue extends DynamicFloatValue

## Casts a DynamicValue to a float and returns it

## The value to cast
@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child
				break

func value() -> float:
	var response = input.value()
	
	## If the cast will fail, return 0.0
	if response is not float and response is not int and response is not String and response is not bool:
		return 0.0
	
	return float(response)
