@abstract class_name DamageComponent extends Component
## Childs to a HitboxComponent, and copies over to any hit targets, running its on_target function.

@onready var victim:Actor = null
@onready var health:HealthComponent

func _ready() -> void:
	## If not made inert, do the damage where you are.
	if get_parent() is not HitboxAreaSubComponent:
		victim = actor

func attach_to(target:Actor):
	## Attach a copy of this node to the hit actor
	var new = self.duplicate()
	
	target.add_child(new)
	
	new.victim = target

## What to do when you're done damaging
func finished_damaging():
	queue_free()

func _process(delta: float) -> void:
	if victim != null:
		if health == null:
			for child in victim.get_components():
				if child is HealthComponent:
					health = child
		
		if health != null:
			on_target(victim, delta)

@abstract func on_target(_target:Actor, _delta:float)
