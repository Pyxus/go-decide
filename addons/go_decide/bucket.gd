extends RefCounted

# Type: Pseudo-Set[StringName]
var actions: Dictionary

var weight: float


func update_action_utility() -> void:
    for action in actions:
        action.calc_utility()