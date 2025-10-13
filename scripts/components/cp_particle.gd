extends Component # Doesn't 
class_name ParticleComponent
## Adds particles via a signal or condition. 
## If this component is a Node2D, it'll spawn at this component's position,
## otherwise at the actor's position.

func _init() -> void:
	component_id = "Particle"

var me = get_me()

## The packedscene to spawn when the make function is called
@export var particle:PackedScene
## Whether to summon a particle once ready.
@export var make_on_ready := false
## A condition that makes particles if it's true
@export var condition:DynamicCondition
var ready_delay := 0.01

func _process(delta: float) -> void:
	if make_on_ready:
		ready_delay = move_toward(ready_delay, 0, delta)
		if ready_delay <= 0:
			make()
			make_on_ready = false
	elif condition != null:
		if condition.value():
			make()

func make():
	if me is Node2D:
		Global.new_particle.emit(particle, me.global_position)
	else:
		Global.new_particle.emit(particle, actor.global_position)
