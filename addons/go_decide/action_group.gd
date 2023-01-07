class_name ActionGroup
extends RefCounted

## List of actions belonging to this group
var actions: Array[Action]

## Group weight. Groups with a higher weight are evaluated first by the [class Reasoner]
var weight: float


func add_action(action: Action) -> void:
    actions.append(action)


func add_actions(actions: Array[Action]) -> void:
    actions.append_array(actions)

func update_action_utility(context: Context) -> void:
    for action in actions:
        action.calc_utility(context)