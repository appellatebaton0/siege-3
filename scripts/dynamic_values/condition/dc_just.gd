class_name DynamicJustCondition extends DynamicCondition
## Is true if its subcondition *just* became the state it was detecting.

## The condition to scan
@export var input:DynamicCondition
## What to detect, true or false.
@export var detect := true
var switch = false

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicCondition:
				input = child

func value() -> bool:
	# print(input, ": ", input.value(), " -> ", input.input, " -> ", input.input.value(), " -> ", input.input.value().value())
	if input != null:
		if input.value() == detect:
			print("wut")
			print("input ", input)
			if not switch:
				switch = true
				print("ret tru")
				return true
		else:
			switch = false
	return false
