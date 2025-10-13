extends Component
class_name AnimatedSpriteComponent
var me:AnimatedSprite2D = get_me()

func _init() -> void:
	component_id = "AnimatedSprite"

## If set, plays a global animation that synces across nodes with it.
@export var global_animation:GlobalAnimation
## Allows for tying conditions to which animation is played.
@export var condition_ties:Dictionary[DynamicCondition, String]
@export var flip_h_condition:DynamicCondition ## Flips horizontally if true
@export var flip_v_condition:DynamicCondition ## Flips vertically if true

func _ready():
	if global_animation != null:
		Global.add_global_animation(global_animation)

func _process(_delta: float) -> void:
	if global_animation != null:
		me.frame = global_animation.current_frame
	
	if flip_h_condition != null:
		me.flip_h = flip_h_condition.value()
	if flip_v_condition != null:
		me.flip_v = flip_v_condition.value()

	if condition_ties != null:
		for tie in condition_ties:
			if tie.value() and me.sprite_frames.has_animation(condition_ties[tie]):
				me.play(condition_ties[tie])
				break
				
