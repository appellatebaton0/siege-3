class_name ToggleGravityRigidSubComponent extends RigidSubComponent
## Allows for the gravity of a RigidComponent to be toggled with signals / a condition.

signal toggled_off
signal toggled_on
signal toggled

func _init():
	component_id = "ToggleGravityRigidSubComponent"

@export var toggle_condition:DynamicCondition ## If met, toggles.
@export var toggle_off_condition:DynamicCondition ## If met, toggles off.
@export var toggle_on_condition:DynamicCondition ## If met, toggles on.
@export var set_condition:DynamicCondition ## Toggles the gravity to this value.

@onready var on_gravity := rigid_component.me.gravity_scale
@onready var off_gravity := 0.0
var grav_switch:bool = true

func toggle_off():
	set_to(false)
func toggle_on():
	set_to(true)
func toggle():
	set_to(not grav_switch)

func set_to(value:bool):
	# Emit the signals
	toggled.emit()
	if value:
		toggled_on.emit()
	else:
		toggled_off.emit()
	
	# Make the switch
	grav_switch = value
	rigid_component.me.gravity_scale = on_gravity if value else off_gravity

var set_last
func _process(_delta: float) -> void:
	if set_condition != null:
		if set_condition.value() != set_last:
			set_last = set_condition.value()
			set_to(set_last)
	if toggle_condition != null:
		if toggle_condition.value():
			toggle()
	if toggle_off_condition.value() and grav_switch:
		toggle_off()
	elif toggle_on_condition != null and toggle_on_condition.value() and not grav_switch:
		toggle_on()
	
	
