extends Component
class_name SFXComponent
func _init() -> void:
	component_id = "SFX"

## The sound effect to play
@export var sfx:AudioStream
## Whether to play when the actor is freeing
@export var play_on_free:bool = false
## Optional condition, if met will play the SFX
@export var condition:DynamicCondition

func _ready() -> void:
	
	if condition == null:
		for child in get_children():
			if child is DynamicCondition:
				condition = child
	
	if play_on_free:
		actor.freeing.connect(make)

func _process(_delta: float) -> void:
	if condition != null:
		if condition.value():
			make()

func make():
	Global.play_sfx.emit(sfx)
