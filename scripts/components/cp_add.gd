class_name AddComponent extends Component
## Adds a given node to another via a signal or condition.

func _init():
	component_id = "Delete"

## The node to add to the target.
@export var scene:DynamicScenesValue
## The node the scene will be added to.
@export var target:DynamicNodeValue
## Any SpawnArguments to give it
@export var pass_modifiers:Array[ModArgumentComponent]
## The condition that has to be met to add a node. WARNING: Runs every frame if true every frame.
@export var condition:DynamicCondition

func _ready() -> void:
	for child in get_children():
		if child is ModArgumentComponent:
			pass_modifiers.append(child)
		elif child is DynamicCondition and condition == null:
			condition = child
		elif child is DynamicNodeValue and target == null:
			target = child
		elif child is DynamicScenesValue and scene == null:
			scene = child

func _process(_delta: float) -> void:
	if condition != null:
		if condition.value():
			add()

var scenes:Array[PackedScene]
func add():
	if target != null and scene != null:
		var node := target.value()
		
		if scene.value() != null:
			scenes = scene.value()
		
		for new_scene in scenes:
			var new = new_scene.instantiate()
			
			node.add_child(new)
			
			for modifier in pass_modifiers:
				modifier.modify(new)
