@tool
class_name EvaluatorFunctionCos
extends EvaluatorFunction

@export var a: float = .5:
	set(value):
		a = value
		_update_curve()

@export var b: float = 0:
	set(value):
		b = value
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return 1 - cos(input * PI * a) + b