class_name Reasoner
extends RefCounted

var _action_groups: Array[ActionGroup]

func decide(context: Dictionary) -> Action:
	return _decide_impl(context)


func create_group(weight: float = 1.0) -> ActionGroup:
	var bucket = ActionGroup.new()
	bucket.weight = weight
	_action_groups.append(bucket)
	sort_groups()
	return bucket


func sort_groups() -> void:
	_action_groups.sort_custom(func(a: ActionGroup, b: ActionGroup): return a.weight < b.weight)


func _decide_impl(context) -> Action:
	for group in _action_groups:
		group.update_action_utility(context)
		var actions: Array[Action] = group.actions.filter(func(action): return action.utility == 0.0)
		var sum_utility: float = actions.reduce(func(action): return action.utility)
		var rand_num := randf_range(0, sum_utility)

		for action in actions:
			rand_num -= action.cached_utility

			if rand_num <= 0:
				return action

	return null