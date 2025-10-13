class_name DynamicModifiedFloatValue extends DynamicFloatValue
## Modifies an input float value via an operation

## The float val to modify
@export var input:DynamicFloatValue

enum op{
	ADD, ## Add amount to the input
	DIVIDE, ## Divide the input by amount
	MULTIPLY, ## Multiply input by amount
	POW ## Raise input to the amounth power
	}
## The operation to use.
@export var operation := op.ADD
## The value to modify it with.
@export var amount := 0.0

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicFloatValue:
				input = child

func value() -> float:
	if input != null:
		var response = input.value()
		match operation:
			op.ADD:
				return response + amount
			op.DIVIDE:
				return response / amount
			op.MULTIPLY:
				return response * amount
			op.POW:
				return pow(response, amount)
	return 0.0
