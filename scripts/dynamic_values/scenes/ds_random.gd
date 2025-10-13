class_name DynamicRandomSceneValue extends DynamicScenesValue

## Returns a random scene from the given options.

## The given options to draw from.
@export var options:Array[PackedScene]

func value() -> Array[PackedScene]:
	return [options.pick_random()]
