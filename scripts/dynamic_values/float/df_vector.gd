class_name DynamicVectorFloatValue extends DynamicFloatValue
## Gets the x or y value from a vector2

@export var input:DynamicVector2Value

enum v{x,y}
@export var type := v.x

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicVector2Value:
				input = child

func value() -> float:
	if input != null:
		var vec = input.value()
		match type:
			v.x:
				return vec.x
			v.y:
				return vec.y
	
	return 0.0
