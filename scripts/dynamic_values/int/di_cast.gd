class_name DynamicCastIntValue extends DynamicIntValue
## Casts a DV to an int

## The value to cast
@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child

func value() -> int:
	if input != null:
		var response = input.value()
		# If it can be cast, cast and return
		if response is int or response is float or response is bool or response is String:
			return int(response)
	return -1
