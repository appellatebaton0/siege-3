class_name AnimatorElement extends Element
## Provides an in for signals to play animations.

func _init():
	component_id = "Animator"

## The animator to play the animation of.
@export var animator:DynamicNodeValue
## The name of the animation to play.
@export var animation_name:String
## The speed scale to play the animation with.
@export_range(-4.0, 4.0, 0.001) var speed_scale := 1.0
## If this condition is true, will animate ONCE.
@export var condition:DynamicCondition

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodeValue and animator == null:
			animator = child
		elif child is DynamicCondition and condition == null:
			condition = child

func _process(_delta: float) -> void:
	if condition != null:
		if condition.value():
			animate()
			condition = null

func animate():
	var node := animator.value()
	if node is AnimationPlayer and animation_name != "":
		node.play(animation_name, -1, speed_scale, speed_scale < 0)
