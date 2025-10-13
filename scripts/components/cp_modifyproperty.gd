class_name ModifyPropertyComponent extends Component
## Allows signals and conditions to modify a property.

func _init():
	component_id = "ExampleComponent"

## The node to set the property of.
@export var target:DynamicNodeValue
## The property to set on the input.
@export var property:String
var sub_values:Array[String]
## The value to set it to.
@export var new_value:DynamicValue
## The condition that must be met to set the property.
@export var condition:DynamicCondition

func _ready() -> void:
	# Prioritize the specifically set input
	
	for child in get_children():
		if child is DynamicNodeValue and target == null:
			target = child
		elif child is DynamicCondition and condition == null:
			condition = child
		elif child is DynamicValue and new_value == null:
			new_value = child
	
	## Turn the property into an array of subvalues.
	#while property != "":
		## Get the index of the first period
		#var period_index = property.find(".")
		#
		## Get the value up to that period if it exists.
		#var sub_value = property.left(period_index) if period_index != -1 else property
		#
		## Add that value to the list
		#sub_values.append(sub_value)
		#
		## Cut the value out of the property
		#if period_index != -1:
			#property = property.right(len(property) - period_index - 1)
		#else:
			#property = ""

func _process(_delta: float) -> void:
	if condition != null:
		if condition.value():
			modify()

func modify() -> void:
	if target != null and new_value != null:
		var node = target.value()
		if node != null:
			node.set(property, new_value.value())
