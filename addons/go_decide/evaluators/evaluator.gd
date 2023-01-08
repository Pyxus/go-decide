@tool
class_name Evaluator
extends Resource

func evaluate(value: float) -> float:
    return evaluate_impl(value)


func evaluate_impl(value: float) -> float:
    return value