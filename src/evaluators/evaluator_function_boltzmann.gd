@tool
class_name EvaluatorFunctionBoltzmann
extends EvaluatorFunction

const E = 2.71828

@export var a: float = 1:
	set(value):
		a = value
		_update_curve()

@export var t: float = E / 2.0:
	set(value):
		t = max(0.001, value)
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return pow(a * E, input / t) - 1
