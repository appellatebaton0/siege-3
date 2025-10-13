class_name CollisionMatchAreaSubComponent extends AreaSubComponent
## Matches its CP_Area's collision shapes to another actor's

func _init():
	component_id = "CollisionMatchAreaSubComponent"

@export var from:DynamicNodeValue

func get_recursive_children(of:Node, depth := 4) -> Array[Node]:
	if depth <= 0:
		return []
	
	var response:Array[Node] = []
	
	if of != null:
		for child in of.get_children():
			response.append(child)
			response.append_array(get_recursive_children(child, depth - 1))
	
	return response

func get_collision_objects() -> Array[Node]:
	if from != null:
		var node = from.value()
		if node != null:
			# Get the children of the node, 4 layers deep.
			var array = get_recursive_children(node)
			var response:Array[Node]
			
			# Filter out everything that isn't a collision shape/polygon
			for child in array:
				if child is CollisionPolygon2D or child is CollisionShape2D:
					response.append(child)
			
			return response
	return []

## Update the collision shapes
func update():
	# Out with the old
	for child in area_component.get_children():
		if child is CollisionPolygon2D or child is CollisionShape2D:
			child.queue_free()
	
	# In with the new!
	for object in get_collision_objects():
		var new = object.duplicate()
		area_component.add_child(new)
