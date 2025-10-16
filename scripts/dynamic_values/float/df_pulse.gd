class_name DynamicTimerFloatValue extends DynamicFloatValue
## Returns the value of a timer between 0 and 1, * the multiplier.
## The max value is a DV.

## The maximum time of the timer.
@export var max_time:DynamicFloatValue
var last_max:float = 1.0
## The value to multiply the maximum by.
@export var max_time_multiplier := 1.0
@export var time:float = 0.0 ## The starting time. Offset to offset the timer.
## The value to multiply the response by.
@export var response_multiplier := 1.0
## Whether to move from 0 to the max, or the other way around.
@export var reverse := false

func _ready() -> void:
	for child in get_children():
		if child is DynamicFloatValue and max_time == null:
			max_time = child


func _process(delta: float) -> void:
	
	
	if max_time != null:
		last_max = max_time.value() * max_time_multiplier
	else:
		last_max = 1 * max_time_multiplier
	
	
	if reverse:
		time = move_toward(time, last_max, delta)
		
		if time >= last_max:
			time = 0
	else:
		time = move_toward(time, 0, delta)
		
		if time <= 0 or time > last_max:
			time = last_max

func value() -> float:
	if last_max == 0:
		return 1.0 if reverse else 0.0
	return (time / last_max) * response_multiplier
