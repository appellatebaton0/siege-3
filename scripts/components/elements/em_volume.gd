class_name VolumeElement extends Element
## Ties a slider to an audio bus.

func _init():
	component_id = "VolumeElement"

## The slider to tie.
@export var slider:DynamicNodeValue
var slider_node:Slider
## The audio bus to tie it to.
@export var bus_name:String

func _ready() -> void:
	# Look for DV_Nodes in children
	if slider == null:
		for child in get_children():
			if child is DynamicNodeValue:
				slider = child
	
	# Try to find the slider in the parent and the given node.
	if get_parent() is Slider:
		slider_node = get_parent()
	elif slider != null:
		if slider.value() is Slider:
			slider_node = slider.value()
	
	# If a slider was found, make the tie.
	if slider_node != null:
		slider_node.value_changed.connect(_on_value_changed)
		## Update it initially.
		_on_value_changed(slider_node.value)

func _on_value_changed(to:float):
	# As long as the bus exists, set the value.
	if AudioServer.get_bus_index(bus_name) != -1:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear_to_db(to))
