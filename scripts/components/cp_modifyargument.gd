class_name ModArgumentComponent extends Component
## Modifies a given spawn argument on a given node.

func _init():
	component_id = "ModProperty"

## The value to modify
@export var target_value := ""
## The value to set it to
@export var new_value:DynamicValue
## The node to modify
@export var target:DynamicNodeValue

func _ready() -> void:
	for child in get_children():
		if child is DynamicNodeValue and target == null:
			target = child
		elif child is DynamicValue and new_value == null:
			new_value = child

func modify(override_target:Node = null, override_target_value := "", override_value:Variant = null):
	var use_target:Node
	var use_target_value:String = target_value
	var use_value:Variant
	
	# Do the overrides if needed.
	if override_value != null:
		use_value = override_value
	elif new_value != null:
		use_value = new_value.value()
	
	if override_target != null:
		use_target = override_target
	elif target != null:
		use_target = target.value()
	
	if override_target_value != "":
		use_target_value = override_target_value
	
	# If everything's valid, modify the spawn arguments.
	if use_value != null and (use_target is Interface or use_target is Actor):
		use_target.spawn_arguments[use_target_value] = use_value
