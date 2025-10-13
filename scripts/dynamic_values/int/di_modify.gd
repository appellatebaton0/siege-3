class_name DynamicModifiedIntValue extends DynamicIntValue
## Modifies an input float value via an operation

## The float val to modify
@export var input:DynamicIntValue

enum op{
	ADD, ## Add amount to the input
	DIVIDE, ## Divide the input by amount
	MULTIPLY, ## Multiply input by amount
	}
## The operation to use.
@export var operation := op.ADD
## The value to modify it with.
@export var amount := 0

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicIntValue:
				input = child

func value() -> int:
	if input != null:
		var response = input.value()
		match operation:
			op.ADD:
				return response + amount
			op.DIVIDE:
				@warning_ignore("integer_division")
				return response / amount
			op.MULTIPLY:
				return response * amount
	return 0
