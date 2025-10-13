class_name RigidComponent extends Component
## Provides rigidbody functionality to an actor

func _init():
	component_id = "RigidComponent"
var me:RigidBody2D = get_me()


func _physics_process(_delta: float) -> void:
	if actor.is_active():
		actor.global_position = me.global_position
		actor.rotation = me.rotation
	me.position = Vector2(0,0)
