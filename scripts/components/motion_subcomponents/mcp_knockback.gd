class_name KnockbackMotionSubComponent extends MotionSubComponent
## Provides an in for signals or other things to do knockback.
## sort of primitive right now.

func _init():
	component_id = "KnockbackMotionSub"

## The amount of knockback to take
@export var knockback_amount := 200.0
## The cooldown on taking knockback, in seconds.
@export var cooldown := 0.5
var cooldown_timer = 0.0

var knockback_direction := Vector2.ZERO

func knockback(from:Node2D):
	knockback_direction = from.global_position.direction_to(actor.global_position)

func phys_active(delta:float):
	cooldown_timer = move_toward(cooldown_timer, 0, delta)
	if knockback_direction != Vector2.ZERO and cooldown_timer <= 0:
		character.velocity += knockback_direction * knockback_amount
		knockback_direction = Vector2.ZERO
		cooldown_timer = cooldown
