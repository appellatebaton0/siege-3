extends Component
class_name SpawnerComponent
var me:Node2D = get_me()
func _init() -> void:
	component_id = "Spawner"

signal spawning

## Spawns nodes from PackedScenes according to given parameters.

## The value to get options from.
@export var options_value:DynamicScenesValue
## The value to set the position as. Defaults to the spawner's position.
@export var position_value:DynamicVector2Value
## The value to set the rotation as. Defaults to 0.0.
@export var rotation_value:DynamicValue
## The value to set the velocity to. Defaults to (0,0).
@export var velocity_value:DynamicVector2Value

## The place newly added objects should go
@export var main:DynamicNodeValue
## The condition for spawning something. Empty = always true
@export var condition:DynamicCondition
## Whether or not to run down the spawn_interval regardless of whether the condition is true.
@export var cooldown_ignores_condition := false

@export var spawn_limit := 0 ## How many actors this spawner can create at maximum (-1 = infinite)
var spawned_so_far := 0
@export var auto_spawn := false ## Whether the spawner automatically starts spawning.
@export var spawn_signal_interval := 1.0 ## How long to wait before sending the "spawning" signal. Must be less than spawn_interval.
var sent_signal := false ## Whether the signal's been sent this go around.
@export var spawn_interval := 1.0 ## How long to wait between each spawn
@export var spawn_time := 0.0 ## The time before the first spawn


func get_actor_motion_component(from:Node) -> MotionComponent:
	if from is Actor:
		for component in from.get_components():
			if component is MotionComponent:
				return component
	return null

func spawn():
	for option in options_value.value():
		var new = option.instantiate()
		
		main.value().add_child(new)
		
		if new is Node2D:
			## Get transform
			var global_position:Vector2 = position_value.value() if position_value != null else me.global_position
			var rotation:float = rotation_value.value() if rotation_value != null else 0.0
			var velocity:Vector2 = velocity_value.value() if velocity_value != null else Vector2.ZERO
	
			# Apply position & rotation
			new.global_position = global_position
			new.rotation = rotation
			
			# Apply initial velocity (or attempt to)
			if get_actor_motion_component(new) != null:
				get_actor_motion_component(new).me.velocity = velocity.rotated(rotation)

func _process(delta: float) -> void:
	if auto_spawn and actor.is_active():
		if cooldown_ignores_condition:
			spawn_time = move_toward(spawn_time, spawn_interval, delta)
		if (condition == null or condition.value()) and (spawned_so_far < spawn_limit or spawn_limit < 0):
			if not cooldown_ignores_condition:
				spawn_time = move_toward(spawn_time, spawn_interval, delta)
			
			if spawn_time >= spawn_signal_interval and not sent_signal:
				spawning.emit()
				sent_signal = true
			
			if spawn_time >= spawn_interval:
				spawn()
				spawn_time = 0.0
				sent_signal = false
