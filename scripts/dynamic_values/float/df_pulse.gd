class_name DynamicTimerFloatValue extends DynamicFloatValue
## Returns the value of a timer between 0 and 1, * the multiplier.
## The max value is a DV.

## The maximum time of the timer.
@export var max_time:DynamicFloatValue
var last_max:float = 1.0
## The value to multiply the maximum by.
@export var max_time_multiplier := 1.0
var time:float = 0.0
## The value to multiply the response by.
@export var response_multiplier := 1.0

func _ready() -> void:
	for child in get_children():
		if child is DynamicFloatValue and max_time == null:
			max_time = child


func _process(delta: float) -> void:
	
	if max_time != null:
		last_max = max_time.value() * max_time_multiplier
	
	time = move_toward(time, 0, delta)
	
	if time <= 0 or time > last_max:
		time = last_max

func value() -> float:
	if last_max == 0:
		return 0.0
	return (time / last_max) * response_multiplier
