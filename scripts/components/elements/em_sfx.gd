extends Element
class_name SFXElement
## Allows for signals to be used to play sound effects.

func _init():
	component_id = "SFXElement"

@export var sfx:AudioStream

func make():
	Global.play_sfx.emit(sfx)

func make_value(_val:Variant):
	Global.play_sfx.emit(sfx)
