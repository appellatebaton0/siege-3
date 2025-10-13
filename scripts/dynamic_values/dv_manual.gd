class_name ManualDynamicValue extends DynamicValue

@warning_ignore("unused_signal") signal changed

## The value to store, and respond to requests with.
@export var response:Variant

func set_to(to:Variant):
	response = to
	changed.emit()

func filled() -> bool:
	return response != null

func value() -> Variant:
	return response
