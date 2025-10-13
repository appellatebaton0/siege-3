class_name DynamicCastVector2Value extends DynamicVector2Value
## Casts an input to a Vec2

## The Vector2 to cast
@export var input:DynamicValue

func _ready() -> void:
	if input == null:
		for child in get_children():
			if child is DynamicValue:
				input = child

func value() -> Vector2:
	if input != null:
		var response = input.value()
		
		if input.value() is Vector2 or input.value() is Vector2i:
			return Vector2(response)
	
	return Vector2.ZERO
