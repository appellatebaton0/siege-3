extends Control
class_name Interface

# A class for Controls that allows them to adopt
# functionality from Elements.

# See also: Actor for Node2Ds

## A Dictionary to provide surface-level arguments to an interface.
@export var spawn_arguments:Dictionary[String, Variant]

@onready var elements:Array[Element] = get_elements()
func get_elements(depth:int = 4, with:Node = self) -> Array[Element]:
	if depth <= 0:
		return []
	
	var return_elements:Array[Element]
	
	for child in with.get_children():
		if child is Element:
			return_elements.append(child)
		
		return_elements.append_array(get_elements(depth - 1, child))
	
	return return_elements

@onready var components:Array[Component] = get_components()
func get_components(depth:int = 4, with:Node = self) -> Array[Component]:
	if depth <= 0:
		return []
	
	var return_components:Array[Component]
		
	for child in with.get_children():
		if child is Component:
			return_components.append(child)
		return_components.append_array(get_components(depth - 1, child))
	
	return return_components

@onready var subinterfaces:Array[Interface] = get_subinterfaces()
func get_subinterfaces() -> Array[Interface]:
	var interfaces:Array[Interface]
	
	for child in get_children():
		if child is Interface:
			interfaces.append(child)
			
	return interfaces
