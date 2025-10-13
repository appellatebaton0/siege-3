class_name LookComponent extends Component
var me:Node2D = get_me()
func _init():
	component_id = "Look"

## Faces towards another node based on a DynamicNodeValue.
## Good for making guns, since it can look at the mouse or an enemy.

## The node to look at
@export var target:DynamicNodeValue

func _ready() -> void:
	## If the target's unset, look in the children.
	if target == null:
		for child in get_children():
			if child is DynamicNodeValue:
				target = child 
				break

func _process(_delta: float) -> void:
	if target != null:
		me.look_at(target.value().global_position)
