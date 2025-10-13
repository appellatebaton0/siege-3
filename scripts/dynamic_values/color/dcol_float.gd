class_name DynamicFloatColorValue extends DynamicColorValue
## Casts floats into a color.

@export var red:DynamicFloatValue
@export var green:DynamicFloatValue
@export var blue:DynamicFloatValue
@export var alpha:DynamicFloatValue


func value() -> Color:
	var r := red.value() if red != null else 0.0
	var g := green.value() if green != null else 0.0
	var b := blue.value() if blue != null else 0.0
	var a := alpha.value() if alpha != null else 0.0
	
	return Color(r,g,b,a)
