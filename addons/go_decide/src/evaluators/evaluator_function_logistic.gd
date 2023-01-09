@tool
class_name EvaluatorFunctionLogistic
extends EvaluatorFunction

const E = 2.71828

@export var k: float = 1:
	set(value):
		k = value
		_update_curve()

@export var x0: float = 0:
	set(value):
		x0 = value
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return 1  / (1 + exp(-k * (4 * E * (input - x0) - 2 * E)))
