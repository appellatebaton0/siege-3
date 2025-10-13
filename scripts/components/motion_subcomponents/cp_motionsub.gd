@abstract class_name MotionSubComponent extends Component
## Provides interface for a subcomponent that adds function to a MotionComponent


@onready var component:MotionComponent = get_parent()
@onready var character:CharacterBody2D = component.me

## Helper functions
func vec2_move_towards(a:Vector2, b:Vector2, delta:float):
	a.x = move_toward(a.x, b.x, delta)
	a.y = move_toward(a.y, b.y, delta)
	
	return a

## Ran functions

# Active
func phys_active(_delta:float):
	pass
func post_phys_active(_delta:float):
	pass
func active(_delta:float):
	pass
