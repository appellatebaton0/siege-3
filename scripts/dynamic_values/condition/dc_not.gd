class_name DynamicNotCondition extends DynamicCondition

## Returns the opposite of the input

## The value to NOT
@export var input:DynamicCondition

func _ready() -> void:
	# If input is set, use that
	if input == null:
		# Otherwise, look in children
		for child in get_children():
			if child is DynamicValue:
				input = child
				break

func value() -> bool:
	if input != null:
		return not input.value()
	return true
