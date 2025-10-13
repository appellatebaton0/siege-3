class_name SingleDamageComponent extends DamageComponent
## Does instant damage to the target.

func _init():
	component_id = "SingleDamage"

## Set a manual damage value to do to the target.
@export var manual_damage := 0.0
## If set, does this DV's value in damage instead.
@export var dynamic_damage:DynamicFloatValue

func on_target(_target:Actor, _delta:float):
	var this_damage = dynamic_damage.value() if dynamic_damage != null else manual_damage 
	
	health.alter_health(-this_damage)
	
	finished_damaging()
