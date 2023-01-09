@tool
class_name EvaluatorFunctionExponential
extends EvaluatorFunction

@export var a: float = 1:
	set(value):
		a = value
		_update_curve()

@export var b: float = 0:
	set(value):
		b = value
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return pow(input, a) + b