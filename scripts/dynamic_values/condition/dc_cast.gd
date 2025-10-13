class_name DynamicCastCondition extends DynamicCondition

## Casts another value to a bool

## The value to cast
@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child
				break

func value() -> bool:
	
	var response = input.value()
	
	if response is DynamicCondition:
		return response.value()
	
	## If the cast will fail, return false.
	if response is not bool and response is not int and response is not float:
		return false
	
	return bool(response)
