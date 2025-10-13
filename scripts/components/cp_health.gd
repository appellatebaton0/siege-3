class_name HealthComponent extends Component
## Is affected by damage components

signal health_reached_zero
signal took_damage

func _init():
	component_id = "Health"

@export var health := 50.0

func alter_health(amount:float):
	# If  the amount is negative, it's damage.
	if amount < 0:
		took_damage.emit()
		
		health = max(0, health + amount)
	
	# If health is 0, take note.
	if health <= 0:
		health = 0 # Failsafe.
		health_reached_zero.emit()
