class_name DirectoryLoadComponent extends Component
## Loads a packedscene to its parent for every
## scene in a directory. Good for level select buttons.

func _init():
	component_id = "DirectoryLoad"

## Spawn argument modifiers that should get the file passed to them
@export var pass_file_modifiers:Array[ModArgumentComponent]
## Spawn arg modifiers that should get the index of the file passed to them.
@export var pass_index_modifiers:Array[ModArgumentComponent]

## Whether to just load the scenes *from* the directory
@export var load_from_directory:bool = false
## Whether to add the children in reverse.
@export var load_from_back:bool = false
## Scene to load for each scene in a directory. Only loads if load_from_directory is false.
@export var loading_scene:PackedScene
## The path to the directory to use.
@export_dir var directory_path:String

## Any modifiers to apply to the created scene
@export var modifiers:Array[ModArgumentComponent]

@onready var parent = get_parent()
var to_be_parented:Array[Node]

func _ready() -> void:
	# Fix DAMN IMPORT ISSUES
	directory_path = directory_path.replace(".remap", "")
	directory_path = directory_path.replace(".import", "")
	
	for child in get_children():
		if child is ModArgumentComponent:
			modifiers.append(child)
	
	var file_paths:Array[String]
	
	## Access the directory and iterate through its files
	var dir:DirAccess = DirAccess.open(directory_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "": # While there are files left
			# As long as it isn't a directory
			if !dir.current_is_dir(): 
				
				file_name = file_name.replace(".remap", "")
				file_name = file_name.replace(".import", "")
				
				file_paths.append(directory_path + "/" + file_name)
				
			file_name = dir.get_next() # Move on
	else: # IF something messed up.
		print("An error occurred when trying to access the path.")
	
	
	file_paths.sort()
	if load_from_back:
		file_paths.reverse()
	
	for i in range(len(file_paths)):
		var new
		if load_from_directory: ## Load the file itself
			new = load(file_paths[i])
		else: ## Load a file for each file
			new = loading_scene.instantiate()
			
		for mod in modifiers:
			if pass_file_modifiers.has(mod):
				mod.modify(new, "", load(file_paths[i]))
			elif pass_index_modifiers.has(mod):
				mod.modify(new, "", i)
			else:
				mod.modify(new)
	
		to_be_parented.append(new)


func _process(_delta: float) -> void:
	while len(to_be_parented) > 0:
		var node = to_be_parented[0]
		
		if node.get_parent() == null:
			parent.add_child(node)
			to_be_parented.erase(node)
		
		
