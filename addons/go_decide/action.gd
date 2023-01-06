class_name Action
extends RefCounted

var probability: float = 1.0:
    set(value):
        probability = clampf(value, 0, 1)

var weight: float = 1.0
var evaluator := Evaluator.new()
var considerations: Array[Consideration]
var name: StringName

# Type: () -> void
var execute: Callable

func _init(name: StringName, considerations: Array[Consideration], execute: Callable) -> void:
    self.name = name
    self.considerations = considerations
    self.execute = execute


func calc_utility(context: Dictionary) -> float:
    if considerations.is_empty():
        return 0.0

    var sum_score := 0.0
    for consideration in considerations:
        sum_score += evaluator.evaluate(consideration.score(context))
    
    return (sum_score / considerations.size()) * clampf(probability, 0, 1) * weight