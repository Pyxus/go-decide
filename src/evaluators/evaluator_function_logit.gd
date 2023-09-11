@tool
class_name EvaluatorFunctionLogit
extends EvaluatorFunction

const E = 2.71828

@export var a: float = E:
	set(value):
		a = max(0.01, value)
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return (_logb(input / (1 - input), a) + 2 * E) / 4 * E if a > 0 else 0.0


func _logb(value: float, base: float) -> float:
	return log(value) / log(base)
