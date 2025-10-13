class_name AutoColumnElement extends Element
## Automatically sets the number of columns for a grid component to be about equal to its rows.

func _init():
	component_id = "AutoColumn"

@onready var grid_container:GridContainer = get_grid_container()
func get_grid_container() -> GridContainer:
	if get_parent() is GridContainer:
		return get_parent()
	return null

func update() -> void:
	if grid_container != null:
		grid_container.columns = floor(sqrt(grid_container.get_child_count()))

var last_child_count:int = 0
func _process(_delta: float) -> void:
	var this_child_count := grid_container.get_child_count()
	if this_child_count != last_child_count:
		update()
	last_child_count = this_child_count
