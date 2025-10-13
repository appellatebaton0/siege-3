class_name HurtboxAreaSubComponent extends AreaSubComponent
## Allows an actor to be hurt by hitbox components.

func _init() -> void:
	component_id = "HurtboxAreaSub"

signal hurt(by:Actor) ## Emits when 
signal clicked_on

@export var clickable:bool = false

func hurt_by(hurter:Actor):
	hurt.emit(hurter)

func is_valid_area(area:Area2D) -> bool:
	var component = area
	if component is AreaComponent:
		for child in component.get_components():
			if child is HitboxAreaSubComponent:
				return true
	return false

func on_area_entered(area: Area2D) -> void:
	if is_valid_area(area):
		hurt_by(area.actor)

func on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if clickable:
		if event is InputEventMouseButton:
			if event.pressed:
				clicked_on.emit()
