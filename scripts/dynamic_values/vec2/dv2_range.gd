class_name DynamicRangeVector2Value extends DynamicVector2Value
## Returns a random vector within the given range.

## The minimum values for the x and y values.
@export var minimum_values := Vector2.ZERO
## The maximum values for the x and y values.
@export var maximum_values := Vector2.ZERO

func value() -> Vector2:
	var x = randf_range(minimum_values.x, maximum_values.x)
	var y = randf_range(minimum_values.y, maximum_values.y)
	
	return Vector2(x,y)
