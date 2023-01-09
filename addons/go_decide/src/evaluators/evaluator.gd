@tool
class_name Evaluator
extends Resource

@export var invert: bool:
    set(value):
        invert = value
        _invert_updated()

func evaluate(input: float) -> float:
    var evaluation := _evaluate_impl(input)
    if evaluation < 0 or evaluation > 1:
        push_warning("Evaluations should be normalized from 0 to 1.")

    return 1 - _evaluate_impl(input) if invert else _evaluate_impl(input)


func _evaluate_impl(input: float) -> float:
    push_warning("Method unimplemented")
    return input


func _invert_updated() -> void:
    pass