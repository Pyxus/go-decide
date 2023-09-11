@tool
class_name EvaluatorFunctionThreshold
extends EvaluatorFunction

@export_range(0, 1, 0.001) var a: float = .5:
	set(value):
		a = value
		_update_curve()


func _init() -> void:
	super()
	
	if _curve_generator:
		_curve_generator.increment = .01


func _evaluate_impl(input: float) -> float:
	return 0.0 if input > a else 1.0
