class_name AnimationFinishElement extends Element
## Provides a seperate signal when a certain animation finishes.

func _init():
	component_id = "AnimationFinishElement"

## The looked-for animation just finished
signal finished

## The animation to look for.
@export var animation:String
## The animator to connect to
@export var animator:DynamicNodeValue
var real_animator:AnimationPlayer

func _ready() -> void:
	if animator == null:
		for child in get_children():
			if child is DynamicNodeValue:
				animator = child
	if animator == null and get_parent() is AnimationPlayer:
		real_animator = get_parent()
	
	if animator != null:
		var value = animator.value()
		if value is AnimationPlayer:
			real_animator = value
			real_animator.animation_finished.connect(_on_finished)

func _on_finished(anim_name:String):
	if anim_name == animation:
		finished.emit()
