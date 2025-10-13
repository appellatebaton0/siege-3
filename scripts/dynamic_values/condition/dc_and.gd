class_name DynamicAndCondition extends DynamicCondition

## Returns if all inputs are true

## The values to AND
@export var inputs:Array[DynamicCondition]

func _ready() -> void:
	# Look in children for more conditions
	for child in get_children():
		if child is DynamicCondition:
			inputs.append(child)

func value() -> bool:
	for input in inputs:
		# If any fail, return false.
		if input.value() == null or not input.value():
			return false
	
	return true
