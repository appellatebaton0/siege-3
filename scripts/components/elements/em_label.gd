extends Element
class_name LabelElement
## Provides dynamic text to Control nodes that can show DynamicValues

func _init():
	component_id = "LabelElement"

@export var node_to_set:Control ## The control to give the value to
@export var value_to_set := "text" ## The value to set as this dynamic one
@export var values:Array[DynamicValue]

## Use {x} to substitue values, with x being the index in the values array.
@export_multiline var text_format:String = "{0}"

func _ready() -> void:
	
	if node_to_set == null:
		## If this node IS a control, use it.
		## This is how this element used to work (which is bad),
		## so this is a failsafe.
		if get_me() is Control:
			node_to_set = get_me()
		elif get_parent() is Control:
			node_to_set = get_parent()
	
	for child in get_children():
		if child is DynamicValue:
			values.append(child)
	
	_update_label()

func _process(_delta: float) -> void:
	_update_label()


var real_values:Array[Variant]
func _update_label():
	if len(values) < 0:
		return
	
	for i in range(len(values)):
		if values[i].value() != null:
			if len(real_values) > i:
				real_values[i] = values[i].value()
			else:
				real_values.append(values[i].value())
	
	var real_text:String = text_format
	
	if len(real_values) >= len(values):
		for i in range(len(values)):
			real_text = real_text.replace("{" + str(i) + "}", str(real_values[i]))
	
	node_to_set.set(value_to_set, real_text)
	
