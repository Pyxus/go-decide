@tool
class_name EvaluatorFunctionLinear
extends EvaluatorFunction

@export var a: float = 1:
	set(value):
		a = max(0.01, value)
		_update_curve()

@export var b: float = 0:
	set(value):
		b = value
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return (input / a) - b if a > 0 else 0.0
