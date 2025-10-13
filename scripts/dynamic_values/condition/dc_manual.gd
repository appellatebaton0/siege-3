class_name DynamicManualCondition extends DynamicCondition
## Literally just responds to requests with the response.

## The value to response with
@export var response := true

func value() -> bool:
	return response
