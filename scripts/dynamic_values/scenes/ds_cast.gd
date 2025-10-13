class_name DynamicCastScenesValue extends DynamicScenesValue

@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child

func value() -> Array[PackedScene]:
	if input != null:
		var val = input.value()
		if val is Array[PackedScene]:
			return val
		elif val is PackedScene:
			return [val]
	return []
