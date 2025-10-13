class_name DynamicInequalityCondition extends DynamicCondition
## Return the answer to an inequality

## The value to compare in the inequality
@export var input:DynamicNumberValue

enum comparisons{GREATER_THAN, LESS_THAN, GREATER_OR_EQUAL, LESS_OR_EQUAL, EQUAL}
## The comparison to make between the input and comparator
@export var comparison := comparisons.EQUAL

## The value to compare the value to.
@export var comparator := 0

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicNumberValue:
				input = child

func value() -> bool:
	if input != null:
		var iv = input.value()
		
		match comparison:
			comparisons.GREATER_THAN:
				return iv > comparator
			comparisons.LESS_THAN:
				return iv < comparator
			comparisons.GREATER_OR_EQUAL:
				return iv >= comparator
			comparisons.LESS_OR_EQUAL:
				return iv <= comparator
			comparisons.EQUAL:
				return iv == comparator
	return false
