class_name Consideration
extends Resource


func score(context: Dictionary = {}) -> float:
    return _score_impl(context)


func _score_impl(context: Dictionary = {}) -> float:
    return 0.0