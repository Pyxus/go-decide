@tool
class_name EvaluatorFunctionSmoothstep
extends EvaluatorFunction


@export var a: float = 1:
	set(value):
		a = max(0.01, value)
		_update_curve()


func _evaluate_impl(input: float) -> float:
	return smoothstep(0, 1, input * a)